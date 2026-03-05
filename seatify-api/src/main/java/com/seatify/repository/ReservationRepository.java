package com.seatify.repository;

import com.seatify.model.entity.Reservation;
import com.seatify.model.enums.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface ReservationRepository extends JpaRepository<Reservation, UUID> {

    List<Reservation> findByUserIdOrderByDateDescTimeDesc(UUID userId);

    List<Reservation> findByVenueIdOrderByDateDescTimeDesc(String venueId);

    List<Reservation> findByUserIdAndStatusOrderByDateDescTimeDesc(UUID userId, ReservationStatus status);

    @Query("SELECT r FROM Reservation r WHERE r.table.id = :tableId AND r.date = :date AND r.status <> 'cancelled'")
    List<Reservation> findActiveByTableIdAndDate(String tableId, LocalDate date);
}
