package com.seatify.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

@Data
public class UpsertFloorZoneRequest {
    @NotNull
    private Map<String, String> name;

    @NotNull
    private Integer x;
    @NotNull
    private Integer y;
    @NotNull
    private Integer width;
    @NotNull
    private Integer height;

    private String color;
}
