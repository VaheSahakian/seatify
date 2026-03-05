package com.seatify.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.Map;

@Entity
@Table(name = "menu_items")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class MenuItem {

    @Id
    @Column(length = 20)
    private String id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private MenuCategory category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "venue_id", nullable = false)
    private Venue venue;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(nullable = false, columnDefinition = "jsonb")
    private Map<String, String> name;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private Map<String, String> description;

    @Column(nullable = false)
    @Builder.Default
    private Integer price = 0;

    @Column(length = 500)
    private String image;

    @Column(columnDefinition = "varchar[]")
    @JdbcTypeCode(SqlTypes.ARRAY)
    @Builder.Default
    private String[] tags = new String[]{};

    @Column(name = "sort_order", nullable = false)
    @Builder.Default
    private Integer sortOrder = 0;
}
