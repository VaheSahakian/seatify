-- =============================================
-- V19: Add rotation column to floor_tables for editor support
-- =============================================

ALTER TABLE floor_tables
    ADD COLUMN rotation INT NOT NULL DEFAULT 0;
