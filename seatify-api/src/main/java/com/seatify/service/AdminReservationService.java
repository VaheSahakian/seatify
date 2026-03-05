package com.seatify.service;

import com.seatify.dto.response.AdminReservationResponse;
import com.seatify.exception.BadRequestException;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.Reservation;
import com.seatify.model.enums.ReservationStatus;
import com.seatify.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AdminReservationService {

    private final ReservationRepository reservationRepository;

    @Transactional(readOnly = true)
    public List<AdminReservationResponse> listReservations(String venueId, LocalDate date, String status) {
        List<Reservation> reservations = reservationRepository.findByVenueIdOrderByDateDescTimeDesc(venueId);

        return reservations.stream()
                .filter(r -> date == null || r.getDate().equals(date))
                .filter(r -> status == null || r.getStatus().name().equals(status))
                .map(AdminReservationResponse::from)
                .toList();
    }

    @Transactional(readOnly = true)
    public AdminReservationResponse getReservation(String venueId, UUID reservationId) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));
        if (!reservation.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Reservation does not belong to this venue");
        }
        return AdminReservationResponse.from(reservation);
    }

    @Transactional
    public AdminReservationResponse updateStatus(String venueId, UUID reservationId, String newStatus) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));
        if (!reservation.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Reservation does not belong to this venue");
        }

        reservation.setStatus(ReservationStatus.valueOf(newStatus));
        reservation = reservationRepository.save(reservation);
        return AdminReservationResponse.from(reservation);
    }
}
