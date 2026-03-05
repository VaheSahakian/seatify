package com.seatify.model.entity;

import com.seatify.model.enums.TableShape;
import com.seatify.model.enums.TableStatus;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "floor_tables")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class FloorTable {

    @Id
    @Column(length = 20)
    private String id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "venue_id", nullable = false)
    private Venue venue;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "zone_id", nullable = false)
    private FloorZone zone;

    @Column(nullable = false)
    private Integer x;

    @Column(nullable = false)
    private Integer y;

    @Column(nullable = false)
    private Integer width;

    @Column(nullable = false)
    private Integer height;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    @Builder.Default
    private TableShape shape = TableShape.rect;

    @Column(nullable = false)
    @Builder.Default
    private Short seats = 2;

    @Column(length = 10)
    private String label;

    @Enumerated(EnumType.STRING)
    @Column(name = "default_status", nullable = false, length = 20)
    @Builder.Default
    private TableStatus defaultStatus = TableStatus.available;
}
