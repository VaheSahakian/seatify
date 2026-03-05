package com.seatify.repository;

import com.seatify.model.entity.AdminRefreshToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface AdminRefreshTokenRepository extends JpaRepository<AdminRefreshToken, UUID> {
    Optional<AdminRefreshToken> findByTokenAndRevokedFalse(String token);

    @Modifying
    @Query("UPDATE AdminRefreshToken t SET t.revoked = true WHERE t.admin.id = :adminId")
    void revokeAllByAdminId(UUID adminId);
}
