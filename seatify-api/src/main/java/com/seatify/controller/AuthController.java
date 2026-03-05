package com.seatify.controller;

import com.seatify.dto.request.LoginRequest;
import com.seatify.dto.request.RefreshRequest;
import com.seatify.dto.request.RegisterRequest;
import com.seatify.dto.request.UpdateProfileRequest;
import com.seatify.dto.response.AuthResponse;
import com.seatify.dto.response.UserResponse;
import com.seatify.model.entity.User;
import com.seatify.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(authService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(authService.refresh(request.getRefreshToken()));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@AuthenticationPrincipal User user) {
        authService.logout(user.getId());
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> me(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(authService.getMe(user.getId()));
    }

    @PatchMapping("/profile")
    public ResponseEntity<UserResponse> updateProfile(@AuthenticationPrincipal User user,
                                                       @RequestBody UpdateProfileRequest request) {
        return ResponseEntity.ok(authService.updateProfile(user.getId(), request));
    }
}
