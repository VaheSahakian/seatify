package com.seatify.service;

import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    /**
     * Mock payment processing. Always succeeds for card payments.
     */
    public String processPayment(String method, int amount) {
        if ("card".equalsIgnoreCase(method)) {
            return "success";
        }
        // Cash payments are always pending until in-person
        return "pending";
    }
}
