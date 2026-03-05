package com.seatify.controller;

import com.seatify.dto.response.AdminReservationResponse;
import com.seatify.model.entity.AdminUser;
import com.seatify.service.AdminReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/admin/reservations")
@RequiredArgsConstructor
public class AdminReservationController {

    private final AdminReservationService adminReservationService;

    @GetMapping
    public ResponseEntity<List<AdminReservationResponse>> list(
            @AuthenticationPrincipal AdminUser admin,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false) String status) {
        return ResponseEntity.ok(adminReservationService.listReservations(admin.getVenue().getId(), date, status));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AdminReservationResponse> get(@AuthenticationPrincipal AdminUser admin,
                                                         @PathVariable UUID id) {
        return ResponseEntity.ok(adminReservationService.getReservation(admin.getVenue().getId(), id));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<AdminReservationResponse> updateStatus(@AuthenticationPrincipal AdminUser admin,
                                                                   @PathVariable UUID id,
                                                                   @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(adminReservationService.updateStatus(admin.getVenue().getId(), id, body.get("status")));
    }
}
