package com.seatify.service;

import com.seatify.dto.response.AvailabilityResponse;
import com.seatify.dto.response.VenueDetailResponse;
import com.seatify.dto.response.VenueListResponse;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.FloorTable;
import com.seatify.model.entity.Reservation;
import com.seatify.model.entity.Venue;
import com.seatify.repository.FloorTableRepository;
import com.seatify.repository.ReservationRepository;
import com.seatify.repository.VenueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@RequiredArgsConstructor
public class VenueService {

    private final VenueRepository venueRepository;
    private final FloorTableRepository floorTableRepository;
    private final ReservationRepository reservationRepository;

    @Transactional(readOnly = true)
    public List<VenueListResponse> listVenues() {
        return venueRepository.findAll().stream()
                .map(VenueListResponse::from)
                .toList();
    }

    @Transactional(readOnly = true)
    public VenueDetailResponse getVenueBySlug(String slug) {
        Venue venue = venueRepository.findBySlug(slug)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found: " + slug));
        return VenueDetailResponse.from(venue);
    }

    @Transactional(readOnly = true)
    public AvailabilityResponse getAvailability(String venueId, LocalDate date, String time, short partySize) {
        // Validate venue exists
        if (!venueRepository.existsById(venueId)) {
            throw new ResourceNotFoundException("Venue not found: " + venueId);
        }

        List<FloorTable> allTables = floorTableRepository.findByVenueId(venueId);
        LocalTime requestedTime = LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm"));

        List<VenueDetailResponse.TableResponse> available = allTables.stream()
                .filter(table -> table.getSeats() >= partySize)
                .filter(table -> {
                    List<Reservation> reservations = reservationRepository.findActiveByTableIdAndDate(table.getId(), date);
                    return reservations.stream().noneMatch(r -> {
                        LocalTime resTime = LocalTime.parse(r.getTime(), DateTimeFormatter.ofPattern("HH:mm"));
                        long minutesDiff = Math.abs(java.time.Duration.between(requestedTime, resTime).toMinutes());
                        return minutesDiff < 120; // 2-hour window
                    });
                })
                .map(t -> VenueDetailResponse.TableResponse.builder()
                        .id(t.getId())
                        .zoneId(t.getZone().getId())
                        .x(t.getX())
                        .y(t.getY())
                        .width(t.getWidth())
                        .height(t.getHeight())
                        .shape(t.getShape().name())
                        .seats(t.getSeats())
                        .label(t.getLabel())
                        .status("available")
                        .build())
                .toList();

        return AvailabilityResponse.builder()
                .availableTables(available)
                .build();
    }
}
