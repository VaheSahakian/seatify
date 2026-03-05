package com.seatify.controller;

import com.seatify.dto.request.*;
import com.seatify.dto.response.VenueDetailResponse;
import com.seatify.model.entity.*;
import com.seatify.service.AdminVenueService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/venue")
@RequiredArgsConstructor
public class AdminVenueController {

    private final AdminVenueService adminVenueService;

    // ── Venue Info ───────────────────────────────────────────────

    @GetMapping
    public ResponseEntity<VenueDetailResponse> getVenue(@AuthenticationPrincipal AdminUser admin) {
        return ResponseEntity.ok(adminVenueService.getVenue(admin.getVenue().getId()));
    }

    @PatchMapping
    public ResponseEntity<VenueDetailResponse> updateVenue(@AuthenticationPrincipal AdminUser admin,
                                                            @RequestBody UpdateVenueRequest request) {
        return ResponseEntity.ok(adminVenueService.updateVenue(admin.getVenue().getId(), request));
    }

    // ── Menu Categories ──────────────────────────────────────────

    @PostMapping("/menu/categories")
    public ResponseEntity<Map<String, Object>> createCategory(@AuthenticationPrincipal AdminUser admin,
                                                               @Valid @RequestBody UpsertMenuCategoryRequest request) {
        MenuCategory cat = adminVenueService.createMenuCategory(admin.getVenue().getId(), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "id", cat.getId(), "name", cat.getName(), "sortOrder", cat.getSortOrder()));
    }

    @PutMapping("/menu/categories/{id}")
    public ResponseEntity<Map<String, Object>> updateCategory(@AuthenticationPrincipal AdminUser admin,
                                                               @PathVariable String id,
                                                               @Valid @RequestBody UpsertMenuCategoryRequest request) {
        MenuCategory cat = adminVenueService.updateMenuCategory(admin.getVenue().getId(), id, request);
        return ResponseEntity.ok(Map.of("id", cat.getId(), "name", cat.getName(), "sortOrder", cat.getSortOrder()));
    }

    @DeleteMapping("/menu/categories/{id}")
    public ResponseEntity<Void> deleteCategory(@AuthenticationPrincipal AdminUser admin, @PathVariable String id) {
        adminVenueService.deleteMenuCategory(admin.getVenue().getId(), id);
        return ResponseEntity.noContent().build();
    }

    // ── Menu Items ───────────────────────────────────────────────

    @PostMapping("/menu/items")
    public ResponseEntity<Map<String, Object>> createItem(@AuthenticationPrincipal AdminUser admin,
                                                           @Valid @RequestBody UpsertMenuItemRequest request) {
        MenuItem item = adminVenueService.createMenuItem(admin.getVenue().getId(), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "id", item.getId(), "name", item.getName(), "price", item.getPrice(),
                "categoryId", item.getCategory().getId()));
    }

    @PutMapping("/menu/items/{id}")
    public ResponseEntity<Map<String, Object>> updateItem(@AuthenticationPrincipal AdminUser admin,
                                                           @PathVariable String id,
                                                           @Valid @RequestBody UpsertMenuItemRequest request) {
        MenuItem item = adminVenueService.updateMenuItem(admin.getVenue().getId(), id, request);
        return ResponseEntity.ok(Map.of(
                "id", item.getId(), "name", item.getName(), "price", item.getPrice(),
                "categoryId", item.getCategory().getId()));
    }

    @DeleteMapping("/menu/items/{id}")
    public ResponseEntity<Void> deleteItem(@AuthenticationPrincipal AdminUser admin, @PathVariable String id) {
        adminVenueService.deleteMenuItem(admin.getVenue().getId(), id);
        return ResponseEntity.noContent().build();
    }

    // ── Floor Zones ──────────────────────────────────────────────

    @PostMapping("/floor/zones")
    public ResponseEntity<Map<String, Object>> createZone(@AuthenticationPrincipal AdminUser admin,
                                                           @Valid @RequestBody UpsertFloorZoneRequest request) {
        FloorZone zone = adminVenueService.createFloorZone(admin.getVenue().getId(), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "id", zone.getId(), "name", zone.getName(), "x", zone.getX(), "y", zone.getY(),
                "width", zone.getWidth(), "height", zone.getHeight(), "color", zone.getColor() != null ? zone.getColor() : ""));
    }

    @PutMapping("/floor/zones/{id}")
    public ResponseEntity<Map<String, Object>> updateZone(@AuthenticationPrincipal AdminUser admin,
                                                           @PathVariable String id,
                                                           @Valid @RequestBody UpsertFloorZoneRequest request) {
        FloorZone zone = adminVenueService.updateFloorZone(admin.getVenue().getId(), id, request);
        return ResponseEntity.ok(Map.of(
                "id", zone.getId(), "name", zone.getName(), "x", zone.getX(), "y", zone.getY(),
                "width", zone.getWidth(), "height", zone.getHeight(), "color", zone.getColor() != null ? zone.getColor() : ""));
    }

    @DeleteMapping("/floor/zones/{id}")
    public ResponseEntity<Void> deleteZone(@AuthenticationPrincipal AdminUser admin, @PathVariable String id) {
        adminVenueService.deleteFloorZone(admin.getVenue().getId(), id);
        return ResponseEntity.noContent().build();
    }

    // ── Floor Tables ─────────────────────────────────────────────

    @PostMapping("/floor/tables")
    public ResponseEntity<Map<String, Object>> createTable(@AuthenticationPrincipal AdminUser admin,
                                                            @Valid @RequestBody UpsertFloorTableRequest request) {
        FloorTable table = adminVenueService.createFloorTable(admin.getVenue().getId(), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "id", table.getId(), "zoneId", table.getZone().getId(), "label", table.getLabel() != null ? table.getLabel() : "",
                "seats", table.getSeats(), "shape", table.getShape().name()));
    }

    @PutMapping("/floor/tables/{id}")
    public ResponseEntity<Map<String, Object>> updateTable(@AuthenticationPrincipal AdminUser admin,
                                                            @PathVariable String id,
                                                            @Valid @RequestBody UpsertFloorTableRequest request) {
        FloorTable table = adminVenueService.updateFloorTable(admin.getVenue().getId(), id, request);
        return ResponseEntity.ok(Map.of(
                "id", table.getId(), "zoneId", table.getZone().getId(), "label", table.getLabel() != null ? table.getLabel() : "",
                "seats", table.getSeats(), "shape", table.getShape().name()));
    }

    @DeleteMapping("/floor/tables/{id}")
    public ResponseEntity<Void> deleteTable(@AuthenticationPrincipal AdminUser admin, @PathVariable String id) {
        adminVenueService.deleteFloorTable(admin.getVenue().getId(), id);
        return ResponseEntity.noContent().build();
    }

    // ── Hours ────────────────────────────────────────────────────

    @PutMapping("/hours")
    public ResponseEntity<List<Map<String, String>>> replaceHours(@AuthenticationPrincipal AdminUser admin,
                                                                   @Valid @RequestBody List<UpsertVenueHoursRequest> requests) {
        List<VenueHours> hours = adminVenueService.replaceHours(admin.getVenue().getId(), requests);
        return ResponseEntity.ok(hours.stream()
                .map(h -> Map.of("day", h.getDay(), "open", h.getOpenTime(), "close", h.getCloseTime()))
                .toList());
    }

    // ── Images ───────────────────────────────────────────────────

    @PostMapping("/images")
    public ResponseEntity<Map<String, Object>> addImage(@AuthenticationPrincipal AdminUser admin,
                                                         @Valid @RequestBody AddVenueImageRequest request) {
        VenueImage image = adminVenueService.addImage(admin.getVenue().getId(), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "id", image.getId(), "url", image.getUrl(), "sortOrder", image.getSortOrder()));
    }

    @DeleteMapping("/images/{id}")
    public ResponseEntity<Void> deleteImage(@AuthenticationPrincipal AdminUser admin, @PathVariable Integer id) {
        adminVenueService.deleteImage(admin.getVenue().getId(), id);
        return ResponseEntity.noContent().build();
    }
}
