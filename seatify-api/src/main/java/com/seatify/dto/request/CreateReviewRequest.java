package com.seatify.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

@Data
public class CreateReviewRequest {
    @NotNull
    @Min(1) @Max(5)
    private Short rating;

    private Map<String, String> comment;
}
