-- =============================================
-- V12: Add Dragon Garden Byuzand venue with full menu
-- =============================================

-- ─── Venue ──────────────────────────────────────────────────────
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v6', 'Dragon Garden Byuzand', 'dragon-garden',
 '{"en":"Authentic Chinese and Pan-Asian restaurant offering Peking duck, dim sum, seafood, and traditional wok dishes in a stylish setting.","hy":"Chinakan yev hamaasiatakan restoran, voronq araqarkum en Pekinyan bad, dim sam, tsovamterq yev avandakan wok uteshtner.","ru":"Аутентичный китайский и паназиатский ресторан с пекинской уткой, дим-самом, морепродуктами и традиционными блюдами вок в стильной обстановке."}',
 ARRAY['Chinese','Asian','Seafood','Sushi'], 3, 4.5, 92,
 'Byuzand St, Yerevan 0010', 40.1811, 44.5185, '+374 10 580808',
 ARRAY['WiFi','Air Conditioning','Takeout'],
 '{"en":"Free cancellation 2 hours before. No-show fee 2000 AMD.","hy":"Anvchar chegarkum 2 zham araj. Chnerkayanalu tuyc 2000 AMD.","ru":"Бесплатная отмена за 2 часа. Штраф за неявку 2000 драм."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v6', 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800', 0),
