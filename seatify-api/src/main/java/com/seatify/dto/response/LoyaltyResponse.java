package com.seatify.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class LoyaltyResponse {
    private int points;
    private String tier;
    private List<PointTransactionResponse> history;
}
