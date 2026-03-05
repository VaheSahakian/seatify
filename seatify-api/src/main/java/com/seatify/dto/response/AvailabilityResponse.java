package com.seatify.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class AvailabilityResponse {
    private List<VenueDetailResponse.TableResponse> availableTables;
}
