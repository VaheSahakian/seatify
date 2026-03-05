package com.seatify.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

@Data
public class UpsertMenuItemRequest {
    @NotBlank
    private String categoryId;

    @NotNull
    private Map<String, String> name;

    private Map<String, String> description;
    private Integer price;
    private String image;
    private String[] tags;
    private Integer sortOrder;
}
