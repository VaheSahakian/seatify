package com.seatify.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class CreateReservationRequest {
    @NotBlank
    private String venueId;

    @NotBlank
    private String tableId;

    @NotNull
    private LocalDate date;

    @NotBlank
    private String time;

    @NotNull
    private Short partySize;

    private String paymentMethod;

    private List<PreOrderItemRequest> preOrder;

    @Data
    public static class PreOrderItemRequest {
        @NotBlank
        private String menuItemId;
        @NotNull
        private Short quantity;
    }
}
