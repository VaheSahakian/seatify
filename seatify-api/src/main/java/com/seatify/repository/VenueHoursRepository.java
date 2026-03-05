package com.seatify.repository;

import com.seatify.model.entity.VenueHours;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VenueHoursRepository extends JpaRepository<VenueHours, Integer> {
    List<VenueHours> findByVenueId(String venueId);
    void deleteByVenueId(String venueId);
}
