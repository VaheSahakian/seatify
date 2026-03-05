package com.seatify.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "venues")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Venue {

    @Id
    @Column(length = 20)
    private String id;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(nullable = false, unique = true, length = 200)
    private String slug;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private Map<String, String> description;

    @Column(columnDefinition = "varchar[]")
    @JdbcTypeCode(SqlTypes.ARRAY)
    private String[] cuisine;

    @Column(name = "price_range", nullable = false)
    private Short priceRange;

    @Column(nullable = false, precision = 2, scale = 1)
    private BigDecimal rating;

    @Column(name = "review_count", nullable = false)
    @Builder.Default
    private Integer reviewCount = 0;

    @Column(length = 300)
    private String address;

    private Double latitude;
    private Double longitude;

    @Column(length = 30)
    private String phone;

    @Column(columnDefinition = "varchar[]")
    @JdbcTypeCode(SqlTypes.ARRAY)
    private String[] features;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private Map<String, String> policies;

    @Column(name = "floor_plan_width")
    private Integer floorPlanWidth;

    @Column(name = "floor_plan_height")
    private Integer floorPlanHeight;

    @OneToMany(mappedBy = "venue", fetch = FetchType.LAZY)
    @OrderBy("sortOrder ASC")
    @Builder.Default
    private List<VenueImage> images = new ArrayList<>();

    @OneToMany(mappedBy = "venue", fetch = FetchType.LAZY)
    @Builder.Default
    private List<VenueHours> hours = new ArrayList<>();

    @OneToMany(mappedBy = "venue", fetch = FetchType.LAZY)
    @Builder.Default
    private List<FloorZone> zones = new ArrayList<>();

    @OneToMany(mappedBy = "venue", fetch = FetchType.LAZY)
    @Builder.Default
    private List<FloorTable> tables = new ArrayList<>();

    @OneToMany(mappedBy = "venue", fetch = FetchType.LAZY)
    @OrderBy("sortOrder ASC")
    @Builder.Default
    private List<MenuCategory> menuCategories = new ArrayList<>();
}
