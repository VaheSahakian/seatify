-- =============================================
-- V11: Seed one admin user per venue (password = "admin123")
-- BCrypt hash of "admin123": $2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2
-- =============================================

-- We generate the hash at migration time using a known BCrypt output
-- password: admin123
INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000001', 'v1', 'Yasaman Admin', 'admin-yasaman@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 11 803333', 'owner'),
('d0000000-0000-0000-0000-000000000002', 'v2', 'De Angelo Admin', 'admin-deangelo@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 545454', 'owner'),
('d0000000-0000-0000-0000-000000000003', 'v3', 'Mamma Mia Admin', 'admin-mammamia@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 999777', 'owner'),
('d0000000-0000-0000-0000-000000000004', 'v4', 'Twins Admin', 'admin-twins@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 55 887766', 'owner'),
('d0000000-0000-0000-0000-000000000005', 'v5', 'Sirelis Admin', 'admin-sirelis@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 94 121212', 'owner');
