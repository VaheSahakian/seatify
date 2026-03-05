package com.seatify.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AdminAuthResponse {
    private AdminUserResponse admin;
    private String accessToken;
    private String refreshToken;
}
