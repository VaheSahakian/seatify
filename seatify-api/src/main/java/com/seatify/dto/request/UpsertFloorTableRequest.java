package com.seatify.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class UpsertFloorTableRequest {
    @NotBlank
    private String zoneId;

    @NotNull
    private Integer x;
    @NotNull
    private Integer y;
    @NotNull
    private Integer width;
    @NotNull
    private Integer height;

    private String shape;
    private Short seats;
    private String label;
    private String defaultStatus;
}
