package com.seatify.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "venue_hours")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class VenueHours {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "venue_id", nullable = false)
    private Venue venue;

    @Column(nullable = false, length = 20)
    private String day;

    @Column(name = "open_time", nullable = false, length = 5)
    private String openTime;

    @Column(name = "close_time", nullable = false, length = 5)
    private String closeTime;
}
