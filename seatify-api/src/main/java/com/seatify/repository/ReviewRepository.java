package com.seatify.repository;

import com.seatify.model.entity.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface ReviewRepository extends JpaRepository<Review, UUID> {
    Page<Review> findByVenueIdOrderByCreatedAtDesc(String venueId, Pageable pageable);

    boolean existsByUserIdAndVenueId(UUID userId, String venueId);

    @Query("SELECT COALESCE(AVG(r.rating), 0) FROM Review r WHERE r.venue.id = :venueId")
    Double averageRatingByVenueId(String venueId);

    long countByVenueId(String venueId);
}
