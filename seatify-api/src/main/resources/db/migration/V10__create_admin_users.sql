-- =============================================
-- V10: Admin users and refresh tokens
-- =============================================

CREATE TABLE admin_users (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    venue_id    VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    phone       VARCHAR(20),
    role        VARCHAR(20) NOT NULL DEFAULT 'owner',
    active      BOOLEAN NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX idx_admin_users_venue_owner ON admin_users(venue_id) WHERE role = 'owner';

CREATE TABLE admin_refresh_tokens (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    admin_id    UUID NOT NULL REFERENCES admin_users(id) ON DELETE CASCADE,
    token       VARCHAR(500) NOT NULL UNIQUE,
    expires_at  TIMESTAMPTZ NOT NULL,
    revoked     BOOLEAN NOT NULL DEFAULT false
);
