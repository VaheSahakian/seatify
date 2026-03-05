package com.seatify.dto.request;

import lombok.Data;

import java.util.Map;

@Data
public class UpdateVenueRequest {
    private String name;
    private Map<String, String> description;
    private String[] cuisine;
    private Short priceRange;
    private String address;
    private String phone;
    private String[] features;
    private Map<String, String> policies;
}
