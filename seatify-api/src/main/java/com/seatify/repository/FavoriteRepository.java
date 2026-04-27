package com.seatify.repository;

import com.seatify.model.entity.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {

    List<Favorite> findByUserId(UUID userId);

    Optional<Favorite> findByUserIdAndVenueId(UUID userId, String venueId);

    boolean existsByUserIdAndVenueId(UUID userId, String venueId);

    void deleteByUserIdAndVenueId(UUID userId, String venueId);
}
