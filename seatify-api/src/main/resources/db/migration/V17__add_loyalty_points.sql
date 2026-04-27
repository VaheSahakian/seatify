-- Add loyalty tier to users (loyalty_points already exists from V1)
ALTER TABLE users ADD COLUMN loyalty_tier VARCHAR(20) NOT NULL DEFAULT 'Bronze';

-- Points history for tracking
CREATE TABLE point_transactions (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    points INTEGER NOT NULL,
    type VARCHAR(20) NOT NULL,
    description VARCHAR(200),
    reservation_id UUID REFERENCES reservations(id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Give existing seeded users some starting points
UPDATE users SET loyalty_points = 150 WHERE email = 'anna@example.com';
UPDATE users SET loyalty_points = 80 WHERE email = 'david@example.com';
UPDATE users SET loyalty_points = 320, loyalty_tier = 'Silver' WHERE email = 'maria@example.com';
UPDATE users SET loyalty_points = 50 WHERE email = 'alex@example.com';
