package com.seatify.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class AddVenueImageRequest {
    @NotBlank
    private String url;
    private Integer sortOrder;
}
