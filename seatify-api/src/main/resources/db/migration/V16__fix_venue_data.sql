-- =============================================
-- V16: Fix real addresses, phone numbers, coordinates, and hours
-- =============================================

-- v1: Yasaman Restaurant - Yekmalyan 1/1
UPDATE venues SET
  address = '1/1 Yekmalyan St, Yerevan 0002',
  phone = '+374 11 803333',
  latitude = 40.18468,
  longitude = 44.50768
WHERE id = 'v1';
DELETE FROM venue_hours WHERE venue_id = 'v1';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v1', 'Mon-Sun', '09:00', '00:00');

-- v2: De Angelo Café - Pushkin 31
UPDATE venues SET
  address = '31 Pushkin St, Yerevan 0002',
  phone = '+374 44 448899',
  latitude = 40.18450,
  longitude = 44.51150
WHERE id = 'v2';
DELETE FROM venue_hours WHERE venue_id = 'v2';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v2', 'Mon-Sun', '09:00', '00:00');

-- v3: Mamma Mia - Pushkin 41
UPDATE venues SET
  address = '41 Pushkin St, Yerevan 0002',
  phone = '+374 41 222111',
  latitude = 40.18520,
  longitude = 44.51020
WHERE id = 'v3';
DELETE FROM venue_hours WHERE venue_id = 'v3';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v3', 'Mon-Sun', '09:00', '02:00');

-- v4: Twins Smashburgers - Pushkin 40
UPDATE venues SET
  address = '40 Pushkin St, Yerevan 0002',
  phone = '+374 99 909030',
  latitude = 40.18540,
  longitude = 44.51000
WHERE id = 'v4';
DELETE FROM venue_hours WHERE venue_id = 'v4';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v4', 'Mon-Sun', '11:00', '02:00');

-- v5: Sirelis - Pushkin 25
UPDATE venues SET
  address = '25 Pushkin St, Yerevan 0010',
  phone = '+374 44 558899',
  latitude = 40.18380,
  longitude = 44.51230
WHERE id = 'v5';
DELETE FROM venue_hours WHERE venue_id = 'v5';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v5', 'Mon-Sun', '12:00', '00:00');

-- v6: Dragon Garden - Aram 76
UPDATE venues SET
  address = '76 Aram St, Yerevan 0002',
  phone = '+374 60 757588',
  latitude = 40.18375,
  longitude = 44.50797
WHERE id = 'v6';
DELETE FROM venue_hours WHERE venue_id = 'v6';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v6', 'Mon-Sun', '11:00', '01:00');

-- v7: Bar B.Q. - Pushkin 40
UPDATE venues SET
  address = '40 Pushkin St, Yerevan 0002',
  phone = '+374 33 333222',
  latitude = 40.18550,
  longitude = 44.50980
WHERE id = 'v7';
DELETE FROM venue_hours WHERE venue_id = 'v7';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v7', 'Mon-Sun', '11:00', '03:00');

-- v8: Black Angus - Mashtots 39/12
UPDATE venues SET
  address = '39/12 Mashtots Ave, Yerevan 0002',
  phone = '+374 43 508070',
  latitude = 40.18720,
  longitude = 44.50580
WHERE id = 'v8';
DELETE FROM venue_hours WHERE venue_id = 'v8';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v8', 'Mon-Sun', '08:30', '02:00');

-- v9: Cinnabon - Abovyan 1/3
UPDATE venues SET
  address = '1/3 Abovyan St, Yerevan 0010',
  phone = '+374 93 545903',
  latitude = 40.17780,
  longitude = 44.51380
WHERE id = 'v9';
DELETE FROM venue_hours WHERE venue_id = 'v9';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v9', 'Mon-Sun', '10:30', '00:00');

-- v10: Espress It - Northern Ave 6
UPDATE venues SET
  address = '6 Northern Ave, Yerevan 0001',
  phone = '+374 11 293333',
  latitude = 40.18150,
  longitude = 44.51430
WHERE id = 'v10';
DELETE FROM venue_hours WHERE venue_id = 'v10';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v10', 'Mon-Sun', '08:00', '00:00');

-- v11: InTempo - Northern Ave 10/3
UPDATE venues SET
  address = '10/3 Northern Ave, Yerevan 0010',
  phone = '+374 77 966933',
  latitude = 40.18260,
  longitude = 44.51520
WHERE id = 'v11';
DELETE FROM venue_hours WHERE venue_id = 'v11';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v11', 'Mon-Sun', '09:00', '00:00');

-- v12: If You Know You Know - Isahakyan 46/3
UPDATE venues SET
  address = '46/3 Isahakyan St, Yerevan 0009',
  phone = '+374 98 000046',
  latitude = 40.19000,
  longitude = 44.51850
WHERE id = 'v12';
DELETE FROM venue_hours WHERE venue_id = 'v12';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v12', 'Mon-Sun', '12:00', '01:00');

-- v13: Kamancha - Tumanyan 23
UPDATE venues SET
  address = '23 Tumanyan St, Yerevan 0002',
  phone = '+374 95 711700',
  latitude = 40.18300,
  longitude = 44.51659
WHERE id = 'v13';
DELETE FROM venue_hours WHERE venue_id = 'v13';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v13', 'Mon-Sun', '10:00', '22:00');

-- v14: Ktoor - Saryan 24
UPDATE venues SET
  address = '24 Saryan St, Yerevan 0002',
  phone = '+374 44 242440',
  latitude = 40.18395,
  longitude = 44.50491
WHERE id = 'v14';
DELETE FROM venue_hours WHERE venue_id = 'v14';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v14', 'Mon-Sun', '10:00', '00:00');

-- v15: Mao - Isahakyan 28
UPDATE venues SET
  address = '28 Isahakyan St, Yerevan 0009',
  phone = '+374 55 001001',
  latitude = 40.18831,
  longitude = 44.52058
WHERE id = 'v15';
DELETE FROM venue_hours WHERE venue_id = 'v15';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v15', 'Mon-Sun', '11:00', '00:00');

-- v16: Mozzarella - Aram 2
UPDATE venues SET
  address = '2 Aram St, Yerevan 0010',
  phone = '+374 44 001881',
  latitude = 40.17750,
  longitude = 44.51180
WHERE id = 'v16';
DELETE FROM venue_hours WHERE venue_id = 'v16';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v16', 'Mon-Sun', '10:00', '00:00');

-- v17: Patrick's Pastry - Aram 64
UPDATE venues SET
  name = 'Patrick''s Pastry',
  address = '64 Aram St, Yerevan 0002',
  phone = '+374 44 008118',
  latitude = 40.18480,
  longitude = 44.50720
WHERE id = 'v17';
DELETE FROM venue_hours WHERE venue_id = 'v17';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v17', 'Mon-Sun', '08:00', '23:00');

-- v18: Segafredo - Abovyan 36
UPDATE venues SET
  address = '36 Abovyan St, Yerevan 0009',
  phone = '+374 77 566016',
  latitude = 40.18550,
  longitude = 44.51690
WHERE id = 'v18';
DELETE FROM venue_hours WHERE venue_id = 'v18';
INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v18', 'Mon-Sun', '08:00', '00:00');
