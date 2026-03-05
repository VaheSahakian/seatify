package com.seatify.service;

import com.seatify.dto.request.LoginRequest;
import com.seatify.dto.request.RegisterRequest;
import com.seatify.dto.request.UpdateProfileRequest;
import com.seatify.dto.response.AuthResponse;
import com.seatify.dto.response.UserResponse;
import com.seatify.exception.BadRequestException;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.RefreshToken;
import com.seatify.model.entity.User;
import com.seatify.repository.RefreshTokenRepository;
import com.seatify.repository.UserRepository;
import com.seatify.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new BadRequestException("Email already registered");
        }

        User user = User.builder()
                .name(request.getName())
                .email(request.getEmail())
                .passwordHash(passwordEncoder.encode(request.getPassword()))
                .phone(request.getPhone())
                .language(request.getLanguage() != null ? request.getLanguage() : "en")
                .build();

        user = userRepository.save(user);
        return createAuthResponse(user);
    }

    @Transactional
    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new BadRequestException("Invalid email or password"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            throw new BadRequestException("Invalid email or password");
        }

        return createAuthResponse(user);
    }

    @Transactional
    public AuthResponse refresh(String refreshTokenStr) {
        RefreshToken refreshToken = refreshTokenRepository.findByTokenAndRevokedFalse(refreshTokenStr)
                .orElseThrow(() -> new BadRequestException("Invalid or expired refresh token"));

        if (refreshToken.getExpiresAt().isBefore(OffsetDateTime.now())) {
            refreshToken.setRevoked(true);
            refreshTokenRepository.save(refreshToken);
            throw new BadRequestException("Refresh token expired");
        }

        // Revoke old token
        refreshToken.setRevoked(true);
        refreshTokenRepository.save(refreshToken);

        // Issue new tokens
        User user = refreshToken.getUser();
        return createAuthResponse(user);
    }

    @Transactional
    public void logout(UUID userId) {
        refreshTokenRepository.revokeAllByUserId(userId);
    }

    public UserResponse getMe(UUID userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        return UserResponse.from(user);
    }

    @Transactional
    public UserResponse updateProfile(UUID userId, UpdateProfileRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (request.getName() != null) user.setName(request.getName());
        if (request.getPhone() != null) user.setPhone(request.getPhone());
        if (request.getLanguage() != null) user.setLanguage(request.getLanguage());
        if (request.getAvatar() != null) user.setAvatar(request.getAvatar());

        user = userRepository.save(user);
        return UserResponse.from(user);
    }

    private AuthResponse createAuthResponse(User user) {
        String accessToken = jwtTokenProvider.generateAccessToken(user.getId(), user.getEmail());
        String refreshTokenStr = jwtTokenProvider.generateRefreshToken();

        RefreshToken refreshToken = RefreshToken.builder()
                .user(user)
                .token(refreshTokenStr)
                .expiresAt(OffsetDateTime.now().plusNanos(jwtTokenProvider.getRefreshTokenExpiration() * 1_000_000))
                .build();
        refreshTokenRepository.save(refreshToken);

        return AuthResponse.builder()
                .user(UserResponse.from(user))
                .accessToken(accessToken)
                .refreshToken(refreshTokenStr)
                .build();
    }
}
