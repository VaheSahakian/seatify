-- =============================================
-- V8: Seed data for Seatify
-- =============================================

-- ─── Users (password = "password123" BCrypt-hashed) ──────────────────────
INSERT INTO users (id, name, email, password_hash, phone, avatar, loyalty_points, cashback) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Anna K.', 'anna@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+374 91 111111', 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100', 250, 5000),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'David M.', 'david@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+374 91 222222', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', 180, 3200),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Maria S.', 'maria@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+374 91 333333', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100', 320, 7500),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Alex T.', 'alex@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+374 91 444444', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100', 150, 2800),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Sona V.', 'sona@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+374 91 555555', 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100', 90, 1500),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Pierre L.', 'pierre@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+374 91 666666', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100', 200, 4000);

-- ─── Venue 1: Yasaman Restaurant ──────────────────────────────────────────
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v1', 'Yasaman Restaurant', 'yasaman',
 '{"en":"Beautiful garden-style restaurant with an amazing wine list and authentic Armenian cuisine.","hy":"Geghdelays海ecik aygestanoc restoran hiaspan giniyov tsankov ev haykakan xohanotqov.","ru":"Ресторан в стиле сада с потрясающей картой вин и аутентичной армянской кухней."}',
 ARRAY['Armenian','Salads','Vegan','BBQ'], 3, 4.7, 187,
 'M, 1/1 Yekmalyan St, Yerevan 0002', 40.1776, 44.5126, '+374 11 803333',
 ARRAY['Private Rooms','Valet Parking','WiFi'],
 '{"en":"Free cancellation 1 hour before. 10-minute grace period. 1000 AMD no-show fee.","hy":"Andelays海ar chegharkum 1 zham araj. 10 rope artonutyun. 1000 AMD tughank.","ru":"Бесплатная отмена за 1 час. 10 минут ожидания. Штраф за неявку 1000 драм."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v1', 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800', 0),
('v1', 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800', 1),
('v1', 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v1', 'Mon-Sun', '11:00', '00:00');

-- Yasaman zones
INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v1-z1', 'v1', '{"en":"Garden Terrace","hy":"Aygestani terasa","ru":"Садовая терраса"}', 0, 0, 560, 200, '#E8F5E9'),
('v1-z2', 'v1', '{"en":"Wine Cellar Room","hy":"Ginu nkughi srah","ru":"Винный зал"}', 0, 200, 560, 200, '#FBE9E7');

-- Yasaman tables
INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v1-t1',  'v1', 'v1-z1', 40,  30,  80,  80,  'circle', 4,  'G1', 'available'),
('v1-t2',  'v1', 'v1-z1', 160, 30,  80,  80,  'circle', 4,  'G2', 'occupied'),
('v1-t3',  'v1', 'v1-z1', 280, 30,  80,  80,  'circle', 2,  'G3', 'available'),
('v1-t4',  'v1', 'v1-z1', 400, 30,  100, 60,  'rect',   6,  'G4', 'reserved'),
('v1-t5',  'v1', 'v1-z1', 40,  120, 100, 60,  'rect',   8,  'G5', 'available'),
('v1-t6',  'v1', 'v1-z1', 200, 120, 80,  80,  'circle', 4,  'G6', 'occupied'),
('v1-t7',  'v1', 'v1-z2', 40,  230, 80,  80,  'circle', 2,  'W1', 'available'),
('v1-t8',  'v1', 'v1-z2', 160, 230, 120, 60,  'rect',   6,  'W2', 'available'),
('v1-t9',  'v1', 'v1-z2', 320, 230, 80,  80,  'circle', 4,  'W3', 'occupied'),
('v1-t10', 'v1', 'v1-z2', 440, 230, 80,  80,  'circle', 2,  'W4', 'available'),
('v1-t11', 'v1', 'v1-z2', 120, 330, 140, 50,  'rect',   10, 'W5', 'reserved'),
('v1-t12', 'v1', 'v1-z2', 340, 330, 80,  80,  'circle', 4,  'W6', 'available');

-- Yasaman menu categories
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES
('v1-mc1', 'v1', '{"en":"Wine by the Glass","ru":"Вино по бокалам","hy":"Գինի՝ բdelays海akhnerov"}', 0),
('v1-mc2', 'v1', '{"en":"Red Wines","ru":"Красные вина","hy":"Karmir ginier"}', 1),
('v1-mc3', 'v1', '{"en":"Bar · Whisky (50ml)","ru":"Бар · Виски (50мл)","hy":"Bar · Viski (50ml)"}', 2),
('v1-mc4', 'v1', '{"en":"Beer","ru":"Пиво","hy":"Garejur"}', 3);

-- Yasaman menu items
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-m1',  'v1-mc1', 'v1', '{"en":"Areni Noir Reserve","ru":"Areni Noir Reserve","hy":"Areni Noir Reserve"}', '{"en":"Areni Valley, Armenia 2019","ru":"Долина Арeni, Армения 2019","hy":"Areni hovi, Hayastan 2019"}', 3300, '{}', 0),
('v1-m2',  'v1-mc1', 'v1', '{"en":"Karas Rosé","ru":"Karas Rosé","hy":"Karas Rosé"}', '{"en":"Armavir, Armenia 2021","ru":"Армавир, Армения 2021","hy":"Armavir, Hayastan 2021"}', 2800, '{}', 1),
('v1-m3',  'v1-mc1', 'v1', '{"en":"Zorah Karasi","ru":"Zorah Karasi","hy":"Zorah Karasi"}', '{"en":"Rind Village, Vayots Dzor 2018","ru":"Село Ринд, Вайоц Дзор 2018","hy":"Rind gyugh, Vayots Dzor 2018"}', 4200, '{}', 2),
('v1-m4',  'v1-mc1', 'v1', '{"en":"Van Ardi White","ru":"Van Ardi White","hy":"Van Ardi White"}', '{"en":"Aragatsotn, Armenia 2020","ru":"Арагацотн, Армения 2020","hy":"Aragatsotn, Hayastan 2020"}', 2500, '{}', 3),
('v1-m5',  'v1-mc1', 'v1', '{"en":"Kataro Dry Red","ru":"Kataro Dry Red","hy":"Kataro Dry Red"}', '{"en":"Areni, Armenia 2017","ru":"Арeni, Армения 2017","hy":"Areni, Hayastan 2017"}', 3800, '{}', 4),
('v1-m6',  'v1-mc1', 'v1', '{"en":"Trinity White Dry","ru":"Trinity White Dry","hy":"Trinity White Dry"}', '{"en":"Aragatsotn, Armenia 2021","ru":"Арагацотн, Армения 2021","hy":"Aragatsotn, Hayastan 2021"}', 2200, '{}', 5),
('v1-m7',  'v1-mc2', 'v1', '{"en":"Areni Noir by Zorah (bottle)","ru":"Areni Noir by Zorah (бутылка)","hy":"Areni Noir by Zorah (shish)"}', '{"en":"Full-bodied Armenian red, 750ml","ru":"Полнотелое армянское красное, 750мл","hy":"Liatsin haykakan karmir, 750ml"}', 18000, '{}', 0),
('v1-m8',  'v1-mc2', 'v1', '{"en":"Karas Reserve Red","ru":"Karas Reserve Red","hy":"Karas Reserve Red"}', '{"en":"Armavir, Armenia, 750ml","ru":"Армавир, Армения, 750мл","hy":"Armavir, Hayastan, 750ml"}', 14000, '{}', 1),
('v1-m9',  'v1-mc2', 'v1', '{"en":"Kataro Red Dry","ru":"Kataro Red Dry","hy":"Kataro Red Dry"}', '{"en":"Vayots Dzor, 750ml","ru":"Вайоц Дзор, 750мл","hy":"Vayots Dzor, 750ml"}', 12000, '{}', 2),
('v1-m10', 'v1-mc2', 'v1', '{"en":"Van Ardi Red Reserve","ru":"Van Ardi Red Reserve","hy":"Van Ardi Red Reserve"}', '{"en":"Aragatsotn, Armenia 2018, 750ml","ru":"Арагацотн, Армения 2018, 750мл","hy":"Aragatsotn, Hayastan 2018, 750ml"}', 16000, '{}', 3),
('v1-m11', 'v1-mc2', 'v1', '{"en":"Armas Red Dry","ru":"Armas Red Dry","hy":"Armas Red Dry"}', '{"en":"Aragatsotn, rich and velvety, 750ml","ru":"Арагацотн, насыщенное и бархатистое, 750мл","hy":"Aragatsotn, hagurats ev tavshya, 750ml"}', 11000, '{}', 4),
('v1-m12', 'v1-mc2', 'v1', '{"en":"Old Bridge Red Semi-Sweet","ru":"Old Bridge Red Semi-Sweet","hy":"Old Bridge Red Semi-Sweet"}', '{"en":"Armenia, fruity and smooth, 750ml","ru":"Армения, фруктовое и мягкое, 750мл","hy":"Hayastan, mtghayinatam ev p''ap''uk, 750ml"}', 9000, '{}', 5),
('v1-m13', 'v1-mc3', 'v1', '{"en":"Jameson","ru":"Jameson","hy":"Jameson"}', '{"en":"Irish Whiskey","ru":"Ирландский виски","hy":"Irlandakan viski"}', 2500, '{}', 0),
('v1-m14', 'v1-mc3', 'v1', '{"en":"Jack Daniel''s","ru":"Jack Daniel''s","hy":"Jack Daniel''s"}', '{"en":"Tennessee Whiskey","ru":"Виски из Теннесси","hy":"Tennesi viski"}', 2800, '{}', 1),
('v1-m15', 'v1-mc3', 'v1', '{"en":"Johnnie Walker Black","ru":"Johnnie Walker Black","hy":"Johnnie Walker Black"}', '{"en":"Blended Scotch Whisky","ru":"Купажированный шотландский виски","hy":"Shotlandakan viski"}', 3500, '{}', 2),
('v1-m16', 'v1-mc3', 'v1', '{"en":"Macallan 12","ru":"Macallan 12","hy":"Macallan 12"}', '{"en":"Single Malt, Speyside","ru":"Односолодовый, Спейсайд","hy":"Miasolodayin, Speyside"}', 5500, '{}', 3),
('v1-m17', 'v1-mc3', 'v1', '{"en":"Glenfiddich 15","ru":"Glenfiddich 15","hy":"Glenfiddich 15"}', '{"en":"Single Malt, Solera Reserve","ru":"Односолодовый, Солера Резерв","hy":"Miasolodayin, Solera Reserve"}', 5000, '{}', 4),
('v1-m18', 'v1-mc3', 'v1', '{"en":"Monkey Shoulder","ru":"Monkey Shoulder","hy":"Monkey Shoulder"}', '{"en":"Blended Malt Scotch","ru":"Купажированный солодовый шотландский","hy":"Kupajavorats solodayin shotlandakan"}', 3000, '{}', 5),
('v1-m19', 'v1-mc4', 'v1', '{"en":"Dargett IPA (0.33L)","ru":"Dargett IPA (0.33л)","hy":"Dargett IPA (0.33L)"}', '{"en":"Armenian craft IPA, citrusy and hoppy","ru":"Армянское крафтовое IPA, цитрусовое и хмельное","hy":"Haykakan kraft IPA, tsitrusayin ev khmelya"}', 1800, '{}', 0),
('v1-m20', 'v1-mc4', 'v1', '{"en":"Kilikia Draft (0.5L)","ru":"Kilikia разливное (0.5л)","hy":"Kilikia tsoren (0.5L)"}', '{"en":"Classic Armenian lager on draft","ru":"Классический армянский лагер, разливной","hy":"Dasakan haykakan lager, tsoren"}', 1200, '{}', 1),
('v1-m21', 'v1-mc4', 'v1', '{"en":"Gyumri Gold (0.5L)","ru":"Gyumri Gold (0.5л)","hy":"Gyumri Gold (0.5L)"}', '{"en":"Light lager from Gyumri brewery","ru":"Светлый лагер из гюмрийской пивоварни","hy":"Bats lager Gyumru garejratnic"}', 1000, '{}', 2),
('v1-m22', 'v1-mc4', 'v1', '{"en":"Dargett Apricot Ale (0.33L)","ru":"Dargett Apricot Ale (0.33л)","hy":"Dargett Tsiranayuny Ale (0.33L)"}', '{"en":"Fruity Armenian craft ale with apricot","ru":"Фруктовый армянский эль с абрикосом","hy":"Mtghayinatam haykakan el tsirankov"}', 2000, '{}', 3);

-- ─── Venue 2: De Angelo Café ──────────────────────────────────────────────
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v2', 'De Angelo Café', 'de-angelo',
 '{"en":"A little corner of Italy in Yerevan with handmade pasta, wood-fired pizza, and artisan desserts.","hy":"Italiayi mi ankyun Yerevanum` tnayin pasta, p''ch''ov pica ev arvestagorcakan desertner.","ru":"Уголок Италии в Ереване с домашней пастой, пиццей на дровах и авторскими десертами."}',
 ARRAY['Italian','Pasta','Pizza','Wine'], 2, 4.5, 234,
 '31 Pushkin St, Yerevan 0002', 40.1811, 44.5136, '+374 44 448899',
 ARRAY['Outside Seating','2nd Floor View','WiFi'],
 '{"en":"Free cancellation 1 hour before. 10-minute grace period.","hy":"Andelays海ar chegharkum 1 zham araj. 10 rope artonutyun.","ru":"Бесплатная отмена за 1 час. 10 минут ожидания."}',
 520, 380);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v2', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800', 0),
