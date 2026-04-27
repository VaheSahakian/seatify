package com.seatify.controller;

import com.seatify.model.entity.Favorite;
import com.seatify.model.entity.User;
import com.seatify.model.entity.Venue;
import com.seatify.repository.FavoriteRepository;
import com.seatify.repository.VenueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/favorites")
@RequiredArgsConstructor
public class FavoriteController {

    private final FavoriteRepository favoriteRepository;
    private final VenueRepository venueRepository;

    @GetMapping
    public List<String> list(@AuthenticationPrincipal User user) {
        return favoriteRepository.findByUserId(user.getId())
                .stream().map(f -> f.getVenue().getId()).toList();
    }

    @PostMapping("/{venueId}")
    public ResponseEntity<?> add(@AuthenticationPrincipal User user, @PathVariable String venueId) {
        if (favoriteRepository.existsByUserIdAndVenueId(user.getId(), venueId)) {
            return ResponseEntity.ok().build();
        }
        Venue venue = venueRepository.findById(venueId).orElseThrow();
        Favorite fav = new Favorite();
        fav.setUser(user);
        fav.setVenue(venue);
        favoriteRepository.save(fav);
        return ResponseEntity.status(201).build();
    }

    @DeleteMapping("/{venueId}")
    @Transactional
    public ResponseEntity<?> remove(@AuthenticationPrincipal User user, @PathVariable String venueId) {
        favoriteRepository.deleteByUserIdAndVenueId(user.getId(), venueId);
        return ResponseEntity.noContent().build();
    }
}
