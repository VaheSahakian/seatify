package com.seatify.repository;

import com.seatify.model.entity.VenueImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VenueImageRepository extends JpaRepository<VenueImage, Integer> {
    List<VenueImage> findByVenueIdOrderBySortOrderAsc(String venueId);
}