('v2', 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800', 1),
('v2', 'https://images.unsplash.com/photo-1544148103-0773bf10d330?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v2', 'Mon-Sun', '09:00', '00:00');

-- De Angelo zones
INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v2-z1', 'v2', '{"en":"Main Hall","hy":"Glkhavor dahlich","ru":"Основной зал"}', 0, 0, 520, 190, '#FFF3E0'),
('v2-z2', 'v2', '{"en":"Outdoor Terrace","hy":"Artatnay terasa","ru":"Летняя терраса"}', 0, 190, 520, 190, '#E0F7FA');

-- De Angelo tables
INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v2-t1',  'v2', 'v2-z1', 30,  25,  70,  70,  'circle', 2, 'A1', 'available'),
('v2-t2',  'v2', 'v2-z1', 140, 25,  70,  70,  'circle', 2, 'A2', 'occupied'),
('v2-t3',  'v2', 'v2-z1', 250, 25,  90,  55,  'rect',   4, 'A3', 'available'),
('v2-t4',  'v2', 'v2-z1', 380, 25,  110, 55,  'rect',   6, 'A4', 'reserved'),
('v2-t5',  'v2', 'v2-z1', 30,  110, 90,  55,  'rect',   4, 'A5', 'available'),
('v2-t6',  'v2', 'v2-z1', 180, 110, 70,  70,  'circle', 2, 'A6', 'occupied'),
('v2-t7',  'v2', 'v2-z2', 30,  215, 80,  80,  'circle', 4, 'T1', 'available'),
('v2-t8',  'v2', 'v2-z2', 150, 215, 80,  80,  'circle', 4, 'T2', 'available'),
('v2-t9',  'v2', 'v2-z2', 270, 215, 80,  80,  'circle', 2, 'T3', 'reserved'),
('v2-t10', 'v2', 'v2-z2', 390, 215, 100, 55,  'rect',   6, 'T4', 'available'),
('v2-t11', 'v2', 'v2-z2', 100, 320, 130, 45,  'rect',   8, 'T5', 'occupied'),
('v2-t12', 'v2', 'v2-z2', 300, 320, 70,  70,  'circle', 2, 'T6', 'available');

-- De Angelo menu
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES
('v2-mc1', 'v2', '{"en":"Pasta Fresca","ru":"Паста Фреска","hy":"Թdelays海arm Pasta"}', 0),
('v2-mc2', 'v2', '{"en":"Brooklyn Pizza","ru":"Бруклинская пицца","hy":"Bruqlin Picca"}', 1),
('v2-mc3', 'v2', '{"en":"Dolci","ru":"Десерты","hy":"Aghander"}', 2),
('v2-mc4', 'v2', '{"en":"Breakfast (09:00-13:00)","ru":"Завтрак (09:00-13:00)","hy":"Nakhachash (09:00-13:00)"}', 3),
('v2-mc5', 'v2', '{"en":"Viennoiserie","ru":"Венские булочки","hy":"Khmoreghen"}', 4);

INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-m1',  'v2-mc1', 'v2', '{"en":"Linguine Quattro Formaggi","ru":"Лингвини Куаттро Формаджи","hy":"Լingvine Quatro Formaji"}', '{"en":"Four-cheese linguine with creamy sauce","ru":"Лингвини с четырьмя сырами в сливочном соусе","hy":"Chors panrov lingvine kremayov sous"}', 3300, ARRAY['vegetarian'], 0),
('v2-m2',  'v2-mc1', 'v2', '{"en":"Spaghetti Carbonara","ru":"Спагетти Карбонара","hy":"Սpaghetti Karbonara"}', '{"en":"Classic carbonara with pancetta and egg yolk","ru":"Классическая карбонара с панчеттой и желтком","hy":"Dasakan karbonara panchetayov ev dzvatseghnov"}', 3500, '{}', 1),
('v2-m3',  'v2-mc1', 'v2', '{"en":"Rigatoni Bolognese","ru":"Ригатони Болоньезе","hy":"Rigatoni Boloneze"}', '{"en":"Slow-cooked meat ragù with rigatoni","ru":"Ригатони с мясным рагу длительной готовки","hy":"Dandagh yeparats msayin ragu rigatoniov"}', 3900, '{}', 2),
('v2-m4',  'v2-mc1', 'v2', '{"en":"Shrimp Fettuccine Alfredo","ru":"Феттучине Альфредо","hy":"Fettuccinne Alfredo"}', '{"en":"Fettuccine with shrimp in a creamy alfredo sauce","ru":"Феттучине с креветками в сливочном соусе Альфредо","hy":"Fettucchine tsovakhetsgetin kremayov alfredo sous"}', 4900, ARRAY['seafood'], 3),
('v2-m5',  'v2-mc1', 'v2', '{"en":"Seafood Spaghetti","ru":"Спагетти с морепродуктами","hy":"Tsovamterqov Spaghetti"}', '{"en":"Mixed seafood spaghetti in white wine sauce","ru":"Спагетти с морепродуктами в соусе из белого вина","hy":"Kharnvoratsq tsovamterqov spaghetti spitaki ginii sous"}', 4500, ARRAY['seafood'], 4),
('v2-m6',  'v2-mc1', 'v2', '{"en":"Beetroot Pasta","ru":"Свекольная паста","hy":"Tsaklerov pasta"}', '{"en":"Homemade beetroot pasta with goat cheese","ru":"Домашняя паста из свёклы с козьим сыром","hy":"Tnayin tsaklerov pasta ayci panrov"}', 3700, ARRAY['vegetarian'], 5),
('v2-m7',  'v2-mc2', 'v2', '{"en":"Margherita","ru":"Маргарита","hy":"Margarita"}', '{"en":"Classic tomato, mozzarella, and basil","ru":"Классическая с томатом, моцареллой и базиликом","hy":"Dasakan lolikov, mocarellayov ev rejanov"}', 3700, ARRAY['vegetarian'], 0),
('v2-m8',  'v2-mc2', 'v2', '{"en":"Pepperoni","ru":"Пепперони","hy":"Pepperoni"}', '{"en":"Spicy pepperoni with mozzarella","ru":"Острая пепперони с моцареллой","hy":"Ktsu pepperoni mocarellayov"}', 3900, '{}', 1),
('v2-m9',  'v2-mc2', 'v2', '{"en":"Quattro Formaggi","ru":"Куатро Формаджи","hy":"Quatro Formaji"}', '{"en":"Four Italian cheeses on a thin crust","ru":"Четыре итальянских сыра на тонком тесте","hy":"Chors italakan panir barak khmoric"}', 3900, ARRAY['vegetarian'], 2),
('v2-m10', 'v2-mc2', 'v2', '{"en":"Prosciutto Crudo, Rucola","ru":"Прошутто Крудо с руколой","hy":"Proshutto Krudo rukolayov"}', '{"en":"Dry-cured ham with fresh arugula","ru":"Сыровяленая ветчина со свежей руколой","hy":"Choratsrats khindzeri mis tarm rukolayov"}', 4600, '{}', 3),
('v2-m11', 'v2-mc2', 'v2', '{"en":"Carpaccio with Tarragon","ru":"Карпаччо с эстрагоном","hy":"Karpacho estragonov"}', '{"en":"Thin-sliced beef with tarragon and parmesan","ru":"Тонко нарезанная говядина с эстрагоном и пармезаном","hy":"Barakatsreats hovamis estragonov ev parmezanov"}', 5500, '{}', 4),
('v2-m12', 'v2-mc3', 'v2', '{"en":"Tiramisu De Angelo","ru":"Тирамису Де Анджело","hy":"Tiramissu De Angelo"}', '{"en":"Our signature tiramisu with mascarpone","ru":"Наш фирменный тирамису с маскарпоне","hy":"Mer firmenayin tiramissu maskarponeyov"}', 1900, '{}', 0),
('v2-m13', 'v2-mc3', 'v2', '{"en":"San Sebastian","ru":"Сан Себастьян","hy":"San Sebastian"}', '{"en":"Basque burnt cheesecake","ru":"Баскский сгоревший чизкейк","hy":"Baskakan ayrats chizkeyq"}', 2500, '{}', 1),
('v2-m14', 'v2-mc3', 'v2', '{"en":"Carrot Cake","ru":"Морковный торт","hy":"Gazarov tort"}', '{"en":"Moist carrot cake with cream cheese frosting","ru":"Влажный морковный торт с кремом из сыра","hy":"Xonavats gazarov tort panrayin kremov"}', 2300, '{}', 2),
('v2-m15', 'v2-mc3', 'v2', '{"en":"New York Cheesecake","ru":"Нью-Йорк чизкейк","hy":"New York Cheesecake"}', '{"en":"Classic New York style cheesecake","ru":"Классический чизкейк в нью-йоркском стиле","hy":"Dasakan New York ochi chizkeyq"}', 1900, '{}', 3),
('v2-m16', 'v2-mc3', 'v2', '{"en":"Apple & Cinnamon Tart","ru":"Яблочный тарт с корицей","hy":"Xndzori tart darchinov"}', '{"en":"Warm apple tart with cinnamon and vanilla ice cream","ru":"Тёплый яблочный тарт с корицей и ванильным мороженым","hy":"Tak xndzori tart darchinov ev vanilayin pagphaghakov"}', 1900, '{}', 4),
('v2-m17', 'v2-mc4', 'v2', '{"en":"Avocado Toast","ru":"Тост с авокадо","hy":"Avokado tost"}', '{"en":"Sourdough toast with smashed avocado and poached egg","ru":"Тост на закваске с авокадо и яйцом пашот","hy":"Ttkvayin haci tost avokadoyov ev pashov dzvatseghnov"}', 3200, ARRAY['vegetarian'], 0),
('v2-m18', 'v2-mc4', 'v2', '{"en":"Salmon Croissant","ru":"Круассан с лососем","hy":"Saghmonov kruasan"}', '{"en":"Fresh croissant with smoked salmon and cream cheese","ru":"Свежий круассан с копчёным лососем и сливочным сыром","hy":"Tarm kruasan xndzatsvats saghmonov ev kremayov panrov"}', 3600, ARRAY['seafood'], 1),
('v2-m19', 'v2-mc4', 'v2', '{"en":"Belgian Waffle with Berries","ru":"Бельгийские вафли","hy":"Belgiyakan vafli"}', '{"en":"Crispy Belgian waffle with fresh berries and syrup","ru":"Хрустящие бельгийские вафли со свежими ягодами","hy":"Khrtkhrtun belgiyakan vafli tarm hataptghnerov"}', 2700, '{}', 2),
('v2-m20', 'v2-mc4', 'v2', '{"en":"Classic Syrniki","ru":"Классические сырники","hy":"Dasakan sirnik"}', '{"en":"Russian-style cottage cheese pancakes with sour cream","ru":"Классические сырники со сметаной","hy":"Dasakan sirnikner ttvashov"}', 2500, ARRAY['vegetarian'], 3),
('v2-m21', 'v2-mc4', 'v2', '{"en":"Proper English Breakfast Waffle","ru":"Английские вафли с завтраком","hy":"Angliyakan nakhachash vafli"}', '{"en":"Waffle with eggs, bacon, beans, sausage, and mushrooms","ru":"Вафли с яйцами, беконом, фасолью, сосиской и грибами","hy":"Vafli dzvatseghnov, bekonov, lobov, nrberov ev sngov"}', 4900, '{}', 4),
('v2-m22', 'v2-mc5', 'v2', '{"en":"Croissant","ru":"Круассан","hy":"Kruasan"}', '{"en":"Freshly baked butter croissant","ru":"Свежеиспечённый масляный круассан","hy":"Nor thkhvats karayin kruasan"}', 700, ARRAY['vegetarian'], 0),
('v2-m23', 'v2-mc5', 'v2', '{"en":"Pain au Chocolat","ru":"Пэн-о-шоколад","hy":"Pen-o-shokola"}', '{"en":"Flaky pastry with dark chocolate filling","ru":"Слоёная выпечка с тёмным шоколадом","hy":"Sghatsats thkhvatsegh mug shokoladov"}', 900, ARRAY['vegetarian'], 1),
('v2-m24', 'v2-mc5', 'v2', '{"en":"Almond Cream Croissant","ru":"Круассан с миндальным кремом","hy":"Kruasan nushov kremov"}', '{"en":"Croissant filled with almond frangipane cream","ru":"Круассан с миндальным кремом франжипан","hy":"Kruasan nushi frandjipan kremov"}', 900, ARRAY['vegetarian'], 2);

-- ─── Venue 3: Mamma Mia ──────────────────────────────────────────────────
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v3', 'Mamma Mia', 'mamma-mia',
 '{"en":"Cozy Italian bistro with creative pizzas, fresh pasta, and signature desserts.","hy":"Jerm italakan bistro steghtsagorcakan piccanerov, tarm pastaov ev firmayan desertnerov.","ru":"Уютное итальянское бистро с авторскими пиццами, свежей пастой и фирменными десертами."}',
 ARRAY['Italian','Pizza','Desserts'], 2, 4.3, 156,
 '14 Abovyan St, Yerevan', 40.1792, 44.5089, '+374 10 520020',
 ARRAY['WiFi','Delivery'],
 '{"en":"Free cancellation 1 hour before. 10-minute grace period.","hy":"Anchar chegharkum 1 zham araj. 10 rope artonutyun.","ru":"Бесплатная отмена за 1 час. 10 минут ожидания."}',
 500, 380);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v3', 'https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=800', 0),
