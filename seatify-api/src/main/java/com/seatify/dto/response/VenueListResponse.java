package com.seatify.dto.response;

import com.seatify.model.entity.Venue;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Data
@Builder
public class VenueListResponse {
    private String id;
    private String name;
    private String slug;
    private List<String> images;
    private String[] cuisine;
    private Short priceRange;
    private BigDecimal rating;
    private Integer reviewCount;
    private String address;
    private CoordinatesResponse coordinates;

    @Data
    @Builder
    public static class CoordinatesResponse {
        private Double lat;
        private Double lng;
    }

    public static VenueListResponse from(Venue venue) {
        return VenueListResponse.builder()
                .id(venue.getId())
                .name(venue.getName())
                .slug(venue.getSlug())
                .images(venue.getImages().stream().map(vi -> vi.getUrl()).toList())
                .cuisine(venue.getCuisine())
                .priceRange(venue.getPriceRange())
                .rating(venue.getRating())
                .reviewCount(venue.getReviewCount())
                .address(venue.getAddress())
                .coordinates(CoordinatesResponse.builder()
                        .lat(venue.getLatitude())
                        .lng(venue.getLongitude())
                        .build())
                .build();
    }
}
