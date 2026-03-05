CREATE TABLE reviews (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    venue_id   VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating     SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment    JSONB,
    created_at DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE(user_id, venue_id)
);
