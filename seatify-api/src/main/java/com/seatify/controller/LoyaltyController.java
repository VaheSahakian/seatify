package com.seatify.controller;

import com.seatify.dto.response.LoyaltyResponse;
import com.seatify.dto.response.PointTransactionResponse;
import com.seatify.model.entity.PointTransaction;
import com.seatify.model.entity.User;
import com.seatify.service.LoyaltyService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/loyalty")
@RequiredArgsConstructor
public class LoyaltyController {

    private final LoyaltyService loyaltyService;

    @GetMapping
    public ResponseEntity<LoyaltyResponse> getLoyalty(@AuthenticationPrincipal User user) {
        List<PointTransaction> history = loyaltyService.getHistory(user.getId());
        List<PointTransactionResponse> historyResponse = history.stream()
                .map(PointTransactionResponse::from)
                .toList();

        return ResponseEntity.ok(LoyaltyResponse.builder()
                .points(user.getLoyaltyPoints())
                .tier(user.getLoyaltyTier())
                .history(historyResponse)
                .build());
    }

    @GetMapping("/history")
    public ResponseEntity<List<PointTransactionResponse>> getHistory(@AuthenticationPrincipal User user) {
        List<PointTransaction> history = loyaltyService.getHistory(user.getId());
        return ResponseEntity.ok(history.stream()
                .map(PointTransactionResponse::from)
                .toList());
    }
}
