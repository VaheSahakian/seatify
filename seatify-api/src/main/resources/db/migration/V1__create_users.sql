CREATE TABLE users (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    avatar        VARCHAR(500),
    loyalty_points INTEGER NOT NULL DEFAULT 0,
    cashback      NUMERIC(10,2) NOT NULL DEFAULT 0,
    language      VARCHAR(2) NOT NULL DEFAULT 'en',
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
