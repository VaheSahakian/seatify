package com.seatify.dto.response;

import com.seatify.model.entity.Review;
import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class ReviewResponse {
    private String id;
    private String venueId;
    private String userId;
    private String userName;
    private String userAvatar;
    private Short rating;
    private Map<String, String> comment;
    private String date;

    public static ReviewResponse from(Review review) {
        return ReviewResponse.builder()
                .id(review.getId().toString())
                .venueId(review.getVenue().getId())
                .userId(review.getUser().getId().toString())
                .userName(review.getUser().getName())
                .userAvatar(review.getUser().getAvatar())
                .rating(review.getRating())
                .comment(review.getComment())
                .date(review.getCreatedAt().toString())
                .build();
    }
}
