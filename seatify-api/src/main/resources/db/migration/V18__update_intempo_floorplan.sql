-- =============================================
-- V18: Update InTempo (v11) floor plan to match real layout
-- L-shaped room: upper wide section, lower narrow section, window nook
-- =============================================

DELETE FROM floor_tables WHERE venue_id = 'v11';
DELETE FROM floor_zones WHERE venue_id = 'v11';

UPDATE venues SET floor_plan_width = 480, floor_plan_height = 620 WHERE id = 'v11';

-- 3 zones forming the L-shape
INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v11-z1', 'v11', '{"en":"Upper Hall","ru":"Верхний зал"}',   10, 10, 380, 280, '#FFF3E0'),
('v11-z2', 'v11', '{"en":"Lower Hall","ru":"Нижний зал"}',    10, 290, 260, 320, '#EFEBE9'),
('v11-z3', 'v11', '{"en":"Window","ru":"У окна"}',           270, 430, 200, 180, '#E3F2FD');

-- 14 tables matching the photo layout
INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
-- Upper Hall: row 1
('v11-t1',  'v11', 'v11-z1', 175, 20,  70, 40, 'rect', 2, 'T1', 'available'),
-- Upper Hall: row 2
('v11-t2',  'v11', 'v11-z1', 55,  80,  50, 70, 'rect', 4, 'T2', 'available'),
('v11-t3',  'v11', 'v11-z1', 210, 85,  90, 50, 'rect', 4, 'T3', 'available'),
-- Upper Hall: row 3
('v11-t4',  'v11', 'v11-z1', 50,  180, 65, 50, 'rect', 4, 'T4', 'available'),
('v11-t5',  'v11', 'v11-z1', 185, 185, 45, 45, 'circle', 2, 'T5', 'available'),
('v11-t6',  'v11', 'v11-z1', 305, 175, 70, 50, 'rect', 4, 'T6', 'available'),
-- Middle: between halls
('v11-t7',  'v11', 'v11-z2', 175, 300, 85, 50, 'rect', 4, 'T7', 'available'),
-- Lower Hall: row 1
('v11-t8',  'v11', 'v11-z2', 80,  370, 55, 70, 'rect', 4, 'T8', 'available'),
('v11-t9',  'v11', 'v11-z2', 170, 375, 80, 50, 'rect', 4, 'T9', 'available'),
-- Lower Hall: row 2
('v11-t10', 'v11', 'v11-z2', 25,  470, 80, 55, 'rect', 4, 'T10', 'available'),
('v11-t11', 'v11', 'v11-z2', 120, 470, 70, 55, 'rect', 4, 'T11', 'available'),
('v11-t12', 'v11', 'v11-z2', 205, 470, 55, 55, 'rect', 4, 'T12', 'available'),
-- Bottom left: circle
('v11-t13', 'v11', 'v11-z2', 25,  555, 50, 50, 'circle', 2, 'T13', 'available'),
-- Window nook
('v11-w1',  'v11', 'v11-z3', 330, 500, 70, 50, 'rect', 2, 'W1', 'available');
