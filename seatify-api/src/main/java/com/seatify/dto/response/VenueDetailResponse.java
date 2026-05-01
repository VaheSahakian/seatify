package com.seatify.dto.response;

import com.seatify.model.entity.*;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Data
@Builder
public class VenueDetailResponse {
    private String id;
    private String name;
    private String slug;
    private Map<String, String> description;
    private String[] cuisine;
    private Short priceRange;
    private BigDecimal rating;
    private Integer reviewCount;
    private String address;
    private VenueListResponse.CoordinatesResponse coordinates;
    private String phone;
    private List<String> images;
    private List<HoursResponse> hours;
    private String[] features;
    private Map<String, String> policies;
    private FloorPlanResponse floorPlan;
    private List<MenuCategoryResponse> menu;

    @Data @Builder
    public static class HoursResponse {
        private String day;
        private String open;
        private String close;
    }

    @Data @Builder
    public static class FloorPlanResponse {
        private Integer width;
        private Integer height;
        private List<ZoneResponse> zones;
        private List<TableResponse> tables;
    }

    @Data @Builder
    public static class ZoneResponse {
        private String id;
        private Map<String, String> name;
        private Integer x;
        private Integer y;
        private Integer width;
        private Integer height;
        private String color;
    }

    @Data @Builder
    public static class TableResponse {
        private String id;
        private String zoneId;
        private Integer x;
        private Integer y;
        private Integer width;
        private Integer height;
        private String shape;
        private Short seats;
        private String label;
        private String status;
        private Integer rotation;
    }

    @Data @Builder
    public static class MenuCategoryResponse {
        private String id;
        private Map<String, String> name;
        private List<MenuItemResponse> items;
    }

    @Data @Builder
    public static class MenuItemResponse {
        private String id;
        private Map<String, String> name;
        private Map<String, String> description;
        private Integer price;
        private String image;
        private String[] tags;
    }

    public static VenueDetailResponse from(Venue venue) {
        return VenueDetailResponse.builder()
                .id(venue.getId())
                .name(venue.getName())
                .slug(venue.getSlug())
                .description(venue.getDescription())
                .cuisine(venue.getCuisine())
                .priceRange(venue.getPriceRange())
                .rating(venue.getRating())
                .reviewCount(venue.getReviewCount())
                .address(venue.getAddress())
                .coordinates(VenueListResponse.CoordinatesResponse.builder()
                        .lat(venue.getLatitude())
                        .lng(venue.getLongitude())
                        .build())
                .phone(venue.getPhone())
                .images(venue.getImages().stream().map(VenueImage::getUrl).toList())
                .hours(venue.getHours().stream().map(h -> HoursResponse.builder()
                        .day(h.getDay())
                        .open(h.getOpenTime())
                        .close(h.getCloseTime())
                        .build()).toList())
                .features(venue.getFeatures())
                .policies(venue.getPolicies())
                .floorPlan(FloorPlanResponse.builder()
                        .width(venue.getFloorPlanWidth())
                        .height(venue.getFloorPlanHeight())
                        .zones(venue.getZones().stream().map(z -> ZoneResponse.builder()
                                .id(z.getId())
                                .name(z.getName())
                                .x(z.getX())
                                .y(z.getY())
                                .width(z.getWidth())
                                .height(z.getHeight())
                                .color(z.getColor())
                                .build()).toList())
                        .tables(venue.getTables().stream().map(t -> TableResponse.builder()
                                .id(t.getId())
                                .zoneId(t.getZone().getId())
                                .x(t.getX())
                                .y(t.getY())
                                .width(t.getWidth())
                                .height(t.getHeight())
                                .shape(t.getShape().name())
                                .seats(t.getSeats())
                                .label(t.getLabel())
                                .status(t.getDefaultStatus().name())
                                .rotation(t.getRotation() != null ? t.getRotation() : 0)
                                .build()).toList())
                        .build())
                .menu(venue.getMenuCategories().stream().map(mc -> MenuCategoryResponse.builder()
                        .id(mc.getId())
                        .name(mc.getName())
                        .items(mc.getItems().stream().map(mi -> MenuItemResponse.builder()
                                .id(mi.getId())
                                .name(mi.getName())
                                .description(mi.getDescription())
                                .price(mi.getPrice())
                                .image(mi.getImage())
                                .tags(mi.getTags())
                                .build()).toList())
                        .build()).toList())
                .build();
    }
}
