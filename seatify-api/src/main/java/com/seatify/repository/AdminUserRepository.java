package com.seatify.repository;

import com.seatify.model.entity.AdminUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface AdminUserRepository extends JpaRepository<AdminUser, UUID> {
    Optional<AdminUser> findByEmail(String email);
    Optional<AdminUser> findByVenueId(String venueId);
}
