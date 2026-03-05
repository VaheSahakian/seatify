package com.seatify.dto.response;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class AdminDashboardResponse {
    private Long totalReservations;
    private Long upcomingReservations;
    private Long todayReservations;
    private BigDecimal averageRating;
    private Integer reviewCount;
    private Long revenue;
}
