package com.seatify.service;

import com.seatify.model.entity.MenuCategory;
import com.seatify.model.entity.MenuItem;
import com.seatify.model.entity.Venue;
import com.seatify.repository.VenueRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class VenueContextProvider {

    private static final long TTL_MS = 10 * 60 * 1000L;

    private final VenueRepository venueRepository;

    private volatile String cachedContext;
    private volatile long cachedAt;

    @Transactional(readOnly = true)
    public String getContext() {
        long now = System.currentTimeMillis();
        String cached = cachedContext;
        if (cached != null && (now - cachedAt) < TTL_MS) {
            return cached;
        }
        String built = buildContext();
        synchronized (this) {
            cachedContext = built;
            cachedAt = System.currentTimeMillis();
        }
        return built;
    }

    private String buildContext() {
        StringBuilder sb = new StringBuilder();
        sb.append("LIVE SEATIFY RESTAURANT DATA (use this to answer):\n\n");
        List<Venue> venues = venueRepository.findAll();
        for (Venue v : venues) {
            sb.append("=== ").append(v.getName())
              .append(" (slug: ").append(v.getSlug()).append(") ===\n");
            sb.append("Cuisine: ");
            if (v.getCuisine() != null && v.getCuisine().length > 0) {
                sb.append(String.join(", ", v.getCuisine()));
            } else {
                sb.append("—");
            }
            sb.append(" | Price: ")
              .append("$".repeat(Math.max(1, v.getPriceRange() == null ? 1 : v.getPriceRange())))
              .append(" | Rating: ").append(v.getRating())
              .append(" (").append(v.getReviewCount() == null ? 0 : v.getReviewCount()).append(" reviews)\n");
            if (v.getAddress() != null && !v.getAddress().isBlank()) {
                sb.append("Address: ").append(v.getAddress()).append("\n");
            }
            if (v.getFeatures() != null && v.getFeatures().length > 0) {
                sb.append("Features: ").append(String.join(", ", v.getFeatures())).append("\n");
            }
            String desc = mapEn(v.getDescription());
            if (!desc.isEmpty()) {
                sb.append("About: ").append(truncate(desc, 240)).append("\n");
            }

            List<MenuCategory> cats = v.getMenuCategories();
            if (cats != null && !cats.isEmpty()) {
                sb.append("Menu:\n");
                for (MenuCategory cat : cats) {
                    String catName = mapEn(cat.getName());
                    if (catName.isEmpty()) catName = "Items";
                    sb.append("  • ").append(catName).append(": ");
                    List<String> parts = new ArrayList<>();
                    for (MenuItem item : cat.getItems()) {
                        String itemName = mapEn(item.getName());
                        if (itemName.isEmpty()) continue;
                        StringBuilder p = new StringBuilder(itemName);
                        if (item.getPrice() != null && item.getPrice() > 0) {
                            p.append(" (").append(item.getPrice()).append("֏)");
                        }
                        if (item.getTags() != null && item.getTags().length > 0) {
                            p.append(" [").append(String.join(",", item.getTags())).append("]");
                        }
                        parts.add(p.toString());
                    }
                    sb.append(String.join(", ", parts)).append("\n");
                }
            }
            sb.append("\n");
        }
        log.info("Built venue context: {} venues, {} chars", venues.size(), sb.length());
        return sb.toString();
    }

    public synchronized void invalidate() {
        cachedContext = null;
        cachedAt = 0L;
    }

    private static String mapEn(Map<String, String> m) {
        if (m == null || m.isEmpty()) return "";
        String en = m.get("en");
        if (en != null && !en.isBlank()) return en;
        return m.values().stream().filter(s -> s != null && !s.isBlank()).findFirst().orElse("");
    }

    private static String truncate(String s, int max) {
        if (s == null) return "";
        return s.length() <= max ? s : s.substring(0, max - 1) + "…";
    }
}