('v3', 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=800', 1),
('v3', 'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v3', 'Mon-Sun', '09:00', '00:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v3-z1', 'v3', '{"en":"Indoor Dining","hy":"Nerdsi srah","ru":"Обеденный зал"}', 0, 0, 500, 200, '#FCE4EC'),
('v3-z2', 'v3', '{"en":"Bar Area","hy":"Bari taratsk","ru":"Барная зона"}', 0, 200, 500, 180, '#EDE7F6');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v3-t1',  'v3', 'v3-z1', 30,  25,  70,  70,  'circle', 2, 'M1', 'available'),
('v3-t2',  'v3', 'v3-z1', 130, 25,  70,  70,  'circle', 2, 'M2', 'occupied'),
('v3-t3',  'v3', 'v3-z1', 230, 25,  90,  55,  'rect',   4, 'M3', 'available'),
('v3-t4',  'v3', 'v3-z1', 360, 25,  110, 55,  'rect',   6, 'M4', 'reserved'),
('v3-t5',  'v3', 'v3-z1', 30,  115, 90,  55,  'rect',   4, 'M5', 'available'),
('v3-t6',  'v3', 'v3-z1', 160, 115, 70,  70,  'circle', 2, 'M6', 'available'),
('v3-t7',  'v3', 'v3-z1', 280, 115, 70,  70,  'circle', 4, 'M7', 'occupied'),
('v3-t8',  'v3', 'v3-z2', 30,  225, 70,  70,  'circle', 2, 'B1', 'available'),
('v3-t9',  'v3', 'v3-z2', 140, 225, 90,  55,  'rect',   4, 'B2', 'reserved'),
('v3-t10', 'v3', 'v3-z2', 270, 225, 70,  70,  'circle', 2, 'B3', 'available'),
('v3-t11', 'v3', 'v3-z2', 380, 225, 90,  55,  'rect',   4, 'B4', 'occupied');

-- Mamma Mia menu
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES
('v3-mc1', 'v3', '{"en":"Breakfast Menu (10:00-14:00)","ru":"Завтрак (10:00-14:00)","hy":"Nakhachash (10:00-14:00)"}', 0),
('v3-mc2', 'v3', '{"en":"Pizza","ru":"Пицца","hy":"Picca"}', 1),
('v3-mc3', 'v3', '{"en":"Pasta","ru":"Паста","hy":"Pasta"}', 2),
('v3-mc4', 'v3', '{"en":"Desserts","ru":"Десерты","hy":"Aghander"}', 3),
('v3-mc5', 'v3', '{"en":"Cocktails","ru":"Коктейли","hy":"Kokteyler"}', 4);

INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v3-m1',  'v3-mc1', 'v3', '{"en":"Scrambled Eggs","ru":"Яичница-болтунья","hy":"Dzvatseghn"}', '{"en":"Fluffy scrambled eggs with toast","ru":"Воздушная яичница-болтунья с тостом","hy":"P''ap''uk dzvatseghn tostov"}', 1800, ARRAY['vegetarian'], 0),
('v3-m2',  'v3-mc1', 'v3', '{"en":"English Breakfast","ru":"Английский завтрак","hy":"Angliyakan nakhachash"}', '{"en":"Eggs, bacon, sausage, beans, toast, and mushrooms","ru":"Яйца, бекон, сосиска, фасоль, тост и грибы","hy":"Dzvatseghn, bekon, nrber, lob, tost ev sunk"}', 4500, '{}', 1),
('v3-m3',  'v3-mc1', 'v3', '{"en":"Bacon Benedict","ru":"Бенедикт с беконом","hy":"Benedict bekonov"}', '{"en":"Poached eggs on English muffin with hollandaise","ru":"Яйца пашот на маффине с голландским соусом","hy":"Pashov dzvatseghn angliyakan mafinov holandez sousov"}', 3800, '{}', 2),
('v3-m4',  'v3-mc1', 'v3', '{"en":"Avocado Toast","ru":"Тост с авокадо","hy":"Avokado tost"}', '{"en":"Smashed avocado on sourdough with cherry tomatoes","ru":"Авокадо на хлебе из закваски с черри","hy":"Avokado ttkvayin hacin cherov lolikov"}', 3200, ARRAY['vegetarian'], 3),
('v3-m5',  'v3-mc1', 'v3', '{"en":"Belgian Waffles","ru":"Бельгийские вафли","hy":"Belgiyakan vafli"}', '{"en":"Crispy waffles with maple syrup and whipped cream","ru":"Хрустящие вафли с кленовым сиропом и взбитыми сливками","hy":"Khrtkhrtun vafli tkhkii sharoyov ev haratsvats serov"}', 2600, ARRAY['vegetarian'], 4),
('v3-m6',  'v3-mc1', 'v3', '{"en":"Pancake with Seasonal Berries","ru":"Панкейки с ягодами","hy":"Panqeyk hataptghnerov"}', '{"en":"Fluffy pancakes topped with seasonal berries","ru":"Воздушные панкейки с сезонными ягодами","hy":"P''ap''uk panqeyk yeghanakayin hataptghnerov"}', 2500, ARRAY['vegetarian'], 5),
('v3-m7',  'v3-mc2', 'v3', '{"en":"Margherita","ru":"Маргарита","hy":"Margarita"}', '{"en":"Tomato sauce, mozzarella, fresh basil","ru":"Томатный соус, моцарелла, свежий базилик","hy":"Lolikoy sous, mocarella, tarm rejan"}', 3100, ARRAY['vegetarian'], 0),
('v3-m8',  'v3-mc2', 'v3', '{"en":"Quattro Formaggi","ru":"Куатро Формаджи","hy":"Quatro Formaji"}', '{"en":"Mozzarella, gorgonzola, parmesan, ricotta","ru":"Моцарелла, горгонзола, пармезан, рикотта","hy":"Mocarella, gorgonzola, parmezan, rikotta"}', 3900, ARRAY['vegetarian'], 1),
('v3-m9',  'v3-mc2', 'v3', '{"en":"Pepperoni","ru":"Пепперони","hy":"Pepperoni"}', '{"en":"Spicy pepperoni with melted mozzarella","ru":"Острая пепперони с расплавленной моцареллой","hy":"Ktsu pepperoni haltsvats mocarellayov"}', 3900, '{}', 2),
('v3-m10', 'v3-mc2', 'v3', '{"en":"Truffle","ru":"Трюфельная","hy":"Tryufelayin"}', '{"en":"Black truffle cream, mushrooms, mozzarella","ru":"Крем из чёрного трюфеля, грибы, моцарелла","hy":"Sev tryufel krem, sunk, mocarella"}', 4100, ARRAY['vegetarian'], 3),
('v3-m11', 'v3-mc2', 'v3', '{"en":"Mortadella","ru":"Мортаделла","hy":"Mortadella"}', '{"en":"Italian mortadella, stracciatella, pistachio","ru":"Итальянская мортаделла, страчателла, фисташка","hy":"Italakan mortadella, strachiatella, pistaki"}', 4900, '{}', 4),
('v3-m12', 'v3-mc3', 'v3', '{"en":"Carbonara","ru":"Карбонара","hy":"Karbonara"}', '{"en":"Classic carbonara with guanciale and pecorino","ru":"Классическая карбонара с гуанчале и пекорино","hy":"Dasakan karbonara guanchaleov ev pekorinov"}', 3600, '{}', 0),
('v3-m13', 'v3-mc3', 'v3', '{"en":"Alfredo","ru":"Альфредо","hy":"Alfredo"}', '{"en":"Creamy fettuccine alfredo with parmesan","ru":"Сливочные феттучине альфредо с пармезаном","hy":"Kremayov fettuchine alfredo parmezanov"}', 3700, ARRAY['vegetarian'], 1),
('v3-m14', 'v3-mc3', 'v3', '{"en":"Aglio e Olio with Seafood","ru":"Алио-олио с морепродуктами","hy":"Alyo-olyo tsovamterqov"}', '{"en":"Garlic and olive oil pasta with mixed seafood","ru":"Паста с чесноком и оливковым маслом с морепродуктами","hy":"Skhtorov ev dzithapruki yughov pasta tsovamterqov"}', 4300, ARRAY['seafood'], 2),
('v3-m15', 'v3-mc3', 'v3', '{"en":"Casarecce Cacio e Pepe","ru":"Казарече Качо е Пепе","hy":"Kazareche Kacho e Pepe"}', '{"en":"Casarecce with pecorino and black pepper","ru":"Казарече с пекорино и чёрным перцем","hy":"Kazareche pekorinov ev sev bghbeghov"}', 2800, ARRAY['vegetarian'], 3),
('v3-m16', 'v3-mc3', 'v3', '{"en":"Signature Truffle Pasta","ru":"Фирменная трюфельная паста","hy":"Firmenayin tryufelayin pasta"}', '{"en":"House specialty with black truffle and cream","ru":"Фирменное блюдо с чёрным трюфелем и сливками","hy":"Tann firmenayin tsar sev tryufelov ev serov"}', 3200, ARRAY['vegetarian'], 4),
('v3-m17', 'v3-mc4', 'v3', '{"en":"The Tiramisu","ru":"Тирамису","hy":"Tiramissu"}', '{"en":"Signature tiramisu with espresso-soaked ladyfingers","ru":"Фирменный тирамису с пропитанным кофе печеньем","hy":"Firmenayin tiramissu espresso-ov taqotsrats thxvatseghov"}', 2200, '{}', 0),
('v3-m18', 'v3-mc4', 'v3', '{"en":"Vanilla Panna Cotta","ru":"Ванильная Панна Котта","hy":"Vanil Panna Kotta"}', '{"en":"Silky panna cotta with vanilla bean and berry coulis","ru":"Нежная панна котта с ванилью и ягодным кули","hy":"Metaqsya panna kotta vanilayov ev hataptghi kulisov"}', 2300, ARRAY['vegetarian'], 1),
('v3-m19', 'v3-mc4', 'v3', '{"en":"Pistachio Gelato","ru":"Фисташковое джелато","hy":"Pistaki pagphaghak"}', '{"en":"Italian-style pistachio gelato, three scoops","ru":"Фисташковое джелато в итальянском стиле, три шарика","hy":"Italakan ochi pistaki pagphaghak, yerek glob"}', 3600, ARRAY['vegetarian'], 2),
('v3-m20', 'v3-mc4', 'v3', '{"en":"Strawberry Millefeuille","ru":"Мильфей с клубникой","hy":"Elaki milfey"}', '{"en":"Crispy puff pastry layered with cream and strawberries","ru":"Хрустящее слоёное тесто с кремом и клубникой","hy":"Khrtkhrtun sghatsats khmor kremov ev elakov"}', 2300, '{}', 3),
('v3-m21', 'v3-mc4', 'v3', '{"en":"Brownie Noire","ru":"Брауни Нуар","hy":"Brauni Nuar"}', '{"en":"Rich dark chocolate brownie with vanilla ice cream","ru":"Насыщенный шоколадный брауни с ванильным мороженым","hy":"Hagurats mug shokoladov brauni vanilayin pagphaghakov"}', 3500, '{}', 4),
('v3-m22', 'v3-mc5', 'v3', '{"en":"Milano 100ml","ru":"Милано 100мл","hy":"Milano 100ml"}', '{"en":"Classic Milano cocktail with Aperol and prosecco","ru":"Классический коктейль Милано с Апероль и просекко","hy":"Dasakan Milano kokteyl Aperol-ov ev prosekko-ov"}', 2800, '{}', 0),
('v3-m23', 'v3-mc5', 'v3', '{"en":"Mamma Mia 80ml","ru":"Мамма Миа 80мл","hy":"Mamma Mia 80ml"}', '{"en":"House signature cocktail","ru":"Фирменный коктейль заведения","hy":"Tann firmenayin kokteyl"}', 2100, '{}', 1),
('v3-m24', 'v3-mc5', 'v3', '{"en":"Roma Spritz 200ml","ru":"Рома Спритц 200мл","hy":"Roma Sprites 200ml"}', '{"en":"Refreshing Roman-style spritz","ru":"Освежающий спритц в римском стиле","hy":"Zovatsnotch hrayin ochi sprites"}', 2700, '{}', 2),
('v3-m25', 'v3-mc5', 'v3', '{"en":"Negroni 100ml","ru":"Негрони 100мл","hy":"Negroni 100ml"}', '{"en":"Gin, Campari, sweet vermouth","ru":"Джин, Кампари, сладкий вермут","hy":"Djin, Kampari, kaghtstsr vermut"}', 3600, '{}', 3),
('v3-m26', 'v3-mc5', 'v3', '{"en":"Torino 200ml","ru":"Торино 200мл","hy":"Torino 200ml"}', '{"en":"A refreshing Turin-inspired cocktail","ru":"Освежающий коктейль, вдохновлённый Турином","hy":"Zovatsnotch Torino-ic ognvats kokteyl"}', 2800, '{}', 4);

-- ─── Venue 4: Twins Smashburgers ──────────────────────────────────────────
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v4', 'Twins Smashburgers', 'twins',
 '{"en":"Best smashburgers in town with crispy fries and creamy milkshakes.","hy":"Qaghaqum lavagun smashburgernerý khrtkhrtun friyov ev kremayun milksheykerov.","ru":"Лучшие смэшбургеры в городе с хрустящей картошкой и кремовыми милкшейками."}',
 ARRAY['Fast Food','American'], 2, 4.6, 312,
 '40 Pushkin St, Yerevan', 40.1825, 44.5142, '+374 99 909030',
 ARRAY['WiFi','Takeout'],
 '{"en":"Free cancellation 30 min before. 5-minute grace period.","hy":"Anchar chegharkum 30 rope araj.","ru":"Бесплатная отмена за 30 минут."}',
 500, 350);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v4', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', 0),
