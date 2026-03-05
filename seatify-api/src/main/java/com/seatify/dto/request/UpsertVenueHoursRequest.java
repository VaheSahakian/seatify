package com.seatify.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class UpsertVenueHoursRequest {
    @NotBlank
    private String day;
    @NotBlank
    private String openTime;
    @NotBlank
    private String closeTime;
}
