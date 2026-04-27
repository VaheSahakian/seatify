package com.seatify.dto.response;

import com.seatify.model.entity.PointTransaction;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PointTransactionResponse {
    private Long id;
    private int points;
    private String type;
    private String description;
    private String reservationId;
    private String createdAt;

    public static PointTransactionResponse from(PointTransaction tx) {
        return PointTransactionResponse.builder()
                .id(tx.getId())
                .points(tx.getPoints())
                .type(tx.getType())
                .description(tx.getDescription())
                .reservationId(tx.getReservation() != null ? tx.getReservation().getId().toString() : null)
                .createdAt(tx.getCreatedAt() != null ? tx.getCreatedAt().toString() : null)
                .build();
    }
}
