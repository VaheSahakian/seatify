CREATE TABLE venues (
    id                VARCHAR(20) PRIMARY KEY,
    name              VARCHAR(200) NOT NULL,
    slug              VARCHAR(200) NOT NULL UNIQUE,
    description       JSONB,
    cuisine           VARCHAR[] NOT NULL DEFAULT '{}',
    price_range       SMALLINT NOT NULL DEFAULT 2,
    rating            NUMERIC(2,1) NOT NULL DEFAULT 0,
    review_count      INTEGER NOT NULL DEFAULT 0,
    address           VARCHAR(300),
    latitude          DOUBLE PRECISION,
    longitude         DOUBLE PRECISION,
    phone             VARCHAR(30),
    features          VARCHAR[] NOT NULL DEFAULT '{}',
    policies          JSONB,
    floor_plan_width  INTEGER,
    floor_plan_height INTEGER
);

CREATE TABLE venue_images (
    id         SERIAL PRIMARY KEY,
    venue_id   VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    url        VARCHAR(500) NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE venue_hours (
    id         SERIAL PRIMARY KEY,
    venue_id   VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    day        VARCHAR(20) NOT NULL,
    open_time  VARCHAR(5) NOT NULL,
    close_time VARCHAR(5) NOT NULL
);
