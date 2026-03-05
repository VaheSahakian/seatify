package com.seatify.dto.response;

import com.seatify.model.entity.Reservation;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AdminReservationResponse {
    private String id;
    private String customerName;
    private String customerPhone;
    private String date;
    private String time;
    private Short partySize;
    private String tableId;
    private String tableLabel;
    private String status;
    private Integer totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private String createdAt;

    public static AdminReservationResponse from(Reservation r) {
        return AdminReservationResponse.builder()
                .id(r.getId().toString())
                .customerName(r.getUser().getName())
                .customerPhone(r.getUser().getPhone())
                .date(r.getDate().toString())
                .time(r.getTime())
                .partySize(r.getPartySize())
                .tableId(r.getTable().getId())
                .tableLabel(r.getTable().getLabel())
                .status(r.getStatus().name())
                .totalAmount(r.getTotalAmount())
                .paymentMethod(r.getPaymentMethod())
                .paymentStatus(r.getPaymentStatus())
                .createdAt(r.getCreatedAt().toString())
                .build();
    }
}
