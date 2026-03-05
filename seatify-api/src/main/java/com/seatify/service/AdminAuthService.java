package com.seatify.service;

import com.seatify.dto.request.AdminLoginRequest;
import com.seatify.dto.response.AdminAuthResponse;
import com.seatify.dto.response.AdminUserResponse;
import com.seatify.exception.BadRequestException;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.AdminRefreshToken;
import com.seatify.model.entity.AdminUser;
import com.seatify.repository.AdminRefreshTokenRepository;
import com.seatify.repository.AdminUserRepository;
import com.seatify.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AdminAuthService {

    private final AdminUserRepository adminUserRepository;
    private final AdminRefreshTokenRepository adminRefreshTokenRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public AdminAuthResponse login(AdminLoginRequest request) {
        AdminUser admin = adminUserRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new BadRequestException("Invalid email or password"));

        if (!admin.getActive()) {
            throw new BadRequestException("Account is deactivated");
        }

        if (!passwordEncoder.matches(request.getPassword(), admin.getPasswordHash())) {
            throw new BadRequestException("Invalid email or password");
        }

        return createAuthResponse(admin);
    }

    @Transactional
    public AdminAuthResponse refresh(String refreshTokenStr) {
        AdminRefreshToken refreshToken = adminRefreshTokenRepository.findByTokenAndRevokedFalse(refreshTokenStr)
                .orElseThrow(() -> new BadRequestException("Invalid or expired refresh token"));

        if (refreshToken.getExpiresAt().isBefore(OffsetDateTime.now())) {
            refreshToken.setRevoked(true);
            adminRefreshTokenRepository.save(refreshToken);
            throw new BadRequestException("Refresh token expired");
        }

        refreshToken.setRevoked(true);
        adminRefreshTokenRepository.save(refreshToken);

        AdminUser admin = refreshToken.getAdmin();
        return createAuthResponse(admin);
    }

    @Transactional
    public void logout(UUID adminId) {
        adminRefreshTokenRepository.revokeAllByAdminId(adminId);
    }

    public AdminUserResponse getMe(UUID adminId) {
        AdminUser admin = adminUserRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Admin not found"));
        return AdminUserResponse.from(admin);
    }

    private AdminAuthResponse createAuthResponse(AdminUser admin) {
        String accessToken = jwtTokenProvider.generateAdminAccessToken(admin.getId(), admin.getEmail());
        String refreshTokenStr = jwtTokenProvider.generateRefreshToken();

        AdminRefreshToken refreshToken = AdminRefreshToken.builder()
                .admin(admin)
                .token(refreshTokenStr)
                .expiresAt(OffsetDateTime.now().plusNanos(jwtTokenProvider.getRefreshTokenExpiration() * 1_000_000))
                .build();
        adminRefreshTokenRepository.save(refreshToken);

        return AdminAuthResponse.builder()
                .admin(AdminUserResponse.from(admin))
                .accessToken(accessToken)
                .refreshToken(refreshTokenStr)
                .build();
    }
}
