package com.seatify.service;

import com.seatify.dto.request.*;
import com.seatify.dto.response.VenueDetailResponse;
import com.seatify.exception.BadRequestException;
import com.seatify.exception.ResourceNotFoundException;
import com.seatify.model.entity.*;
import com.seatify.model.enums.TableShape;
import com.seatify.model.enums.TableStatus;
import com.seatify.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AdminVenueService {

    private final VenueRepository venueRepository;
    private final MenuCategoryRepository menuCategoryRepository;
    private final MenuItemRepository menuItemRepository;
    private final FloorZoneRepository floorZoneRepository;
    private final FloorTableRepository floorTableRepository;
    private final VenueHoursRepository venueHoursRepository;
    private final VenueImageRepository venueImageRepository;

    @Transactional(readOnly = true)
    public VenueDetailResponse getVenue(String venueId) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));
        return VenueDetailResponse.from(venue);
    }

    @Transactional
    public VenueDetailResponse updateVenue(String venueId, UpdateVenueRequest request) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        if (request.getName() != null) venue.setName(request.getName());
        if (request.getDescription() != null) venue.setDescription(request.getDescription());
        if (request.getCuisine() != null) venue.setCuisine(request.getCuisine());
        if (request.getPriceRange() != null) venue.setPriceRange(request.getPriceRange());
        if (request.getAddress() != null) venue.setAddress(request.getAddress());
        if (request.getPhone() != null) venue.setPhone(request.getPhone());
        if (request.getFeatures() != null) venue.setFeatures(request.getFeatures());
        if (request.getPolicies() != null) venue.setPolicies(request.getPolicies());

        venue = venueRepository.save(venue);
        return VenueDetailResponse.from(venue);
    }

    // ── Menu Categories ──────────────────────────────────────────

    @Transactional
    public MenuCategory createMenuCategory(String venueId, UpsertMenuCategoryRequest request) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        MenuCategory category = MenuCategory.builder()
                .id(venueId + "-cat-" + UUID.randomUUID().toString().substring(0, 8))
                .venue(venue)
                .name(request.getName())
                .sortOrder(request.getSortOrder() != null ? request.getSortOrder() : 0)
                .build();

        return menuCategoryRepository.save(category);
    }

    @Transactional
    public MenuCategory updateMenuCategory(String venueId, String categoryId, UpsertMenuCategoryRequest request) {
        MenuCategory category = menuCategoryRepository.findById(categoryId)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found"));
        if (!category.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Category does not belong to this venue");
        }

        if (request.getName() != null) category.setName(request.getName());
        if (request.getSortOrder() != null) category.setSortOrder(request.getSortOrder());

        return menuCategoryRepository.save(category);
    }

    @Transactional
    public void deleteMenuCategory(String venueId, String categoryId) {
        MenuCategory category = menuCategoryRepository.findById(categoryId)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found"));
        if (!category.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Category does not belong to this venue");
        }
        menuCategoryRepository.delete(category);
    }

    // ── Menu Items ───────────────────────────────────────────────

    @Transactional
    public MenuItem createMenuItem(String venueId, UpsertMenuItemRequest request) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));
        MenuCategory category = menuCategoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new ResourceNotFoundException("Category not found"));
        if (!category.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Category does not belong to this venue");
        }

        MenuItem item = MenuItem.builder()
                .id(venueId + "-item-" + UUID.randomUUID().toString().substring(0, 8))
                .venue(venue)
                .category(category)
                .name(request.getName())
                .description(request.getDescription())
                .price(request.getPrice() != null ? request.getPrice() : 0)
                .image(request.getImage())
                .tags(request.getTags() != null ? request.getTags() : new String[]{})
                .sortOrder(request.getSortOrder() != null ? request.getSortOrder() : 0)
                .build();

        return menuItemRepository.save(item);
    }

    @Transactional
    public MenuItem updateMenuItem(String venueId, String itemId, UpsertMenuItemRequest request) {
        MenuItem item = menuItemRepository.findById(itemId)
                .orElseThrow(() -> new ResourceNotFoundException("Menu item not found"));
        if (!item.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Item does not belong to this venue");
        }

        if (request.getCategoryId() != null) {
            MenuCategory category = menuCategoryRepository.findById(request.getCategoryId())
                    .orElseThrow(() -> new ResourceNotFoundException("Category not found"));
            item.setCategory(category);
        }
        if (request.getName() != null) item.setName(request.getName());
        if (request.getDescription() != null) item.setDescription(request.getDescription());
        if (request.getPrice() != null) item.setPrice(request.getPrice());
        if (request.getImage() != null) item.setImage(request.getImage());
        if (request.getTags() != null) item.setTags(request.getTags());
        if (request.getSortOrder() != null) item.setSortOrder(request.getSortOrder());

        return menuItemRepository.save(item);
    }

    @Transactional
    public void deleteMenuItem(String venueId, String itemId) {
        MenuItem item = menuItemRepository.findById(itemId)
                .orElseThrow(() -> new ResourceNotFoundException("Menu item not found"));
        if (!item.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Item does not belong to this venue");
        }
        menuItemRepository.delete(item);
    }

    // ── Floor Zones ──────────────────────────────────────────────

    @Transactional
    public FloorZone createFloorZone(String venueId, UpsertFloorZoneRequest request) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        FloorZone zone = FloorZone.builder()
                .id(venueId + "-z-" + UUID.randomUUID().toString().substring(0, 8))
                .venue(venue)
                .name(request.getName())
                .x(request.getX())
                .y(request.getY())
                .width(request.getWidth())
                .height(request.getHeight())
                .color(request.getColor())
                .build();

        return floorZoneRepository.save(zone);
    }

    @Transactional
    public FloorZone updateFloorZone(String venueId, String zoneId, UpsertFloorZoneRequest request) {
        FloorZone zone = floorZoneRepository.findById(zoneId)
                .orElseThrow(() -> new ResourceNotFoundException("Zone not found"));
        if (!zone.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Zone does not belong to this venue");
        }

        if (request.getName() != null) zone.setName(request.getName());
        if (request.getX() != null) zone.setX(request.getX());
        if (request.getY() != null) zone.setY(request.getY());
        if (request.getWidth() != null) zone.setWidth(request.getWidth());
        if (request.getHeight() != null) zone.setHeight(request.getHeight());
        if (request.getColor() != null) zone.setColor(request.getColor());

        return floorZoneRepository.save(zone);
    }

    @Transactional
    public void deleteFloorZone(String venueId, String zoneId) {
        FloorZone zone = floorZoneRepository.findById(zoneId)
                .orElseThrow(() -> new ResourceNotFoundException("Zone not found"));
        if (!zone.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Zone does not belong to this venue");
        }
        floorZoneRepository.delete(zone);
    }

    // ── Floor Tables ─────────────────────────────────────────────

    @Transactional
    public FloorTable createFloorTable(String venueId, UpsertFloorTableRequest request) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));
        FloorZone zone = floorZoneRepository.findById(request.getZoneId())
                .orElseThrow(() -> new ResourceNotFoundException("Zone not found"));
        if (!zone.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Zone does not belong to this venue");
        }

        FloorTable table = FloorTable.builder()
                .id(venueId + "-t-" + UUID.randomUUID().toString().substring(0, 8))
                .venue(venue)
                .zone(zone)
                .x(request.getX())
                .y(request.getY())
                .width(request.getWidth())
                .height(request.getHeight())
                .shape(request.getShape() != null ? TableShape.valueOf(request.getShape()) : TableShape.rect)
                .seats(request.getSeats() != null ? request.getSeats() : 2)
                .label(request.getLabel())
                .defaultStatus(request.getDefaultStatus() != null ? TableStatus.valueOf(request.getDefaultStatus()) : TableStatus.available)
                .build();

        return floorTableRepository.save(table);
    }

    @Transactional
    public FloorTable updateFloorTable(String venueId, String tableId, UpsertFloorTableRequest request) {
        FloorTable table = floorTableRepository.findById(tableId)
                .orElseThrow(() -> new ResourceNotFoundException("Table not found"));
        if (!table.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Table does not belong to this venue");
        }

        if (request.getZoneId() != null) {
            FloorZone zone = floorZoneRepository.findById(request.getZoneId())
                    .orElseThrow(() -> new ResourceNotFoundException("Zone not found"));
            table.setZone(zone);
        }
        if (request.getX() != null) table.setX(request.getX());
        if (request.getY() != null) table.setY(request.getY());
        if (request.getWidth() != null) table.setWidth(request.getWidth());
        if (request.getHeight() != null) table.setHeight(request.getHeight());
        if (request.getShape() != null) table.setShape(TableShape.valueOf(request.getShape()));
        if (request.getSeats() != null) table.setSeats(request.getSeats());
        if (request.getLabel() != null) table.setLabel(request.getLabel());
        if (request.getDefaultStatus() != null) table.setDefaultStatus(TableStatus.valueOf(request.getDefaultStatus()));

        return floorTableRepository.save(table);
    }

    @Transactional
    public void deleteFloorTable(String venueId, String tableId) {
        FloorTable table = floorTableRepository.findById(tableId)
                .orElseThrow(() -> new ResourceNotFoundException("Table not found"));
        if (!table.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Table does not belong to this venue");
        }
        floorTableRepository.delete(table);
    }

    // ── Hours ────────────────────────────────────────────────────

    @Transactional
    public List<VenueHours> replaceHours(String venueId, List<UpsertVenueHoursRequest> requests) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        venueHoursRepository.deleteByVenueId(venueId);
        venueHoursRepository.flush();

        List<VenueHours> hours = requests.stream()
                .map(r -> VenueHours.builder()
                        .venue(venue)
                        .day(r.getDay())
                        .openTime(r.getOpenTime())
                        .closeTime(r.getCloseTime())
                        .build())
                .toList();

        return venueHoursRepository.saveAll(hours);
    }

    // ── Images ───────────────────────────────────────────────────

    @Transactional
    public VenueImage addImage(String venueId, AddVenueImageRequest request) {
        Venue venue = venueRepository.findById(venueId)
                .orElseThrow(() -> new ResourceNotFoundException("Venue not found"));

        VenueImage image = VenueImage.builder()
                .venue(venue)
                .url(request.getUrl())
                .sortOrder(request.getSortOrder() != null ? request.getSortOrder() : 0)
                .build();

        return venueImageRepository.save(image);
    }

    @Transactional
    public void deleteImage(String venueId, Integer imageId) {
        VenueImage image = venueImageRepository.findById(imageId)
                .orElseThrow(() -> new ResourceNotFoundException("Image not found"));
        if (!image.getVenue().getId().equals(venueId)) {
            throw new BadRequestException("Image does not belong to this venue");
        }
        venueImageRepository.delete(image);
    }
}
