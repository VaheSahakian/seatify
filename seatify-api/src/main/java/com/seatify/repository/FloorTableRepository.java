package com.seatify.repository;

import com.seatify.model.entity.FloorTable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FloorTableRepository extends JpaRepository<FloorTable, String> {
    List<FloorTable> findByVenueId(String venueId);
}
