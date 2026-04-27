package com.seatify.service;

import com.seatify.dto.request.CreateReservationRequest;
import com.seatify.dto.response.ReservationResponse;
import com.seatify.exception.BadRequestException;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.*;
import com.seatify.model.enums.ReservationStatus;
import com.seatify.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReservationService {

    private final ReservationRepository reservationRepository;
    private final VenueRepository venueRepository;
    private final FloorTableRepository floorTableRepository;
    private final MenuItemRepository menuItemRepository;
    private final UserRepository userRepository;
    private final PaymentService paymentService;
    private final LoyaltyService loyaltyService;

    @Transactional
    public ReservationResponse create(UUID userId, CreateReservationRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        Venue venue = venueRepository.findById(request.getVenueId())
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        FloorTable table = floorTableRepository.findById(request.getTableId())
                .orElseThrow(() -> new ResourceNotFoundException("Table not found"));

        // Check table belongs to venue
        if (!table.getVenue().getId().equals(venue.getId())) {
            throw new BadRequestException("Table does not belong to this venue");
        }

        // Check seats
        if (table.getSeats() < request.getPartySize()) {
            throw new BadRequestException("Table has only " + table.getSeats() + " seats");
        }

        // Check availability (2-hour window)
        LocalTime requestedTime = LocalTime.parse(request.getTime(), DateTimeFormatter.ofPattern("HH:mm"));
        List<Reservation> existing = reservationRepository.findActiveByTableIdAndDate(table.getId(), request.getDate());
        boolean conflict = existing.stream().anyMatch(r -> {
            LocalTime resTime = LocalTime.parse(r.getTime(), DateTimeFormatter.ofPattern("HH:mm"));
            return Math.abs(Duration.between(requestedTime, resTime).toMinutes()) < 120;
        });
        if (conflict) {
            throw new BadRequestException("Table is not available at this time");
        }

        // Process pre-order
        List<PreOrderItem> preOrderItems = new ArrayList<>();
        int totalAmount = 0;

        if (request.getPreOrder() != null && !request.getPreOrder().isEmpty()) {
            for (CreateReservationRequest.PreOrderItemRequest poi : request.getPreOrder()) {
                MenuItem menuItem = menuItemRepository.findById(poi.getMenuItemId())
                        .orElseThrow(() -> new ResourceNotFoundException("Menu item not found: " + poi.getMenuItemId()));

                int lineTotal = menuItem.getPrice() * poi.getQuantity();
                totalAmount += lineTotal;

                preOrderItems.add(PreOrderItem.builder()
                        .menuItem(menuItem)
                        .quantity(poi.getQuantity())
                        .unitPrice(menuItem.getPrice())
                        .build());
            }
        }

        // Generate QR code
        String qrCode = "RES-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase() + "-" + venue.getSlug().toUpperCase();

        // Process payment
        String paymentMethod = request.getPaymentMethod() != null ? request.getPaymentMethod() : "card";
        String paymentStatus = paymentService.processPayment(paymentMethod, totalAmount);

        Reservation reservation = Reservation.builder()
                .user(user)
                .venue(venue)
                .table(table)
                .date(request.getDate())
                .time(request.getTime())
                .partySize(request.getPartySize())
                .totalAmount(totalAmount)
                .qrCode(qrCode)
                .paymentMethod(paymentMethod)
                .paymentStatus(paymentStatus)
                .build();

        reservation = reservationRepository.save(reservation);

        // Save pre-order items
        for (PreOrderItem poi : preOrderItems) {
            poi.setReservation(reservation);
        }
        reservation.getPreOrderItems().addAll(preOrderItems);
        reservation = reservationRepository.save(reservation);

        // Award loyalty points for reservation
        loyaltyService.awardPoints(user, 50, "reservation", "Reservation at " + venue.getName(), reservation.getId());

        return ReservationResponse.from(reservation);
    }

    @Transactional(readOnly = true)
    public List<ReservationResponse> listByUser(UUID userId, String status) {
        List<Reservation> reservations;
        if (status != null && !status.isBlank()) {
            ReservationStatus rs = ReservationStatus.valueOf(status);
            reservations = reservationRepository.findByUserIdAndStatusOrderByDateDescTimeDesc(userId, rs);
        } else {
            reservations = reservationRepository.findByUserIdOrderByDateDescTimeDesc(userId);
        }
        return reservations.stream().map(ReservationResponse::from).toList();
    }

    @Transactional(readOnly = true)
    public ReservationResponse getById(UUID userId, UUID reservationId) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));

        if (!reservation.getUser().getId().equals(userId)) {
            throw new ResourceNotFoundException("Reservation not found");
        }

        return ReservationResponse.from(reservation);
    }

    @Transactional
    public ReservationResponse cancel(UUID userId, UUID reservationId) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));

        if (!reservation.getUser().getId().equals(userId)) {
            throw new ResourceNotFoundException("Reservation not found");
        }

        if (reservation.getStatus() != ReservationStatus.upcoming) {
            throw new BadRequestException("Only upcoming reservations can be cancelled");
        }

        reservation.setStatus(ReservationStatus.cancelled);
        reservation = reservationRepository.save(reservation);
        return ReservationResponse.from(reservation);
    }
}
