package com.seatify.dto.response;

import com.seatify.model.entity.User;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class UserResponse {
    private String id;
    private String name;
    private String email;
    private String phone;
    private String avatar;
    private Integer loyaltyPoints;
    private String loyaltyTier;
    private BigDecimal cashback;
    private String language;

    public static UserResponse from(User user) {
        return UserResponse.builder()
                .id(user.getId().toString())
                .name(user.getName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .avatar(user.getAvatar())
                .loyaltyPoints(user.getLoyaltyPoints())
                .loyaltyTier(user.getLoyaltyTier())
                .cashback(user.getCashback())
                .language(user.getLanguage())
                .build();
    }
}