('v4', 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800', 1),
('v4', 'https://images.unsplash.com/photo-1586816001966-79b736744398?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v4', 'Mon-Sun', '11:00', '02:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v4-z1', 'v4', '{"en":"Dining Area","hy":"Chashkeri srah","ru":"Обеденная зона"}', 0, 0, 500, 350, '#FFF9C4');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v4-t1',  'v4', 'v4-z1', 30,  25,  80,  50,  'rect',   2, 'S1',  'available'),
('v4-t2',  'v4', 'v4-z1', 140, 25,  80,  50,  'rect',   2, 'S2',  'occupied'),
('v4-t3',  'v4', 'v4-z1', 250, 25,  80,  50,  'rect',   4, 'S3',  'available'),
('v4-t4',  'v4', 'v4-z1', 360, 25,  110, 50,  'rect',   6, 'S4',  'reserved'),
('v4-t5',  'v4', 'v4-z1', 30,  110, 70,  70,  'circle', 4, 'S5',  'available'),
('v4-t6',  'v4', 'v4-z1', 140, 110, 70,  70,  'circle', 4, 'S6',  'occupied'),
('v4-t7',  'v4', 'v4-z1', 250, 110, 70,  70,  'circle', 2, 'S7',  'available'),
('v4-t8',  'v4', 'v4-z1', 360, 110, 70,  70,  'circle', 2, 'S8',  'available'),
('v4-t9',  'v4', 'v4-z1', 80,  220, 120, 50,  'rect',   8, 'S9',  'reserved'),
('v4-t10', 'v4', 'v4-z1', 280, 220, 80,  50,  'rect',   4, 'S10', 'available');

-- Twins menu
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES
('v4-mc1', 'v4', '{"en":"Big Boss Smashburgers","ru":"Биг Босс Смашбургеры","hy":"Big Boss Smeshburgerner"}', 0),
('v4-mc2', 'v4', '{"en":"Milkshakes","ru":"Милкшейки","hy":"Milqsheyq"}', 1),
('v4-mc3', 'v4', '{"en":"Fries","ru":"Фри","hy":"Fri"}', 2),
('v4-mc4', 'v4', '{"en":"Salads & Sides","ru":"Салаты и добавки","hy":"Aghtcanner"}', 3);

INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v4-m1',  'v4-mc1', 'v4', '{"en":"Original Cheeseburger","ru":"Оригинальный чизбургер","hy":"Original chizburger"}', '{"en":"Classic smashburger with American cheese and special sauce","ru":"Классический смэшбургер с американским сыром и фирменным соусом","hy":"Dasakan smeshburger amerikyan panrov ev firmenayin sousov"}', 2400, '{}', 0),
('v4-m2',  'v4-mc1', 'v4', '{"en":"Creamy Smash","ru":"Крими Смеш","hy":"Qrimi Smesh"}', '{"en":"Double patty with cream cheese and caramelized onion","ru":"Двойная котлета со сливочным сыром и карамелизированным луком","hy":"Krknakit kotlet kremayov panrov ev karamelatsvats sokhov"}', 2500, '{}', 1),
('v4-m3',  'v4-mc1', 'v4', '{"en":"Crispy Chicken Royale","ru":"Криспи Чикен Рояль","hy":"Qrispi Chiken Royal"}', '{"en":"Crispy fried chicken with lettuce and mayo","ru":"Хрустящая курица с салатом и майонезом","hy":"Khrtkhrtun hav salatov ev mayonezov"}', 2500, '{}', 2),
('v4-m4',  'v4-mc1', 'v4', '{"en":"Spicy Jalapeño","ru":"Острый Халапеньо","hy":"Spaysi Khalapeno"}', '{"en":"Smashburger with jalapeño peppers and pepper jack cheese","ru":"Смэшбургер с халапеньо и сыром пеппер джек","hy":"Smeshburger khalapeno bghbeghov ev pepper jak panrov"}', 2600, '{}', 3),
('v4-m5',  'v4-mc1', 'v4', '{"en":"Bacon Truffle","ru":"Бекон Трюфель","hy":"Bekon Tryufl"}', '{"en":"Premium smashburger with bacon and truffle mayo","ru":"Премиум смэшбургер с беконом и трюфельным майонезом","hy":"Premium smeshburger bekonov ev tryufelayin mayonezov"}', 3200, '{}', 4),
('v4-m6',  'v4-mc1', 'v4', '{"en":"Veggie Burger","ru":"Вегги Бургер","hy":"Veggi Burger"}', '{"en":"Plant-based patty with lettuce, tomato, and vegan mayo","ru":"Растительная котлета с салатом, томатом и веганским майонезом","hy":"Busakan kotlet salatov, lolikoy ev veganayin mayonezov"}', 2600, ARRAY['vegetarian','vegan'], 5),
('v4-m7',  'v4-mc2', 'v4', '{"en":"Vanilla","ru":"Ванильный","hy":"Vanil"}', '{"en":"Classic vanilla milkshake","ru":"Классический ванильный милкшейк","hy":"Dasakan vanilayin milqsheyq"}', 1200, ARRAY['vegetarian'], 0),
('v4-m8',  'v4-mc2', 'v4', '{"en":"Oreo","ru":"Орео","hy":"Oreo"}', '{"en":"Creamy Oreo cookie milkshake","ru":"Сливочный милкшейк с печеньем Орео","hy":"Kremayov Oreo thkhvatseghov milqsheyq"}', 1200, ARRAY['vegetarian'], 1),
('v4-m9',  'v4-mc2', 'v4', '{"en":"Strawberry","ru":"Клубничный","hy":"Elak"}', '{"en":"Fresh strawberry milkshake","ru":"Милкшейк со свежей клубникой","hy":"Tarm elakov milqsheyq"}', 1400, ARRAY['vegetarian'], 2),
('v4-m10', 'v4-mc3', 'v4', '{"en":"Classic Fries","ru":"Классический фри","hy":"Dasakan fri"}', '{"en":"Golden crispy French fries","ru":"Золотистый хрустящий фри","hy":"Voskeguyun khrtkhrtun fri"}', 900, ARRAY['vegetarian','vegan'], 0),
('v4-m11', 'v4-mc3', 'v4', '{"en":"Cheese Fries","ru":"Фри с сыром","hy":"Panrov fri"}', '{"en":"Fries topped with melted cheddar","ru":"Фри с расплавленным чеддером","hy":"Fri haltsvats chedderov"}', 1200, ARRAY['vegetarian'], 1),
('v4-m12', 'v4-mc3', 'v4', '{"en":"Truffle Fries","ru":"Трюфельный фри","hy":"Tryufelayin fri"}', '{"en":"Fries with truffle oil and parmesan","ru":"Фри с трюфельным маслом и пармезаном","hy":"Fri tryufelayin yughov ev parmezanov"}', 1500, ARRAY['vegetarian'], 2),
('v4-m13', 'v4-mc3', 'v4', '{"en":"Sweet Potato Fries","ru":"Фри из батата","hy":"Kaghtshr kartofilov fri"}', '{"en":"Crispy sweet potato fries with dipping sauce","ru":"Хрустящий фри из батата с соусом","hy":"Khrtkhrtun kaghtshr kartofilov fri sousov"}', 1100, ARRAY['vegetarian','vegan'], 3),
('v4-m14', 'v4-mc4', 'v4', '{"en":"Greek Salad","ru":"Греческий салат","hy":"Hunakan aghtcan"}', '{"en":"Fresh vegetables with feta cheese and olives","ru":"Свежие овощи с сыром фета и оливками","hy":"Tarm banjareghener feta panrov ev dzetenov"}', 2200, ARRAY['vegetarian'], 0),
('v4-m15', 'v4-mc4', 'v4', '{"en":"Caesar Salad","ru":"Салат Цезарь","hy":"Tsezar aghtcan"}', '{"en":"Romaine lettuce, croutons, parmesan, Caesar dressing","ru":"Салат ромэн, гренки, пармезан, соус Цезарь","hy":"Romeyn salat, grenki, parmezan, Tsezar sous"}', 2500, '{}', 1),
('v4-m16', 'v4-mc4', 'v4', '{"en":"Chicken Nuggets","ru":"Куриные наггетсы","hy":"Havi nagetser"}', '{"en":"Crispy chicken nuggets (8 pcs) with dipping sauce","ru":"Хрустящие куриные наггетсы (8 шт.) с соусом","hy":"Khrtkhrtun havi nagetser (8 hat) sousov"}', 1800, '{}', 2);

-- ─── Venue 5: Sirelis Café ───────────────────────────────────────────────
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v5', 'Sirelis Café', 'sirelis',
 '{"en":"Traditional Armenian café with BBQ, kebabs, and a relaxing outdoor terrace.","hy":"Avanduakan hay srjaran khorovatov, qababov ev hangstutyun patsot terasayov.","ru":"Традиционное армянское кафе с шашлыком, кебабом и уютной летней террасой."}',
 ARRAY['Armenian','BBQ','Kebab','Salads'], 2, 4.4, 198,
 '25 Pushkin St, Yerevan 0010', 40.1854, 44.5167, '+374 44 558899',
 ARRAY['Outdoor Seating','Live Music','WiFi'],
 '{"en":"Free cancellation 1 hour before. 10-minute grace period.","hy":"Anchar chegharkum 1 zham araj. 10 rope artonutyun.","ru":"Бесплатная отмена за 1 час. 10 минут ожидания."}',
 540, 420);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v5', 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800', 0),