('v6', 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?w=800', 1),
('v6', 'https://images.unsplash.com/photo-1555126634-323283e090fa?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v6', 'Mon-Sun', '12:00', '23:00');

-- ─── Floor zones ────────────────────────────────────────────────
INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v6-z1', 'v6', '{"en":"Main Hall","hy":"Glkhavor srah","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v6-z2', 'v6', '{"en":"Private Room","hy":"Masnvor senyak","ru":"Отдельная комната"}', 0, 200, 560, 200, '#E3F2FD');

-- ─── Floor tables ───────────────────────────────────────────────
INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v6-t1',  'v6', 'v6-z1', 40,  30,  80,  80,  'circle', 4,  'M1', 'available'),
('v6-t2',  'v6', 'v6-z1', 160, 30,  80,  80,  'circle', 4,  'M2', 'available'),
('v6-t3',  'v6', 'v6-z1', 280, 30,  80,  80,  'circle', 2,  'M3', 'available'),
('v6-t4',  'v6', 'v6-z1', 400, 30,  100, 60,  'rect',   6,  'M4', 'available'),
('v6-t5',  'v6', 'v6-z1', 40,  120, 100, 60,  'rect',   8,  'M5', 'available'),
('v6-t6',  'v6', 'v6-z1', 200, 120, 80,  80,  'circle', 4,  'M6', 'available'),
('v6-t7',  'v6', 'v6-z2', 40,  230, 80,  80,  'circle', 2,  'P1', 'available'),
('v6-t8',  'v6', 'v6-z2', 160, 230, 120, 60,  'rect',   6,  'P2', 'available'),
('v6-t9',  'v6', 'v6-z2', 320, 230, 80,  80,  'circle', 4,  'P3', 'available'),
('v6-t10', 'v6', 'v6-z2', 440, 230, 80,  80,  'circle', 2,  'P4', 'available');

-- ─── Admin user ─────────────────────────────────────────────────
INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000006', 'v6', 'Dragon Garden Admin', 'admin-dragon@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 580808', 'owner');

-- ─── Menu Categories ────────────────────────────────────────────
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES
('v6-cat-lent',     'v6', '{"en":"Lent Menu","hy":"Pahqi menyou","ru":"Постное меню"}', 0),
('v6-cat-main',     'v6', '{"en":"Main Dishes","hy":"Glkhvor uteshtner","ru":"Основные блюда"}', 1),
('v6-cat-veal',     'v6', '{"en":"Veal Dishes","hy":"Horthi msov uteshtner","ru":"Блюда из телятины"}', 2),
('v6-cat-ostrich',  'v6', '{"en":"Ostrich Dishes","hy":"Jaylami msov uteshtner","ru":"Блюда из страуса"}', 3),
('v6-cat-seafood',  'v6', '{"en":"Seafood","hy":"Tsovamterq","ru":"Морепродукты"}', 4),
('v6-cat-pasta',    'v6', '{"en":"Pasta & Noodles","hy":"Pasta yev lapsha","ru":"Паста и лапша"}', 5),
('v6-cat-rice',     'v6', '{"en":"Rice Dishes","hy":"Brndzov uteshtner","ru":"Блюда из риса"}', 6),
('v6-cat-soups',    'v6', '{"en":"Soups","hy":"Apurner","ru":"Супы"}', 7),
('v6-cat-salads',   'v6', '{"en":"Salads","hy":"Aghtsanner","ru":"Салаты"}', 8),
('v6-cat-desserts', 'v6', '{"en":"Desserts","hy":"Aghandер","ru":"Десерты"}', 9),
('v6-cat-bao',      'v6', '{"en":"Bao & Bread","hy":"Bao yev Hats","ru":"Бао и Хлеб"}', 10),
('v6-cat-drinks',   'v6', '{"en":"Drinks","hy":"Ympeliqner","ru":"Напитки"}', 11);

-- ─── Menu Items: Lent Menu ──────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i001', 'v6-cat-lent', 'v6', '{"en":"French fries","hy":"Ֆրի","ru":"Картофель фри"}', NULL, 1200, ARRAY['Vegan'], 0),
('v6-i002', 'v6-cat-lent', 'v6', '{"en":"Fried vegetables","hy":"Tapakats banjareghenutyun","ru":"Жареные овощи"}', NULL, 3600, ARRAY['Vegan'], 1),
('v6-i003', 'v6-cat-lent', 'v6', '{"en":"Pig''s ears","hy":"Khozi akanjner","ru":"Свиные уши"}', NULL, 3600, ARRAY[]::varchar[], 2),
('v6-i004', 'v6-cat-lent', 'v6', '{"en":"Vegetable salad in Chinese way","hy":"Բanjareghenay in aghtsan chinakan dzevov","ru":"Овощной салат по-китайски"}', NULL, 3200, ARRAY['Vegan'], 3),
('v6-i005', 'v6-cat-lent', 'v6', '{"en":"Salad with soybean sprouts","hy":"Aghtsan soyayi tsilerov","ru":"Салат из ростков сои"}', NULL, 3400, ARRAY['Vegan'], 4),
('v6-i006', 'v6-cat-lent', 'v6', '{"en":"Noodles with vegetables","hy":"Lapsha banjareghenov","ru":"Лапша с овощами"}', NULL, 3400, ARRAY['Vegan'], 5),
('v6-i007', 'v6-cat-lent', 'v6', '{"en":"Fried oyster mushrooms with Chinese spices","hy":"Tapakats kakhasunk chinakan hamemunqnerov","ru":"Жареные вешенки с китайскими специями"}', NULL, 3900, ARRAY['Vegan'], 6),
('v6-i008', 'v6-cat-lent', 'v6', '{"en":"Kappa maki","hy":"Կappa maki","ru":"Каппа маки"}', NULL, 1800, ARRAY['Sushi'], 7),
('v6-i009', 'v6-cat-lent', 'v6', '{"en":"Chuka maki","hy":"Chuka maki","ru":"Чука маки"}', NULL, 1800, ARRAY['Sushi'], 8),
('v6-i010', 'v6-cat-lent', 'v6', '{"en":"Avocado maki","hy":"Avokado maki","ru":"Авокадо маки"}', NULL, 2200, ARRAY['Sushi'], 9),
('v6-i011', 'v6-cat-lent', 'v6', '{"en":"Chuka","hy":"Chuka","ru":"Чука"}', NULL, 2900, ARRAY[]::varchar[], 10),
('v6-i012', 'v6-cat-lent', 'v6', '{"en":"Cucumbers in Chinese style","hy":"Varung chinakan dzevov","ru":"Огурцы в китайском стиле"}', NULL, 1300, ARRAY['Vegan'], 11);

-- ─── Menu Items: Main Dishes ────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i013', 'v6-cat-main', 'v6', '{"en":"Duck in Beijing (Peking) way","hy":"Բad Pekinyan dzevov","ru":"Утка по-пекински"}', NULL, 27400, ARRAY['Signature'], 0),
('v6-i014', 'v6-cat-main', 'v6', '{"en":"Shrimp with teriyaki sauce","hy":"Tsovakhetsgein teriyaki sousov","ru":"Креветки под соусом терияки"}', NULL, 9700, ARRAY['Seafood'], 1),
('v6-i015', 'v6-cat-main', 'v6', '{"en":"Shrimp with marinated cucumber","hy":"Tsovakhetsgein marinatsvatsi varungov","ru":"Креветки с маринованным огурцом"}', NULL, 9600, ARRAY['Seafood'], 2),
('v6-i016', 'v6-cat-main', 'v6', '{"en":"Lamb ribs with soy sauce Dragon Garden","hy":"Garran kogh er soyayi sousov","ru":"Бараньи ребрышки с соевым соусом Dragon Garden"}', NULL, 9500, ARRAY['Signature'], 3),
('v6-i017', 'v6-cat-main', 'v6', '{"en":"Duck meat with wine","hy":"Badi mis ginov","ru":"Мясо утки с вином"}', NULL, 8900, ARRAY[]::varchar[], 4),
('v6-i018', 'v6-cat-main', 'v6', '{"en":"Duck breast with lemon sauce","hy":"Badi krtsqamis limoni sousov","ru":"Утиная грудка с лимонным соусом"}', NULL, 8900, ARRAY[]::varchar[], 5),
('v6-i019', 'v6-cat-main', 'v6', '{"en":"Crispy shrimps","hy":"Khrthkhrtan tsovakhetsgetinner","ru":"Хрустящие креветки"}', NULL, 8800, ARRAY['Seafood'], 6),
('v6-i020', 'v6-cat-main', 'v6', '{"en":"Duck in a pan","hy":"Բad tavayi mej","ru":"Утка на сковороде"}', NULL, 8700, ARRAY[]::varchar[], 7),
('v6-i021', 'v6-cat-main', 'v6', '{"en":"Octopus in Chinese style","hy":"Uthotnuk chinakan dzevov","ru":"Осьминог по-китайски"}', NULL, 8600, ARRAY['Seafood'], 8),
('v6-i022', 'v6-cat-main', 'v6', '{"en":"Duck with broccoli and champignons","hy":"Բad brokoliov yev shampinionov","ru":"Утка с брокколи и шампиньонами"}', NULL, 8600, ARRAY[]::varchar[], 9),
('v6-i023', 'v6-cat-main', 'v6', '{"en":"Duck with coriander","hy":"Բad hamemov","ru":"Утка с кориандром"}', NULL, 8400, ARRAY[]::varchar[], 10),
('v6-i024', 'v6-cat-main', 'v6', '{"en":"Octopus with unagi sauce","hy":"Uthotnuk unagi sousov","ru":"Осьминог под соусом унаги"}', NULL, 7600, ARRAY['Seafood'], 11),
('v6-i025', 'v6-cat-main', 'v6', '{"en":"Turkey with mushrooms","hy":"Hndkahav snkov","ru":"Индейка с грибами"}', NULL, 6900, ARRAY[]::varchar[], 12),
('v6-i026', 'v6-cat-main', 'v6', '{"en":"Pork with shrimps in sauce on fire","hy":"Khozi mis tsovakhetsgetNov sousov kraki vra","ru":"Свинина с креветками в соусе на огне"}', NULL, 6900, ARRAY['Spicy'], 13),
('v6-i027', 'v6-cat-main', 'v6', '{"en":"Pork with marinated cucumber","hy":"Khozi mis marinatsvatsi varungov","ru":"Свинина с маринованным огурцом"}', NULL, 6600, ARRAY[]::varchar[], 14),
('v6-i028', 'v6-cat-main', 'v6', '{"en":"Chicken with shrimps and s.a.s. sauce","hy":"Havi mis tsovakhetsgetNov yev s.a.s. sousov","ru":"Курица с креветками под соусом s.a.s."}', NULL, 6600, ARRAY[]::varchar[], 15),
('v6-i029', 'v6-cat-main', 'v6', '{"en":"Chicken with raspberry sauce","hy":"Havi mis malaynayi sousov","ru":"Курица с малиновым соусом"}', NULL, 6300, ARRAY[]::varchar[], 16),
('v6-i030', 'v6-cat-main', 'v6', '{"en":"Pork gum bao","hy":"Khozi mis gum bao","ru":"Свинина гум бао"}', NULL, 5900, ARRAY[]::varchar[], 17),
('v6-i031', 'v6-cat-main', 'v6', '{"en":"Pork in a pan","hy":"Khozi mis tavayi mej","ru":"Свинина на сковороде"}', NULL, 5900, ARRAY[]::varchar[], 18),
('v6-i032', 'v6-cat-main', 'v6', '{"en":"Pork with green onions in pan","hy":"Khozi mis kanach sokhov tavayi mej","ru":"Свинина с зеленым луком на сковороде"}', NULL, 5900, ARRAY[]::varchar[], 19),
('v6-i033', 'v6-cat-main', 'v6', '{"en":"Chicken cashew","hy":"Hav keshyuov","ru":"Курица кешью"}', NULL, 5900, ARRAY[]::varchar[], 20),
('v6-i034', 'v6-cat-main', 'v6', '{"en":"Chicken with broccoli","hy":"Hav brokoliov","ru":"Курица с брокколи"}', NULL, 5900, ARRAY[]::varchar[], 21),
('v6-i035', 'v6-cat-main', 'v6', '{"en":"Shrimp with coriander and peanuts","hy":"Tsovakhetsgein hamemov yev getnanuShov","ru":"Креветки с кориандром и арахисом"}', NULL, 5900, ARRAY['Seafood'], 22),
('v6-i036', 'v6-cat-main', 'v6', '{"en":"Pork with vegetables","hy":"Khozi mis banjareghenov","ru":"Свинина с овощами"}', NULL, 5800, ARRAY[]::varchar[], 23),
('v6-i037', 'v6-cat-main', 'v6', '{"en":"Spicy chicken","hy":"Ktsu hav","ru":"Острая курица"}', NULL, 5800, ARRAY['Spicy'], 24),
('v6-i038', 'v6-cat-main', 'v6', '{"en":"Chicken in a pan","hy":"Hav tavayi mej","ru":"Курица на сковороде"}', NULL, 5700, ARRAY[]::varchar[], 25),
('v6-i039', 'v6-cat-main', 'v6', '{"en":"Chicken with orange in sweet and sour sauce","hy":"Hav narnjov ttvaqaghstsr sousov","ru":"Курица с апельсином в кисло-сладком соусе"}', NULL, 5600, ARRAY[]::varchar[], 26),
('v6-i040', 'v6-cat-main', 'v6', '{"en":"Gunbao","hy":"Gunbao","ru":"Гунбао"}', NULL, 5600, ARRAY['Spicy'], 27),
('v6-i041', 'v6-cat-main', 'v6', '{"en":"Chicken with pineapple in sweet and sour sauce","hy":"Hav ananasov ttvaqaghstsr sousov","ru":"Курица с ананасом в кисло-сладком соусе"}', NULL, 5600, ARRAY[]::varchar[], 28),
('v6-i042', 'v6-cat-main', 'v6', '{"en":"Chinese style squid rings","hy":"Kalmari oghakner chinakan dzevov","ru":"Кольца кальмара по-китайски"}', NULL, 5600, ARRAY['Seafood'], 29),
('v6-i043', 'v6-cat-main', 'v6', '{"en":"Chicken in sweet and sour sauce","hy":"Hav ttvaqaghstsr sousov","ru":"Курица в кисло-сладком соусе"}', NULL, 5400, ARRAY[]::varchar[], 30),
('v6-i044', 'v6-cat-main', 'v6', '{"en":"Chicken with vegetables","hy":"Hav banjareghenov","ru":"Курица с овощами"}', NULL, 5400, ARRAY[]::varchar[], 31),
('v6-i045', 'v6-cat-main', 'v6', '{"en":"Chicken casserole with broccoli","hy":"Havi msov kaserol brokoliov","ru":"Куриная запеканка с брокколи"}', NULL, 5300, ARRAY[]::varchar[], 32),
('v6-i046', 'v6-cat-main', 'v6', '{"en":"Shongo Pai","hy":"Shongo Pay","ru":"Шонго Пай"}', NULL, 5200, ARRAY[]::varchar[], 33),
('v6-i047', 'v6-cat-main', 'v6', '{"en":"Crispy chicken","hy":"Khrthkhrtan hav","ru":"Хрустящая курица"}', NULL, 4800, ARRAY[]::varchar[], 34),
('v6-i048', 'v6-cat-main', 'v6', '{"en":"Chinese style pork tenderloin","hy":"Khozi papkamis chinakan dzevov","ru":"Свиная вырезка по-китайски"}', NULL, 4800, ARRAY[]::varchar[], 35),
('v6-i049', 'v6-cat-main', 'v6', '{"en":"Fried eggplant with pork / chicken","hy":"Tapakats smbuk khozi / havi msov","ru":"Жареные баклажаны со свининой / курицей"}', NULL, 4600, ARRAY[]::varchar[], 36),
('v6-i050', 'v6-cat-main', 'v6', '{"en":"Pork with chips","hy":"Khozi mis chipserov","ru":"Свинина с чипсами"}', NULL, 4200, ARRAY[]::varchar[], 37),
('v6-i051', 'v6-cat-main', 'v6', '{"en":"Mussels in spicy sauce","hy":"Midianer ktsu sousov","ru":"Мидии в остром соусе"}', NULL, 3900, ARRAY['Seafood','Spicy'], 38),
('v6-i052', 'v6-cat-main', 'v6', '{"en":"Chinese style chicken wings","hy":"Havi tevikner chinakan dzevov","ru":"Куриные крылышки по-китайски"}', NULL, 3900, ARRAY[]::varchar[], 39),
('v6-i053', 'v6-cat-main', 'v6', '{"en":"Chinese style fried vegetables","hy":"Tapakats banjaregh en chinakan dzevov","ru":"Жареные овощи по-китайски"}', NULL, 3700, ARRAY['Vegan'], 40),
('v6-i054', 'v6-cat-main', 'v6', '{"en":"Fish Son-Shu","hy":"Dzuk Son-Shu","ru":"Рыба Сон-Шу"}', NULL, 13400, ARRAY['Seafood'], 41);

-- ─── Menu Items: Veal Dishes ────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i055', 'v6-cat-veal', 'v6', '{"en":"Spicy veal","hy":"Ktsu horthi mis","ru":"Острая телятина"}', NULL, 7900, ARRAY['Spicy'], 0),
('v6-i056', 'v6-cat-veal', 'v6', '{"en":"Veal with oyster sauce","hy":"Horthi mis ostreyi sousov","ru":"Телятина под устричным соусом"}', NULL, 7600, ARRAY[]::varchar[], 1),
('v6-i057', 'v6-cat-veal', 'v6', '{"en":"Veal with s.s.s. sauce","hy":"Horthi mis s.s.s. sousov","ru":"Телятина с соусом s.s.s."}', NULL, 7400, ARRAY[]::varchar[], 2),
('v6-i058', 'v6-cat-veal', 'v6', '{"en":"Veal with vegetables","hy":"Horthi mis banjareghenov","ru":"Телятина с овощами"}', NULL, 7400, ARRAY[]::varchar[], 3),
('v6-i059', 'v6-cat-veal', 'v6', '{"en":"Veal with coriander","hy":"Horthi mis hamemov","ru":"Телятина с кориандром"}', NULL, 7200, ARRAY[]::varchar[], 4),
('v6-i060', 'v6-cat-veal', 'v6', '{"en":"Veal on a pan","hy":"Horthi mis tavayi mej","ru":"Телятина на сковороде"}', NULL, 7100, ARRAY[]::varchar[], 5),
('v6-i061', 'v6-cat-veal', 'v6', '{"en":"Veal with broccoli","hy":"Horthi mis brokoliov","ru":"Телятина с брокколи"}', NULL, 6900, ARRAY[]::varchar[], 6),
('v6-i062', 'v6-cat-veal', 'v6', '{"en":"Veal with black mushrooms on a pan","hy":"Horthi mis sev snkov tavayi mej","ru":"Телятина с черными грибами на сковороде"}', NULL, 6800, ARRAY[]::varchar[], 7),
('v6-i063', 'v6-cat-veal', 'v6', '{"en":"Kyang-so","hy":"Kyang-so","ru":"Кянг-со"}', NULL, 6400, ARRAY[]::varchar[], 8);

-- ─── Menu Items: Ostrich Dishes ─────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i064', 'v6-cat-ostrich', 'v6', '{"en":"Ostrich meat with coriander","hy":"Jaylami mis hamemov","ru":"Мясо страуса с кориандром"}', NULL, 9600, ARRAY['Exotic'], 0);

-- ─── Menu Items: Seafood ────────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i065', 'v6-cat-seafood', 'v6', '{"en":"Cashew shrimp","hy":"Tsovakhetsgein keshyuov","ru":"Креветки с кешью"}', NULL, 9900, ARRAY['Seafood'], 0),
('v6-i066', 'v6-cat-seafood', 'v6', '{"en":"Shrimps in shell on pan","hy":"Tsovakhetsgein zrahov tavayi mej","ru":"Креветки в панцире на сковороде"}', NULL, 9800, ARRAY['Seafood'], 1),
('v6-i067', 'v6-cat-seafood', 'v6', '{"en":"Shrimps in spicy sauce on fire","hy":"Tsovakhetsgein ktsu sousov kraki vra","ru":"Креветки в остром соусе на огне"}', NULL, 8600, ARRAY['Seafood','Spicy'], 2),
('v6-i068', 'v6-cat-seafood', 'v6', '{"en":"Octopus in a pan","hy":"Uthotnuk tavayi mej","ru":"Осьминог на сковороде"}', NULL, 8400, ARRAY['Seafood'], 3),
('v6-i069', 'v6-cat-seafood', 'v6', '{"en":"Frog legs in Chinese style","hy":"Gorti tatikner chinakan dzevov","ru":"Лягушачьи лапки по-китайски"}', NULL, 8900, ARRAY['Exotic'], 4),
('v6-i070', 'v6-cat-seafood', 'v6', '{"en":"Shrimp Con Xia","hy":"Tsovakhetsgein Kon Sya","ru":"Креветки Кон Ся"}', NULL, 6600, ARRAY['Seafood'], 5),
('v6-i071', 'v6-cat-seafood', 'v6', '{"en":"Shrimp ghadeif","hy":"Tsovakhetsgein kadaif","ru":"Креветки кадайф"}', NULL, 4600, ARRAY['Seafood'], 6),
('v6-i072', 'v6-cat-seafood', 'v6', '{"en":"Crispy trout","hy":"Khrthkhrtan ishkhan","ru":"Хрустящая форель"}', NULL, 4600, ARRAY['Seafood'], 7),
('v6-i073', 'v6-cat-seafood', 'v6', '{"en":"Fried sig","hy":"Tapakats sig","ru":"Жареный сиг"}', NULL, 3900, ARRAY['Seafood'], 8);

-- ─── Menu Items: Pasta & Noodles ────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i074', 'v6-cat-pasta', 'v6', '{"en":"Newro with veal","hy":"Nevro horthi msov","ru":"Невро с телятиной"}', NULL, 5600, ARRAY[]::varchar[], 0),
('v6-i075', 'v6-cat-pasta', 'v6', '{"en":"Noodles with shrimps","hy":"Lapsha tsovakhetsgetNov","ru":"Лапша с креветками"}', NULL, 4600, ARRAY['Seafood'], 1),
('v6-i076', 'v6-cat-pasta', 'v6', '{"en":"Noodles with veal","hy":"Lapsha horthi msov","ru":"Лапша с телятиной"}', NULL, 4300, ARRAY[]::varchar[], 2),
('v6-i077', 'v6-cat-pasta', 'v6', '{"en":"Mu Kai Udon noodles","hy":"Lapsha Mu Kay Udon","ru":"Лапша Му Кай Удон"}', NULL, 4300, ARRAY[]::varchar[], 3),
('v6-i078', 'v6-cat-pasta', 'v6', '{"en":"Noodles with chicken","hy":"Lapsha havov","ru":"Лапша с курицей"}', NULL, 3800, ARRAY[]::varchar[], 4),
('v6-i079', 'v6-cat-pasta', 'v6', '{"en":"Noodles (Plain)","hy":"Lapsha (aranc haveloumneri)","ru":"Лапша (простая)"}', NULL, 1400, ARRAY['Vegan'], 5);

-- ─── Menu Items: Rice Dishes ────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i080', 'v6-cat-rice', 'v6', '{"en":"Fried rice with veal","hy":"Tapakats brindz horthi msov","ru":"Жареный рис с телятиной"}', NULL, 3800, ARRAY[]::varchar[], 0),
('v6-i081', 'v6-cat-rice', 'v6', '{"en":"Fried rice with shrimps","hy":"Tapakats brindz tsovakhetsgetNov","ru":"Жареный рис с креветками"}', NULL, 3600, ARRAY['Seafood'], 1),
('v6-i082', 'v6-cat-rice', 'v6', '{"en":"Fried rice with chicken","hy":"Tapakats brindz havov","ru":"Жареный рис с курицей"}', NULL, 2800, ARRAY[]::varchar[], 2),
('v6-i083', 'v6-cat-rice', 'v6', '{"en":"Yang-Zhu fried rice (veg & egg)","hy":"Yan-Chzhu tapakats brindz","ru":"Жареный рис Ян-Чжу (овощи и яйцо)"}', NULL, 2400, ARRAY['Vegetarian'], 3),
('v6-i084', 'v6-cat-rice', 'v6', '{"en":"Rice (Plain)","hy":"Brindz (aranc haveloumneri)","ru":"Рис (простой)"}', NULL, 1200, ARRAY['Vegan'], 4);

-- ─── Menu Items: Soups ──────────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i085', 'v6-cat-soups', 'v6', '{"en":"Dragon soup","hy":"Drakon apur","ru":"Суп Дракон"}', NULL, 5800, ARRAY['Signature'], 0),
('v6-i086', 'v6-cat-soups', 'v6', '{"en":"Tom Yum with seafood","hy":"Tom Yam tsovamterqov","ru":"Том Ям с морепродуктами"}', NULL, 5900, ARRAY['Spicy','Seafood'], 1),
('v6-i087', 'v6-cat-soups', 'v6', '{"en":"Tom Yum","hy":"Tom Yam","ru":"Том Ям"}', NULL, 4400, ARRAY['Spicy'], 2),
('v6-i088', 'v6-cat-soups', 'v6', '{"en":"Ramen","hy":"Ramen","ru":"Рамен"}', NULL, 2900, ARRAY[]::varchar[], 3),
('v6-i089', 'v6-cat-soups', 'v6', '{"en":"Sour spicy soup","hy":"Ttvaktsu apur","ru":"Кисло-острый суп"}', NULL, 2600, ARRAY['Spicy'], 4),
('v6-i090', 'v6-cat-soups', 'v6', '{"en":"Egg soup with veal","hy":"Dzvov apur horthi msov","ru":"Яичный суп с телятиной"}', NULL, 2600, ARRAY[]::varchar[], 5),
('v6-i091', 'v6-cat-soups', 'v6', '{"en":"Chinese soup","hy":"Chinakan apur","ru":"Китайский суп"}', NULL, 2400, ARRAY[]::varchar[], 6),
('v6-i092', 'v6-cat-soups', 'v6', '{"en":"Spicy chicken soup","hy":"Ktsu havov apur","ru":"Острый куриный суп"}', NULL, 2400, ARRAY['Spicy'], 7),
('v6-i093', 'v6-cat-soups', 'v6', '{"en":"Spicy mushroom soup","hy":"Ktsu snkov apur","ru":"Острый грибной суп"}', NULL, 2300, ARRAY['Spicy','Vegan'], 8);

-- ─── Menu Items: Salads ─────────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i094', 'v6-cat-salads', 'v6', '{"en":"Gato sake","hy":"Gato sake","ru":"Гато саке"}', NULL, 5900, ARRAY[]::varchar[], 0),
('v6-i095', 'v6-cat-salads', 'v6', '{"en":"Midori Sara","hy":"Midori Sara","ru":"Мидори Сара"}', NULL, 3900, ARRAY[]::varchar[], 1),
('v6-i096', 'v6-cat-salads', 'v6', '{"en":"Fen-se","hy":"Fen-se","ru":"Фен-се"}', NULL, 3600, ARRAY[]::varchar[], 2);

-- ─── Menu Items: Desserts ───────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i097', 'v6-cat-desserts', 'v6', '{"en":"Black orchid","hy":"Sev orkhidea","ru":"Черная орхидея"}', NULL, 4600, ARRAY[]::varchar[], 0),
('v6-i098', 'v6-cat-desserts', 'v6', '{"en":"Fried apples in caramel","hy":"Tapakats khndsor karameli mej","ru":"Жареные яблоки в карамели"}', NULL, 4300, ARRAY[]::varchar[], 1),
('v6-i099', 'v6-cat-desserts', 'v6', '{"en":"White orchid","hy":"Spitak orkhidea","ru":"Белая орхидея"}', NULL, 4200, ARRAY[]::varchar[], 2),
('v6-i100', 'v6-cat-desserts', 'v6', '{"en":"Fried ice cream","hy":"Tapakats paghpaghak","ru":"Жареное мороженое"}', NULL, 1700, ARRAY[]::varchar[], 3);

-- ─── Menu Items: Bao & Bread ────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i101', 'v6-cat-bao', 'v6', '{"en":"Shrimp Bao","hy":"Tsovakhetsgetniov Bao","ru":"Бао с креветками"}', NULL, 3300, ARRAY['Seafood'], 0),
('v6-i102', 'v6-cat-bao', 'v6', '{"en":"Beef Bao","hy":"Tavari msov Bao","ru":"Бао с говядиной"}', NULL, 3100, ARRAY[]::varchar[], 1),
('v6-i103', 'v6-cat-bao', 'v6', '{"en":"Chicken Bao","hy":"Havi msov Bao","ru":"Бао с курицей"}', NULL, 2800, ARRAY[]::varchar[], 2),
('v6-i104', 'v6-cat-bao', 'v6', '{"en":"Chinese bread / Bread basket","hy":"Chinakan hats / Hatsi zambyugh","ru":"Китайский хлеб / Хлебная корзина"}', NULL, 900, ARRAY[]::varchar[], 3);

-- ─── Menu Items: Drinks ─────────────────────────────────────────
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v6-i105', 'v6-cat-drinks', 'v6', '{"en":"Pomegranate juice (250ml)","hy":"Nrani hyut (250ml)","ru":"Гранатовый сок (250мл)"}', NULL, 5500, ARRAY['Drink'], 0),
('v6-i106', 'v6-cat-drinks', 'v6', '{"en":"Fresh juices (Apple/Orange/Grapefruit)","hy":"Tarm hyuter (Khndsor/Narinj/Thurinj)","ru":"Свежевыжатые соки (Яблоко/Апельсин/Грейпфрут)"}', NULL, 2200, ARRAY['Drink'], 1),
('v6-i107', 'v6-cat-drinks', 'v6', '{"en":"Lemonades (various 500ml)","hy":"Limonadner (tarberi 500ml)","ru":"Лимонады (разные 500мл)"}', NULL, 1700, ARRAY['Drink'], 2),
('v6-i108', 'v6-cat-drinks', 'v6', '{"en":"Sodas (Coke/Fanta/Sprite 0.5l)","hy":"Zovatsutsich mpeliqner (0.5l)","ru":"Газировки (Кола/Фанта/Спрайт 0.5л)"}', NULL, 500, ARRAY['Drink'], 3),
('v6-i109', 'v6-cat-drinks', 'v6', '{"en":"Water (Byuregh/Jermuk 0.5l)","hy":"Jur (Byuregh/Jermuk 0.5l)","ru":"Вода (Бюрег/Джермук 0.5л)"}', NULL, 300, ARRAY['Drink'], 4),
('v6-i110', 'v6-cat-drinks', 'v6', '{"en":"Beer (Dargett 0.33l)","hy":"Garejur (Darget 0.33l)","ru":"Пиво (Даргетт 0.33л)"}', NULL, 1600, ARRAY['Alcohol'], 5),
('v6-i111', 'v6-cat-drinks', 'v6', '{"en":"Wine (Red Dragon 0.75l)","hy":"Gini (Karmir Drakon 0.75l)","ru":"Вино (Красный Дракон 0.75л)"}', NULL, 9000, ARRAY['Alcohol'], 6);
