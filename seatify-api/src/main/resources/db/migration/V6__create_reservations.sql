CREATE TABLE reservations (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id        UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    venue_id       VARCHAR(20) NOT NULL REFERENCES venues(id),
    table_id       VARCHAR(20) NOT NULL REFERENCES floor_tables(id),
    date           DATE NOT NULL,
    time           VARCHAR(5) NOT NULL,
    party_size     SMALLINT NOT NULL,
    status         VARCHAR(20) NOT NULL DEFAULT 'upcoming',
    total_amount   INTEGER NOT NULL DEFAULT 0,
    qr_code        VARCHAR(100) NOT NULL UNIQUE,
    payment_method VARCHAR(10),
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_reservations_table_date ON reservations(table_id, date);

CREATE TABLE pre_order_items (
    id             SERIAL PRIMARY KEY,
    reservation_id UUID NOT NULL REFERENCES reservations(id) ON DELETE CASCADE,
    menu_item_id   VARCHAR(20) NOT NULL REFERENCES menu_items(id),
    quantity       SMALLINT NOT NULL DEFAULT 1,
    unit_price     INTEGER NOT NULL DEFAULT 0
);
