package com.seatify.controller;

import com.seatify.dto.request.CreateReviewRequest;
import com.seatify.dto.response.*;
import com.seatify.model.entity.User;
import com.seatify.service.ReviewService;
import com.seatify.service.VenueService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/venues")
@RequiredArgsConstructor
public class VenueController {

    private final VenueService venueService;
    private final ReviewService reviewService;

    @GetMapping
    public ResponseEntity<List<VenueListResponse>> listVenues() {
        return ResponseEntity.ok(venueService.listVenues());
    }

    @GetMapping("/search")
    public ResponseEntity<List<VenueListResponse>> searchVenues(@RequestParam(required = false) String dish) {
        if (dish != null && !dish.isBlank()) {
            return ResponseEntity.ok(venueService.searchByDish(dish));
        }
        return ResponseEntity.ok(venueService.listVenues());
    }

    @GetMapping("/{slug}")
    public ResponseEntity<VenueDetailResponse> getVenue(@PathVariable String slug) {
        return ResponseEntity.ok(venueService.getVenueBySlug(slug));
    }

    @GetMapping("/{id}/availability")
    public ResponseEntity<AvailabilityResponse> getAvailability(
            @PathVariable String id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam String time,
            @RequestParam short partySize) {
        return ResponseEntity.ok(venueService.getAvailability(id, date, time, partySize));
    }

    @GetMapping("/{id}/reviews")
    public ResponseEntity<Page<ReviewResponse>> getReviews(
            @PathVariable String id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(reviewService.listByVenue(id, page, size));
    }

    @PostMapping("/{id}/reviews")
    public ResponseEntity<ReviewResponse> createReview(
            @PathVariable String id,
            @AuthenticationPrincipal User user,
            @Valid @RequestBody CreateReviewRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(reviewService.create(user.getId(), id, request));
    }
}
