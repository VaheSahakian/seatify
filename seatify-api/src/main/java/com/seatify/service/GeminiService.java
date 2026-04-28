package com.seatify.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.seatify.dto.request.ChatRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class GeminiService {

    private static final String BASE_PROMPT = """
            You are Seatify Assistant, a friendly chatbot embedded in the Seatify app — a restaurant
            reservation and pre-ordering platform in Yerevan, Armenia.

            CAPABILITIES:
            - Recommend specific restaurants from the live data below, based on cuisine, dishes, price, or vibe.
            - Suggest specific dishes from a venue's menu when asked.
            - Explain how to make a reservation, browse menus, pre-order food, manage favorites, and earn
              loyalty points (50 per reservation, 20 per review; Bronze/Silver/Gold tiers).

            RULES:
            - Use ONLY the LIVE SEATIFY RESTAURANT DATA section below for restaurant facts and menus. Never invent.
            - When recommending a venue, mention its name and 1–2 standout dishes from its actual menu.
            - For real-time availability (specific date/time/party size), tell the user to open the venue page
              and use the reservation flow — you don't have live table data.
            - Prices are in Armenian dram (֏).
            - Be concise (3–6 sentences typical), warm, and helpful. Use light emoji sparingly.
            """;

    private static final int MAX_RETRIES = 2;

    private final String apiKey;
    private final String model;
    private final String baseUrl;
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final VenueContextProvider venueContextProvider;

    public GeminiService(
            @Value("${app.gemini.api-key:}") String apiKey,
            @Value("${app.gemini.model:gemini-2.5-flash}") String model,
            @Value("${app.gemini.base-url:https://generativelanguage.googleapis.com/v1beta}") String baseUrl,
            VenueContextProvider venueContextProvider
    ) {
        this.apiKey = apiKey;
        this.model = model;
        this.baseUrl = baseUrl;
        this.venueContextProvider = venueContextProvider;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    public String chat(ChatRequest request) {
        if (apiKey == null || apiKey.isBlank()) {
            throw new ResponseStatusException(HttpStatus.SERVICE_UNAVAILABLE,
                    "Gemini API key is not configured");
        }

        Map<String, Object> body = buildBody(request);
        String payload;
        try {
            payload = objectMapper.writeValueAsString(body);
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to encode chat request");
        }

        String url = "%s/models/%s:generateContent?key=%s".formatted(baseUrl, model, apiKey);

        HttpResponse<String> response = null;
        Exception lastError = null;
        for (int attempt = 0; attempt <= MAX_RETRIES; attempt++) {
            try {
                HttpRequest httpRequest = HttpRequest.newBuilder()
                        .uri(URI.create(url))
                        .timeout(Duration.ofSeconds(30))
                        .header("Content-Type", "application/json")
                        .POST(HttpRequest.BodyPublishers.ofString(payload))
                        .build();
                response = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());

                int code = response.statusCode();
                if (code == 503 || code == 502 || code == 504) {
                    log.warn("Gemini transient {} (attempt {}/{}): {}", code, attempt + 1, MAX_RETRIES + 1, truncate(response.body(), 200));
                    if (attempt < MAX_RETRIES) {
                        sleep(500L * (1L << attempt));
                        continue;
                    }
                }
                break;
            } catch (Exception e) {
                lastError = e;
                log.warn("Gemini call attempt {} failed: {}", attempt + 1, e.getMessage());
                if (attempt < MAX_RETRIES) {
                    sleep(500L * (1L << attempt));
                    continue;
                }
            }
        }

        if (response == null) {
            log.error("Gemini call failed after retries", lastError);
            throw new ResponseStatusException(HttpStatus.BAD_GATEWAY, "Failed to reach Gemini");
        }

        int code = response.statusCode();
        if (code < 200 || code >= 300) {
            log.error("Gemini API error {}: {}", code, response.body());
            String detail = extractErrorMessage(response.body());
            if (code == 429) {
                throw new ResponseStatusException(HttpStatus.TOO_MANY_REQUESTS,
                        "Gemini rate limit hit — try again in a minute, switch GEMINI_MODEL, or enable billing. " + detail);
            }
            if (code == 503) {
                throw new ResponseStatusException(HttpStatus.SERVICE_UNAVAILABLE,
                        "Gemini is temporarily overloaded. Please try again. " + detail);
            }
            throw new ResponseStatusException(HttpStatus.BAD_GATEWAY,
                    "Gemini API returned " + code + ": " + detail);
        }

        try {
            JsonNode root = objectMapper.readTree(response.body());
            JsonNode parts = root.path("candidates").path(0).path("content").path("parts");
            StringBuilder reply = new StringBuilder();
            if (parts.isArray()) {
                for (JsonNode part : parts) {
                    String text = part.path("text").asText("");
                    if (!text.isEmpty()) reply.append(text);
                }
            }
            String result = reply.toString().trim();
            if (result.isEmpty()) {
                String finishReason = root.path("candidates").path(0).path("finishReason").asText("");
                if ("SAFETY".equalsIgnoreCase(finishReason)) {
                    return "Sorry, I can't respond to that. Try rephrasing your question.";
                }
                return "I'm not sure how to answer that. Could you rephrase?";
            }
            return result;
        } catch (Exception e) {
            log.error("Failed to parse Gemini response", e);
            throw new ResponseStatusException(HttpStatus.BAD_GATEWAY, "Failed to parse Gemini response");
        }
    }

    private Map<String, Object> buildBody(ChatRequest request) {
        List<Map<String, Object>> contents = new ArrayList<>();

        if (request.getHistory() != null) {
            for (ChatRequest.ChatMessage msg : request.getHistory()) {
                if (msg.getContent() == null || msg.getContent().isBlank()) continue;
                String role = "assistant".equalsIgnoreCase(msg.getRole()) ? "model" : "user";
                contents.add(messagePart(role, msg.getContent()));
            }
        }
        contents.add(messagePart("user", request.getMessage()));

        String venueData;
        try {
            venueData = venueContextProvider.getContext();
        } catch (Exception e) {
            log.warn("Failed to load venue context for chat", e);
            venueData = "";
        }

        String systemPrompt = BASE_PROMPT + "\n\n" + venueData;

        Map<String, Object> systemInstruction = new LinkedHashMap<>();
        systemInstruction.put("parts", List.of(Map.of("text", systemPrompt)));

        Map<String, Object> generationConfig = new LinkedHashMap<>();
        generationConfig.put("temperature", 0.7);
        generationConfig.put("maxOutputTokens", 1024);
        generationConfig.put("thinkingConfig", Map.of("thinkingBudget", 0));

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("systemInstruction", systemInstruction);
        body.put("contents", contents);
        body.put("generationConfig", generationConfig);
        return body;
    }

    private String extractErrorMessage(String body) {
        try {
            JsonNode err = objectMapper.readTree(body).path("error");
            String message = err.path("message").asText("");
            String status = err.path("status").asText("");
            if (!message.isEmpty() || !status.isEmpty()) {
                return (status.isEmpty() ? "" : "[" + status + "] ") + message;
            }
        } catch (Exception ignored) {
        }
        return truncate(body, 200);
    }

    private Map<String, Object> messagePart(String role, String text) {
        Map<String, Object> msg = new LinkedHashMap<>();
        msg.put("role", role);
        msg.put("parts", List.of(Map.of("text", text)));
        return msg;
    }

    private static String truncate(String s, int max) {
        if (s == null) return "";
        return s.length() <= max ? s : s.substring(0, max);
    }

    private static void sleep(long ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
    }
}
