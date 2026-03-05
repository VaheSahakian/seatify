-- Fix seeded user passwords to match "password123" with proper BCrypt hash
UPDATE users SET password_hash = '$2a$10$Xp9ewp7EuODDXnMSLa8Jbe/LlbEw7t/Ra8IM8n4c7maSMNCCvPyCq'
WHERE email IN ('anna@example.com', 'david@example.com', 'maria@example.com', 'alex@example.com', 'sona@example.com', 'pierre@example.com');
