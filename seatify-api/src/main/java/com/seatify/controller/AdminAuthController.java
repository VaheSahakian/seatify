package com.seatify.controller;

import com.seatify.dto.request.AdminLoginRequest;
import com.seatify.dto.request.RefreshRequest;
import com.seatify.dto.response.AdminAuthResponse;
import com.seatify.dto.response.AdminUserResponse;
import com.seatify.model.entity.AdminUser;
import com.seatify.service.AdminAuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/auth")
@RequiredArgsConstructor
public class AdminAuthController {

    private final AdminAuthService adminAuthService;

    @PostMapping("/login")
    public ResponseEntity<AdminAuthResponse> login(@Valid @RequestBody AdminLoginRequest request) {
        return ResponseEntity.ok(adminAuthService.login(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<AdminAuthResponse> refresh(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(adminAuthService.refresh(request.getRefreshToken()));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@AuthenticationPrincipal AdminUser admin) {
        adminAuthService.logout(admin.getId());
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/me")
    public ResponseEntity<AdminUserResponse> me(@AuthenticationPrincipal AdminUser admin) {
        return ResponseEntity.ok(adminAuthService.getMe(admin.getId()));
    }
}