('v5', 'https://images.unsplash.com/photo-1592861956120-e524fc739696?w=800', 1),
('v5', 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v5', 'Mon-Sun', '12:00', '00:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v5-z1', 'v5', '{"en":"Indoor Hall","hy":"Nerdsi srah","ru":"Внутренний зал"}', 0, 0, 540, 210, '#EFEBE9'),
('v5-z2', 'v5', '{"en":"Outdoor Terrace","hy":"Artatnay terasa","ru":"Летняя терраса"}', 0, 210, 540, 210, '#E8F5E9');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v5-t1',  'v5', 'v5-z1', 30,  25,  80,  80,  'circle', 4,  'I1', 'available'),
('v5-t2',  'v5', 'v5-z1', 150, 25,  80,  80,  'circle', 4,  'I2', 'occupied'),
('v5-t3',  'v5', 'v5-z1', 270, 25,  100, 55,  'rect',   6,  'I3', 'available'),
('v5-t4',  'v5', 'v5-z1', 410, 25,  100, 55,  'rect',   6,  'I4', 'reserved'),
('v5-t5',  'v5', 'v5-z1', 30,  120, 70,  70,  'circle', 2,  'I5', 'available'),
('v5-t6',  'v5', 'v5-z1', 150, 120, 120, 55,  'rect',   8,  'I6', 'occupied'),
('v5-t7',  'v5', 'v5-z2', 30,  240, 80,  80,  'circle', 4,  'O1', 'available'),
('v5-t8',  'v5', 'v5-z2', 150, 240, 80,  80,  'circle', 4,  'O2', 'available'),
('v5-t9',  'v5', 'v5-z2', 270, 240, 80,  80,  'circle', 2,  'O3', 'reserved'),
('v5-t10', 'v5', 'v5-z2', 390, 240, 110, 55,  'rect',   6,  'O4', 'available'),
('v5-t11', 'v5', 'v5-z2', 100, 345, 140, 50,  'rect',   10, 'O5', 'occupied'),
('v5-t12', 'v5', 'v5-z2', 320, 345, 80,  80,  'circle', 4,  'O6', 'available');

-- Sirelis menu
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES
('v5-mc1', 'v5', '{"en":"Smashburgers","ru":"Смашбургеры","hy":"Smeshburgerner"}', 0),
('v5-mc2', 'v5', '{"en":"Coffee","ru":"Кофе","hy":"Surj"}', 1),
('v5-mc3', 'v5', '{"en":"Milkshakes","ru":"Милкшейки","hy":"Milqsheyq"}', 2),
('v5-mc4', 'v5', '{"en":"Fries","ru":"Фри","hy":"Fri"}', 3);

INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-m1',  'v5-mc1', 'v5', '{"en":"Original Cheeseburger","ru":"Оригинальный чизбургер","hy":"Original chizburger"}', '{"en":"Classic smashburger with American cheese and special sauce","ru":"Классический смэшбургер с американским сыром и фирменным соусом","hy":"Dasakan smeshburger amerikyan panrov ev firmenayin sousov"}', 2400, '{}', 0),
('v5-m2',  'v5-mc1', 'v5', '{"en":"Creamy Smash","ru":"Крими Смеш","hy":"Qrimi Smesh"}', '{"en":"Double patty with cream cheese and caramelized onion","ru":"Двойная котлета со сливочным сыром и карамелизированным луком","hy":"Krknakit kotlet kremayov panrov ev karamelatsvats sokhov"}', 2500, '{}', 1),
('v5-m3',  'v5-mc1', 'v5', '{"en":"Crispy Chicken Royale","ru":"Криспи Чикен Рояль","hy":"Qrispi Chiken Royal"}', '{"en":"Crispy fried chicken with lettuce and mayo","ru":"Хрустящая курица с салатом и майонезом","hy":"Khrtkhrtun hav salatov ev mayonezov"}', 2500, '{}', 2),
('v5-m4',  'v5-mc1', 'v5', '{"en":"Spicy Jalapeño","ru":"Острый Халапеньо","hy":"Spaysi Khalapeno"}', '{"en":"Smashburger with jalapeño peppers and pepper jack cheese","ru":"Смэшбургер с халапеньо и сыром пеппер джек","hy":"Smeshburger khalapeno bghbeghov ev pepper jak panrov"}', 2600, '{}', 3),
('v5-m5',  'v5-mc1', 'v5', '{"en":"Bacon Truffle","ru":"Бекон Трюфель","hy":"Bekon Tryufl"}', '{"en":"Premium smashburger with bacon and truffle mayo","ru":"Премиум смэшбургер с беконом и трюфельным майонезом","hy":"Premium smeshburger bekonov ev tryufelayin mayonezov"}', 3200, '{}', 4),
('v5-m6',  'v5-mc1', 'v5', '{"en":"Veggie Burger","ru":"Вегги Бургер","hy":"Veggi Burger"}', '{"en":"Plant-based patty with lettuce, tomato, and vegan mayo","ru":"Растительная котлета с салатом, томатом и веганским майонезом","hy":"Busakan kotlet salatov, lolikoy ev veganayin mayonezov"}', 2600, ARRAY['vegetarian','vegan'], 5),
('v5-m7',  'v5-mc2', 'v5', '{"en":"Espresso","ru":"Эспрессо","hy":"Espresso"}', '{"en":"Single shot espresso","ru":"Одинарный эспрессо","hy":"Miayin espresso"}', 900, ARRAY['vegetarian'], 0),
('v5-m8',  'v5-mc2', 'v5', '{"en":"Americano","ru":"Американо","hy":"Amerikano"}', '{"en":"Espresso with hot water","ru":"Эспрессо с горячей водой","hy":"Espresso tak jrov"}', 900, ARRAY['vegetarian'], 1),
('v5-m9',  'v5-mc2', 'v5', '{"en":"Cappuccino","ru":"Капучино","hy":"Kapuchino"}', '{"en":"Espresso with steamed milk foam","ru":"Эспрессо со вспененным молоком","hy":"Espresso phrprvats kathi prov"}', 1200, ARRAY['vegetarian'], 2),
('v5-m10', 'v5-mc2', 'v5', '{"en":"Flat White","ru":"Флэт Уайт","hy":"Flat White"}', '{"en":"Double espresso with velvety steamed milk","ru":"Двойной эспрессо с бархатистым молоком","hy":"Krknakit espresso tavshya kathov"}', 1300, ARRAY['vegetarian'], 3),
('v5-m11', 'v5-mc2', 'v5', '{"en":"Latte","ru":"Латте","hy":"Latte"}', '{"en":"Espresso with steamed milk","ru":"Эспрессо с горячим молоком","hy":"Espresso tak kathov"}', 1200, ARRAY['vegetarian'], 4),
('v5-m12', 'v5-mc3', 'v5', '{"en":"Vanilla","ru":"Ванильный","hy":"Vanil"}', '{"en":"Classic vanilla milkshake","ru":"Классический ванильный милкшейк","hy":"Dasakan vanilayin milqsheyq"}', 1200, ARRAY['vegetarian'], 0),
('v5-m13', 'v5-mc3', 'v5', '{"en":"Oreo","ru":"Орео","hy":"Oreo"}', '{"en":"Creamy Oreo cookie milkshake","ru":"Сливочный милкшейк с печеньем Орео","hy":"Kremayov Oreo thkhvatseghov milqsheyq"}', 1200, ARRAY['vegetarian'], 1),
('v5-m14', 'v5-mc3', 'v5', '{"en":"Strawberry","ru":"Клубничный","hy":"Elak"}', '{"en":"Fresh strawberry milkshake","ru":"Милкшейк со свежей клубникой","hy":"Tarm elakov milqsheyq"}', 1400, ARRAY['vegetarian'], 2),
('v5-m15', 'v5-mc4', 'v5', '{"en":"Classic Fries","ru":"Классический фри","hy":"Dasakan fri"}', '{"en":"Golden crispy French fries","ru":"Золотистый хрустящий фри","hy":"Voskeguyun khrtkhrtun fri"}', 900, ARRAY['vegetarian','vegan'], 0),
('v5-m16', 'v5-mc4', 'v5', '{"en":"Cheese Fries","ru":"Фри с сыром","hy":"Panrov fri"}', '{"en":"Fries topped with melted cheddar","ru":"Фри с расплавленным чеддером","hy":"Fri haltsvats chedderov"}', 1200, ARRAY['vegetarian'], 1),
('v5-m17', 'v5-mc4', 'v5', '{"en":"Truffle Fries","ru":"Трюфельный фри","hy":"Tryufelayin fri"}', '{"en":"Fries with truffle oil and parmesan","ru":"Фри с трюфельным маслом и пармезаном","hy":"Fri tryufelayin yughov ev parmezanov"}', 1500, ARRAY['vegetarian'], 2),
('v5-m18', 'v5-mc4', 'v5', '{"en":"Sweet Potato Fries","ru":"Фри из батата","hy":"Kaghtshr kartofilov fri"}', '{"en":"Crispy sweet potato fries with dipping sauce","ru":"Хрустящий фри из батата с соусом","hy":"Khrtkhrtun kaghtshr kartofilov fri sousov"}', 1100, ARRAY['vegetarian','vegan'], 3);

-- ─── Reviews ──────────────────────────────────────────────────────────────
INSERT INTO reviews (id, venue_id, user_id, rating, comment, created_at) VALUES
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b01', 'v1', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 5, '{"en":"Absolutely stunning wine selection and atmosphere. The Areni Noir Reserve was perfectly paired with our meal. Will definitely come back!","hy":"Zarmanali ginii yntraniq ev mthnoloort. Areni Noir Reserve-y kataryal yntraniq er mer keraki het. Anhapaymen kveradarnank!","ru":"Потрясающий выбор вин и атмосфера. Areni Noir Reserve идеально сочетался с ужином. Обязательно вернусь!"}', '2025-12-15'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b02', 'v1', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 4, '{"en":"Beautiful garden terrace setting. The wine cellar room is intimate and perfect for dates. Dargett IPA was refreshing.","hy":"Geghetsik aygestani terasa. Ginu nkughi srahy intim e ev kataryal date-i hamar. Dargett IPA-n zovatsnotch er.","ru":"Прекрасная садовая терраса. Винный зал уютный и идеален для свидания. Dargett IPA освежал."}', '2025-11-28'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b03', 'v1', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 5, '{"en":"The private rooms are perfect for celebrations. Great Armenian wine list and the Macallan 12 was superb.","hy":"Masnavori senyakner@ kataryal en tonakatarutyan hamar. Hianali haykakan ginii tsank ev Macallan 12-y hiaspan er.","ru":"Приватные комнаты идеальны для торжеств. Отличная карта армянских вин, а Macallan 12 был великолепен."}', '2025-10-20'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b04', 'v2', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 5, '{"en":"Best Italian food in Yerevan! The Spaghetti Carbonara is authentic and the Tiramisu De Angelo is heavenly.","hy":"Yerevanum lavagun italakan kerakury! Spaghetti Carbonara-n iravakan e ev Tiramisu De Angelo-n yerknayin e.","ru":"Лучшая итальянская кухня в Ереване! Спагетти Карбонара аутентична, а Тирамису Де Анджело — божественно."}', '2025-12-01'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b05', 'v2', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 5, '{"en":"The outdoor terrace is lovely. We had the Margherita pizza and Seafood Spaghetti — both incredible. Great breakfast too!","hy":"Artatnay terasay sirun e. Margherita piccayn ev Tsovamterqov Spaghetti-n — yerkusn el hianali ein. Nakhachashn el hianali e!","ru":"Летняя терраса прекрасна. Мы взяли пиццу Маргарита и Спагетти с морепродуктами — оба невероятны. Отличный завтрак тоже!"}', '2025-11-15'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b06', 'v3', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 4, '{"en":"Cozy Italian bistro with great pizza. The Truffle pizza and Carbonara pasta are must-tries. Negroni cocktail was perfect.","hy":"Jerm italakan bistro lav piccayov. Tryufelayin piccayn ev Karbonara pastan petq e p''ordzarkel. Negroni kokteyly kataryal er.","ru":"Уютное итальянское бистро с отличной пиццей. Трюфельная пицца и Карбонара — обязательно попробуйте. Негрони был идеален."}', '2025-12-10'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b07', 'v3', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 5, '{"en":"The Pistachio Gelato is the best I have ever had. Mamma Mia cocktail is a unique house creation. Highly recommend!","hy":"Pistaki pagphaghaky lavagunyn e, inch yerbeq ker p''ordzem. Mamma Mia kokteyly eznakan tnayin steghtsagortsutyun e. Khorhurt em talis!","ru":"Фисташковое джелато — лучшее, что я пробовал. Коктейль Мамма Миа — уникальное авторское творение. Очень рекомендую!"}', '2025-11-05'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b08', 'v4', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 5, '{"en":"Best smashburgers in Yerevan! The Bacon Truffle burger is incredible. Oreo milkshake and truffle fries are amazing sides.","hy":"Yerevanum lavagun smashburgernerý! Bacon Truffle burgery anhavanatalin e. Oreo milqsheyqy ev tryufelayin friy hiaspan koghmnakeraker en.","ru":"Лучшие смэшбургеры в Ереване! Бекон Трюфель бургер невероятен. Орео милкшейк и трюфельный фри — потрясающие дополнения."}', '2025-12-18'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b09', 'v4', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 4, '{"en":"Great fast food spot. The Spicy Jalapeño burger has a nice kick. Cheese fries are addictive. Open late which is a huge plus.","hy":"Hianali fast food tegh. Spicy Jalapeño burgery lav ktsutyun uni. Panrov friy kapvum e. Ush bats e, inch mets + e.","ru":"Отличный фастфуд. Острый Халапеньо бургер с приятной остринкой. Фри с сыром — зависимость. Работают допоздна — большой плюс."}', '2025-12-05'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b10', 'v5', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 4, '{"en":"Nice outdoor terrace with live music on weekends. The Original Cheeseburger and Cappuccino make a great combo. Relaxing vibe.","hy":"Sirun artatnay terasa kendani erajshtuthyamb hangstyan orerin. Original Cheeseburger-y ev Cappuccino-n hianali hamadrutuyun en. Hangstutyun mthnoloort.","ru":"Приятная летняя терраса с живой музыкой по выходным. Оригинальный чизбургер и капучино — отличный комбо. Расслабляющая атмосфера."}', '2025-11-22');

