package com.seatify.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

@Data
public class UpsertMenuCategoryRequest {
    @NotNull
    private Map<String, String> name;
    private Integer sortOrder;
}
