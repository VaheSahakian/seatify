package com.seatify.dto.response;

import com.seatify.model.entity.AdminUser;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AdminUserResponse {
    private String id;
    private String venueId;
    private String name;
    private String email;
    private String phone;
    private String role;

    public static AdminUserResponse from(AdminUser admin) {
        return AdminUserResponse.builder()
                .id(admin.getId().toString())
                .venueId(admin.getVenue().getId())
                .name(admin.getName())
                .email(admin.getEmail())
                .phone(admin.getPhone())
                .role(admin.getRole())
                .build();
    }
}