-- ─── Reservations ─────────────────────────────────────────────────────────
-- User 1 (Anna) reservations
INSERT INTO reservations (id, user_id, venue_id, table_id, date, time, party_size, status, total_amount, qr_code, payment_method, payment_status, created_at) VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c01', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'v1', 'v1-t7', '2026-02-25', '19:00', 2, 'upcoming', 0, 'RES-001-YASAMAN', 'card', 'success', '2026-02-18T10:30:00Z'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c02', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'v2', 'v2-t7', '2026-02-22', '20:00', 4, 'upcoming', 10400, 'RES-002-DEANGELO', 'card', 'success', '2026-02-17T14:00:00Z'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c03', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'v4', 'v4-t9', '2026-01-15', '18:30', 6, 'completed', 18500, 'RES-003-TWINS', 'cash', 'success', '2026-01-10T09:00:00Z'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c04', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'v3', 'v3-t1', '2026-01-20', '19:30', 2, 'cancelled', 0, 'RES-004-MAMMAMIA', 'card', 'pending', '2026-01-18T16:00:00Z');

-- Pre-order items for reservation 2 (De Angelo)
INSERT INTO pre_order_items (reservation_id, menu_item_id, quantity, unit_price) VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c02', 'v2-m1', 2, 3300),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c02', 'v2-m12', 2, 1900);
