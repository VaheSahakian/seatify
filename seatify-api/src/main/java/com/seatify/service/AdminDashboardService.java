package com.seatify.service;

import com.seatify.dto.response.AdminDashboardResponse;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.Reservation;
import com.seatify.model.entity.Venue;
import com.seatify.model.enums.ReservationStatus;
import com.seatify.repository.ReservationRepository;
import com.seatify.repository.VenueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminDashboardService {

    private final VenueRepository venueRepository;
    private final ReservationRepository reservationRepository;

    @Transactional(readOnly = true)
    public AdminDashboardResponse getDashboard(String venueId) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        List<Reservation> allReservations = reservationRepository.findByVenueIdOrderByDateDescTimeDesc(venueId);
        LocalDate today = LocalDate.now();

        long total = allReservations.size();
        long upcoming = allReservations.stream()
                .filter(r -> r.getStatus() == ReservationStatus.upcoming)
                .count();
        long todayCount = allReservations.stream()
                .filter(r -> r.getDate().equals(today))
                .count();
        long revenue = allReservations.stream()
                .filter(r -> r.getStatus() != ReservationStatus.cancelled)
                .mapToLong(r -> r.getTotalAmount())
                .sum();

        return AdminDashboardResponse.builder()
                .totalReservations(total)
                .upcomingReservations(upcoming)
                .todayReservations(todayCount)
                .averageRating(venue.getRating())
                .reviewCount(venue.getReviewCount())
                .revenue(revenue)
                .build();
    }
}
