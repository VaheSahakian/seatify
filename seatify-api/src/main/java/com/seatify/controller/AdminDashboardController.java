package com.seatify.controller;

import com.seatify.dto.response.AdminDashboardResponse;
import com.seatify.model.entity.AdminUser;
import com.seatify.service.AdminDashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/dashboard")
@RequiredArgsConstructor
public class AdminDashboardController {

    private final AdminDashboardService adminDashboardService;

    @GetMapping
    public ResponseEntity<AdminDashboardResponse> getDashboard(@AuthenticationPrincipal AdminUser admin) {
        return ResponseEntity.ok(adminDashboardService.getDashboard(admin.getVenue().getId()));
    }
}
