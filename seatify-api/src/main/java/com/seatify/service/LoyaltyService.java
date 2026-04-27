package com.seatify.service;

import com.seatify.model.entity.PointTransaction;
import com.seatify.model.entity.Reservation;
import com.seatify.model.entity.User;
import com.seatify.repository.PointTransactionRepository;
import com.seatify.repository.ReservationRepository;
import com.seatify.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class LoyaltyService {

    private final PointTransactionRepository pointTransactionRepository;
    private final UserRepository userRepository;
    private final ReservationRepository reservationRepository;

    @Transactional
    public void awardPoints(User user, int points, String type, String description, UUID reservationId) {
        PointTransaction tx = new PointTransaction();
        tx.setUser(user);
        tx.setPoints(points);
        tx.setType(type);
        tx.setDescription(description);

        if (reservationId != null) {
            Reservation reservation = reservationRepository.findById(reservationId).orElse(null);
            tx.setReservation(reservation);
        }

        pointTransactionRepository.save(tx);

        user.setLoyaltyPoints(user.getLoyaltyPoints() + points);
        user.setLoyaltyTier(calculateTier(user.getLoyaltyPoints()));
        userRepository.save(user);
    }

    public String calculateTier(int points) {
        if (points >= 500) return "Gold";
        if (points >= 200) return "Silver";
        return "Bronze";
    }

    @Transactional(readOnly = true)
    public List<PointTransaction> getHistory(UUID userId) {
        return pointTransactionRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }
}
