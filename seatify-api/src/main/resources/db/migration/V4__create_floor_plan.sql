CREATE TABLE floor_zones (
    id       VARCHAR(20) PRIMARY KEY,
    venue_id VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    name     JSONB NOT NULL,
    x        INTEGER NOT NULL DEFAULT 0,
    y        INTEGER NOT NULL DEFAULT 0,
    width    INTEGER NOT NULL,
    height   INTEGER NOT NULL,
    color    VARCHAR(20)
);

CREATE TABLE floor_tables (
    id             VARCHAR(20) PRIMARY KEY,
    venue_id       VARCHAR(20) NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
    zone_id        VARCHAR(20) NOT NULL REFERENCES floor_zones(id) ON DELETE CASCADE,
    x              INTEGER NOT NULL DEFAULT 0,
    y              INTEGER NOT NULL DEFAULT 0,
    width          INTEGER NOT NULL,
    height         INTEGER NOT NULL,
    shape          VARCHAR(10) NOT NULL DEFAULT 'rect',
    seats          SMALLINT NOT NULL DEFAULT 2,
    label          VARCHAR(10),
    default_status VARCHAR(20) NOT NULL DEFAULT 'available'
);
