package com.seatify.controller;

import com.seatify.dto.request.CreateReservationRequest;
import com.seatify.dto.response.ReservationResponse;
import com.seatify.model.entity.User;
import com.seatify.service.ReservationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/reservations")
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService reservationService;

    @PostMapping
    public ResponseEntity<ReservationResponse> create(
            @AuthenticationPrincipal User user,
            @Valid @RequestBody CreateReservationRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(reservationService.create(user.getId(), request));
    }

    @GetMapping
    public ResponseEntity<List<ReservationResponse>> list(
            @AuthenticationPrincipal User user,
            @RequestParam(required = false) String status) {
        return ResponseEntity.ok(reservationService.listByUser(user.getId(), status));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservationResponse> get(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        return ResponseEntity.ok(reservationService.getById(user.getId(), id));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<ReservationResponse> cancel(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        return ResponseEntity.ok(reservationService.cancel(user.getId(), id));
    }
}
