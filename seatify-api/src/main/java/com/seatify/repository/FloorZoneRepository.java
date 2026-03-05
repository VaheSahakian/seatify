package com.seatify.repository;

import com.seatify.model.entity.FloorZone;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FloorZoneRepository extends JpaRepository<FloorZone, String> {
    List<FloorZone> findByVenueId(String venueId);
}
