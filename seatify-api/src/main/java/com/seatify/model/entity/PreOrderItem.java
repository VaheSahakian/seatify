package com.seatify.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "pre_order_items")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class PreOrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reservation_id", nullable = false)
    private Reservation reservation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "menu_item_id", nullable = false)
    private MenuItem menuItem;

    @Column(nullable = false)
    @Builder.Default
    private Short quantity = 1;

    @Column(name = "unit_price", nullable = false)
    @Builder.Default
    private Integer unitPrice = 0;
}
