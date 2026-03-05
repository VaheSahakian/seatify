package com.seatify.dto.response;

import com.seatify.model.entity.Reservation;
import com.seatify.model.entity.PreOrderItem;
import com.seatify.model.entity.VenueImage;
import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Builder
public class ReservationResponse {
    private String id;
    private String venueId;
    private String venueName;
    private String venueImage;
    private String date;
    private String time;
    private Short partySize;
    private String tableId;
    private String tableLabel;
    private String status;
    private List<PreOrderResponse> preOrder;
    private Integer totalAmount;
    private String qrCode;
    private String paymentMethod;
    private String paymentStatus;
    private String createdAt;

    @Data @Builder
    public static class PreOrderResponse {
        private PreOrderMenuItemResponse menuItem;
        private Short quantity;
        private String venueId;
    }

    @Data @Builder
    public static class PreOrderMenuItemResponse {
        private String id;
        private Map<String, String> name;
        private Map<String, String> description;
        private Integer price;
        private String[] tags;
    }

    public static ReservationResponse from(Reservation r) {
        List<VenueImage> venueImages = r.getVenue().getImages();
        String venueImage = venueImages.isEmpty() ? null : venueImages.get(0).getUrl();

        return ReservationResponse.builder()
                .id(r.getId().toString())
                .venueId(r.getVenue().getId())
                .venueName(r.getVenue().getName())
                .venueImage(venueImage)
                .date(r.getDate().toString())
                .time(r.getTime())
                .partySize(r.getPartySize())
                .tableId(r.getTable().getId())
                .tableLabel(r.getTable().getLabel())
                .status(r.getStatus().name())
                .preOrder(r.getPreOrderItems().stream().map(poi -> PreOrderResponse.builder()
                        .menuItem(PreOrderMenuItemResponse.builder()
                                .id(poi.getMenuItem().getId())
                                .name(poi.getMenuItem().getName())
                                .description(poi.getMenuItem().getDescription())
                                .price(poi.getUnitPrice())
                                .tags(poi.getMenuItem().getTags())
                                .build())
                        .quantity(poi.getQuantity())
                        .venueId(r.getVenue().getId())
                        .build()).toList())
                .totalAmount(r.getTotalAmount())
                .qrCode(r.getQrCode())
                .paymentMethod(r.getPaymentMethod())
                .paymentStatus(r.getPaymentStatus())
                .createdAt(r.getCreatedAt().toString())
                .build();
    }
}
