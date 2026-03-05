package com.seatify.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "venue_images")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class VenueImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "venue_id", nullable = false)
    private Venue venue;

    @Column(nullable = false, length = 500)
    private String url;

    @Column(name = "sort_order", nullable = false)
    @Builder.Default
    private Integer sortOrder = 0;
}
