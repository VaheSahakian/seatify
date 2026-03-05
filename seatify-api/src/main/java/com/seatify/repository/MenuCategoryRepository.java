package com.seatify.repository;

import com.seatify.model.entity.MenuCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MenuCategoryRepository extends JpaRepository<MenuCategory, String> {
    List<MenuCategory> findByVenueIdOrderBySortOrderAsc(String venueId);
}
