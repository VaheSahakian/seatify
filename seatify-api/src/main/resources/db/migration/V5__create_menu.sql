CREATE TABLE menu_categories (
    id         VARCHAR(20) PRIMARY KEY,
    venue_id   VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    name       JSONB NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE menu_items (
    id          VARCHAR(20) PRIMARY KEY,
    category_id VARCHAR(20) NOT NULL REFERENCES menu_categories(id) ON DELETE CASCADE,
    venue_id    VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    name        JSONB NOT NULL,
    description JSONB,
    price       INTEGER NOT NULL DEFAULT 0,
    image       VARCHAR(500),
    tags        VARCHAR[] NOT NULL DEFAULT '{}',
    sort_order  INTEGER NOT NULL DEFAULT 0
);
