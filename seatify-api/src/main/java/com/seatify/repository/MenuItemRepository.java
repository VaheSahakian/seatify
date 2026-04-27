package com.seatify.repository;

import com.seatify.model.entity.MenuItem;
import com.seatify.model.entity.Venue;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MenuItemRepository extends JpaRepository<MenuItem, String> {

    @Query(value = "SELECT DISTINCT v.* FROM menu_items mi JOIN venues v ON mi.venue_id = v.id WHERE mi.name::text ILIKE CONCAT('%', :query, '%')", nativeQuery = true)
    List<Venue> findVenuesByDishName(@Param("query") String query);
}
