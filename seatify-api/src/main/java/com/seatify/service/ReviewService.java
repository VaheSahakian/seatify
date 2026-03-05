package com.seatify.service;

import com.seatify.dto.request.CreateReviewRequest;
import com.seatify.dto.response.ReviewResponse;
import com.seatify.exception.BadRequestException;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.Review;
import com.seatify.model.entity.User;
import com.seatify.model.entity.Venue;
import com.seatify.repository.ReviewRepository;
import com.seatify.repository.UserRepository;
import com.seatify.repository.VenueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final VenueRepository venueRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public Page<ReviewResponse> listByVenue(String venueId, int page, int size) {
        if (!venueRepository.existsById(venueId)) {
            throw new ResourceNotFoundException("Venue not found");
        }
        return reviewRepository.findByVenueIdOrderByCreatedAtDesc(venueId, PageRequest.of(page, size))
                .map(ReviewResponse::from);
    }

    @Transactional
    public ReviewResponse create(UUID userId, String venueId, CreateReviewRequest request) {
        if (reviewRepository.existsByUserIdAndVenueId(userId, venueId)) {
            throw new BadRequestException("You have already reviewed this venue");
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        Review review = Review.builder()
                .user(user)
                .venue(venue)
                .rating(request.getRating())
                .comment(request.getComment())
                .build();

        review = reviewRepository.save(review);

        // Update venue rating and review count
        updateVenueRating(venue);

        return ReviewResponse.from(review);
    }

    private void updateVenueRating(Venue venue) {
        Double avg = reviewRepository.averageRatingByVenueId(venue.getId());
        long count = reviewRepository.countByVenueId(venue.getId());

        venue.setRating(BigDecimal.valueOf(avg).setScale(1, RoundingMode.HALF_UP));
        venue.setReviewCount((int) count);
        venueRepository.save(venue);
    }
}
