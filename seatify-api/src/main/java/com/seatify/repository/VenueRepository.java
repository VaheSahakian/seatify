package com.seatify.repository;

import com.seatify.model.entity.Venue;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VenueRepository extends JpaRepository<Venue, String> {
    Optional<Venue> findBySlug(String slug);
}
