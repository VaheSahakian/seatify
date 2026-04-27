-- =============================================
-- V13: Add remaining restaurants from menu JSONs
-- =============================================

-- Clean up pre_order_items that reference old menu items for replaced venues
DELETE FROM pre_order_items WHERE menu_item_id IN (SELECT id FROM menu_items WHERE venue_id IN ('v1','v2','v5'));

-- ─── Replace menu for Yasaman (v1) ──────────────────────
DELETE FROM menu_items WHERE venue_id = 'v1';
DELETE FROM menu_categories WHERE venue_id = 'v1';

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c00', 'v1', '{"en": "Appetizers", "hy": "Սկսելու համար (Նախուտեստներ)", "ru": "Закуски"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i001', 'v1-c00', 'v1', '{"en": "Assorted aged cheeses", "hy": "Հնեցված պանիրների տեսականի", "ru": "Ассорти выдержанных сыров"}', NULL, 6400, ARRAY[]::varchar[], 0),
('v1-i002', 'v1-c00', 'v1', '{"en": "Armenian Greens", "hy": "Հայկական կանաչիներ", "ru": "Армянская зелень"}', NULL, 1800, ARRAY[]::varchar[], 1),
('v1-i003', 'v1-c00', 'v1', '{"en": "Pickles assortment", "hy": "Թթվի տեսականի", "ru": "Ассорти солений"}', NULL, 2200, ARRAY[]::varchar[], 2),
('v1-i004', 'v1-c00', 'v1', '{"en": "Ghavurma", "hy": "Ղավուրմա", "ru": "Гавурма"}', NULL, 3500, ARRAY[]::varchar[], 3),
('v1-i005', 'v1-c00', 'v1', '{"en": "Pancake with beef and sour cream", "hy": "Նրբաբլիթ տավարի մսով և թթվասերով", "ru": "Блинчик с говядиной и сметаной"}', NULL, 2800, ARRAY[]::varchar[], 4),
('v1-i006', 'v1-c00', 'v1', '{"en": "Vegetable rolls", "hy": "Բանջարեղենային ռոլեր", "ru": "Овощные роллы"}', NULL, 1900, ARRAY[]::varchar[], 5),
('v1-i007', 'v1-c00', 'v1', '{"en": "Green olives with tarragon oil", "hy": "Կանաչ ձիթապտուղ թարխունի ձեթով", "ru": "Зеленые оливки с тархуновым маслом"}', NULL, 2200, ARRAY[]::varchar[], 6),
('v1-i008', 'v1-c00', 'v1', '{"en": "Radish", "hy": "Բողկ", "ru": "Редька"}', NULL, 1000, ARRAY[]::varchar[], 7),
('v1-i009', 'v1-c00', 'v1', '{"en": "Chanakh and sheep cheese", "hy": "Պանիր չանախ և ոչխարի", "ru": "Овечий сыр и чанах"}', NULL, 1800, ARRAY[]::varchar[], 8),
('v1-i010', 'v1-c00', 'v1', '{"en": "Roast beef with parmesan seasoning", "hy": "Ռոստբիֆ համեմված պարմեզանով", "ru": "Ростбиф, приправленный пармезаном"}', NULL, 3700, ARRAY[]::varchar[], 9),
('v1-i011', 'v1-c00', 'v1', '{"en": "Bread / Lavash", "hy": "Հաց / Լավաշ", "ru": "Хлеб / Лаваш"}', NULL, 350, ARRAY[]::varchar[], 10),
('v1-i012', 'v1-c00', 'v1', '{"en": "Eggplant with walnut sauce", "hy": "Սմբուկ ընկույզի սոուսով", "ru": "Баклажаны с ореховым соусом"}', NULL, 1800, ARRAY[]::varchar[], 11);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c01', 'v1', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i013', 'v1-c01', 'v1', '{"en": "With beef", "hy": "Հորթի մսով", "ru": "С телятиной"}', NULL, 3600, ARRAY[]::varchar[], 0),
('v1-i014', 'v1-c01', 'v1', '{"en": "With tomato, tarragon and feta", "hy": "Լոլիկով, թարխունով և ֆետա պանրով", "ru": "С помидорами, эстрагоном и сыром фета"}', NULL, 3500, ARRAY[]::varchar[], 1),
('v1-i015', 'v1-c01', 'v1', '{"en": "With cucumbers, tomatoes and sweet peppers", "hy": "Վարունգով, լոլիկով և քաղցր պղպեղով", "ru": "С огурцами, помидорами и сладким перцем"}', NULL, 2900, ARRAY[]::varchar[], 2),
('v1-i016', 'v1-c01', 'v1', '{"en": "With roastbeef, avocado and feta", "hy": "Ռոստբիֆով, ավոկադոյով և ֆետայով", "ru": "С ростбифом, авокадо и сыром фета"}', NULL, 3900, ARRAY[]::varchar[], 3),
('v1-i017', 'v1-c01', 'v1', '{"en": "With green beans, quail egg and tarragon sauce", "hy": "Կանաչ լոբով, լորի ձվով և թարխունի սոուսով", "ru": "С зеленой фасолью, перепелиным яйцом и соусом из эстрагона"}', NULL, 2900, ARRAY[]::varchar[], 4),
('v1-i018', 'v1-c01', 'v1', '{"en": "With kotem, vegetables and chanakh cheese", "hy": "Կոտեմով, բանջարեղենով և չանախ պանրով", "ru": "С котемом, овощами и сыром чанах"}', NULL, 3800, ARRAY[]::varchar[], 5),
('v1-i019', 'v1-c01', 'v1', '{"en": "Green salad with chicken breast", "hy": "Կանաչ աղցան հավի կրծքամսով", "ru": "Зеленый салат с куриной грудкой"}', NULL, 3100, ARRAY[]::varchar[], 6),
('v1-i020', 'v1-c01', 'v1', '{"en": "With aveluk and strained yogurt", "hy": "Ավելուկով և քամած մածունով", "ru": "С горным щавелем и сцеженным мацуном"}', NULL, 2600, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c02', 'v1', '{"en": "Dips", "hy": "Դիփեր", "ru": "Дипы"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i021', 'v1-c02', 'v1', '{"en": "Strained yogurt with red pepper and pistachios", "hy": "Քամած մածուն կարմիր բիբարով և պիստակով", "ru": "Процеженный мацун с красным перцем и фисташками"}', NULL, 1900, ARRAY[]::varchar[], 0),
('v1-i022', 'v1-c02', 'v1', '{"en": "Mutabal", "hy": "Մութաբալ", "ru": "Мутабал"}', NULL, 2100, ARRAY[]::varchar[], 1),
('v1-i023', 'v1-c02', 'v1', '{"en": "Hummus with roast beef and vegetables", "hy": "Հումուս ռոստբիֆով և բանջարեղենով", "ru": "Хумус с ростбифом и овощами"}', NULL, 3200, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c03', 'v1', '{"en": "From the Stone Oven", "hy": "Քարի վառարանից", "ru": "Из каменной печи"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i024', 'v1-c03', 'v1', '{"en": "Lahmajo in the pit oven", "hy": "Լահմաջոներ փռի մեջ", "ru": "Ламаджо в печи"}', NULL, 3100, ARRAY[]::varchar[], 0),
('v1-i025', 'v1-c03', 'v1', '{"en": "Pide with ghavurma, tomato and pepper", "hy": "Փիդե ղավուրմայով, լոլիկով և բիբարով", "ru": "Пиде с гавурмой, помидорами и перцем"}', NULL, 3100, ARRAY[]::varchar[], 1),
('v1-i026', 'v1-c03', 'v1', '{"en": "Pide with herbs and cheese", "hy": "Փիդե կանաչիներով և պանրով", "ru": "Пиде с зеленью и сыром"}', NULL, 2400, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c04', 'v1', '{"en": "Soups", "hy": "Ապուրներ", "ru": "Супы"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i027', 'v1-c04', 'v1', '{"en": "Khash with meat", "hy": "Խաշ մսով", "ru": "Хаш с мясом"}', NULL, 3800, ARRAY[]::varchar[], 0),
('v1-i028', 'v1-c04', 'v1', '{"en": "Yogurt soup with ishli kufta", "hy": "Սպաս իշլի քուֆթայով", "ru": "Спас с ишли кюфтой"}', NULL, 3200, ARRAY[]::varchar[], 1),
('v1-i029', 'v1-c04', 'v1', '{"en": "Piti", "hy": "Փիթի", "ru": "Пити"}', NULL, 2500, ARRAY[]::varchar[], 2),
('v1-i030', 'v1-c04', 'v1', '{"en": "Kharcho", "hy": "Խառչո", "ru": "Харчо"}', NULL, 3000, ARRAY[]::varchar[], 3),
('v1-i031', 'v1-c04', 'v1', '{"en": "With red beans", "hy": "Լոբով ապուր", "ru": "С красным лобио"}', NULL, 1900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c05', 'v1', '{"en": "Grill / BBQ", "hy": "Ուտեստներ ածուխի վրա", "ru": "Блюда на углях"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i032', 'v1-c05', 'v1', '{"en": "Pork BBQ ribs/loin chops", "hy": "Խոզի խորոված (մատներ/չալաղաջ)", "ru": "Шашлык из свиных ребер / корейки"}', NULL, 4700, ARRAY[]::varchar[], 0),
('v1-i033', 'v1-c05', 'v1', '{"en": "Pork mix BBQ", "hy": "Խոզի խառը խորոված", "ru": "Шашлык из свинины"}', NULL, 4200, ARRAY[]::varchar[], 1),
('v1-i034', 'v1-c05', 'v1', '{"en": "Lamb BBQ", "hy": "Գառան խորոված", "ru": "Шашлык из ягнятины (мякоть)"}', NULL, 4700, ARRAY[]::varchar[], 2),
('v1-i035', 'v1-c05', 'v1', '{"en": "Chicken BBQ", "hy": "Խորոված ճուտ", "ru": "Шашлык из цыпленка"}', NULL, 2700, ARRAY[]::varchar[], 3),
('v1-i036', 'v1-c05', 'v1', '{"en": "Crayfish kebab", "hy": "Քաբաբ խեցգետնի", "ru": "Кебаб из раковых шеек"}', NULL, 3500, ARRAY[]::varchar[], 4),
('v1-i037', 'v1-c05', 'v1', '{"en": "Lamb BBQ ribs and loin chops", "hy": "Գառան մատներ և չալաղաջ", "ru": "Шашлык из ягнятины (ребрышки, корейка)"}', NULL, 6200, ARRAY[]::varchar[], 5),
('v1-i038', 'v1-c05', 'v1', '{"en": "Grilled sturgeon with vegetable salad", "hy": "Ասետրինայի խորոված բանջարեղենային աղցանով", "ru": "Осетрина на гриле с овощным салатом"}', NULL, 6200, ARRAY[]::varchar[], 6),
('v1-i039', 'v1-c05', 'v1', '{"en": "Grilled veal tenderloin", "hy": "Հորթի խորոված փափկամիս", "ru": "Телячья вырезка на гриле"}', NULL, 4300, ARRAY[]::varchar[], 7),
('v1-i040', 'v1-c05', 'v1', '{"en": "Turkey BBQ", "hy": "Հնդկահավի խորոված", "ru": "Шашлык из индейки"}', NULL, 14600, ARRAY[]::varchar[], 8),
('v1-i041', 'v1-c05', 'v1', '{"en": "Chicken kebab", "hy": "Հավի քաբաբ", "ru": "Кабаб из курицы"}', NULL, 1900, ARRAY[]::varchar[], 9),
('v1-i042', 'v1-c05', 'v1', '{"en": "Veal kabab", "hy": "Հորթի քաբաբ", "ru": "Кабаб из говядины"}', NULL, 2100, ARRAY[]::varchar[], 10),
('v1-i043', 'v1-c05', 'v1', '{"en": "Salmon with zucchini and spinach", "hy": "Սաղմոն դդմիկով և սպանախով", "ru": "Лосось с цукини и шпинатом"}', NULL, 6600, ARRAY[]::varchar[], 11),
('v1-i044', 'v1-c05', 'v1', '{"en": "BBQ Set (4-5 persons)", "hy": "Սեթ խորովածի (4-5 անձի համար)", "ru": "Сет шашлыков (на 4-5 персон)"}', NULL, 25400, ARRAY[]::varchar[], 12);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c06', 'v1', '{"en": "Main Dishes", "hy": "Հիմնական ուտեստներ և խավարտներ", "ru": "Основные блюда"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i045', 'v1-c06', 'v1', '{"en": "Tolma with calf sliced meat (Cabbage/Grape)", "hy": "Տոլմա հորթի մսով (կաղամբով կամ խաղողի տերևով)", "ru": "Долма из нарезанной телятины"}', NULL, 3600, ARRAY[]::varchar[], 0),
('v1-i046', 'v1-c06', 'v1', '{"en": "Tolma with goose sliced meat", "hy": "Տոլմա սագի կտրտած մսով", "ru": "Толма из нарезанного гусиного мяса"}', NULL, 3800, ARRAY[]::varchar[], 1),
('v1-i047', 'v1-c06', 'v1', '{"en": "River trout (karmrakhayt) summer style", "hy": "Գետի կարմրախայտ ամառային ձևով", "ru": "Вареная горно-ручьевая форель по-летнему"}', NULL, 5900, ARRAY[]::varchar[], 2),
('v1-i048', 'v1-c06', 'v1', '{"en": "Chicken breast with rice", "hy": "Հավի կրծքամիս սերուցքային սոուսով և բրնձով", "ru": "Куриная грудка в сливочном соусе с рисом"}', NULL, 3600, ARRAY[]::varchar[], 3),
('v1-i049', 'v1-c06', 'v1', '{"en": "Calf cheek with green cream sauce", "hy": "Հորթի թուշ կարտոֆիլի խյուսով", "ru": "Щека теленка с зеленым сливочным соусом"}', NULL, 4700, ARRAY[]::varchar[], 4),
('v1-i050', 'v1-c06', 'v1', '{"en": "Turkey harisa", "hy": "Հնդկահավի հարիսա", "ru": "Ариса из индейки"}', NULL, 3400, ARRAY[]::varchar[], 5),
('v1-i051', 'v1-c06', 'v1', '{"en": "Crayfish kufta with rice and mushrooms", "hy": "Խեցգետնի քուֆթա բրնձով և սնկով", "ru": "Кюфта из раков с рисом и грибами"}', NULL, 6700, ARRAY[]::varchar[], 6);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c07', 'v1', '{"en": "Side Dishes", "hy": "Խավարտներ", "ru": "Гарниры"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i052', 'v1-c07', 'v1', '{"en": "Sauteed spinach", "hy": "Տապակած սպանախ", "ru": "Тушеный шпинат"}', NULL, 2700, ARRAY[]::varchar[], 0),
('v1-i053', 'v1-c07', 'v1', '{"en": "Homemade fried potatoes", "hy": "Տնական կարտոֆիլ", "ru": "Жареный картофель по-домашнему"}', NULL, 1900, ARRAY[]::varchar[], 1),
('v1-i054', 'v1-c07', 'v1', '{"en": "Grilled vegetables", "hy": "Գրիլ բանջարեղեն", "ru": "Овощи на гриле"}', NULL, 2800, ARRAY[]::varchar[], 2),
('v1-i055', 'v1-c07', 'v1', '{"en": "Potato BBQ", "hy": "Շաշլիկ կարտոֆիլից", "ru": "Шашлык из картофеля"}', NULL, 1200, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c08', 'v1', '{"en": "Desserts", "hy": "Աղանդեր", "ru": "Десерты"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i056', 'v1-c08', 'v1', '{"en": "Hot halva with ice cream", "hy": "Տաք հալվա պաղպաղակով", "ru": "Теплая халва с мороженым"}', NULL, 2200, ARRAY[]::varchar[], 0),
('v1-i057', 'v1-c08', 'v1', '{"en": "Honey cake", "hy": "Մեղրով տորթ", "ru": "Медовик"}', NULL, 2600, ARRAY[]::varchar[], 1),
('v1-i058', 'v1-c08', 'v1', '{"en": "Pakhlava", "hy": "Փախլավա", "ru": "Пахлава"}', NULL, 2200, ARRAY[]::varchar[], 2),
('v1-i059', 'v1-c08', 'v1', '{"en": "Freshly baked gata", "hy": "Տաք գաթա ընդեղենով", "ru": "Свежеиспеченная гата"}', NULL, 2500, ARRAY[]::varchar[], 3),
('v1-i060', 'v1-c08', 'v1', '{"en": "Napoleon", "hy": "Նապոլեոն", "ru": "Наполеон"}', NULL, 2400, ARRAY[]::varchar[], 4),
('v1-i061', 'v1-c08', 'v1', '{"en": "Mikado", "hy": "Միկադո", "ru": "Микадо"}', NULL, 2600, ARRAY[]::varchar[], 5),
('v1-i062', 'v1-c08', 'v1', '{"en": "Esterhazy", "hy": "Էստերհազի", "ru": "Эстерхази"}', NULL, 2600, ARRAY[]::varchar[], 6),
('v1-i063', 'v1-c08', 'v1', '{"en": "Seasonal fruits", "hy": "Սեզոնային մրգեր", "ru": "Сезонные фрукты"}', NULL, 5900, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v1-c09', 'v1', '{"en": "Lenten Menu", "hy": "Պահքի մենյու", "ru": "Постное меню"}', 9);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v1-i064', 'v1-c09', 'v1', '{"en": "Pasuts dolma", "hy": "Պասուց տոլմա", "ru": "Пасуц толма"}', NULL, 1300, ARRAY[]::varchar[], 0),
('v1-i065', 'v1-c09', 'v1', '{"en": "Grilled Eggplant with Tahini", "hy": "Խորոված սմբուկ թահինով", "ru": "Баклажан на гриле с тахини"}', NULL, 3400, ARRAY[]::varchar[], 1),
('v1-i066', 'v1-c09', 'v1', '{"en": "Quinoa tabouleh", "hy": "Թաբուլե քինուայով", "ru": "Табуле из киноа"}', NULL, 2400, ARRAY[]::varchar[], 2),
('v1-i067', 'v1-c09', 'v1', '{"en": "Soup with sorrel and lentils", "hy": "Ավելուկով և ոսպով ապուր", "ru": "Суп со щавелем и чечевицей"}', NULL, 2300, ARRAY[]::varchar[], 3),
('v1-i068', 'v1-c09', 'v1', '{"en": "Sauteed sibegh", "hy": "Տապակած սիբեխ", "ru": "Жареный сибех"}', NULL, 2200, ARRAY[]::varchar[], 4),
('v1-i069', 'v1-c09', 'v1', '{"en": "Beetroot stems", "hy": "Բազուկի ճավ", "ru": "Черешки свеклы"}', NULL, 1500, ARRAY[]::varchar[], 5);

-- ─── Replace menu for De Angelo (v2) ──────────────────────
DELETE FROM menu_items WHERE venue_id = 'v2';
DELETE FROM menu_categories WHERE venue_id = 'v2';

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c00', 'v2', '{"en": "Breakfast", "hy": "ՆԱԽԱՃԱՇ", "ru": "Завтрак"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i001', 'v2-c00', 'v2', '{"en": "Granola Yoghurt", "hy": "Գրանոլա յոգուրտ", "ru": "Йогурт с гранолой"}', NULL, 2400, ARRAY[]::varchar[], 0),
('v2-i002', 'v2-c00', 'v2', '{"en": "Shakshuka", "hy": "Շակշուկա", "ru": "Шакшука"}', '{"en": "Neapolitan sauce, poached eggs", "hy": "նեապոլիտանա սոուս, բենետիկդ ձվով", "ru": "Неаполитанский соус, яйца пашот"}', 2800, ARRAY[]::varchar[], 1),
('v2-i003', 'v2-c00', 'v2', '{"en": "Roast beef croissant", "hy": "Ռոստբիֆ կրուասան", "ru": "Круассан с ростбифом"}', NULL, 3500, ARRAY[]::varchar[], 2),
('v2-i004', 'v2-c00', 'v2', '{"en": "Bacon croissant", "hy": "Բեկոն կրուասան", "ru": "Круассан с беконом"}', NULL, 2800, ARRAY[]::varchar[], 3),
('v2-i005', 'v2-c00', 'v2', '{"en": "Fresh Strawberries & Blueberries", "hy": "Թարմ ելակ և հապալաս սերուցքով", "ru": "Свежая клубника и голубика"}', '{"en": "With cream", "hy": "սերուցքով", "ru": "Со сливками"}', 1500, ARRAY[]::varchar[], 4),
('v2-i006', 'v2-c00', 'v2', '{"en": "Strawberry Bowl", "hy": "Ելակի բոուլ", "ru": "Клубничный боул"}', NULL, 1900, ARRAY[]::varchar[], 5),
('v2-i007', 'v2-c00', 'v2', '{"en": "Cottage Cheese Blini", "hy": "Կաթնաշոռային նրբաբլիթներ", "ru": "Блинчики с творогом"}', '{"en": "Berry jam", "hy": "հատապտղային ջեմ", "ru": "Ягодный джем"}', 2200, ARRAY[]::varchar[], 6),
('v2-i008', 'v2-c00', 'v2', '{"en": "Classic Syrniks", "hy": "Կաթնաշոռով սիռնիկներ", "ru": "Классические сырники"}', '{"en": "Berry jam and Chantilly cream", "hy": "հատապտղային ջեմ և Շանթիլի կրեմ", "ru": "Ягодный джем и крем Шантильи"}', 2500, ARRAY[]::varchar[], 7),
('v2-i009', 'v2-c00', 'v2', '{"en": "Belgian Waffle", "hy": "Բելգիական վաֆլի", "ru": "Бельгийские вафли"}', '{"en": "Berry puree, Chantilly cream", "hy": "հատապտղային խյուս, շանթիլի կրեմ", "ru": "Ягодное пюре, крем Шантильи"}', 2700, ARRAY[]::varchar[], 8),
('v2-i010', 'v2-c00', 'v2', '{"en": "Chocolate Crepe", "hy": "Շոկոլադով կրեպ", "ru": "Блинчик с шоколадом"}', NULL, 2100, ARRAY[]::varchar[], 9),
('v2-i011', 'v2-c00', 'v2', '{"en": "Mandarin Crepe", "hy": "Մանդարինով կրեպ", "ru": "Блинчик с мандарином"}', NULL, 1700, ARRAY[]::varchar[], 10),
('v2-i012', 'v2-c00', 'v2', '{"en": "Guacamole Toast", "hy": "Գուակամոլե տոստ", "ru": "Тост с гуакамоле"}', NULL, 2700, ARRAY[]::varchar[], 11),
('v2-i013', 'v2-c00', 'v2', '{"en": "Avocado Toast", "hy": "Ավոկադո տոստ", "ru": "Тост с авокадо"}', '{"en": "Poached egg", "hy": "ձու Պաշոտ", "ru": "Яйцо пашот"}', 2700, ARRAY[]::varchar[], 12),
('v2-i014', 'v2-c00', 'v2', '{"en": "Italian Scrambled Eggs", "hy": "Հարած ձու Իտալական ձևով", "ru": "Скрамбл по-итальянски"}', '{"en": "Toast, bell pepper", "hy": "տոստ, բուլղարական պղպեղ", "ru": "Тост, болгарский перец"}', 2900, ARRAY[]::varchar[], 13),
('v2-i015', 'v2-c00', 'v2', '{"en": "French Toast Waffles", "hy": "Ֆրանսիական վաֆլ տոստ", "ru": "Французские вафли-тосты"}', '{"en": "Strawberries, almond flakes", "hy": "ելակ, նուշի փաթիլներ", "ru": "Клубника, лепестки миндаля"}', 3500, ARRAY[]::varchar[], 14),
('v2-i016', 'v2-c00', 'v2', '{"en": "Belgian Waffle Eggs Benedict", "hy": "Բելգիական վաֆլի, ձու Պաշոտ", "ru": "Бельгийские вафли Бенедикт"}', '{"en": "Hollandaise sauce", "hy": "Հոլանդեզ սոուսով", "ru": "Голландский соус"}', 3700, ARRAY[]::varchar[], 15),
('v2-i017', 'v2-c00', 'v2', '{"en": "Syrnik Bowl", "hy": "Կաթնաշոռով սիռնիկների բոլլ", "ru": "Сырник боул"}', '{"en": "Almond petals, berries", "hy": "նուշի թերթիկներ, հատապտուղներ", "ru": "Миндальные лепестки, ягоды"}', 3500, ARRAY[]::varchar[], 16),
('v2-i018', 'v2-c00', 'v2', '{"en": "Proper English Breakfast", "hy": "Անգլիական Վաֆլ Նախաճաշ", "ru": "Английский завтрак"}', NULL, 4900, ARRAY[]::varchar[], 17),
('v2-i019', 'v2-c00', 'v2', '{"en": "Salmon Eggs Benedict", "hy": "Ձու Պաշոտ սաղմոնով", "ru": "Яйца пашот с лососем"}', '{"en": "Guacamole toast", "hy": "Գուակամոլե տոստ", "ru": "Тост с гуакамоле"}', 4900, ARRAY[]::varchar[], 18),
('v2-i020', 'v2-c00', 'v2', '{"en": "Salmon Croissant", "hy": "Կրուասան սաղմոնով", "ru": "Круассан с лососем"}', '{"en": "Cream cheese, cucumber, mixed salad", "hy": "կրեմ պանիր, վարունգ, միքս աղցան", "ru": "Сливочный сыр, огурец, микс салат"}', 3600, ARRAY[]::varchar[], 19),
('v2-i021', 'v2-c00', 'v2', '{"en": "Oatmeal with Berries", "hy": "Գերկուլես հատապտղային", "ru": "Овсянка с ягодами"}', NULL, 2500, ARRAY[]::varchar[], 20),
('v2-i022', 'v2-c00', 'v2', '{"en": "Fried Eggs", "hy": "Ձվածեղ 2 ձվով", "ru": "Яичница из 2 яиц"}', NULL, 2200, ARRAY[]::varchar[], 21),
('v2-i023', 'v2-c00', 'v2', '{"en": "Omelette Simple", "hy": "Ձվածեղ հարած ձվով", "ru": "Омлет"}', NULL, 2200, ARRAY[]::varchar[], 22),
('v2-i024', 'v2-c00', 'v2', '{"en": "Classic Waffle", "hy": "Կլասսիկ վաֆլի", "ru": "Классическая вафля"}', NULL, 1200, ARRAY[]::varchar[], 23);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c01', 'v2', '{"en": "Appetizers", "hy": "ԱՆՏԻՊԱՍՏԻ & ՆԱԽՈՒՏԵՍՏՆԵՐ", "ru": "Закуски"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i025', 'v2-c01', 'v2', '{"en": "Bruschetta con Prosciutto Crudo", "hy": "Բրուսկետա կոն Պրոշուտո Կրուդո", "ru": "Брускетта с Прошутто Крудо"}', '{"en": "Rucola, cream cheese", "hy": "ռուկոլա, կրեմ պանիր", "ru": "Руккола, сливочный сыр"}', 1700, ARRAY[]::varchar[], 0),
('v2-i026', 'v2-c01', 'v2', '{"en": "Bruschetta al Pomodoro", "hy": "Բրուսկետա ալ Պոմոդորո", "ru": "Брускетта с томатами"}', '{"en": "Basil, parmesan, balsamic sauce", "hy": "բազիլ, պարմեզան, Բալզամիկ սոուս", "ru": "Базилик, пармезан, бальзамический соус"}', 1300, ARRAY[]::varchar[], 1),
('v2-i027', 'v2-c01', 'v2', '{"en": "Bruschetta con Coppa", "hy": "Բրուսկետա կոն Կոպպա", "ru": "Брускетта с коппой"}', '{"en": "Rucola, cream cheese, fig jam", "hy": "ռուկոլա, կրեմ պանիր, թզի ջեմ", "ru": "Руккола, сливочный сыр, джем из инжира"}', 1500, ARRAY[]::varchar[], 2),
('v2-i028', 'v2-c01', 'v2', '{"en": "Italian Appetizer", "hy": "Իտալական նախուտեստ", "ru": "Итальянская закуска"}', '{"en": "Sun-dried tomatoes, olives, artichoke, chips", "hy": "լոլիկի չիր, ձիթապտուղ, արտիշոկ, չիպս", "ru": "Вяленые томаты, оливки, артишок, чипсы"}', 2500, ARRAY[]::varchar[], 3),
('v2-i029', 'v2-c01', 'v2', '{"en": "Seasonal Bruschetta Set", "hy": "Սեզոնային բրուսկետա սեթ", "ru": "Сет сезонных брускетт"}', NULL, 3700, ARRAY[]::varchar[], 4),
('v2-i030', 'v2-c01', 'v2', '{"en": "Italian Premium Cold Cuts & Cheeses", "hy": "Իտալական պրեմիում մսի և պանրի տեսականի", "ru": "Мясное и сырное ассорти"}', NULL, 7900, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c02', 'v2', '{"en": "Salads", "hy": "ԱՂՑԱՆՆԵՐ", "ru": "Салаты"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i031', 'v2-c02', 'v2', '{"en": "Beetroot Salad", "hy": "Բազուկով աղցան", "ru": "Салат из свеклы"}', '{"en": "Feta mousse, honey-mustard dressing", "hy": "ֆետա մուս, մեղր-մանանեխ սոուս", "ru": "Мусс из феты, медово-горчичный соус"}', 2200, ARRAY[]::varchar[], 0),
('v2-i032', 'v2-c02', 'v2', '{"en": "Green Salad with Shrimp", "hy": "Կանաչ աղցան ծովախեցգետնով", "ru": "Зеленый салат с креветками"}', '{"en": "Avocado, cucumber, citronette", "hy": "ավոկադո, վարունգ, ցիտրոնետե սոուս", "ru": "Авокадо, огурец, соус цитронет"}', 4700, ARRAY[]::varchar[], 1),
('v2-i033', 'v2-c02', 'v2', '{"en": "The Greek Salad", "hy": "Հունական թարմ վեջջի աղցան", "ru": "Греческий салат"}', '{"en": "Fresh veggies, spiced feta cubes", "hy": "համեմված ֆետա պանրով", "ru": "Свежие овощи, пряная фета"}', 2800, ARRAY[]::varchar[], 2),
('v2-i034', 'v2-c02', 'v2', '{"en": "Carpaccio Veneziano", "hy": "Վենետիկյան Կարպաչիո", "ru": "Венецианское карпаччо"}', '{"en": "Turmeric mayo, mix salad", "hy": "քրքումով մայոնեզ, միքս աղցան", "ru": "Майонез с куркумой, микс салат"}', 2900, ARRAY[]::varchar[], 3),
('v2-i035', 'v2-c02', 'v2', '{"en": "Il Cesare Salad", "hy": "Կեսար աղցան Դիփ Ֆրայ հավով", "ru": "Салат Цезарь"}', '{"en": "Deep fried chicken, grape slices", "hy": "խաղողի սլայս", "ru": "Курица фри, ломтики винограда"}', 2900, ARRAY[]::varchar[], 4),
('v2-i036', 'v2-c02', 'v2', '{"en": "Zucchini Salad", "hy": "Դդմիկով աղցան", "ru": "Салат с цукини"}', '{"en": "Almonds, walnuts, parmesan, sun-dried tomatoes", "hy": "նուշ, ընկույզ, պարմեզան, լոլիկի չիր", "ru": "Миндаль, грецкий орех, пармезан, вяленые томаты"}', 2900, ARRAY[]::varchar[], 5),
('v2-i037', 'v2-c02', 'v2', '{"en": "Grilled Avocado Salad", "hy": "Գրիլ ավոկադո", "ru": "Салат с авокадо гриль"}', '{"en": "Tomato, bell pepper, quinoa", "hy": "լոլիկ, բուլղարական պղպեղ, քինուա", "ru": "Помидоры, болгарский перец, киноа"}', 3400, ARRAY[]::varchar[], 6),
('v2-i038', 'v2-c02', 'v2', '{"en": "Panzanella Toscana", "hy": "Տոսկանական Պանցանելա", "ru": "Тосканская Панцанелла"}', '{"en": "Focaccia bites, cherry tomatoes", "hy": "ֆոկաչայի կտորներ, չերի լոլիկ", "ru": "Кусочки фокаччи, помидоры черри"}', 3500, ARRAY[]::varchar[], 7),
('v2-i039', 'v2-c02', 'v2', '{"en": "Whole Stuffed Avocado", "hy": "Լցոնած ավոկադո", "ru": "Фаршированное авокадо"}', '{"en": "With shrimps", "hy": "ծովախեցգետնով", "ru": "С креветками"}', 3900, ARRAY[]::varchar[], 8),
('v2-i040', 'v2-c02', 'v2', '{"en": "Insalata di Mare", "hy": "Ինսալատա Դի Մարե", "ru": "Салат из морепродуктов"}', NULL, 3800, ARRAY[]::varchar[], 9),
('v2-i041', 'v2-c02', 'v2', '{"en": "Grilled Teriyaki Caesar", "hy": "Տերիյակի գրիլ Կեսար աղցան", "ru": "Цезарь гриль Терияки"}', '{"en": "Grapes and orange", "hy": "խաղող և նարինջ", "ru": "Виноград и апельсин"}', 3800, ARRAY[]::varchar[], 10),
('v2-i042', 'v2-c02', 'v2', '{"en": "Roast Beef Salad", "hy": "Ռոստբիֆ աղցան", "ru": "Салат с ростбифом"}', '{"en": "Artichoke, mix salad, cherry tomatoes", "hy": "արտիշոկ, միքս աղցան, չերի լոլիկ", "ru": "Артишок, микс салат, помидоры черри"}', 4700, ARRAY[]::varchar[], 11),
('v2-i043', 'v2-c02', 'v2', '{"en": "La Nicoise", "hy": "Լա Նիսուազ", "ru": "Нисуаз"}', '{"en": "Tuna, vegetables, potatoes", "hy": "աղցան թունայով, բանջարեղեն, կարտոֆիլ", "ru": "Тунец, овощи, картофель"}', 4500, ARRAY[]::varchar[], 12),
('v2-i044', 'v2-c02', 'v2', '{"en": "Caprese Classico", "hy": "Կլասիկ Կապրեզե", "ru": "Капрезе классический"}', '{"en": "Mozzarella, cherry tomatoes, pesto, rucola", "hy": "մոցարելա, չերի լոլիկ, պեստո բազիլ և ռուկոլա", "ru": "Моцарелла, черри, песто, руккола"}', 4700, ARRAY[]::varchar[], 13);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c03', 'v2', '{"en": "Crudo", "hy": "ԿՐՈՒԴՈ", "ru": "Крудо"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i045', 'v2-c03', 'v2', '{"en": "Carpaccio di Manzo", "hy": "Կարպաչիո դի Մանզո", "ru": "Карпаччо из говядины"}', '{"en": "Citronette sauce, rucola, parmesan", "hy": "Ցիտրոնետ սոուս, ռուկոլա, պարմեզան", "ru": "Соус цитронет, руккола, пармезан"}', 2800, ARRAY[]::varchar[], 0),
('v2-i046', 'v2-c03', 'v2', '{"en": "Vitello Tonnato", "hy": "Վիտելո տոնատո", "ru": "Вителло тоннато"}', '{"en": "Mix salad", "hy": "միքս աղցան", "ru": "Микс салат"}', 3700, ARRAY[]::varchar[], 1),
('v2-i047', 'v2-c03', 'v2', '{"en": "Salmon Crudo", "hy": "Սաղմոնի կրուդո", "ru": "Крудо из лосося"}', '{"en": "Aglio-Olio, Citronette sauce, capers", "hy": "Ալիո-Օլիո, Ցիտրոնետ սոուս, կապերս", "ru": "Альо-ольо, соус цитронет, каперсы"}', 3900, ARRAY[]::varchar[], 2),
('v2-i048', 'v2-c03', 'v2', '{"en": "Prime Beef Tartare", "hy": "Թարթար պրեմիում տավարի մսով", "ru": "Тартар из говядины"}', '{"en": "Truffle cream cheese, mustard seeds", "hy": "տրյուֆելի կրեմ պանիր, մանանեխի սերմեր", "ru": "Трюфельный сливочный сыр, семена горчицы"}', 4900, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c04', 'v2', '{"en": "Main Dishes", "hy": "ՀԻՄՆԱԿԱՆ ՈՒՏԵՍՏՆԵՐ", "ru": "Основные блюда"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i049', 'v2-c04', 'v2', '{"en": "Chicken Scaloppine", "hy": "Հավի սկալոպինե", "ru": "Куриное скалоппине"}', '{"en": "Potato puree, spinach puree", "hy": "կարտոֆիլի խյուս, սպանախի խյուս", "ru": "Картофельное пюре, пюре из шпината"}', 3800, ARRAY[]::varchar[], 0),
('v2-i050', 'v2-c04', 'v2', '{"en": "Stuffed Eggplant", "hy": "Լցոնած սմբուկ տապակած բանջարեղենով", "ru": "Фаршированный баклажан"}', '{"en": "Roasted vegetables, Neapolitan sauce", "hy": "նեապոլիտանա սոուս", "ru": "Жареные овощи, неаполитанский соус"}', 3900, ARRAY[]::varchar[], 1),
('v2-i051', 'v2-c04', 'v2', '{"en": "Chicken Parmigiano", "hy": "Ֆրենկս Չիքն Պարմեջիանո", "ru": "Чикен Пармиджано"}', '{"en": "Panko chicken breast, mozzarella", "hy": "հավի կրծքամսի պանկո, մոցարելա", "ru": "Куриная грудка в панко, моцарелла"}', 5500, ARRAY[]::varchar[], 2),
('v2-i052', 'v2-c04', 'v2', '{"en": "French L''Entrecote", "hy": "Ֆրանսիական Անտրեկոտ", "ru": "Французский антрекот"}', '{"en": "Premium Angus flank", "hy": "պրեմիում անգուսի ֆլենք", "ru": "Фланк ангус премиум"}', 7900, ARRAY[]::varchar[], 3),
('v2-i053', 'v2-c04', 'v2', '{"en": "Tommy Two Steaks Medallions", "hy": "Թոմմի սթեյք մեդալիոններ", "ru": "Медальоны Томми"}', NULL, 8900, ARRAY[]::varchar[], 4),
('v2-i054', 'v2-c04', 'v2', '{"en": "Trout Acqua Pazza", "hy": "Իշխանի Աքուա Պացցա", "ru": "Форель Аква Пацца"}', '{"en": "Black pepper sauce", "hy": "Բլեք փեփը սոուսով", "ru": "Соус черный перец"}', 7900, ARRAY[]::varchar[], 5),
('v2-i055', 'v2-c04', 'v2', '{"en": "The Big Salmon", "hy": "Թարմ սաղմոն", "ru": "Большой лосось"}', '{"en": "Spinach risotto, lemon zest", "hy": "սպանախով ռիզոտտո, կիտրոնի ցեդրա", "ru": "Ризотто со шпинатом, лимонная цедра"}', 8900, ARRAY[]::varchar[], 6),
('v2-i056', 'v2-c04', 'v2', '{"en": "Chicken Breast with Potatoes", "hy": "Հավի կրծքամիս, կարտոֆիլ", "ru": "Куриная грудка с картофелем"}', '{"en": "Dijon, mayo, onion, pepperoncino, lemon", "hy": "դիժոն, մայոնեզ, սոխ, պեպերոնչինո, լիմոն", "ru": "Дижон, майонез, лук, пеперончино, лимон"}', 3800, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c05', 'v2', '{"en": "Pasta & Risotto", "hy": "ԹԱՐՄ ՊԱՍՏԱ", "ru": "Паста и ризотто"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i057', 'v2-c05', 'v2', '{"en": "Linguine Quattro Formaggi", "hy": "Լինգվինի Չորս պանրով", "ru": "Лингвини Четыре сыра"}', '{"en": "Lemon zest", "hy": "կիտրոնի ցեդրա", "ru": "Лимонная цедра"}', 3300, ARRAY[]::varchar[], 0),
('v2-i058', 'v2-c05', 'v2', '{"en": "Spaghetti Truffle", "hy": "Սպագետտի, Տրյուֆելի կրեմ սոուս", "ru": "Спагетти с трюфелем"}', '{"en": "Cashews", "hy": "հնդկական ընկույզ", "ru": "Кешью"}', 3500, ARRAY[]::varchar[], 1),
('v2-i059', 'v2-c05', 'v2', '{"en": "Spaghetti Carbonara", "hy": "Սպագետտի Կարբոնորա", "ru": "Спагетти Карбонара"}', '{"en": "Classic or creamy", "hy": "դասական կամ սերուցքային", "ru": "Классическая или сливочная"}', 3500, ARRAY[]::varchar[], 2),
('v2-i060', 'v2-c05', 'v2', '{"en": "Spaghetti San Marzano", "hy": "Սպագետտի Սան Մարզանո", "ru": "Спагетти Сан Марцано"}', '{"en": "Pomodoro sauce, stracciatella", "hy": "Պոմոդորո սոուսով, ստրաչատելլա", "ru": "Соус помодоро, страчателла"}', 3600, ARRAY[]::varchar[], 3),
('v2-i061', 'v2-c05', 'v2', '{"en": "Casarecce Al Pollo", "hy": "Կասարեչե հավով Ալ Պոլլո", "ru": "Казаречче с курицей"}', '{"en": "Champignons, parmesan, pistachios", "hy": "շամպինիոն, պարմեզան, պիստակ", "ru": "Шампиньоны, пармезан, фисташки"}', 3800, ARRAY[]::varchar[], 4),
('v2-i062', 'v2-c05', 'v2', '{"en": "Seafood Spaghetti", "hy": "Սպագետտի ծովամթերքով", "ru": "Спагетти с морепродуктами"}', '{"en": "Neapolitan sauce", "hy": "Նապոլիտանա սոուսում", "ru": "Неаполитанский соус"}', 4500, ARRAY[]::varchar[], 5),
('v2-i063', 'v2-c05', 'v2', '{"en": "Shrimp Linguine Alfredo", "hy": "Լինգվինի Ալֆրեդո մանրածովախեցգետնով", "ru": "Лингвини Альфредо с креветками"}', NULL, 4900, ARRAY[]::varchar[], 6),
('v2-i064', 'v2-c05', 'v2', '{"en": "Risotto with Tarragon Pesto", "hy": "Րիզոտտո թարխունի պեստոյով", "ru": "Ризотто с песто из тархуна"}', '{"en": "Parmesan, stracciatella", "hy": "պարմեզան, ստրաչատելլա", "ru": "Пармезан, страчателла"}', 2800, ARRAY[]::varchar[], 7),
('v2-i065', 'v2-c05', 'v2', '{"en": "Signature Lasagna", "hy": "Ֆիրմային Լազանյա", "ru": "Фирменная лазанья"}', '{"en": "Premium beef ragu", "hy": "պրեմիում տավարի մսի ռագու", "ru": "Рагу из говядины премиум"}', 4500, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v2-c06', 'v2', '{"en": "Desserts", "hy": "ԴՈԼՉԻ (ՔԱՂՑՐԱՎԵՆԻՔ)", "ru": "Десерты"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v2-i066', 'v2-c06', 'v2', '{"en": "New York Cheesecake", "hy": "Նյու Յորք Չիզքեյք", "ru": "Чизкейк Нью-Йорк"}', NULL, 1900, ARRAY[]::varchar[], 0),
('v2-i067', 'v2-c06', 'v2', '{"en": "Classic Éclair", "hy": "Էկլեր Դասական", "ru": "Эклер классический"}', '{"en": "Chocolate", "hy": "շոկոլադ", "ru": "Шоколад"}', 1600, ARRAY[]::varchar[], 1),
('v2-i068', 'v2-c06', 'v2', '{"en": "Carrot Cake", "hy": "Քերոթ Քեյք", "ru": "Морковный торт"}', NULL, 2300, ARRAY[]::varchar[], 2),
('v2-i069', 'v2-c06', 'v2', '{"en": "San Sebastian Tart", "hy": "Սան Սեբաստիան Հատապտղային տարտ", "ru": "Сан Себастьян тарт"}', NULL, 2500, ARRAY[]::varchar[], 3),
('v2-i070', 'v2-c06', 'v2', '{"en": "Raspberry Panna Cotta", "hy": "Ազնվամորի Պաննա Կոտտա", "ru": "Малиновая панна-котта"}', NULL, 1900, ARRAY[]::varchar[], 4);

-- ─── Replace menu for Sirelis (v5) ──────────────────────
DELETE FROM menu_items WHERE venue_id = 'v5';
DELETE FROM menu_categories WHERE venue_id = 'v5';

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c00', 'v5', '{"en": "Breakfast", "hy": "Նախաճաշ", "ru": "Завтрак"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i001', 'v5-c00', 'v5', '{"en": "Kefir mini pancakes with sour cream, apricot jam and lemon zest", "hy": "Մինի փափկաբլիթներ կեֆիրով, թթվասերով, ծիրանի ջեմով և կիտրոնի ցեստրայով", "ru": "Мини оладьи на кефире со сметаной, абрикосовым джемом и лимонной цедрой"}', NULL, 1900, ARRAY[]::varchar[], 0),
('v5-i002', 'v5-c00', 'v5', '{"en": "Syrniki with coconut condensed milk, sour cream and seasonal berries", "hy": "Սիրնիկներ կոկոսի խտացրած կաթով, թթվասերով և սեզոնային հատապտուղներով", "ru": "Сырники с кокосовой сгущенкой, сметаной и сезонными ягодами"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v5-i003', 'v5-c00', 'v5', '{"en": "Oatmeal with milk, pistachios and seasonal berries", "hy": "Վարսակի շիլա կաթով, պիստակով և սեզոնային հատապտուղներով", "ru": "Овсяная каша на молоке с фисташками и сезонными ягодами"}', NULL, 2900, ARRAY[]::varchar[], 2),
('v5-i004', 'v5-c00', 'v5', '{"en": "Shakshuka with homemade lecho, baba ghanoush, feta cheese, avocado and pesto sauce", "hy": "Շակշուկա տնական լեչոյով, բաբագանուշով, ֆետա պանրով, ավոկադոյով և պեստո սոուսով", "ru": "Шакшука с домашним лечо, бабагануш, сыром фета, авокадо и соусом песто"}', NULL, 2800, ARRAY[]::varchar[], 3),
('v5-i005', 'v5-c00', 'v5', '{"en": "Seasonal greens with cheese and egg, baked in the oven", "hy": "Սեզոնային կանաչիներ պանրով և ձվով` պատրաստված ջեռոցում", "ru": "Сезонные зелени с сыром и яйцом, запеченные в духовке"}', NULL, 2200, ARRAY[]::varchar[], 4),
('v5-i006', 'v5-c00', 'v5', '{"en": "Scrambled eggs with tarragon and guacamole", "hy": "Հարած ձու թարխունով և գուակամոլեով", "ru": "Яичница с эстрагоном и гуакамоле"}', NULL, 2800, ARRAY[]::varchar[], 5),
('v5-i007', 'v5-c00', 'v5', '{"en": "Omelet with oyster mushrooms", "hy": "Կախասնկով ձվածեղ", "ru": "Яичница с вешенками"}', NULL, 2300, ARRAY[]::varchar[], 6),
('v5-i008', 'v5-c00', 'v5', '{"en": "Omelet with tomatoes", "hy": "Լոլիկով ձվածեղ", "ru": "Яичница с томатом"}', NULL, 2300, ARRAY[]::varchar[], 7),
('v5-i009', 'v5-c00', 'v5', '{"en": "Potato draniki with guacamole, sour cream, poached eggs, cherry tomatoes and bacon", "hy": "Կարտոֆիլի դրանիկներ գուակամոլեով, թթվասերով, պաշոտ ձվով, չերի լոլիկով և բեկոնով", "ru": "Картофельные драники с гуакамоле, сметаной, яйцом пашот, помидорами черри и беконом"}', NULL, 2900, ARRAY[]::varchar[], 8),
('v5-i010', 'v5-c00', 'v5', '{"en": "Potato draniki with ''soviet mortadella'', guacamole, cherry tomatoes, pistachios and sour cream", "hy": "Կարտոֆիլի դրանիկներ «սովետական մորտադելլայով», գուակամոլեով, չերի լոլիկով, պիստակով և թթվասերով", "ru": "Картофельные драники с «советской мортаделлой», гуакамоле, помидорами черри, фисташками и сметаной"}', NULL, 2500, ARRAY[]::varchar[], 9),
('v5-i011', 'v5-c00', 'v5', '{"en": "Armenian Breakfast Set", "hy": "Հայկական Նախաճաշի Սեթ", "ru": "Сет «Завтрак по - Армянски»"}', '{"en": "Soft boiled eggs, fresh greens, cheese, lavash, tomato, cucumber, honey and apricot jam", "hy": "Խաշած ձու, թարմ կանաչի, պանիր, լավաշ, լոլիկ, վարունգ, մեղր և ծիրանի ջեմ", "ru": "Яйца всмятку, свежая зелень, сыр, лаваш, помидоры, огурцы, мед и абрикосовый джем"}', 4900, ARRAY[]::varchar[], 10);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c01', 'v5', '{"en": "Traditional Appetizers", "hy": "Դասական նախուտեստ", "ru": "Классические Закуски"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i012', 'v5-c01', 'v5', '{"en": "Bread basket", "hy": "Հացի զամբյուղ", "ru": "Хлебная корзина"}', NULL, 900, ARRAY[]::varchar[], 0),
('v5-i013', 'v5-c01', 'v5', '{"en": "Local cheese platter", "hy": "Պանրի տեսականի", "ru": "Сырное ассорти"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v5-i014', 'v5-c01', 'v5', '{"en": "Local meat platter", "hy": "Մսի տեսականի", "ru": "Мясное ассорти"}', NULL, 6300, ARRAY[]::varchar[], 2),
('v5-i015', 'v5-c01', 'v5', '{"en": "Bunch of greens", "hy": "Կանաչիների փունջ", "ru": "Букет зелени"}', NULL, 2600, ARRAY[]::varchar[], 3),
('v5-i016', 'v5-c01', 'v5', '{"en": "Rezhan", "hy": "Արաժան", "ru": "Аражан"}', NULL, 1600, ARRAY[]::varchar[], 4),
('v5-i017', 'v5-c01', 'v5', '{"en": "Strained matsoni", "hy": "Քամած մածուն", "ru": "Сцеженный мацони"}', NULL, 1200, ARRAY[]::varchar[], 5),
('v5-i018', 'v5-c01', 'v5', '{"en": "Eggplant caviar", "hy": "Սմբուկի խավիար", "ru": "Икра баклажанная"}', NULL, 1400, ARRAY[]::varchar[], 6),
('v5-i019', 'v5-c01', 'v5', '{"en": "Assorted olives", "hy": "Ձիթապտղի տեսականի", "ru": "Ассорти из оливок"}', NULL, 1900, ARRAY[]::varchar[], 7),
('v5-i020', 'v5-c01', 'v5', '{"en": "Assorted pickles", "hy": "Թթվի տեսականի", "ru": "Ассорти солений"}', NULL, 2300, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c02', 'v5', '{"en": "Cold Appetizers", "hy": "Սառը նախուտեստ", "ru": "Холодные Закуски"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i021', 'v5-c02', 'v5', '{"en": "Bell pepper BBQ with bryndza cheese and pesto sauce", "hy": "Խորոված կարմիր պղպեղ բրինձա պանրով և պեստո սոուսով", "ru": "Болгарский перец на мангале с брынзой и соусом песто"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v5-i022', 'v5-c02', 'v5', '{"en": "Roll set - stuffed eggplant, zucchini, red pepper", "hy": "Ռոլլ սեթ - լցոնած սմբուկ, դդմիկ, կարմիր պղպեղ", "ru": "Ролл сет - фаршированный баклажан, кабачок, красный перец"}', NULL, 3200, ARRAY[]::varchar[], 1),
('v5-i023', 'v5-c02', 'v5', '{"en": "Classic hummus with cherry tomatoes, tarragon, basil and olive oil", "hy": "Դասական հումուս չերի լոլիկով, թարխունով, ռեհանով և ձիթապտղի ձեթով", "ru": "Классический хумус с томатами черри, эстрагоном, базиликом и оливковым маслом"}', NULL, 2400, ARRAY[]::varchar[], 2),
('v5-i024', 'v5-c02', 'v5', '{"en": "Basil hummus, Greek yoghurt and apricot jam, served with cereal chips", "hy": "Բազիլիկ հումուս, հունական յոգուրտ և ծիրանի ջեմ, հացահատիկային չիպս", "ru": "Базиликовый хумус, греческий йогурт и абрикосовый джем, чипсы из злаков"}', NULL, 2500, ARRAY[]::varchar[], 3),
('v5-i025', 'v5-c02', 'v5', '{"en": "Tabbouleh", "hy": "Թաբուլե", "ru": "Табуле"}', NULL, 1900, ARRAY[]::varchar[], 4),
('v5-i026', 'v5-c02', 'v5', '{"en": "Beetroot hummus, falafel, Greek yoghurt, tahini sauce and lightly salted cucumbers", "hy": "Բազուկով հումուս, ֆալաֆել, հունական յոգուրտ, թահինի սոուս և թույլ աղ դրած վարունգ", "ru": "Свекольный хумус, фалафель, греческий йогурт, соус тахини и малосольными огурцы"}', NULL, 2500, ARRAY[]::varchar[], 5),
('v5-i027', 'v5-c02', 'v5', '{"en": "Fish set", "hy": "Ձկան սեթ", "ru": "Рыбный сет"}', '{"en": "Marinated whitefish, lightly salted trout, salmon, butterfish", "hy": "Մարինացված սիգ, աղ դրած իշխան, ծխեցված սաղմոն, յուղաձուկ", "ru": "Маринованный сиг, форель малосольная, копченый лосось, масляная рыба"}', 4900, ARRAY[]::varchar[], 6);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c03', 'v5', '{"en": "Hot Appetizers", "hy": "Տաք նախուտեստ", "ru": "Горячие Закуски"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i028', 'v5-c03', 'v5', '{"en": "Spicy lobio - Georgian beans", "hy": "Կծու լոբիո", "ru": "Острое лобио - фасоль по-грузински"}', NULL, 1900, ARRAY[]::varchar[], 0),
('v5-i029', 'v5-c03', 'v5', '{"en": "Grilled eggplant and zucchini with Georgian sauce", "hy": "Գրիլ սմբուկ և դդմիկ վրացական սոուսով", "ru": "Баклажан и кабачок на гриле с грузинским соусом"}', NULL, 2600, ARRAY[]::varchar[], 1),
('v5-i030', 'v5-c03', 'v5', '{"en": "Fresh Baba Ghanoush", "hy": "Թարմ Բաբագանուշ", "ru": "Свежий Бабагануш"}', '{"en": "Preparing in your presence", "hy": "Պատրաստվում է Ձեր ներկայությամբ", "ru": "Готовится в Вашем присутствии"}', 3200, ARRAY[]::varchar[], 2),
('v5-i031', 'v5-c03', 'v5', '{"en": "Arishta tarragon, matsoni mix", "hy": "Արիշտա թարխունով, մածուն միքս", "ru": "Аришта эстрагон, мацони"}', NULL, 2700, ARRAY[]::varchar[], 3),
('v5-i032', 'v5-c03', 'v5', '{"en": "Garni yarakh - eggplant stuffed with minced meat and tomato", "hy": "Գառնի յարախ", "ru": "Гарни ярах - баклажан, мясной фарш и томат"}', NULL, 2500, ARRAY[]::varchar[], 4),
('v5-i033', 'v5-c03', 'v5', '{"en": "Classic pancakes with meat", "hy": "Դասական նրբաբլիթներ մսով", "ru": "Классические блинчики с мясом"}', NULL, 1900, ARRAY[]::varchar[], 5),
('v5-i034', 'v5-c03', 'v5', '{"en": "Omelet with oyster mushrooms", "hy": "Կախասնկով ձվածեղ", "ru": "Яичница с вешенками"}', NULL, 2300, ARRAY[]::varchar[], 6),
('v5-i035', 'v5-c03', 'v5', '{"en": "Omelet with tomatoes", "hy": "Լոլիկով ձվածեղ", "ru": "Яичница с томатом"}', NULL, 2300, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c04', 'v5', '{"en": "Salads", "hy": "Աղցան", "ru": "Салаты"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i036', 'v5-c04', 'v5', '{"en": "Vegetable summer salad", "hy": "Ամառային աղցան", "ru": "Овощной летний салат"}', NULL, 2800, ARRAY[]::varchar[], 0),
('v5-i037', 'v5-c04', 'v5', '{"en": "Summer salad with nuts and chechil cheese", "hy": "Ամառային աղցան ընկույզով և չեչիլ պանրով", "ru": "Летний салат с грецкими орехами и сыром чечил"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v5-i038', 'v5-c04', 'v5', '{"en": "Soviet salad set - Stolichniy, Gandzak, Beetroot salad", "hy": "Սովետական սեթ - մայրաքաղաքային, գանձակ, բազուկով աղցան", "ru": "Советский сет - столичный, гандзак, свекольный салат"}', NULL, 3900, ARRAY[]::varchar[], 2),
('v5-i039', 'v5-c04', 'v5', '{"en": "Shrimp stuffed avocado Olivier salad in spicy sauce", "hy": "Լցոնած ավոկադո օլիվիե ծովախեցգետնով կծու սոուսում", "ru": "Оливье с авокадо, креветками и острым соусом"}', NULL, 3900, ARRAY[]::varchar[], 3),
('v5-i040', 'v5-c04', 'v5', '{"en": "Caesar salad with chechil cheese", "hy": "Կեսար աղցան չեչիլ պանրով", "ru": "Салат Цезарь с сыром чечил"}', NULL, 3900, ARRAY[]::varchar[], 4),
('v5-i041', 'v5-c04', 'v5', '{"en": "Beetroot salad, broccoli, mixed greens, suluguni stracciatella", "hy": "Բազուկով աղցան, բրոկոլի, միքս կանաչի, սուլուգունի ստրատչատելլա", "ru": "Салат из свеклы, брокколи, микс зелени, сулугуни страчателла"}', NULL, 2900, ARRAY[]::varchar[], 5),
('v5-i042', 'v5-c04', 'v5', '{"en": "BBQ pepper and zucchini, tomato, greens, red onion, bryndza cheese, tarragon pesto", "hy": "Խորոված պղպեղ և դդմիկ - լոլիկ, կանաչիներ, կարմիր սոխ, պանիր բրինձա, թարխունի պեստո", "ru": "Перец и кабачок на мангале - томат, зелень, красный лук, сыр брынза, песто из эстрагона"}', NULL, 2500, ARRAY[]::varchar[], 6),
('v5-i043', 'v5-c04', 'v5', '{"en": "Salad with kumquat and crunchy nuts, stracciatella, beetroot, mixed greens, sweet and sour sauce", "hy": "Կումկվատով և խրթխրթան ընկույզով աղցան, ստրատչատելլա, բազուկ, միքս կանաչի, թթվաքաղցր սոուս", "ru": "Салат с кумкватом и хрустящими орехами, страчателла, свекла, микс зелени, кисло-сладкий соус"}', NULL, 2200, ARRAY[]::varchar[], 7),
('v5-i044', 'v5-c04', 'v5', '{"en": "Stuffed avocado with tabbouleh, yogurt with mint", "hy": "Լցոնած ավոկադո թաբուլեով, նանայով յոգուրտ", "ru": "Авокадо, фаршированное табуле, йогурт с мятой"}', NULL, 2700, ARRAY[]::varchar[], 8),
('v5-i045', 'v5-c04', 'v5', '{"en": "Tarragon stracciatella, peaches, prosciutto", "hy": "Թարխուն ստրատչատելլա աղցան, սուլուգունի ստրատչատելլա, դեղձ, պրոշուտտո", "ru": "Эстрагон страчателла, персики, прошутто"}', NULL, 2900, ARRAY[]::varchar[], 9),
('v5-i046', 'v5-c04', 'v5', '{"en": "Tarragon salad, cherry tomatoes, bryndza cheese, grapes, mixed greens, onion", "hy": "Թարխունով աղցան, չերի լոլիկ, պանիր բրինձա, խաղող, միքս կանաչի, սոխ", "ru": "Салат из эстрагона, томаты черри, сыр брынза, виноград, зелень микс, лук"}', NULL, 2900, ARRAY[]::varchar[], 10),
('v5-i047', 'v5-c04', 'v5', '{"en": "Salad with eggplant and suluguni, in cheese sauce with pepper, mushrooms, pistachios", "hy": "Սմբուկով աղցան սուլուգունիով, պղպեղով պանրային սոուսում, սունկ, պիստակ", "ru": "Салат с баклажаном и сулугуни, в сырном соусе с перцем, грибы, фисташки"}', NULL, 3300, ARRAY[]::varchar[], 11),
('v5-i048', 'v5-c04', 'v5', '{"en": "Roastbeef salad in mustard sauce, grated cucumber and potato", "hy": "Ռոստբիֆ աղցան մանանեխի սոուսում, քերած վարունգ և կարտոֆիլ", "ru": "Салат Ростбиф в горчичном соусе, тертый огурец и картофель"}', NULL, 3800, ARRAY[]::varchar[], 12),
('v5-i049', 'v5-c04', 'v5', '{"en": "Caesar kebab salad, guacamole, iceberg, cherry tomato", "hy": "Կեսար քեբաբ աղցան, գուակամոլե, այսբերգ, չերի լոլիկ", "ru": "Салат Цезарь кебаб, гуакамоле, айсберг, черри помидоры"}', NULL, 3900, ARRAY[]::varchar[], 13),
('v5-i050', 'v5-c04', 'v5', '{"en": "Chicken salad, pai potato, red cabbage, greens, mustard sauce", "hy": "Հավով աղցան, կարտոֆիլ պայ, կարմիր կաղամբ, կանաչիներ, մանանեխային սոուս", "ru": "Салат из курицы, картофель пай, краснокочанная капуста, зелень, горчичный соус"}', NULL, 2200, ARRAY[]::varchar[], 14),
('v5-i051', 'v5-c04', 'v5', '{"en": "Marinated whitefish under a ''Coat''", "hy": "Մարինացված սիգ «Շուբ»-ի տակ", "ru": "Маринованная сиг \"под Шубой\""}', NULL, 2600, ARRAY[]::varchar[], 15),
('v5-i052', 'v5-c04', 'v5', '{"en": "Salad with sig, cucumber, tomato, onion, black bread, and lime", "hy": "Աղցան սիգով, վարունգ, լոլիկ, սոխ, սև հաց, լայմ", "ru": "Салат с сигой, огурцом, помидором, луком, черным хлебом и лаймом"}', NULL, 3900, ARRAY[]::varchar[], 16);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c05', 'v5', '{"en": "Pelmeni & Vareniki", "hy": "Պելմենի և Վարենիկ", "ru": "Пельмени и Вареники"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i053', 'v5-c05', 'v5', '{"en": "Angus pelmeni", "hy": "Անգուս պելմենի", "ru": "Ангус пельмени"}', NULL, 2300, ARRAY[]::varchar[], 0),
('v5-i054', 'v5-c05', 'v5', '{"en": "Vareniki with cherry", "hy": "Բալով վարենիկ", "ru": "Вареники с вишней"}', NULL, 2500, ARRAY[]::varchar[], 1),
('v5-i055', 'v5-c05', 'v5', '{"en": "Vareniki with potatoes and mushrooms", "hy": "Կարտոֆիլով և սնկով վարենիկ", "ru": "Вареники с картофелем и грибами"}', NULL, 2100, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c06', 'v5', '{"en": "Soups", "hy": "Ապուր", "ru": "Супы"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i056', 'v5-c06', 'v5', '{"en": "Borsch", "hy": "Բորշ", "ru": "Борщ"}', NULL, 2400, ARRAY[]::varchar[], 0),
('v5-i057', 'v5-c06', 'v5', '{"en": "Solyanka", "hy": "Սոլյանկա", "ru": "Солянка"}', NULL, 2700, ARRAY[]::varchar[], 1),
('v5-i058', 'v5-c06', 'v5', '{"en": "Spas", "hy": "Թանապուր", "ru": "Спас"}', NULL, 1900, ARRAY[]::varchar[], 2),
('v5-i059', 'v5-c06', 'v5', '{"en": "Village chicken soup", "hy": "Տնական հավով ապուր", "ru": "Домашний куриный суп"}', NULL, 2000, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c07', 'v5', '{"en": "Khachapuri & Lahmajun", "hy": "Խաչապուրի և Լահմաջո", "ru": "Хачапури и Лахмаджун"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i060', 'v5-c07', 'v5', '{"en": "Village khachapuri on the fire", "hy": "Գյուղական խաչապուրի կրակի վրա", "ru": "Хачапури по - деревенски на мангале"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v5-i061', 'v5-c07', 'v5', '{"en": "Village khachapuri with bacon on the fire", "hy": "Բեկոնով գյուղական խաչապուրի կրակի վրա", "ru": "Хачапури по - деревенски с беконом на мангале"}', NULL, 3300, ARRAY[]::varchar[], 1),
('v5-i062', 'v5-c07', 'v5', '{"en": "Open khachapuri with four cheese, truffle, pesto sauce, pistachios", "hy": "Բաց խաչապուրի չորս պանրով - տրյուֆել, պեստո սոուս, պիստակ", "ru": "Открытое хачапури Кваттро формаджи, трюфельный соус песто, фисташки"}', NULL, 3600, ARRAY[]::varchar[], 2),
('v5-i063', 'v5-c07', 'v5', '{"en": "Lahmajun \"Pepperoni\" (2 pc)", "hy": "Լահմաջո «Պեպպերոնի» (2 հատ)", "ru": "Лахмаджун \"Пепперони\" (2 шт)"}', NULL, 2700, ARRAY[]::varchar[], 3),
('v5-i064', 'v5-c07', 'v5', '{"en": "Lahmajun \"Margherita\" (2 pc)", "hy": "Լահմաջո «Մարգարիտա» (2 հատ)", "ru": "Лахмаджун \"Маргарита\" (2 шт)"}', NULL, 2200, ARRAY[]::varchar[], 4),
('v5-i065', 'v5-c07', 'v5', '{"en": "Lahmajun \"Four cheese\" (2 pc)", "hy": "Լահմաջո «Չորս պանիր» (2 հատ)", "ru": "Лахмаджун \"Четыре сыра\" (2 шт)"}', NULL, 2400, ARRAY[]::varchar[], 5),
('v5-i066', 'v5-c07', 'v5', '{"en": "Classic Angus lahmajun (3 pc)", "hy": "Դասական Անգուս լահմաջո (3 հատ)", "ru": "Классический Ангус лахмаджун (3 шт)"}', NULL, 3400, ARRAY[]::varchar[], 6),
('v5-i067', 'v5-c07', 'v5', '{"en": "Adjarian khachapuri with three eggs", "hy": "Աճարական խաչապուրի 3 ձվով", "ru": "Хачапури по-аджарски с тремя яйцами"}', NULL, 2900, ARRAY[]::varchar[], 7),
('v5-i068', 'v5-c07', 'v5', '{"en": "Adjarian khachapuri with truffle, 2 eggs", "hy": "Աճարական խաչապուրի տրյուֆելով 2 ձվով", "ru": "Аджарский хачапури с трюфелем, 2 яйца"}', NULL, 3500, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c08', 'v5', '{"en": "Armenian BBQ & Kebab", "hy": "Խորոված և Քեբաբ", "ru": "Шашлыки и Кебабы"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i069', 'v5-c08', 'v5', '{"en": "Pork BBQ", "hy": "Խոզի խորոված", "ru": "Шашлык из свинины"}', NULL, 4700, ARRAY[]::varchar[], 0),
('v5-i070', 'v5-c08', 'v5', '{"en": "Pork BBQ - filet", "hy": "Խոզի խորոված փափուկ", "ru": "Шашлык из свинины - мякоть"}', NULL, 4700, ARRAY[]::varchar[], 1),
('v5-i071', 'v5-c08', 'v5', '{"en": "Pork BBQ - ribs", "hy": "Խոզի խորոված մատ", "ru": "Шашлык из свинины - ребрышки"}', NULL, 4900, ARRAY[]::varchar[], 2),
('v5-i072', 'v5-c08', 'v5', '{"en": "Pork BBQ - loin", "hy": "Խոզի խորոված չալաղաջ", "ru": "Шашлык из свинины - корейка"}', NULL, 4900, ARRAY[]::varchar[], 3),
('v5-i073', 'v5-c08', 'v5', '{"en": "Veal BBQ", "hy": "Հորթի խորոված", "ru": "Шашлык из телёнка"}', NULL, 8900, ARRAY[]::varchar[], 4),
('v5-i074', 'v5-c08', 'v5', '{"en": "Lamb BBQ", "hy": "Գառան խորոված", "ru": "Шашлык из баранины"}', NULL, 6900, ARRAY[]::varchar[], 5),
('v5-i075', 'v5-c08', 'v5', '{"en": "Lamb BBQ - loin", "hy": "Գառան խորոված չալաղաջ", "ru": "Шашлык из баранины - корейка"}', NULL, 7900, ARRAY[]::varchar[], 6),
('v5-i076', 'v5-c08', 'v5', '{"en": "Chicken BBQ", "hy": "Խորոված ճուտ", "ru": "Шашлык из цыпленка"}', NULL, 3300, ARRAY[]::varchar[], 7),
('v5-i077', 'v5-c08', 'v5', '{"en": "Potato BBQ", "hy": "Խորոված կարտոֆիլ", "ru": "Картофель на мангале"}', NULL, 1300, ARRAY[]::varchar[], 8),
('v5-i078', 'v5-c08', 'v5', '{"en": "Chicken kebab", "hy": "Քեբաբ հավի մսով", "ru": "Куриный кебаб"}', NULL, 2400, ARRAY[]::varchar[], 9),
('v5-i079', 'v5-c08', 'v5', '{"en": "Beef kebab", "hy": "Քեբաբ տավարի մսով", "ru": "Говяжий кебаб"}', NULL, 2600, ARRAY[]::varchar[], 10),
('v5-i080', 'v5-c08', 'v5', '{"en": "Angus kebab", "hy": "Քեբաբ անգուսի մսով", "ru": "Ангус кебаб"}', NULL, 2700, ARRAY[]::varchar[], 11),
('v5-i081', 'v5-c08', 'v5', '{"en": "Hare kebab", "hy": "Քեբաբ նապաստակի մսով", "ru": "Кроличий кебаб"}', NULL, 3900, ARRAY[]::varchar[], 12),
('v5-i082', 'v5-c08', 'v5', '{"en": "Kebab set", "hy": "Քեբաբ սեթ - անգուսի, հավի, նապաստակի մսով, պանրով գյուղական խաչապուրի", "ru": "Кебаб сет - из мяса ангуса, курицы, кролика, хачапури с сыром по - деревенски"}', NULL, 13900, ARRAY[]::varchar[], 13),
('v5-i083', 'v5-c08', 'v5', '{"en": "Armenian style BBQ vegetable", "hy": "Խորոված բանջարեղենի ճաշ", "ru": "Овощной шашлык по - армянски"}', '{"en": "Tomatoes, peppers, aubergine, onions, greens", "hy": "Լոլիկ, պղպեղ, սմբուկ, սոխ, կանաչի", "ru": "Томаты, перец, баклажан, лук, зелень"}', 3500, ARRAY[]::varchar[], 14),
('v5-i084', 'v5-c08', 'v5', '{"en": "Mushroom BBQ", "hy": "Խորոված սունկ", "ru": "Грибы на мангале"}', NULL, 2200, ARRAY[]::varchar[], 15),
('v5-i085', 'v5-c08', 'v5', '{"en": "Vegetables BBQ", "hy": "Խորոված բանջարեղեն", "ru": "Овощи на мангале"}', NULL, 3500, ARRAY[]::varchar[], 16),
('v5-i086', 'v5-c08', 'v5', '{"en": "Sevan whitefish BBQ, potato gata", "hy": "Խորոված Սևանի սիգ, կարտոֆիլի գաթա", "ru": "Севанский сиг на мангале, картофельная гата"}', NULL, 3900, ARRAY[]::varchar[], 17),
('v5-i087', 'v5-c08', 'v5', '{"en": "Sterlet Fish BBQ", "hy": "Խորոված ստերլետ, օրզո տրյուֆելային սոուս և պարմեզան", "ru": "Шашлык из стерляди, трюфельная паста и пармезан"}', NULL, 7900, ARRAY[]::varchar[], 18),
('v5-i088', 'v5-c08', 'v5', '{"en": "BBQ river trout - karmrakhayt, grilled vegetables", "hy": "Խորոված կարմրախայտ, գրիլ բանջարեղեն", "ru": "Шашлык из речной форели - кармрахайт, овощи на гриле"}', NULL, 13000, ARRAY[]::varchar[], 19),
('v5-i089', 'v5-c08', 'v5', '{"en": "Whole sterlet BBQ", "hy": "Խորոված ամբողջական թառափ", "ru": "Шашлык из цельной стерляди"}', NULL, 27000, ARRAY[]::varchar[], 20),
('v5-i090', 'v5-c08', 'v5', '{"en": "Small BBQ set (for 2-4 persons)", "hy": "Խորովածի փոքր սեթ (2-4 անձ)", "ru": "Маленький сет шашлыка (на 2-4 персон)"}', NULL, 24000, ARRAY[]::varchar[], 21),
('v5-i091', 'v5-c08', 'v5', '{"en": "Big BBQ set (for 6-8 persons)", "hy": "Խորովածի մեծ սեթ (6-8 անձ)", "ru": "Большой сет шашлыка (на 6-8 персон)"}', NULL, 39000, ARRAY[]::varchar[], 22);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c09', 'v5', '{"en": "Mains", "hy": "Հիմնական Ուտեստ", "ru": "Основные Блюда"}', 9);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i092', 'v5-c09', 'v5', '{"en": "Dolma with grape leaves", "hy": "Թվով տոլմա", "ru": "Толма с виноградными листьями"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v5-i093', 'v5-c09', 'v5', '{"en": "Dolma with cabbage", "hy": "Կաղամբով տոլմա", "ru": "Толма с капустой"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v5-i094', 'v5-c09', 'v5', '{"en": "Tjvjik - beef heart, lung, liver, onion, tomato sauce", "hy": "Տժվժիկ - տավարի սիրտ, թոք, սոխ, լոլիկով սոուս", "ru": "Тжвжик - говяжье сердце, легкое печень, лук, томатный соус"}', NULL, 3500, ARRAY[]::varchar[], 2),
('v5-i095', 'v5-c09', 'v5', '{"en": "Ker u sus - beef tenderloin, bell pepper, tomato, potato, onion, green peas", "hy": "Կեր ու սուս - տավարի սուկի, բուլղարական պղպեղ, լոլիկ, կարտոֆիլ, սոխ, կանաչ ոլոռ", "ru": "Кер у Сус - говяжья вырезка, болгарский перец, томат, картофель, лук, зеленый горошек"}', NULL, 4200, ARRAY[]::varchar[], 3),
('v5-i096', 'v5-c09', 'v5', '{"en": "Potato tabaka with Dilijan mushrooms", "hy": "Կարտոֆիլի տապակա Դիլիջանի սնկերով", "ru": "Картофель табака с дилижанскими грибами"}', NULL, 3200, ARRAY[]::varchar[], 4),
('v5-i097', 'v5-c09', 'v5', '{"en": "Potato tabaka with pork and onion", "hy": "Կարտոֆիլի տապակա խոզի մսով և սոխով", "ru": "Картофель табака со свининой и луком"}', NULL, 3200, ARRAY[]::varchar[], 5),
('v5-i098', 'v5-c09', 'v5', '{"en": "Veal khashlama", "hy": "Հորթի խաշլամա", "ru": "Хашлама из телёнка"}', NULL, 6700, ARRAY[]::varchar[], 6),
('v5-i099', 'v5-c09', 'v5', '{"en": "Boiled river trout, \"Karmrakhayt\" tomato, dill, butter", "hy": "Խաշած կարմրախայտ - լոլիկ, սամիթ, կարագ", "ru": "Отварная речная форель \"Кармрахайт\", томат, укроп, сливочное масло"}', NULL, 7900, ARRAY[]::varchar[], 7),
('v5-i100', 'v5-c09', 'v5', '{"en": "Boiled trout, tarragon, vegetables, butter", "hy": "Խաշած իշխան, թարխուն, բանջարեղեն, կարագ", "ru": "Отварная форель \"Ишхан\", эстрагон, овощи, сливочное масло"}', NULL, 11000, ARRAY[]::varchar[], 8),
('v5-i101', 'v5-c09', 'v5', '{"en": "Meat & vegetable plate", "hy": "Միս բանջարեղենային ափսե - Թենդերլոյն սթեյք, գրիլ արված հավի արծաթամիս, փեփեր սոուս", "ru": "Тарелка с мясом и овощами стейк тендерлоин, куриная грудка на гриле, перечный соус"}', NULL, 12900, ARRAY[]::varchar[], 9),
('v5-i102', 'v5-c09', 'v5', '{"en": "Lamb shank with mashed potatoes", "hy": "Գառան սրունք կարտոֆիլի խյուսով", "ru": "Голень ягненка с картофельным пюре"}', NULL, 7200, ARRAY[]::varchar[], 10),
('v5-i103', 'v5-c09', 'v5', '{"en": "Harissa, caramelized onion, jalapeno, cinnamon", "hy": "Հարիսա, կարամելացված սոխ, հալապենյո, դարչին", "ru": "Хариса, карамелизированный лук, халапеньо, корица"}', NULL, 2900, ARRAY[]::varchar[], 11),
('v5-i104', 'v5-c09', 'v5', '{"en": "Fried whitefish, tartar sauce, lemon", "hy": "Տապակած սիգ, թար-թար սոուս, կիտրոն", "ru": "Жареный сиг, соус тартар, лимон"}', NULL, 4900, ARRAY[]::varchar[], 12),
('v5-i105', 'v5-c09', 'v5', '{"en": "Ishli kufta with emmer wheat and mushrooms", "hy": "Իշլի քյուֆթա հաճարով և սնկով", "ru": "Ишли кюфта с полбой и грибами"}', NULL, 4900, ARRAY[]::varchar[], 13),
('v5-i106', 'v5-c09', 'v5', '{"en": "Tarragon kufta, tomato red sauce, arishta, parmesan", "hy": "Թարխունով քյուֆթա, լոլիկով կարմիր սոուս, արիշտա, պարմեզան", "ru": "Кюфта с эстрагоном, красный соус с помидорами, аришта, пармезан"}', NULL, 4700, ARRAY[]::varchar[], 14),
('v5-i107', 'v5-c09', 'v5', '{"en": "Kufta balls, tarragon cream sauce, cherry tomatoes, nuts", "hy": "Քյուֆթայի գնդիկներ, թարխունով սերուցքային սոուս, չերի լոլիկ, ընկույզ", "ru": "Шарики из кюфты, сливочный соус с эстрагоном, помидоры черри, орехи"}', NULL, 4900, ARRAY[]::varchar[], 15),
('v5-i108', 'v5-c09', 'v5', '{"en": "Honey glazed pork ribs, baby potatoes, iceberg, blue cheese sauce", "hy": "Մեղրով պատրաստված խոզի ռիբս, երիտասարդ կարտոֆիլ, այսբերգ, բլյու չիզ սոուս", "ru": "Свиные ребрышки, приготовленные в меду, молодой картофель, айсберг, соус блю-чиз"}', NULL, 4900, ARRAY[]::varchar[], 16),
('v5-i109', 'v5-c09', 'v5', '{"en": "Pork ribs, French fries, iceberg salad", "hy": "Խոզի ռիբս, կարտոֆիլ ֆրի, այսբերգ աղցան (2 անձ)", "ru": "Свиные ребрышки, картофель фри, салат айсберг"}', NULL, 8900, ARRAY[]::varchar[], 17),
('v5-i110', 'v5-c09', 'v5', '{"en": "Grilled beef tenderloin, fried potatoes, grilled vegetables, pepper sauce", "hy": "Թենդերլոյն սթեյք, տապակած կարտոֆիլ, գրիլ բանջարեղեն, փեփեր սոուս", "ru": "Говяжий тендерлойн на гриле, жареный картофель, овощи на гриле, перечный соус"}', NULL, 8500, ARRAY[]::varchar[], 18),
('v5-i111', 'v5-c09', 'v5', '{"en": "Creamy garlic chicken breast tarragon orzo, caramelized carrots", "hy": "Հավի կրծքամիս սերուցքով և սխտորով թարխուն օրզո, կարամելացված գազար", "ru": "Куриная грудка в сливочно-чесночном соусе орзо с эстрагоном, карамелизированная морковь"}', NULL, 4400, ARRAY[]::varchar[], 19),
('v5-i112', 'v5-c09', 'v5', '{"en": "Chicken big set", "hy": "Հավի մեծ սեթ - խորոված ճուտ և հավի կրծքամիս, հավի քեբաբ, կարտոֆիլ ֆրի, տրյուֆելով թթվասեր", "ru": "Большой куриный сет - цыпленок на мангале и куриная грудка, куриный кебаб, картофель фри, трюфельная сметана"}', NULL, 19000, ARRAY[]::varchar[], 20);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v5-c10', 'v5', '{"en": "Sides", "hy": "Խավարտ", "ru": "Гарниры"}', 10);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v5-i113', 'v5-c10', 'v5', '{"en": "Baby potatoes", "hy": "Երիտասարդ կարտոֆիլ", "ru": "Молодой картофель"}', NULL, 2200, ARRAY[]::varchar[], 0),
('v5-i114', 'v5-c10', 'v5', '{"en": "Mashed potatoes", "hy": "Կարտոֆիլի խյուս", "ru": "Картофельное пюре"}', NULL, 1700, ARRAY[]::varchar[], 1),
('v5-i115', 'v5-c10', 'v5', '{"en": "French fries", "hy": "Կարտոֆիլ Ֆրի", "ru": "Картофель фри"}', NULL, 1700, ARRAY[]::varchar[], 2),
('v5-i116', 'v5-c10', 'v5', '{"en": "Grilled vegetables", "hy": "Գրիլ բանջարեղեն", "ru": "Овощи на гриле"}', NULL, 2200, ARRAY[]::varchar[], 3),
('v5-i117', 'v5-c10', 'v5', '{"en": "Home-style fried potatoes", "hy": "Տնական տապակած կարտոֆիլ", "ru": "Жареный картофель по - домашнему"}', NULL, 2200, ARRAY[]::varchar[], 4),
('v5-i118', 'v5-c10', 'v5', '{"en": "Emmer wheat with mushrooms", "hy": "Հաճար սնկով", "ru": "Полба с грибами"}', NULL, 1700, ARRAY[]::varchar[], 5),
('v5-i119', 'v5-c10', 'v5', '{"en": "Rice", "hy": "Բրինձ", "ru": "Рис"}', NULL, 1300, ARRAY[]::varchar[], 6),
('v5-i120', 'v5-c10', 'v5', '{"en": "Buckwheat", "hy": "Հնդկաձավար", "ru": "Гречка"}', NULL, 1700, ARRAY[]::varchar[], 7),
('v5-i121', 'v5-c10', 'v5', '{"en": "Traditional potato chmur", "hy": "Ավանդական կարտոֆիլի ճմուռ", "ru": "Традиционный картофельный чмур"}', NULL, 1600, ARRAY[]::varchar[], 8);

-- ═══ Bar B.Q. (v7) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v7', 'Bar B.Q.', 'bar-bq',
 '{"en": "Bar B.Q. — a popular restaurant in Yerevan."}',
 ARRAY['BBQ','Grill','Steaks'], 2, 4.3, 67,
 'Northern Ave, Yerevan 0001', 40.1792, 44.5144, '+374 10 545454',
 ARRAY['WiFi','Outdoor Seating','Takeout'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v7', 'https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?w=800', 0),
('v7', 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800', 1),
('v7', 'https://images.unsplash.com/photo-1558030006-450675393462?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v7', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v7-z1', 'v7', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v7-z2', 'v7', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v7-t1', 'v7', 'v7-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v7-t2', 'v7', 'v7-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v7-t3', 'v7', 'v7-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v7-t4', 'v7', 'v7-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v7-t5', 'v7', 'v7-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v7-t6', 'v7', 'v7-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000007', 'v7', 'Bar B.Q. Admin', 'admin-barbq@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 545454', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c00', 'v7', '{"en": "Grill / BBQ", "hy": "Գրիլ / Բարբեքյու", "ru": "Гриль / Барбекю"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i001', 'v7-c00', 'v7', '{"en": "Famous Angus Kebab", "hy": "Ֆեյմս Անգուս Քյաբաբ", "ru": "Знаменитый ангус кебаб"}', NULL, 1550, ARRAY[]::varchar[], 0),
('v7-i002', 'v7-c00', 'v7', '{"en": "House Chicken Kebab", "hy": "Տնական հավի քյաբաբ", "ru": "Фирменный куриный кебаб"}', NULL, 1200, ARRAY[]::varchar[], 1),
('v7-i003', 'v7-c00', 'v7', '{"en": "Poultry Kebab", "hy": "Հնդկահավի քյաբաբ", "ru": "Кебаб из индейки"}', NULL, 1300, ARRAY[]::varchar[], 2),
('v7-i004', 'v7-c00', 'v7', '{"en": "Falafel Kebab", "hy": "Ֆալաֆել քյաբաբ", "ru": "Фалафель кебаб"}', NULL, 1200, ARRAY[]::varchar[], 3),
('v7-i005', 'v7-c00', 'v7', '{"en": "Chicken BBQ", "hy": "Հավի BBQ", "ru": "BBQ из курицы"}', NULL, 1300, ARRAY[]::varchar[], 4),
('v7-i006', 'v7-c00', 'v7', '{"en": "Pork BBQ", "hy": "Խոզի BBQ", "ru": "BBQ из свинины"}', NULL, 1450, ARRAY[]::varchar[], 5),
('v7-i007', 'v7-c00', 'v7', '{"en": "Poultry BBQ", "hy": "Հնդկահավի BBQ", "ru": "BBQ из индейки"}', NULL, 1300, ARRAY[]::varchar[], 6),
('v7-i008', 'v7-c00', 'v7', '{"en": "Chicken Wings BBQ", "hy": "Հավի թևիկների BBQ", "ru": "BBQ из куриных крылышек"}', NULL, 1950, ARRAY[]::varchar[], 7),
('v7-i009', 'v7-c00', 'v7', '{"en": "Sweet Corn BBQ", "hy": "Եգիպտացորենի BBQ", "ru": "BBQ сладкая кукуруза"}', NULL, 700, ARRAY[]::varchar[], 8),
('v7-i010', 'v7-c00', 'v7', '{"en": "Potato BBQ", "hy": "Կարտոֆիլի BBQ", "ru": "BBQ из картофеля"}', NULL, 700, ARRAY[]::varchar[], 9);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c01', 'v7', '{"en": "Shawarma", "hy": "Շաուրմա", "ru": "Шаурма"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i011', 'v7-c01', 'v7', '{"en": "Chicken with Bread", "hy": "Հավի հացով", "ru": "Из курицы в хлебе"}', NULL, 1300, ARRAY[]::varchar[], 0),
('v7-i012', 'v7-c01', 'v7', '{"en": "Chicken with Pita", "hy": "Հավի լոշիկով", "ru": "Из курицы в пите"}', NULL, 1500, ARRAY[]::varchar[], 1),
('v7-i013', 'v7-c01', 'v7', '{"en": "Chicken with Lavash", "hy": "Հավի լավաշով", "ru": "Из курицы в лаваше"}', NULL, 1500, ARRAY[]::varchar[], 2),
('v7-i014', 'v7-c01', 'v7', '{"en": "Pork with Bread", "hy": "Խոզի հացով", "ru": "Из свинины в хлебе"}', NULL, 1400, ARRAY[]::varchar[], 3),
('v7-i015', 'v7-c01', 'v7', '{"en": "Pork with Pita", "hy": "Խոզի լոշիկով", "ru": "Из свинины в пите"}', NULL, 1500, ARRAY[]::varchar[], 4),
('v7-i016', 'v7-c01', 'v7', '{"en": "Pork with Lavash", "hy": "Խոզի լավաշով", "ru": "Из свинины в лаваше"}', NULL, 1600, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c02', 'v7', '{"en": "Lahmajo", "hy": "Լահմաջո", "ru": "Ламаджо"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i017', 'v7-c02', 'v7', '{"en": "Angus", "hy": "Անգուս", "ru": "Ангус"}', NULL, 1000, ARRAY[]::varchar[], 0),
('v7-i018', 'v7-c02', 'v7', '{"en": "Angus Cheese", "hy": "Անգուս պանիր", "ru": "Ангус сыр"}', NULL, 1200, ARRAY[]::varchar[], 1),
('v7-i019', 'v7-c02', 'v7', '{"en": "Angus Maria", "hy": "Անգուս Մարիա", "ru": "Ангус Мария"}', NULL, 1600, ARRAY[]::varchar[], 2),
('v7-i020', 'v7-c02', 'v7', '{"en": "Cheese", "hy": "Պանիր", "ru": "Сыр"}', NULL, 800, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c03', 'v7', '{"en": "Khachapuri on Grill", "hy": "Խաչապուրի կրակի վրա", "ru": "Хачапури на мангале"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i021', 'v7-c03', 'v7', '{"en": "Cheese", "hy": "Պանրով", "ru": "С сыром"}', NULL, 1200, ARRAY[]::varchar[], 0),
('v7-i022', 'v7-c03', 'v7', '{"en": "Cheese and Ham", "hy": "Պանրով և խոզապուխտով", "ru": "С сыром и ветчиной"}', NULL, 1400, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c04', 'v7', '{"en": "Pideh", "hy": "Պիդե", "ru": "Пиде"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i023', 'v7-c04', 'v7', '{"en": "Adjarian", "hy": "Աջարական", "ru": "Аджарский"}', NULL, 1400, ARRAY[]::varchar[], 0),
('v7-i024', 'v7-c04', 'v7', '{"en": "Chicken Veggie", "hy": "Հավի", "ru": "Курица с овощами"}', NULL, 1600, ARRAY[]::varchar[], 1),
('v7-i025', 'v7-c04', 'v7', '{"en": "Pork Baharat", "hy": "Խոզի", "ru": "Свинина бахарат"}', NULL, 1800, ARRAY[]::varchar[], 2),
('v7-i026', 'v7-c04', 'v7', '{"en": "Pepperoni", "hy": "Պեպերոնի / Կծու", "ru": "Пепперони"}', NULL, 1400, ARRAY[]::varchar[], 3),
('v7-i027', 'v7-c04', 'v7', '{"en": "Ham & Sausage", "hy": "Նրբերշիկ / Խոզապուխտ", "ru": "Ветчина с сосиской"}', NULL, 1400, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c05', 'v7', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i028', 'v7-c05', 'v7', '{"en": "Tabbouleh", "hy": "Թաբուլե", "ru": "Табуле"}', NULL, 900, ARRAY[]::varchar[], 0),
('v7-i029', 'v7-c05', 'v7', '{"en": "Mutabal", "hy": "Մութաբալ", "ru": "Мутабал"}', NULL, 950, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v7-c06', 'v7', '{"en": "Drinks", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v7-i030', 'v7-c06', 'v7', '{"en": "Still Water", "hy": "Ջուր չգազավորված", "ru": "Вода без газа"}', NULL, 400, ARRAY[]::varchar[], 0),
('v7-i031', 'v7-c06', 'v7', '{"en": "Sparkling Water", "hy": "Ջուր գազավորված", "ru": "Вода с газом"}', NULL, 400, ARRAY[]::varchar[], 1),
('v7-i032', 'v7-c06', 'v7', '{"en": "Soft Drinks", "hy": "Զովացուցիչ ըմպելիքներ", "ru": "Освежающие напитки"}', NULL, 450, ARRAY[]::varchar[], 2),
('v7-i033', 'v7-c06', 'v7', '{"en": "Tan / Lime / Mint", "hy": "Թան / Լայմ / Նանա", "ru": "Тан / Лайм / Минт"}', NULL, 600, ARRAY[]::varchar[], 3),
('v7-i034', 'v7-c06', 'v7', '{"en": "Draft Beer", "hy": "Դրաֆտ գարեջուր", "ru": "Разливное пиво"}', NULL, 1200, ARRAY[]::varchar[], 4),
('v7-i035', 'v7-c06', 'v7', '{"en": "Tomato / Oregano / Garlic", "hy": "Լոլիկ / Օրեգանո / Սխտոր", "ru": "Томат / Орегано / Чеснок"}', NULL, 600, ARRAY[]::varchar[], 5);

-- ═══ Black Angus Burger Bar (v8) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v8', 'Black Angus Burger Bar', 'black-angus',
 '{"en": "Black Angus Burger Bar — a popular restaurant in Yerevan."}',
 ARRAY['Burgers','American','Fast Food'], 2, 4.4, 156,
 'Tumanyan St 21, Yerevan 0002', 40.1845, 44.513, '+374 10 565656',
 ARRAY['WiFi','Takeout','Delivery'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v8', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', 0),
('v8', 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800', 1),
('v8', 'https://images.unsplash.com/photo-1586816001966-79b736744398?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v8', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v8-z1', 'v8', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v8-z2', 'v8', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v8-t1', 'v8', 'v8-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v8-t2', 'v8', 'v8-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v8-t3', 'v8', 'v8-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v8-t4', 'v8', 'v8-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v8-t5', 'v8', 'v8-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v8-t6', 'v8', 'v8-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000008', 'v8', 'Black Angus Burger Bar Admin', 'admin-blackangus@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 565656', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v8-c00', 'v8', '{"en": "Burgers", "hy": "Բուրգերներ", "ru": "Бургеры"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v8-i001', 'v8-c00', 'v8', '{"en": "Beef - Bacon & Cheddar Cheese (Standard)", "hy": "Տավարի միս - Բեկոն և Չեդեր պանիր (Ստանդարտ)", "ru": "Говядина - Бекон и сыр Чеддер (Стандарт)"}', NULL, 3000, ARRAY[]::varchar[], 0),
('v8-i002', 'v8-c00', 'v8', '{"en": "Beef - Bacon & Cheddar Cheese (Mini)", "hy": "Տավարի միս - Բեկոն և Չեդեր պանիր (Մինի)", "ru": "Говядина - Бекон и сыр Чеддер (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 1),
('v8-i003', 'v8-c00', 'v8', '{"en": "Angus - Bacon & Cheddar Cheese (Standard)", "hy": "Անգուս - Բեկոն և Չեդեր պանիր (Ստանդարտ)", "ru": "Ангус - Бекон и сыр Чеддер (Стандарт)"}', NULL, 3300, ARRAY[]::varchar[], 2),
('v8-i004', 'v8-c00', 'v8', '{"en": "Angus - Bacon & Cheddar Cheese (Mini)", "hy": "Անգուս - Բեկոն և Չեդեր պանիր (Մինի)", "ru": "Ангус - Бекон и сыр Чеддер (Мини)"}', NULL, 2900, ARRAY[]::varchar[], 3),
('v8-i005', 'v8-c00', 'v8', '{"en": "BBQ Grilled Chicken (Standard)", "hy": "BBQ Գրիլ հավ (Ստանդարտ)", "ru": "Курица-гриль барбекю (Стандарт)"}', NULL, 3050, ARRAY[]::varchar[], 4),
('v8-i006', 'v8-c00', 'v8', '{"en": "BBQ Grilled Chicken (Mini)", "hy": "BBQ Գրիլ հավ (Մինի)", "ru": "Курица-гриль барбекю (Мини)"}', NULL, 2650, ARRAY[]::varchar[], 5),
('v8-i007', 'v8-c00', 'v8', '{"en": "Beef - Blue Cheese (Standard)", "hy": "Տավարի միս - Բլյու Չիզ (Ստանդարտ)", "ru": "Говядина - Блю Чиз (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 6),
('v8-i008', 'v8-c00', 'v8', '{"en": "Beef - Blue Cheese (Mini)", "hy": "Տավարի միս - Բլյու Չիզ (Մինի)", "ru": "Говядина - Блю Чиз (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 7),
('v8-i009', 'v8-c00', 'v8', '{"en": "Angus - Blue Cheese (Standard)", "hy": "Անգուս - Բլյու Չիզ (Ստանդարտ)", "ru": "Ангус - Блю Чиз (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 8),
('v8-i010', 'v8-c00', 'v8', '{"en": "Angus - Blue Cheese (Mini)", "hy": "Անգուս - Բլյու Չիզ (Մինի)", "ru": "Ангус - Блю Чиз (Мини)"}', NULL, 2950, ARRAY[]::varchar[], 9),
('v8-i011', 'v8-c00', 'v8', '{"en": "Beef - Classic Cheese (Standard)", "hy": "Տավարի միս - Կլասիկ պանրով (Ստանդարտ)", "ru": "Говядина - Классический сыр (Стандарт)"}', NULL, 2850, ARRAY[]::varchar[], 10),
('v8-i012', 'v8-c00', 'v8', '{"en": "Beef - Classic Cheese (Mini)", "hy": "Տավարի միս - Կլասիկ պանրով (Մինի)", "ru": "Говядина - Классический сыр (Мини)"}', NULL, 2450, ARRAY[]::varchar[], 11),
('v8-i013', 'v8-c00', 'v8', '{"en": "Angus - Classic Cheese (Standard)", "hy": "Անգուս - Կլասիկ պանրով (Ստանդարտ)", "ru": "Ангус - Классический сыр (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 12),
('v8-i014', 'v8-c00', 'v8', '{"en": "Angus - Classic Cheese (Mini)", "hy": "Անգուս - Կլասիկ պանրով (Մինի)", "ru": "Ангус - Классический сыр (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 13),
('v8-i015', 'v8-c00', 'v8', '{"en": "Beef - Classic (Standard)", "hy": "Տավարի միս - Կլասիկ (Ստանդարտ)", "ru": "Говядина - Классик (Стандарт)"}', NULL, 2750, ARRAY[]::varchar[], 14),
('v8-i016', 'v8-c00', 'v8', '{"en": "Beef - Classic (Mini)", "hy": "Տավարի միս - Կլասիկ (Մինի)", "ru": "Говядина - Классик (Мини)"}', NULL, 2350, ARRAY[]::varchar[], 15),
('v8-i017', 'v8-c00', 'v8', '{"en": "Angus - Classic (Standard)", "hy": "Անգուս - Կլասիկ (Ստանդարտ)", "ru": "Ангус - Классик (Стандарт)"}', NULL, 3050, ARRAY[]::varchar[], 16),
('v8-i018', 'v8-c00', 'v8', '{"en": "Angus - Classic (Mini)", "hy": "Անգուս - Կլասիկ (Մինի)", "ru": "Ангус - Классик (Мини)"}', NULL, 2650, ARRAY[]::varchar[], 17),
('v8-i019', 'v8-c00', 'v8', '{"en": "Beef - Classic Double Cheese (Standard)", "hy": "Տավարի միս - Կլասիկ կրկնակի պանրով (Ստանդարտ)", "ru": "Говядина - Классический двойной сыр (Стандарт)"}', NULL, 3700, ARRAY[]::varchar[], 18),
('v8-i020', 'v8-c00', 'v8', '{"en": "Beef - Classic Double Cheese (Mini)", "hy": "Տավարի միս - Կլասիկ կրկնակի պանրով (Մինի)", "ru": "Говядина - Классический двойной сыр (Мини)"}', NULL, 3200, ARRAY[]::varchar[], 19),
('v8-i021', 'v8-c00', 'v8', '{"en": "Angus - Classic Double Cheese (Standard)", "hy": "Անգուս - Կլասիկ կրկնակի պանրով (Ստանդարտ)", "ru": "Ангус - Классический двойной сыр (Стандарт)"}', NULL, 4000, ARRAY[]::varchar[], 20),
('v8-i022', 'v8-c00', 'v8', '{"en": "Angus - Classic Double Cheese (Mini)", "hy": "Անգուս - Կլասիկ կրկնակի պանրով (Մինի)", "ru": "Ангус - Классический двойной сыр (Мини)"}', NULL, 3300, ARRAY[]::varchar[], 21),
('v8-i023', 'v8-c00', 'v8', '{"en": "Beef - Classic Double (Standard)", "hy": "Տավարի միս - Կրկնակի կլասիկ (Ստանդարտ)", "ru": "Говядина - Классический двойной (Стандарт)"}', NULL, 3500, ARRAY[]::varchar[], 22),
('v8-i024', 'v8-c00', 'v8', '{"en": "Beef - Classic Double (Mini)", "hy": "Տավարի միս - Կրկնակի կլասիկ (Մինի)", "ru": "Говядина - Классический двойной (Мини)"}', NULL, 3000, ARRAY[]::varchar[], 23),
('v8-i025', 'v8-c00', 'v8', '{"en": "Angus - Classic Double (Standard)", "hy": "Անգուս - Կրկնակի կլասիկ (Ստանդարտ)", "ru": "Ангус - Классический двойной (Стандарт)"}', NULL, 3800, ARRAY[]::varchar[], 24),
('v8-i026', 'v8-c00', 'v8', '{"en": "Angus - Classic Double (Mini)", "hy": "Անգուս - Կրկնակի կլասիկ (Մինի)", "ru": "Ангус - Классический двойной (Мини)"}', NULL, 3100, ARRAY[]::varchar[], 25),
('v8-i027', 'v8-c00', 'v8', '{"en": "Beef - French Cheese (Standard)", "hy": "Տավարի միս - Ֆրանսիական պանրով (Ստանդարտ)", "ru": "Говядина - Французский сыр (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 26),
('v8-i028', 'v8-c00', 'v8', '{"en": "Beef - French Cheese (Mini)", "hy": "Տավարի միս - Ֆրանսիական պանրով (Մինի)", "ru": "Говядина - Французский сыр (Мини)"}', NULL, 2850, ARRAY[]::varchar[], 27),
('v8-i029', 'v8-c00', 'v8', '{"en": "Angus - French Cheese (Standard)", "hy": "Անգուս - Ֆրանսիական պանրով (Ստանդարտ)", "ru": "Ангус - Французский сыр (Стандарт)"}', NULL, 3550, ARRAY[]::varchar[], 28),
('v8-i030', 'v8-c00', 'v8', '{"en": "Angus - French Cheese (Mini)", "hy": "Անգուս - Ֆրանսիական պանրով (Մինի)", "ru": "Ангус - Французский сыр (Мини)"}', NULL, 3150, ARRAY[]::varchar[], 29),
('v8-i031', 'v8-c00', 'v8', '{"en": "Grilled Chicken (Standard)", "hy": "Գրիլ հավ (Ստանդարտ)", "ru": "Курица-гриль (Стандарт)"}', NULL, 2950, ARRAY[]::varchar[], 30),
('v8-i032', 'v8-c00', 'v8', '{"en": "Grilled Chicken (Mini)", "hy": "Գրիլ հավ (Մինի)", "ru": "Курица-гриль (Мини)"}', NULL, 2550, ARRAY[]::varchar[], 31),
('v8-i033', 'v8-c00', 'v8', '{"en": "Beef - Italian Style (Standard)", "hy": "Տավարի միս - Իտալական ոճով (Ստանդարտ)", "ru": "Говядина - По-итальянски (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 32),
('v8-i034', 'v8-c00', 'v8', '{"en": "Beef - Italian Style (Mini)", "hy": "Տավարի միս - Իտալական ոճով (Մինի)", "ru": "Говядина - По-итальянски (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 33),
('v8-i035', 'v8-c00', 'v8', '{"en": "Angus - Italian Style (Standard)", "hy": "Անգուս - Իտալական ոճով (Ստանդարտ)", "ru": "Ангус - По-итальянски (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 34),
('v8-i036', 'v8-c00', 'v8', '{"en": "Angus - Italian Style (Mini)", "hy": "Անգուս - Իտալական ոճով (Մինի)", "ru": "Ангус - По-итальянски (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 35),
('v8-i037', 'v8-c00', 'v8', '{"en": "Mignon Steak (Standard)", "hy": "Մինյոն Սթեյք (Ստանդարտ)", "ru": "Стейк Миньон (Стандарт)"}', NULL, 3500, ARRAY[]::varchar[], 36),
('v8-i038', 'v8-c00', 'v8', '{"en": "Mignon Steak (Mini)", "hy": "Մինյոն Սթեյք (Մինի)", "ru": "Стейк Миньон (Мини)"}', NULL, 2900, ARRAY[]::varchar[], 37),
('v8-i039', 'v8-c00', 'v8', '{"en": "Beef - Mozzarella Soft (Standard)", "hy": "Տավարի միս - Փափուկ Մոցարելա (Ստանդարտ)", "ru": "Говядина - Нежная моцарелла (Стандарт)"}', NULL, 3050, ARRAY[]::varchar[], 38),
('v8-i040', 'v8-c00', 'v8', '{"en": "Beef - Mozzarella Soft (Mini)", "hy": "Տավարի միս - Փափուկ Մոցարելա (Մինի)", "ru": "Говядина - Нежная моцарелла (Мини)"}', NULL, 2650, ARRAY[]::varchar[], 39),
('v8-i041', 'v8-c00', 'v8', '{"en": "Angus - Mozzarella Soft (Standard)", "hy": "Անգուս - Փափուկ Մոցարելա (Ստանդարտ)", "ru": "Ангус - Нежная моцарелла (Стандарт)"}', NULL, 3350, ARRAY[]::varchar[], 40),
('v8-i042', 'v8-c00', 'v8', '{"en": "Angus - Mozzarella Soft (Mini)", "hy": "Անգուս - Փափուկ Մոցարելա (Մինի)", "ru": "Ангус - Нежная моцарелла (Мини)"}', NULL, 2950, ARRAY[]::varchar[], 41),
('v8-i043', 'v8-c00', 'v8', '{"en": "Beef - Pepper Cheese (Standard)", "hy": "Տավարի միս - Պղպեղային պանրով (Ստանդարտ)", "ru": "Говядина - Перечный сыр (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 42),
('v8-i044', 'v8-c00', 'v8', '{"en": "Beef - Pepper Cheese (Mini)", "hy": "Տավարի միս - Պղպեղային պանրով (Մինի)", "ru": "Говядина - Перечный сыр (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 43),
('v8-i045', 'v8-c00', 'v8', '{"en": "Angus - Pepper Cheese (Standard)", "hy": "Անգուս - Պղպեղային պանրով (Ստանդարտ)", "ru": "Ангус - Перечный сыр (Стандарт)"}', NULL, 3350, ARRAY[]::varchar[], 44),
('v8-i046', 'v8-c00', 'v8', '{"en": "Angus - Pepper Cheese (Mini)", "hy": "Անգուս - Պղպեղային պանրով (Մինի)", "ru": "Ангус - Перечный сыр (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 45),
('v8-i047', 'v8-c00', 'v8', '{"en": "Beef - Swiss Cheese (Standard)", "hy": "Տավարի միս - Շվեյցարական պանրով (Ստանդարտ)", "ru": "Говядина - Швейцарский сыр (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 46),
('v8-i048', 'v8-c00', 'v8', '{"en": "Beef - Swiss Cheese (Mini)", "hy": "Տավարի միս - Շվեյցարական պանրով (Մինի)", "ru": "Говядина - Швейцарский сыр (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 47),
('v8-i049', 'v8-c00', 'v8', '{"en": "Angus - Swiss Cheese (Standard)", "hy": "Անգուս - Շվեյցարական պանրով (Ստանդարտ)", "ru": "Ангус - Швейцарский сыр (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 48),
('v8-i050', 'v8-c00', 'v8', '{"en": "Angus - Swiss Cheese (Mini)", "hy": "Անգուս - Շվեյցարական պանրով (Մինի)", "ru": "Ангус - Швейцарский сыр (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 49),
('v8-i051', 'v8-c00', 'v8', '{"en": "Veggie Burger", "hy": "Բուսական Բուրգեր", "ru": "Вегетарианский бургер"}', NULL, 2450, ARRAY[]::varchar[], 50),
('v8-i052', 'v8-c00', 'v8', '{"en": "Beef - Creamy Avocado (Standard)", "hy": "Տավարի միս - Կրեմային Ավոկադո (Ստանդարտ)", "ru": "Говядина - Сливочный авокадо (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 51),
('v8-i053', 'v8-c00', 'v8', '{"en": "Beef - Creamy Avocado (Mini)", "hy": "Տավարի միս - Կրեմային Ավոկադո (Մինի)", "ru": "Говядина - Сливочный авокадо (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 52),
('v8-i054', 'v8-c00', 'v8', '{"en": "Angus - Creamy Avocado (Standard)", "hy": "Անգուս - Կրեմային Ավոկադո (Ստանդարտ)", "ru": "Ангус - Сливочный авокадо (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 53),
('v8-i055', 'v8-c00', 'v8', '{"en": "Angus - Creamy Avocado (Mini)", "hy": "Անգուս - Կրեմային Ավոկադո (Մինի)", "ru": "Ангус - Сливочный авокадо (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 54),
('v8-i056', 'v8-c00', 'v8', '{"en": "Beef - Tuscan Style (Standard)", "hy": "Տավարի միս - Տոսկանական ոճով (Ստանդարտ)", "ru": "Говядина - По-тоскански (Стандарт)"}', NULL, 3250, ARRAY[]::varchar[], 55),
('v8-i057', 'v8-c00', 'v8', '{"en": "Beef - Tuscan Style (Mini)", "hy": "Տավարի միս - Տոսկանական ոճով (Մինի)", "ru": "Говядина - По-тоскански (Мини)"}', NULL, 2850, ARRAY[]::varchar[], 56),
('v8-i058', 'v8-c00', 'v8', '{"en": "Angus - Tuscan Style (Standard)", "hy": "Անգուս - Տոսկանական ոճով (Ստանդարտ)", "ru": "Ангус - По-тоскански (Стандарт)"}', NULL, 3550, ARRAY[]::varchar[], 57),
('v8-i059', 'v8-c00', 'v8', '{"en": "Angus - Tuscan Style (Mini)", "hy": "Անգուս - Տոսկանական ոճով (Մինի)", "ru": "Ангус - По-тоскански (Мини)"}', NULL, 3150, ARRAY[]::varchar[], 58),
('v8-i060', 'v8-c00', 'v8', '{"en": "Beef - Fried Mozzarella (Standard)", "hy": "Տավարի միս - Տապակած Մոցարելա (Ստանդարտ)", "ru": "Говядина - Жареная моцарелла (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 59),
('v8-i061', 'v8-c00', 'v8', '{"en": "Beef - Fried Mozzarella (Mini)", "hy": "Տավարի միս - Տապակած Մոցարելա (Մինի)", "ru": "Говядина - Жареная моцарелла (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 60),
('v8-i062', 'v8-c00', 'v8', '{"en": "Angus - Fried Mozzarella (Standard)", "hy": "Անգուս - Տապակած Մոցարելա (Ստանդարտ)", "ru": "Ангус - Жареная моцарелла (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 61),
('v8-i063', 'v8-c00', 'v8', '{"en": "Angus - Fried Mozzarella (Mini)", "hy": "Անգուս - Տապակած Մոցարելա (Մինի)", "ru": "Ангус - Жареная моцарелла (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 62),
('v8-i064', 'v8-c00', 'v8', '{"en": "Beef - Mexicano (Standard)", "hy": "Տավարի միս - Մեքսիկանո (Ստանդարտ)", "ru": "Говядина - Мексикано (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 63),
('v8-i065', 'v8-c00', 'v8', '{"en": "Beef - Mexicano (Mini)", "hy": "Տավարի միս - Մեքսիկանո (Մինի)", "ru": "Говядина - Мексикано (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 64),
('v8-i066', 'v8-c00', 'v8', '{"en": "Angus - Mexicano (Standard)", "hy": "Անգուս - Մեքսիկանո (Ստանդարտ)", "ru": "Ангус - Мексикано (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 65),
('v8-i067', 'v8-c00', 'v8', '{"en": "Angus - Mexicano (Mini)", "hy": "Անգուս - Մեքսիկանո (Մինի)", "ru": "Ангус - Мексикано (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 66),
('v8-i068', 'v8-c00', 'v8', '{"en": "Tzatziki Lamb (Standard)", "hy": "Ձաձիկի Գառան միս (Ստանդարտ)", "ru": "Ягненок Тцатцики (Стандарт)"}', NULL, 3200, ARRAY[]::varchar[], 67),
('v8-i069', 'v8-c00', 'v8', '{"en": "Tzatziki Lamb (Mini)", "hy": "Ձաձիկի Գառան միս (Մինի)", "ru": "Ягненок Тцатцики (Мини)"}', NULL, 2800, ARRAY[]::varchar[], 68);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v8-c01', 'v8', '{"en": "Pizza", "hy": "Պիցցա", "ru": "Пицца"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v8-i070', 'v8-c01', 'v8', '{"en": "House Pizza (Large)", "hy": "Ֆիրմային Պիցցա (Մեծ)", "ru": "Фирменная пицца (Большая)"}', NULL, 4450, ARRAY[]::varchar[], 0),
('v8-i071', 'v8-c01', 'v8', '{"en": "House Pizza (Small)", "hy": "Ֆիրմային Պիցցա (Փոքր)", "ru": "Фирменная пицца (Маленькая)"}', NULL, 3350, ARRAY[]::varchar[], 1),
('v8-i072', 'v8-c01', 'v8', '{"en": "Margherita (Large)", "hy": "Մարգարիտա (Մեծ)", "ru": "Маргарита (Большая)"}', NULL, 3550, ARRAY[]::varchar[], 2),
('v8-i073', 'v8-c01', 'v8', '{"en": "Margherita (Small)", "hy": "Մարգարիտա (Փոքր)", "ru": "Маргарита (Маленькая)"}', NULL, 2750, ARRAY[]::varchar[], 3),
('v8-i074', 'v8-c01', 'v8', '{"en": "Quattro Stagioni (Large)", "hy": "Չորս եղանակ (Մեծ)", "ru": "Четыре сезона (Большая)"}', NULL, 4150, ARRAY[]::varchar[], 4),
('v8-i075', 'v8-c01', 'v8', '{"en": "Quattro Stagioni (Small)", "hy": "Չորս եղանակ (Փոքր)", "ru": "Четыре сезона (Маленькая)"}', NULL, 3150, ARRAY[]::varchar[], 5),
('v8-i076', 'v8-c01', 'v8', '{"en": "Pizza Bianca (Large)", "hy": "Պիցցա Բիանկա (Մեծ)", "ru": "Пицца Бьянка (Большая)"}', NULL, 3850, ARRAY[]::varchar[], 6),
('v8-i077', 'v8-c01', 'v8', '{"en": "Pizza Bianca (Small)", "hy": "Պիցցա Բիանկա (Փոքր)", "ru": "Пицца Бьянка (Маленькая)"}', NULL, 3050, ARRAY[]::varchar[], 7),
('v8-i078', 'v8-c01', 'v8', '{"en": "Quattro Formaggi (Large)", "hy": "Չորս պանիր (Մեծ)", "ru": "Четыре сыра (Большая)"}', NULL, 4350, ARRAY[]::varchar[], 8),
('v8-i079', 'v8-c01', 'v8', '{"en": "Quattro Formaggi (Small)", "hy": "Չորս պանիր (Փոքր)", "ru": "Четыре сыра (Маленькая)"}', NULL, 3350, ARRAY[]::varchar[], 9),
('v8-i080', 'v8-c01', 'v8', '{"en": "Capricciosa (Big)", "hy": "Կապրիչոզա (Մեծ)", "ru": "Капричоза (Большая)"}', NULL, 4250, ARRAY[]::varchar[], 10),
('v8-i081', 'v8-c01', 'v8', '{"en": "Capricciosa (Small)", "hy": "Կապրիչոզա (Փոքր)", "ru": "Капричоза (Маленькая)"}', NULL, 3250, ARRAY[]::varchar[], 11),
('v8-i082', 'v8-c01', 'v8', '{"en": "Pepperoni (Large)", "hy": "Պեպերոնի (Մեծ)", "ru": "Пепперони (Большая)"}', NULL, 4250, ARRAY[]::varchar[], 12),
('v8-i083', 'v8-c01', 'v8', '{"en": "Pepperoni (Small)", "hy": "Պեպերոնի (Փոքր)", "ru": "Пепперони (Маленькая)"}', NULL, 3350, ARRAY[]::varchar[], 13),
('v8-i084', 'v8-c01', 'v8', '{"en": "Arugula and Prosciutto (Large)", "hy": "Ռուկոլա և պրոշուտո (Մեծ)", "ru": "Руккола и прошутто (Большая)"}', NULL, 4450, ARRAY[]::varchar[], 14),
('v8-i085', 'v8-c01', 'v8', '{"en": "Arugula and Prosciutto (Small)", "hy": "Ռուկոլա և պրոշուտո (Փոքր)", "ru": "Руккола и прошутто (Маленькая)"}', NULL, 3350, ARRAY[]::varchar[], 15),
('v8-i086', 'v8-c01', 'v8', '{"en": "Veggie Pizza (Large)", "hy": "Բուսական Պիցցա (Մեծ)", "ru": "Вегетарианская пицца (Большая)"}', NULL, 3850, ARRAY[]::varchar[], 16),
('v8-i087', 'v8-c01', 'v8', '{"en": "Veggie Pizza (Small)", "hy": "Բուսական Պիցցա (Փոքր)", "ru": "Вегетарианская пицца (Маленькая)"}', NULL, 2850, ARRAY[]::varchar[], 17);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v8-c02', 'v8', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v8-i088', 'v8-c02', 'v8', '{"en": "Black Angus Salad (Standard)", "hy": "Բլեք Անգուս Աղցան (Ստանդարտ)", "ru": "Салат Блэк Ангус (Стандарт)"}', NULL, 3650, ARRAY[]::varchar[], 0),
('v8-i089', 'v8-c02', 'v8', '{"en": "Black Angus Salad (Mini)", "hy": "Բլեք Անգուս Աղցան (Մինի)", "ru": "Салат Блэк Ангус (Мини)"}', NULL, 3150, ARRAY[]::varchar[], 1),
('v8-i090', 'v8-c02', 'v8', '{"en": "Fresh Garden Salad (Standard)", "hy": "Թարմ Այգու Աղցան (Ստանդարտ)", "ru": "Свежий садовый салат (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 2),
('v8-i091', 'v8-c02', 'v8', '{"en": "Fresh Garden Salad (Mini)", "hy": "Թարմ Այգու Աղցան (Մինի)", "ru": "Свежий садовый салат (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 3),
('v8-i092', 'v8-c02', 'v8', '{"en": "Classic Greek Salad (Standard)", "hy": "Կլասիկ Հունական Աղցան (Ստանդարտ)", "ru": "Классический греческий салат (Стандарт)"}', NULL, 3150, ARRAY[]::varchar[], 4),
('v8-i093', 'v8-c02', 'v8', '{"en": "Classic Greek Salad (Mini)", "hy": "Կլասիկ Հունական Աղցան (Մինի)", "ru": "Классический греческий салат (Мини)"}', NULL, 2750, ARRAY[]::varchar[], 5),
('v8-i094', 'v8-c02', 'v8', '{"en": "Caesar Salad (Standard)", "hy": "Կեսար Աղցան (Ստանդարտ)", "ru": "Салат Цезарь (Стандарт)"}', NULL, 3450, ARRAY[]::varchar[], 6),
('v8-i095', 'v8-c02', 'v8', '{"en": "Caesar Salad (Mini)", "hy": "Կեսար Աղցան (Մինի)", "ru": "Салат Цезарь (Мини)"}', NULL, 3050, ARRAY[]::varchar[], 7),
('v8-i096', 'v8-c02', 'v8', '{"en": "Grilled Veggie Salad (Standard)", "hy": "Գրիլ Բանջարեղենային Աղցան (Ստանդարտ)", "ru": "Салат из овощей на гриле (Стандарт)"}', NULL, 3350, ARRAY[]::varchar[], 8),
('v8-i097', 'v8-c02', 'v8', '{"en": "Grilled Veggie Salad (Mini)", "hy": "Գրիլ Բանջարեղենային Աղցան (Մինի)", "ru": "Салат из овощей на гриле (Мини)"}', NULL, 2950, ARRAY[]::varchar[], 9);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v8-c03', 'v8', '{"en": "Side Dishes", "hy": "Կողմնակի ճաշատեսակներ", "ru": "Гарниры"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v8-i098', 'v8-c03', 'v8', '{"en": "French Fries", "hy": "Ֆրի", "ru": "Картофель фри"}', NULL, 1150, ARRAY[]::varchar[], 0),
('v8-i099', 'v8-c03', 'v8', '{"en": "French Fries with Cheddar", "hy": "Ֆրի Չեդերով", "ru": "Картофель фри с чеддером"}', NULL, 1550, ARRAY[]::varchar[], 1),
('v8-i100', 'v8-c03', 'v8', '{"en": "French Fries with Mozzarella", "hy": "Ֆրի Մոցարելայով", "ru": "Картофель фри с моцареллой"}', NULL, 1550, ARRAY[]::varchar[], 2),
('v8-i101', 'v8-c03', 'v8', '{"en": "Mozzarella Sticks", "hy": "Մոցարելա ցուպիկներ", "ru": "Моцарелла палочки"}', NULL, 2550, ARRAY[]::varchar[], 3),
('v8-i102', 'v8-c03', 'v8', '{"en": "Potato Wedges", "hy": "Գյուղական կարտոֆիլ", "ru": "Картофельные дольки"}', NULL, 1250, ARRAY[]::varchar[], 4),
('v8-i103', 'v8-c03', 'v8', '{"en": "BBQ Chicken Wings (9-10pcs)", "hy": "BBQ Հավի թևիկներ (9-10 կտոր)", "ru": "Куриные крылышки барбекю (9-10 шт)"}', NULL, 3350, ARRAY[]::varchar[], 5),
('v8-i104', 'v8-c03', 'v8', '{"en": "BBQ Chicken Wings (5-7pcs)", "hy": "BBQ Հավի թևիկներ (5-7 կտոր)", "ru": "Куриные крылышки барбекю (5-7 шт)"}', NULL, 2350, ARRAY[]::varchar[], 6),
('v8-i105', 'v8-c03', 'v8', '{"en": "Grilled Oregano Wings (9-10pcs)", "hy": "Գրիլ թևիկներ օրեգանոյով (9-10 կտոր)", "ru": "Крылышки гриль с орегано (9-10 шт)"}', NULL, 3350, ARRAY[]::varchar[], 7),
('v8-i106', 'v8-c03', 'v8', '{"en": "Grilled Oregano Wings (5-7pcs)", "hy": "Գրիլ թևիկներ օրեգանոյով (5-7 կտոր)", "ru": "Крылышки гриль с орегано (5-7 шт)"}', NULL, 2350, ARRAY[]::varchar[], 8),
('v8-i107', 'v8-c03', 'v8', '{"en": "Crispy Onion Rings", "hy": "Սոխի օղակներ", "ru": "Хрустящие луковые кольца"}', NULL, 1450, ARRAY[]::varchar[], 9),
('v8-i108', 'v8-c03', 'v8', '{"en": "Stuffed Potatoes (Bacon/Cheddar)", "hy": "Լցոնված կարտոֆիլ (Բեկոն/Չեդեր)", "ru": "Фаршированный картофель (Бекон/Чеддер)"}', NULL, 2350, ARRAY[]::varchar[], 10),
('v8-i109', 'v8-c03', 'v8', '{"en": "Baked Potato (Mushroom/Cheddar)", "hy": "Թխված կարտոֆիլ (Սունկ/Չեդեր)", "ru": "Печеный картофель (Грибы/Чеддер)"}', NULL, 2150, ARRAY[]::varchar[], 11),
('v8-i110', 'v8-c03', 'v8', '{"en": "Garlic Bread", "hy": "Սխտորով հաց", "ru": "Чесночный хлеб"}', NULL, 2350, ARRAY[]::varchar[], 12);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v8-c04', 'v8', '{"en": "Drinks", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v8-i111', 'v8-c04', 'v8', '{"en": "Soft Drinks (0.5l)", "hy": "Զովացուցիչ ըմպելիքներ (0.5լ)", "ru": "Безалкогольные напитки (0.5л)"}', NULL, 600, ARRAY[]::varchar[], 0),
('v8-i112', 'v8-c04', 'v8', '{"en": "Lemonades", "hy": "Լիմոնադներ", "ru": "Лимонады"}', NULL, 2050, ARRAY[]::varchar[], 1),
('v8-i113', 'v8-c04', 'v8', '{"en": "Milkshakes", "hy": "Միլքշեյքեր", "ru": "Молочные коктейли"}', NULL, 1500, ARRAY[]::varchar[], 2),
('v8-i114', 'v8-c04', 'v8', '{"en": "Smoothies/Yogurt Drinks", "hy": "Սմուզիներ/Յոգուրտային ըմպելիքներ", "ru": "Смузи/Йогуртовые напитки"}', NULL, 1600, ARRAY[]::varchar[], 3),
('v8-i115', 'v8-c04', 'v8', '{"en": "Imported Beer", "hy": "Ներմուծված գարեջուր", "ru": "Импортное пиво"}', NULL, 1800, ARRAY[]::varchar[], 4);

-- ═══ Cinnabon (v9) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v9', 'Cinnabon', 'cinnabon',
 '{"en": "Cinnabon — a popular restaurant in Yerevan."}',
 ARRAY['Bakery','Desserts','Coffee'], 1, 4.2, 203,
 'Abovyan St 8, Yerevan 0001', 40.1835, 44.5155, '+374 10 575757',
 ARRAY['WiFi','Takeout','Air Conditioning'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v9', 'https://images.unsplash.com/photo-1509365390695-33aee754301f?w=800', 0),
('v9', 'https://images.unsplash.com/photo-1483695028939-5bb13f8648b0?w=800', 1),
('v9', 'https://images.unsplash.com/photo-1517433670267-08bbd4be890f?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v9', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v9-z1', 'v9', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v9-z2', 'v9', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v9-t1', 'v9', 'v9-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v9-t2', 'v9', 'v9-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v9-t3', 'v9', 'v9-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v9-t4', 'v9', 'v9-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v9-t5', 'v9', 'v9-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v9-t6', 'v9', 'v9-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000009', 'v9', 'Cinnabon Admin', 'admin-cinnabon@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 575757', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c00', 'v9', '{"en": "Cinnabon Rolls", "hy": "Սինաբոն Ռոլեր", "ru": "Роллы Синнабон"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i001', 'v9-c00', 'v9', '{"en": "Pistachio Minibon", "hy": "Պիստակով Մինիբոն", "ru": "Фисташковый Минибон"}', NULL, 1400, ARRAY[]::varchar[], 0),
('v9-i002', 'v9-c00', 'v9', '{"en": "Apple Minibon", "hy": "Խնձորով Մինիբոն", "ru": "Яблочный Минибон"}', NULL, 1300, ARRAY[]::varchar[], 1),
('v9-i003', 'v9-c00', 'v9', '{"en": "Pecanbon", "hy": "Պեկանբոն", "ru": "Пеканбон"}', NULL, 2300, ARRAY[]::varchar[], 2),
('v9-i004', 'v9-c00', 'v9', '{"en": "Mini Pecanbon", "hy": "Մինի Պեկանբոն", "ru": "Мини Пеканбон"}', NULL, 1600, ARRAY[]::varchar[], 3),
('v9-i005', 'v9-c00', 'v9', '{"en": "Classic Cinnabon", "hy": "Դասական Սինաբոն", "ru": "Классический Синнабон"}', NULL, 1700, ARRAY[]::varchar[], 4),
('v9-i006', 'v9-c00', 'v9', '{"en": "Classic Minibon", "hy": "Դասական Մինիբոն", "ru": "Классический Минибон"}', NULL, 1100, ARRAY[]::varchar[], 5),
('v9-i007', 'v9-c00', 'v9', '{"en": "Chocobon", "hy": "Շոկոբոն", "ru": "Шокобон"}', NULL, 1800, ARRAY[]::varchar[], 6),
('v9-i008', 'v9-c00', 'v9', '{"en": "Mini Chocobon", "hy": "Մինի Շոկոբոն", "ru": "Мини Шокобон"}', NULL, 1200, ARRAY[]::varchar[], 7),
('v9-i009', 'v9-c00', 'v9', '{"en": "Nutella Cinnabon", "hy": "Նուտելլա Սինաբոն", "ru": "Нутелла Синнабон"}', NULL, 2100, ARRAY[]::varchar[], 8),
('v9-i010', 'v9-c00', 'v9', '{"en": "Nutella Minibon", "hy": "Նուտելլա Մինիբոն", "ru": "Нутелла Минибон"}', NULL, 1500, ARRAY[]::varchar[], 9),
('v9-i011', 'v9-c00', 'v9', '{"en": "Berry Minibon", "hy": "Հատապտղային Մինիբոն", "ru": "Ягодный Минибон"}', NULL, 1500, ARRAY[]::varchar[], 10),
('v9-i012', 'v9-c00', 'v9', '{"en": "Roll On-The-Go", "hy": "Ռոլ Օն-դը-Գոու", "ru": "Ролл Он-зе-Гоу"}', NULL, 1100, ARRAY[]::varchar[], 11),
('v9-i013', 'v9-c00', 'v9', '{"en": "Cherry Mini Chocobon", "hy": "Բալով Մինի Շոկոբոն", "ru": "Вишневый Мини Шокобон"}', NULL, 1400, ARRAY[]::varchar[], 12),
('v9-i014', 'v9-c00', 'v9', '{"en": "Peanut butter Mini Chocobon", "hy": "Գետնանուշի կարագով Մինի Շոկոբոն", "ru": "Арахисовый Мини Шокобон"}', NULL, 1800, ARRAY[]::varchar[], 13),
('v9-i015', 'v9-c00', 'v9', '{"en": "Brownie Minibon", "hy": "Բրաունի Մինիբոն", "ru": "Брауни Минибон"}', NULL, 1500, ARRAY[]::varchar[], 14),
('v9-i016', 'v9-c00', 'v9', '{"en": "Cinnabon sticks", "hy": "Սինաբոն ձողիկներ", "ru": "Палочки Синнабон"}', NULL, 1600, ARRAY[]::varchar[], 15),
('v9-i017', 'v9-c00', 'v9', '{"en": "Lemon Minibon", "hy": "Լիմոնով Մինիբոն", "ru": "Лимонный Минибон"}', NULL, 1500, ARRAY[]::varchar[], 16);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c01', 'v9', '{"en": "Cinnapacks", "hy": "Սինափաքեր", "ru": "Синнапаки"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i018', 'v9-c01', 'v9', '{"en": "Classic 4 rolls", "hy": "Դասական 4 ռոլ", "ru": "Классик 4 ролла"}', NULL, 4100, ARRAY[]::varchar[], 0),
('v9-i019', 'v9-c01', 'v9', '{"en": "Chocobon 4 rolls", "hy": "Շոկոբոն 4 ռոլ", "ru": "Шокобон 4 ролла"}', NULL, 4300, ARRAY[]::varchar[], 1),
('v9-i020', 'v9-c01', 'v9', '{"en": "Combo 4 rolls", "hy": "Կոմբո 4 ռոլ", "ru": "Комбо 4 ролла"}', NULL, 4900, ARRAY[]::varchar[], 2),
('v9-i021', 'v9-c01', 'v9', '{"en": "Bite pack", "hy": "Բայթ փաք", "ru": "Байт пак"}', NULL, 2900, ARRAY[]::varchar[], 3),
('v9-i022', 'v9-c01', 'v9', '{"en": "Classic 9 rolls", "hy": "Դասական 9 ռոլ", "ru": "Классик 9 роллов"}', NULL, 4900, ARRAY[]::varchar[], 4),
('v9-i023', 'v9-c01', 'v9', '{"en": "Chocobon 9 rolls", "hy": "Շոկոբոն 9 ռոլ", "ru": "Шокобон 9 роллов"}', NULL, 5200, ARRAY[]::varchar[], 5),
('v9-i024', 'v9-c01', 'v9', '{"en": "Combo 9 rolls", "hy": "Կոմբո 9 ռոլ", "ru": "Комбо 9 роллов"}', NULL, 5700, ARRAY[]::varchar[], 6);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c02', 'v9', '{"en": "Cinnacakes", "hy": "Սինաքեյքեր", "ru": "Синнакейки"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i025', 'v9-c02', 'v9', '{"en": "Classic (1 floor)", "hy": "Դասական (1 հարկ)", "ru": "Классик (1 ярус)"}', NULL, 7500, ARRAY[]::varchar[], 0),
('v9-i026', 'v9-c02', 'v9', '{"en": "Classic (2 floors)", "hy": "Դասական (2 հարկ)", "ru": "Классик (2 яруса)"}', NULL, 12000, ARRAY[]::varchar[], 1),
('v9-i027', 'v9-c02', 'v9', '{"en": "Choco (1 floor)", "hy": "Շոկո (1 հարկ)", "ru": "Шоко (1 ярус)"}', NULL, 9000, ARRAY[]::varchar[], 2),
('v9-i028', 'v9-c02', 'v9', '{"en": "Choco (2 floors)", "hy": "Շոկո (2 հարկ)", "ru": "Шоко (2 яруса)"}', NULL, 15000, ARRAY[]::varchar[], 3),
('v9-i029', 'v9-c02', 'v9', '{"en": "Pecan (1 floor)", "hy": "Պեկան (1 հարկ)", "ru": "Пекан (1 ярус)"}', NULL, 14000, ARRAY[]::varchar[], 4),
('v9-i030', 'v9-c02', 'v9', '{"en": "Pecan (2 floors)", "hy": "Պեկան (2 հարկ)", "ru": "Пекан (2 яруса)"}', NULL, 19000, ARRAY[]::varchar[], 5),
('v9-i031', 'v9-c02', 'v9', '{"en": "Nutella (1 floor)", "hy": "Նուտելլա (1 հարկ)", "ru": "Нутелла (1 ярус)"}', NULL, 10000, ARRAY[]::varchar[], 6),
('v9-i032', 'v9-c02', 'v9', '{"en": "Nutella (2 floors)", "hy": "Նուտելլա (2 հարկ)", "ru": "Нутелла (2 яруса)"}', NULL, 16000, ARRAY[]::varchar[], 7),
('v9-i033', 'v9-c02', 'v9', '{"en": "Berry (1 floor)", "hy": "Հատապտղային (1 հարկ)", "ru": "Ягодный (1 ярус)"}', NULL, 9000, ARRAY[]::varchar[], 8),
('v9-i034', 'v9-c02', 'v9', '{"en": "Berry (2 floors)", "hy": "Հատապտղային (2 հարկ)", "ru": "Ягодный (2 яруса)"}', NULL, 15000, ARRAY[]::varchar[], 9);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c03', 'v9', '{"en": "Bouquets & Specialty Cakes", "hy": "Փնջեր և Հատուկ Թորթեր", "ru": "Букеты и Специальные Торты"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i035', 'v9-c03', 'v9', '{"en": "Classic Cinnacake", "hy": "Դասական Սինաքեյք", "ru": "Классический Синнакейк"}', NULL, 8500, ARRAY[]::varchar[], 0),
('v9-i036', 'v9-c03', 'v9', '{"en": "Mini Classic Cinnacake", "hy": "Մինի Դասական Սինաքեյք", "ru": "Мини Классический Синнакейк"}', NULL, 6500, ARRAY[]::varchar[], 1),
('v9-i037', 'v9-c03', 'v9', '{"en": "Cinnabon Bouquet “Love”", "hy": "Սինաբոն Փունջ «Սեր»", "ru": "Букет Синнабон «Любовь»"}', NULL, 10500, ARRAY[]::varchar[], 2),
('v9-i038', 'v9-c03', 'v9', '{"en": "Mini Bouquet “Love”", "hy": "Մինի Փունջ «Սեր»", "ru": "Мини Букет «Любовь»"}', NULL, 8500, ARRAY[]::varchar[], 3),
('v9-i039', 'v9-c03', 'v9', '{"en": "Cinnabon Bouquet “Happy Birthday”", "hy": "Սինաբոն Փունջ «Շնորհավոր Ծնունդդ»", "ru": "Букет Синнабон «С Днем Рождения»"}', NULL, 10500, ARRAY[]::varchar[], 4),
('v9-i040', 'v9-c03', 'v9', '{"en": "Mini Bouquet “Happy Birthday”", "hy": "Մինի Փունջ «Շնորհավոր Ծնունդդ»", "ru": "Мини Букет «С Днем Рождения»"}', NULL, 8500, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c04', 'v9', '{"en": "Sandwiches & Savory", "hy": "Սենդվիչներ և Ուտեստներ", "ru": "Сэндвичи и Закуски"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i041', 'v9-c04', 'v9', '{"en": "Ham and cheese sandwich", "hy": "Խոզապուխտով և պանրով սենդվիչ", "ru": "Сэндвич с ветчиной и сыром"}', NULL, 1900, ARRAY[]::varchar[], 0),
('v9-i042', 'v9-c04', 'v9', '{"en": "Chicken Chiabatta sandwich", "hy": "Հավով Չիաբատա սենդվիչ", "ru": "Сэндвич Чиабатта с курицей"}', NULL, 2300, ARRAY[]::varchar[], 1),
('v9-i043', 'v9-c04', 'v9', '{"en": "Caesar sandwich", "hy": "Կեսար սենդվիչ", "ru": "Сэндвич Цезарь"}', NULL, 2300, ARRAY[]::varchar[], 2),
('v9-i044', 'v9-c04', 'v9', '{"en": "Cinna bacon sandwich", "hy": "Սիննա բեկոն սենդվիչ", "ru": "Синна сэндвич с беконом"}', NULL, 2200, ARRAY[]::varchar[], 3),
('v9-i045', 'v9-c04', 'v9', '{"en": "Smoked Cinna sandwich", "hy": "Ապխտած Սիննա սենդվիչ", "ru": "Копченый Синна сэндвич"}', NULL, 2400, ARRAY[]::varchar[], 4),
('v9-i046', 'v9-c04', 'v9', '{"en": "Chicken panini", "hy": "Հավով պանինի", "ru": "Панини с курицей"}', NULL, 2400, ARRAY[]::varchar[], 5),
('v9-i047', 'v9-c04', 'v9', '{"en": "Beef panini", "hy": "Տավարի մսով պանինի", "ru": "Панини с говядиной"}', NULL, 2700, ARRAY[]::varchar[], 6),
('v9-i048', 'v9-c04', 'v9', '{"en": "Cinna beef burger", "hy": "Սիննա տավարի մսով բուրգեր", "ru": "Синна бургер с говядиной"}', NULL, 3800, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c05', 'v9', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i049', 'v9-c05', 'v9', '{"en": "Greek salad", "hy": "Հունական աղցան", "ru": "Греческий салат"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v9-i050', 'v9-c05', 'v9', '{"en": "Caesar salad", "hy": "Կեսար աղցան", "ru": "Салат Цезарь"}', NULL, 3100, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c06', 'v9', '{"en": "Kids Menu", "hy": "Մանկական մենյու", "ru": "Детское меню"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i051', 'v9-c06', 'v9', '{"en": "Bear burger", "hy": "Արջուկ բուրգեր", "ru": "Мишка бургер"}', NULL, 1700, ARRAY[]::varchar[], 0),
('v9-i052', 'v9-c06', 'v9', '{"en": "Ham and cheese sandwich", "hy": "Խոզապուխտով և պանրով սենդվիչ", "ru": "Сэндвич с ветчиной и сыром (детский)"}', NULL, 1600, ARRAY[]::varchar[], 1),
('v9-i053', 'v9-c06', 'v9', '{"en": "Chicken nuggets with french fries", "hy": "Հավի նագեթս ֆրիով", "ru": "Куриные наггетсы с картофелем фри"}', NULL, 1700, ARRAY[]::varchar[], 2),
('v9-i054', 'v9-c06', 'v9', '{"en": "Kids pizza", "hy": "Մանկական պիցցա", "ru": "Детская пицца"}', NULL, 1800, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v9-c07', 'v9', '{"en": "Beverages", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v9-i055', 'v9-c07', 'v9', '{"en": "Water (Bjni/Noy 0.5l)", "hy": "Ջուր (Բջնի/Նոյ 0.5լ)", "ru": "Вода (Бжни/Ной 0,5л)"}', NULL, 600, ARRAY[]::varchar[], 0),
('v9-i056', 'v9-c07', 'v9', '{"en": "Soft Drinks (Coke/Fanta/Sprite 0.25l)", "hy": "Զովացուցիչ ըմպելիքներ (Կոկա-Կոլա/Ֆանտա/Սպրայտ 0.25լ)", "ru": "Газированные напитки (Кола/Фанта/Спрайт 0,25л)"}', NULL, 700, ARRAY[]::varchar[], 1),
('v9-i057', 'v9-c07', 'v9', '{"en": "Red Bull", "hy": "Ռեդ Բուլ", "ru": "Ред Булл"}', NULL, 1500, ARRAY[]::varchar[], 2),
('v9-i058', 'v9-c07', 'v9', '{"en": "Espresso", "hy": "Էսպրեսո", "ru": "Эспрессо"}', NULL, 1100, ARRAY[]::varchar[], 3),
('v9-i059', 'v9-c07', 'v9', '{"en": "Double Espresso", "hy": "Կրկնակի Էսպրեսո", "ru": "Двойной Эспрессо"}', NULL, 1700, ARRAY[]::varchar[], 4),
('v9-i060', 'v9-c07', 'v9', '{"en": "Americano", "hy": "Ամերիկանո", "ru": "Американо"}', NULL, 1200, ARRAY[]::varchar[], 5),
('v9-i061', 'v9-c07', 'v9', '{"en": "Cappuccino", "hy": "Կապուչինո", "ru": "Капучино"}', NULL, 1700, ARRAY[]::varchar[], 6),
('v9-i062', 'v9-c07', 'v9', '{"en": "Latte / Mocha", "hy": "Լատտե / Մոկկո", "ru": "Латте / Мокко"}', NULL, 1800, ARRAY[]::varchar[], 7);

-- ═══ Espress It (v10) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v10', 'Espress It', 'espress-it',
 '{"en": "Espress It — a popular restaurant in Yerevan."}',
 ARRAY['Coffee','Cafe','Breakfast'], 1, 4.5, 89,
 'Sayat-Nova Ave 16, Yerevan 0001', 40.1868, 44.5142, '+374 10 585858',
 ARRAY['WiFi','Outdoor Seating','Takeout'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v10', 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800', 0),
('v10', 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800', 1),
('v10', 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v10', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v10-z1', 'v10', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v10-z2', 'v10', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v10-t1', 'v10', 'v10-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v10-t2', 'v10', 'v10-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v10-t3', 'v10', 'v10-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v10-t4', 'v10', 'v10-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v10-t5', 'v10', 'v10-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v10-t6', 'v10', 'v10-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000010', 'v10', 'Espress It Admin', 'admin-espressit@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 585858', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c00', 'v10', '{"en": "Breakfast Plates", "hy": "Նախաճաշի ափսե", "ru": "Тарелки для завтрака"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i001', 'v10-c00', 'v10', '{"en": "American Breakfast", "hy": "Ամերիկյան նախաճաշ", "ru": "Американский завтрак"}', NULL, 2500, ARRAY[]::varchar[], 0),
('v10-i002', 'v10-c00', 'v10', '{"en": "English Breakfast", "hy": "Անգլիական նախաճաշ", "ru": "Английский завтрак"}', NULL, 3200, ARRAY[]::varchar[], 1),
('v10-i003', 'v10-c00', 'v10', '{"en": "French Breakfast", "hy": "Ֆրանսիական նախաճաշ", "ru": "Французский завтрак"}', NULL, 1800, ARRAY[]::varchar[], 2),
('v10-i004', 'v10-c00', 'v10', '{"en": "Croissant with Cherry Jam", "hy": "Կրուասան բալի ջեմով", "ru": "Круассан с вишневым джемом"}', NULL, 1300, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c01', 'v10', '{"en": "Egg Dishes", "hy": "Նախաճաշ ձվով", "ru": "Блюда из яиц"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i005', 'v10-c01', 'v10', '{"en": "Scramble with Cheese", "hy": "Սքրամբլ պանրով", "ru": "Скрамбл с сыром"}', NULL, 1800, ARRAY[]::varchar[], 0),
('v10-i006', 'v10-c01', 'v10', '{"en": "Scramble with Bacon", "hy": "Սքրամբլ բեկոնով", "ru": "Скрамбл с беконом"}', NULL, 1900, ARRAY[]::varchar[], 1),
('v10-i007', 'v10-c01', 'v10', '{"en": "Scramble with Salmon", "hy": "Սքրամբլ սաղմոնով", "ru": "Скрамбл с лососем"}', '{"en": "300g, Hokkaido bread, avocado", "hy": "300գ, Հոկայդո հաց, ավոկադո", "ru": "300г, хлеб Хоккайдо, авокадо"}', 3500, ARRAY[]::varchar[], 2),
('v10-i008', 'v10-c01', 'v10', '{"en": "Omelet with Cheese", "hy": "Օմլետ պանրով", "ru": "Омлет с сыром"}', NULL, 2400, ARRAY[]::varchar[], 3),
('v10-i009', 'v10-c01', 'v10', '{"en": "Omelet with Mortadella", "hy": "Օմլետ մորտադելայով", "ru": "Омлет с мортаделлой"}', NULL, 2600, ARRAY[]::varchar[], 4),
('v10-i010', 'v10-c01', 'v10', '{"en": "Benedict with Mortadella", "hy": "Բենեդիկտ մորտադելայով", "ru": "Бенедикт с мортаделлой"}', NULL, 2700, ARRAY[]::varchar[], 5),
('v10-i011', 'v10-c01', 'v10', '{"en": "Benedict with Salmon", "hy": "Բենեդիկտ սաղմոնով", "ru": "Бенедикт с лососем"}', NULL, 3900, ARRAY[]::varchar[], 6);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c02', 'v10', '{"en": "Main Dishes", "hy": "Հիմնական ուտեստներ", "ru": "Основные блюда"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i012', 'v10-c02', 'v10', '{"en": "Chicken Breast with Bulgur", "hy": "Հավի կրծքամիս բլղուրով", "ru": "Куриная грудка с булгуром"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v10-i013', 'v10-c02', 'v10', '{"en": "Tenderloin", "hy": "Տավարի փափկամիս", "ru": "Вырезка"}', NULL, 4900, ARRAY[]::varchar[], 1),
('v10-i014', 'v10-c02', 'v10', '{"en": "Teriyaki Chicken", "hy": "Թերիյակի հավ", "ru": "Курица терияки"}', NULL, 3100, ARRAY[]::varchar[], 2),
('v10-i015', 'v10-c02', 'v10', '{"en": "Curry Chicken", "hy": "Կարրի հավ", "ru": "Курица карри"}', NULL, 2800, ARRAY[]::varchar[], 3),
('v10-i016', 'v10-c02', 'v10', '{"en": "Mushroom Risotto", "hy": "Սնկով ռիզոտո", "ru": "Грибное ризотто"}', NULL, 2900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c03', 'v10', '{"en": "Pizza", "hy": "Պիցցա", "ru": "Пицца"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i017', 'v10-c03', 'v10', '{"en": "Margherita", "hy": "Մարգարիտա", "ru": "Маргарита"}', NULL, 2100, ARRAY[]::varchar[], 0),
('v10-i018', 'v10-c03', 'v10', '{"en": "Pepperoni", "hy": "Պեպերոնի", "ru": "Пепперони"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v10-i019', 'v10-c03', 'v10', '{"en": "Classic Cheese", "hy": "Դասական պանրով", "ru": "Классическая сырная"}', NULL, 2500, ARRAY[]::varchar[], 2),
('v10-i020', 'v10-c03', 'v10', '{"en": "Mushroom and Truffle", "hy": "Սնկով և տրյուֆելով", "ru": "Грибная с трюфелем"}', NULL, 3900, ARRAY[]::varchar[], 3),
('v10-i021', 'v10-c03', 'v10', '{"en": "Mortadella", "hy": "Մորտադելա", "ru": "Мортаделла"}', NULL, 2900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c04', 'v10', '{"en": "Pasta & Lasagna", "hy": "Պաստա և Լազանյա", "ru": "Паста и Лазанья"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i022', 'v10-c04', 'v10', '{"en": "Carbonara", "hy": "Կարբոնարա", "ru": "Карбонара"}', NULL, 2500, ARRAY[]::varchar[], 0),
('v10-i023', 'v10-c04', 'v10', '{"en": "Al Arrabiata with Chicken", "hy": "Ալ Արաբիատա հավի մսով", "ru": "Алль Аррабиата с курицей"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v10-i024', 'v10-c04', 'v10', '{"en": "Four Cheese", "hy": "Չորս պանիր", "ru": "Четыре сыра"}', NULL, 2600, ARRAY[]::varchar[], 2),
('v10-i025', 'v10-c04', 'v10', '{"en": "Bolognese", "hy": "Բոլոնյեզե", "ru": "Болоньезе"}', NULL, 2300, ARRAY[]::varchar[], 3),
('v10-i026', 'v10-c04', 'v10', '{"en": "Lasagna", "hy": "Լազանյա", "ru": "Лазанья"}', NULL, 2300, ARRAY[]::varchar[], 4),
('v10-i027', 'v10-c04', 'v10', '{"en": "Mushroom and Truffle Lasagna", "hy": "Սնկով և տրյուֆելով լազանյա", "ru": "Лазанья с грибами и трюфелем"}', NULL, 2900, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c05', 'v10', '{"en": "Sandwiches", "hy": "Սենդվիչներ", "ru": "Сэндвичи"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i028', 'v10-c05', 'v10', '{"en": "Paprika Feta", "hy": "Պապրիկա Ֆետա", "ru": "Паприка Фета"}', NULL, 2100, ARRAY[]::varchar[], 0),
('v10-i029', 'v10-c05', 'v10', '{"en": "Crispy Chicken", "hy": "Խրթխրթան հավ", "ru": "Хрустящая курица"}', NULL, 2300, ARRAY[]::varchar[], 1),
('v10-i030', 'v10-c05', 'v10', '{"en": "Ham", "hy": "Խոզապուխտ", "ru": "Ветчина"}', NULL, 1800, ARRAY[]::varchar[], 2),
('v10-i031', 'v10-c05', 'v10', '{"en": "Roast Beef", "hy": "Ռոստբիֆ", "ru": "Ростбиф"}', NULL, 2900, ARRAY[]::varchar[], 3),
('v10-i032', 'v10-c05', 'v10', '{"en": "Salmon", "hy": "Սաղմոն", "ru": "Лосось"}', NULL, 3200, ARRAY[]::varchar[], 4),
('v10-i033', 'v10-c05', 'v10', '{"en": "Tuna", "hy": "Թյունոս", "ru": "Тунец"}', NULL, 3200, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c06', 'v10', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i034', 'v10-c06', 'v10', '{"en": "Tabule", "hy": "Թաբուլե", "ru": "Табуле"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v10-i035', 'v10-c06', 'v10', '{"en": "Teriyaki Chicken", "hy": "Թերիյակի հավ", "ru": "Курица терияки"}', NULL, 2100, ARRAY[]::varchar[], 1),
('v10-i036', 'v10-c06', 'v10', '{"en": "Crispy Caesar", "hy": "Խրթխրթան Կեսար", "ru": "Хрустящий Цезарь"}', NULL, 2800, ARRAY[]::varchar[], 2),
('v10-i037', 'v10-c06', 'v10', '{"en": "Greek Salad", "hy": "Հունական աղցան", "ru": "Греческий салат"}', NULL, 2800, ARRAY[]::varchar[], 3),
('v10-i038', 'v10-c06', 'v10', '{"en": "Roast Beef Salad", "hy": "Ռոստբիֆ աղցան", "ru": "Салат с ростбифом"}', NULL, 3500, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c07', 'v10', '{"en": "Garnishes & Soups", "hy": "Խավարտներ և Ապուրներ", "ru": "Гарниры и Супы"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i039', 'v10-c07', 'v10', '{"en": "Mashed Potatoes / Rice", "hy": "Կարտոֆիլի պյուրե / Բրինձ", "ru": "Картофельное пюре / Рис"}', NULL, 900, ARRAY[]::varchar[], 0),
('v10-i040', 'v10-c07', 'v10', '{"en": "Country Style Potatoes", "hy": "Գյուղական կարտոֆիլ", "ru": "Картофель по-деревенски"}', NULL, 950, ARRAY[]::varchar[], 1),
('v10-i041', 'v10-c07', 'v10', '{"en": "French Fries", "hy": "Ֆրի", "ru": "Картофель фри"}', NULL, 1300, ARRAY[]::varchar[], 2),
('v10-i042', 'v10-c07', 'v10', '{"en": "Chicken Noodle Soup", "hy": "Հավով լապշայով ապուր", "ru": "Куриный суп с лапшой"}', NULL, 1700, ARRAY[]::varchar[], 3),
('v10-i043', 'v10-c07', 'v10', '{"en": "Pumpkin Cream Soup", "hy": "Դդմի կրեմ-ապուր", "ru": "Тыквенный крем-суп"}', NULL, 1400, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c08', 'v10', '{"en": "Crepes & Croissants", "hy": "Բլիթներ և Կրուասաններ", "ru": "Блины и Круассаны"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i044', 'v10-c08', 'v10', '{"en": "Crepe (Ham & Cheese / Banana & Nutella)", "hy": "Բլիթ (Խոզապուխտ և պանիր / Բանան և Նուտելլա)", "ru": "Блинчик (Ветчина и сыр / Банан и Нутелла)"}', NULL, 1800, ARRAY[]::varchar[], 0),
('v10-i045', 'v10-c08', 'v10', '{"en": "Crepe (Cottage Cheese)", "hy": "Բլիթ (Կաթնաշոռով)", "ru": "Блинчик (Творог)"}', NULL, 1400, ARRAY[]::varchar[], 1),
('v10-i046', 'v10-c08', 'v10', '{"en": "Crepe (Salted Caramel)", "hy": "Բլիթ (Աղի կարամել)", "ru": "Блинчик (Соленая карамель)"}', NULL, 1600, ARRAY[]::varchar[], 2),
('v10-i047', 'v10-c08', 'v10', '{"en": "Croissant (Classic)", "hy": "Կրուասան (Դասական)", "ru": "Круассан (Классический)"}', NULL, 900, ARRAY[]::varchar[], 3),
('v10-i048', 'v10-c08', 'v10', '{"en": "Croissant (Raisin / Three Chocolates)", "hy": "Կրուասան (Չամիչ / Երեք շոկոլադ)", "ru": "Круассан (Изюм / Три шоколада)"}', NULL, 1100, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c09', 'v10', '{"en": "Desserts", "hy": "Աղանդեր", "ru": "Десерты"}', 9);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i049', 'v10-c09', 'v10', '{"en": "San Sebastian Cheesecake", "hy": "Սան Սեբաստիան չիզքեյք", "ru": "Чизкейк Сан-Себастьян"}', '{"en": "Pistachio: 3,400 AMD", "hy": "Պիստակով: 3,400 AMD", "ru": "Фисташковый: 3,400 AMD"}', 2900, ARRAY[]::varchar[], 0),
('v10-i050', 'v10-c09', 'v10', '{"en": "Cheesecake (Blueberry / Oreo / Raffaello / Fruit)", "hy": "Չիզքեյք (Հապալաս / Օրեո / Ռաֆայելլո / Մրգային)", "ru": "Чизкейк (Черника / Орео / Раффаэлло / Фруктовый)"}', NULL, 2200, ARRAY[]::varchar[], 1),
('v10-i051', 'v10-c09', 'v10', '{"en": "Tiramisu", "hy": "Տիրամիսու", "ru": "Тирамису"}', '{"en": "Pistachio: 2,900 AMD", "hy": "Պիստակով: 2,900 AMD", "ru": "Фисташковый: 2,900 AMD"}', 2250, ARRAY[]::varchar[], 2),
('v10-i052', 'v10-c09', 'v10', '{"en": "Cakes (Chocolate / Red Velvet / Carrot & Walnut)", "hy": "Տորթեր (Շոկոլադե / Ռեդ Վելվետ / Գազարով և ընկույզով)", "ru": "Торты (Шоколадный / Красный бархат / Морковный с орехом)"}', NULL, 1900, ARRAY[]::varchar[], 3),
('v10-i053', 'v10-c09', 'v10', '{"en": "Tarts & Pastries (Strawberry Tart / Apple Strudel / Eclair)", "hy": "Տարտեր և թխվածքներ (Ելակի տարտ / Խնձորի շտրուդել / Էկլեր)", "ru": "Тарты и выпечка (Клубничный тарт / Яблочный штрудель / Эклер)"}', NULL, 1900, ARRAY[]::varchar[], 4),
('v10-i054', 'v10-c09', 'v10', '{"en": "Small Bites (Macaron / Truffle / Cookie)", "hy": "Փոքրիկ քաղցրավենիք (Մակարոն / Տրյուֆել / Թխվածքաբլիթ)", "ru": "Маленькие закуски (Макарон / Трюфель / Печенье)"}', NULL, 400, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v10-c10', 'v10', '{"en": "Coffee", "hy": "Սուրճ", "ru": "Кофе"}', 10);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v10-i055', 'v10-c10', 'v10', '{"en": "Espresso", "hy": "Էսպրեսսո", "ru": "Эспрессо"}', '{"en": "300ml / 400ml", "hy": "300մլ / 400մլ", "ru": "300мл / 400мл"}', 900, ARRAY[]::varchar[], 0),
('v10-i056', 'v10-c10', 'v10', '{"en": "Americano", "hy": "Ամերիկանո", "ru": "Американо"}', '{"en": "300ml / 400ml", "hy": "300մլ / 400մլ", "ru": "300мл / 400мл"}', 1200, ARRAY[]::varchar[], 1),
('v10-i057', 'v10-c10', 'v10', '{"en": "Cappuccino", "hy": "Կապուչինո", "ru": "Капучино"}', '{"en": "300ml / 400ml", "hy": "300մլ / 400մլ", "ru": "300мл / 400мл"}', 1400, ARRAY[]::varchar[], 2),
('v10-i058', 'v10-c10', 'v10', '{"en": "Latte", "hy": "Լատտե", "ru": "Латте"}', '{"en": "300ml / 400ml", "hy": "300մլ / 400մլ", "ru": "300мл / 400мл"}', 1500, ARRAY[]::varchar[], 3),
('v10-i059', 'v10-c10', 'v10', '{"en": "Flat White", "hy": "Ֆլեթ Ուայթ", "ru": "Флэт Уайт"}', '{"en": "300ml / 400ml", "hy": "300մլ / 400մլ", "ru": "300мл / 400мл"}', 1500, ARRAY[]::varchar[], 4),
('v10-i060', 'v10-c10', 'v10', '{"en": "Bumble Coffee (300ml)", "hy": "Բամբլ սուրճ (300մլ)", "ru": "Бамбл кофе (300мл)"}', NULL, 2000, ARRAY[]::varchar[], 5);

-- ═══ InTempo (v11) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v11', 'InTempo', 'intempo',
 '{"en": "InTempo — a popular restaurant in Yerevan."}',
 ARRAY['European','Fine Dining','Wine'], 3, 4.6, 112,
 'Pushkin St 4, Yerevan 0002', 40.1822, 44.5118, '+374 10 595959',
 ARRAY['WiFi','Air Conditioning','Valet Parking','Live Music'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v11', 'https://images.unsplash.com/photo-1550966871-3ed3cdb51f3a?w=800', 0),
('v11', 'https://images.unsplash.com/photo-1424847651672-bf20a4b0982b?w=800', 1),
('v11', 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v11', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v11-z1', 'v11', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v11-z2', 'v11', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v11-t1', 'v11', 'v11-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v11-t2', 'v11', 'v11-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v11-t3', 'v11', 'v11-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v11-t4', 'v11', 'v11-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v11-t5', 'v11', 'v11-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v11-t6', 'v11', 'v11-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000011', 'v11', 'InTempo Admin', 'admin-intempo@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 595959', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c00', 'v11', '{"en": "Lent Menu", "hy": "Պահքի մենյու", "ru": "Постное меню"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i001', 'v11-c00', 'v11', '{"en": "Lent Bruschetta with Avocado & Cherry Tomatoes", "hy": "Պահքի բրուսկետա ավոկադոյով և չերի լոլիկներով", "ru": "Постная брускетта с авокадо и черри"}', NULL, 2600, ARRAY[]::varchar[], 0),
('v11-i002', 'v11-c00', 'v11', '{"en": "Lent Salad with Quinoa & Avocado", "hy": "Պահքի աղցան քինոայով և ավոկադոյով", "ru": "Постный салат с киноа и авокадо"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v11-i003', 'v11-c00', 'v11', '{"en": "Lent Greek Salad", "hy": "Պահքի հունական աղցան", "ru": "Постный греческий салат"}', '{"en": "Cucumber, kalamata/green olives, bell pepper, marinated onion, basil", "hy": "Վարունգ, կալամատա/կանաչ ձիթապտուղ, պղպեղ, մարինացված սոխ, ռեհան", "ru": "Огурец, оливки каламата/зеленые, болгарский перец, маринованный лук, базилик"}', 2700, ARRAY[]::varchar[], 2),
('v11-i004', 'v11-c00', 'v11', '{"en": "Lent Pizza with Avocado", "hy": "Պահքի պիցցա ավոկադոյով", "ru": "Постная пицца с авокадо"}', NULL, 2900, ARRAY[]::varchar[], 3),
('v11-i005', 'v11-c00', 'v11', '{"en": "Lent Pizza with Eggplant", "hy": "Պահքի պիցցա սմբուկով", "ru": "Постная пицца с баклажанами"}', NULL, 2400, ARRAY[]::varchar[], 4),
('v11-i006', 'v11-c00', 'v11', '{"en": "Lent Club Sandwich", "hy": "Պահքի քլաբ սենդվիչ", "ru": "Постный клаб-сэндвич"}', NULL, 2600, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c01', 'v11', '{"en": "Breakfast", "hy": "Նախաճաշ", "ru": "Завтрак"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i007', 'v11-c01', 'v11', '{"en": "Classic Croissant", "hy": "Դասական կրուասան", "ru": "Классический круассан"}', NULL, 900, ARRAY[]::varchar[], 0),
('v11-i008', 'v11-c01', 'v11', '{"en": "Croissant with Nutella", "hy": "Կրուասան նուտելայով", "ru": "Круассан с нутеллой"}', NULL, 1200, ARRAY[]::varchar[], 1),
('v11-i009', 'v11-c01', 'v11', '{"en": "Croissant with Pistachio Cream", "hy": "Կրուասան պիստակի կրեմով", "ru": "Круассан с фисташковым кремом"}', NULL, 1500, ARRAY[]::varchar[], 2),
('v11-i010', 'v11-c01', 'v11', '{"en": "Croissant with Olympia Cream", "hy": "Կրուասան Օլիմպիա կրեմով", "ru": "Круассан с кремом Олимпия"}', NULL, 1300, ARRAY[]::varchar[], 3),
('v11-i011', 'v11-c01', 'v11', '{"en": "Armenian Tomato Omelet", "hy": "Հայկական ձվածեղ լոլիկով", "ru": "Армянский омлет с помидорами"}', NULL, 2300, ARRAY[]::varchar[], 4),
('v11-i012', 'v11-c01', 'v11', '{"en": "English Breakfast", "hy": "Անգլիական նախաճաշ", "ru": "Английский завтрак"}', NULL, 3600, ARRAY[]::varchar[], 5),
('v11-i013', 'v11-c01', 'v11', '{"en": "Waffle with Brand Cream", "hy": "Վաֆլի ֆիրմային կրեմով", "ru": "Вафли с фирменным кремом"}', NULL, 2100, ARRAY[]::varchar[], 6),
('v11-i014', 'v11-c01', 'v11', '{"en": "Waffle with Pistachio Cream", "hy": "Վաֆլի պիստակի կրեմով", "ru": "Вафли с фисташковым кремом"}', NULL, 2200, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c02', 'v11', '{"en": "Pizza", "hy": "Պիցցա", "ru": "Пицца"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i015', 'v11-c02', 'v11', '{"en": "Margherita", "hy": "Մարգարիտա", "ru": "Маргарита"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v11-i016', 'v11-c02', 'v11', '{"en": "Basil Pistachio", "hy": "Ռեհան Պիստակ", "ru": "Базилик Фисташка"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v11-i017', 'v11-c02', 'v11', '{"en": "Dolce", "hy": "Դոլչե", "ru": "Дольче"}', NULL, 2900, ARRAY[]::varchar[], 2),
('v11-i018', 'v11-c02', 'v11', '{"en": "Vegetable", "hy": "Բանջարեղենային", "ru": "Овощная"}', NULL, 3300, ARRAY[]::varchar[], 3),
('v11-i019', 'v11-c02', 'v11', '{"en": "Diavola", "hy": "Դիավոլա", "ru": "Диавола"}', NULL, 3600, ARRAY[]::varchar[], 4),
('v11-i020', 'v11-c02', 'v11', '{"en": "Pepperoni", "hy": "Պեպերոնի", "ru": "Пепперони"}', NULL, 3600, ARRAY[]::varchar[], 5),
('v11-i021', 'v11-c02', 'v11', '{"en": "Picante", "hy": "Պիկանտե", "ru": "Пиканте"}', NULL, 3600, ARRAY[]::varchar[], 6),
('v11-i022', 'v11-c02', 'v11', '{"en": "Al Pollo", "hy": "Ալ Պոլլո", "ru": "Аль Полло"}', NULL, 3700, ARRAY[]::varchar[], 7),
('v11-i023', 'v11-c02', 'v11', '{"en": "Lazio", "hy": "Լացիո", "ru": "Лацио"}', NULL, 3800, ARRAY[]::varchar[], 8),
('v11-i024', 'v11-c02', 'v11', '{"en": "Pepperoni with Mascarpone", "hy": "Պեպերոնի մասկարպոնեով", "ru": "Пепперони с маскарпоне"}', NULL, 3900, ARRAY[]::varchar[], 9),
('v11-i025', 'v11-c02', 'v11', '{"en": "Mortadella & Pistachio", "hy": "Մորտադելլա և պիստակ", "ru": "Мортаделла и фисташки"}', NULL, 3900, ARRAY[]::varchar[], 10),
('v11-i026', 'v11-c02', 'v11', '{"en": "4 Cheese", "hy": "4 պանիր", "ru": "4 сыра"}', NULL, 3900, ARRAY[]::varchar[], 11),
('v11-i027', 'v11-c02', 'v11', '{"en": "Al Tartufo", "hy": "Ալ Տարտուֆո", "ru": "Аль Тартуфо"}', NULL, 3900, ARRAY[]::varchar[], 12),
('v11-i028', 'v11-c02', 'v11', '{"en": "Tuscana", "hy": "Տոսկանա", "ru": "Тоскана"}', NULL, 3900, ARRAY[]::varchar[], 13),
('v11-i029', 'v11-c02', 'v11', '{"en": "Caprese", "hy": "Կապրեզե", "ru": "Капрезе"}', NULL, 3900, ARRAY[]::varchar[], 14),
('v11-i030', 'v11-c02', 'v11', '{"en": "Prosciutto & Arugula", "hy": "Պրոշուտո և ռուկոլա", "ru": "Прошутто и руккола"}', NULL, 4600, ARRAY[]::varchar[], 15),
('v11-i031', 'v11-c02', 'v11', '{"en": "Viennese", "hy": "Վիեննական", "ru": "Венская"}', NULL, 4600, ARRAY[]::varchar[], 16),
('v11-i032', 'v11-c02', 'v11', '{"en": "Dolce Pistachio", "hy": "Դոլչե Պիստակ", "ru": "Дольче Фисташка"}', NULL, 3100, ARRAY[]::varchar[], 17);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c03', 'v11', '{"en": "Pinsere", "hy": "Պինցերե", "ru": "Пинчере"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i033', 'v11-c03', 'v11', '{"en": "Margherita", "hy": "Մարգարիտա", "ru": "Маргарита"}', NULL, 1600, ARRAY[]::varchar[], 0),
('v11-i034', 'v11-c03', 'v11', '{"en": "Pepperoni", "hy": "Պեպերոնի", "ru": "Пепперони"}', NULL, 1700, ARRAY[]::varchar[], 1),
('v11-i035', 'v11-c03', 'v11', '{"en": "Pancetta Mix", "hy": "Պանչետա միքս", "ru": "Панчетта микс"}', NULL, 1900, ARRAY[]::varchar[], 2),
('v11-i036', 'v11-c03', 'v11', '{"en": "Crudo Mix", "hy": "Կրուդո միքս", "ru": "Крудо микс"}', NULL, 1900, ARRAY[]::varchar[], 3),
('v11-i037', 'v11-c03', 'v11', '{"en": "Speziata", "hy": "Սպեցիատա", "ru": "Специата"}', NULL, 1900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c04', 'v11', '{"en": "Sandwiches & Burgers", "hy": "Սենդվիչներ և բուրգերներ", "ru": "Сэндвичи и бургеры"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i038', 'v11-c04', 'v11', '{"en": "Piadina Mortadella", "hy": "Պիադինա Մորտադելլա", "ru": "Пиадина Мортаделла"}', NULL, 2500, ARRAY[]::varchar[], 0),
('v11-i039', 'v11-c04', 'v11', '{"en": "Piadina Exclusive", "hy": "Պիադինա Էքսկլյուզիվ", "ru": "Пиадина Эксклюзив"}', NULL, 2500, ARRAY[]::varchar[], 1),
('v11-i040', 'v11-c04', 'v11', '{"en": "Piadina Prosciutto", "hy": "Պիադինա Պրոշուտո", "ru": "Пиадина Прошутто"}', NULL, 3100, ARRAY[]::varchar[], 2),
('v11-i041', 'v11-c04', 'v11', '{"en": "Crispy Chicken Burger", "hy": "Քրիսփի հավով բուրգեր", "ru": "Бургер с хрустящей курицей"}', NULL, 3100, ARRAY[]::varchar[], 3),
('v11-i042', 'v11-c04', 'v11', '{"en": "Pulled Pork Burger", "hy": "Պուլդ փորք բուրգեր", "ru": "Бургер с рваной свининой"}', NULL, 3500, ARRAY[]::varchar[], 4),
('v11-i043', 'v11-c04', 'v11', '{"en": "Unique Burger", "hy": "Յունիկ բուրգեր", "ru": "Уникальный бургер"}', NULL, 3900, ARRAY[]::varchar[], 5),
('v11-i044', 'v11-c04', 'v11', '{"en": "InTempo Burger", "hy": "ԻնՏեմպո բուրգեր", "ru": "ИнТемпо бургер"}', NULL, 3900, ARRAY[]::varchar[], 6),
('v11-i045', 'v11-c04', 'v11', '{"en": "Signature Crispy Club Sandwich", "hy": "Ֆիրմային քրիսփի քլաբ սենդվիչ", "ru": "Фирменный хрустящий клаб-сэндвич"}', NULL, 3100, ARRAY[]::varchar[], 7),
('v11-i046', 'v11-c04', 'v11', '{"en": "Classic Club Sandwich", "hy": "Դասական քլաբ սենդվիչ", "ru": "Классический клаб-сэндвич"}', NULL, 3500, ARRAY[]::varchar[], 8),
('v11-i047', 'v11-c04', 'v11', '{"en": "Neapolitan Sandwich Pancetta", "hy": "Նեապոլիտանական սենդվիչ Պանչետա", "ru": "Неаполитанский сэндвич Панчетта"}', NULL, 2400, ARRAY[]::varchar[], 9),
('v11-i048', 'v11-c04', 'v11', '{"en": "Neapolitan Sandwich Mortadella", "hy": "Նեապոլիտանական սենդվիչ Մորտադելլա", "ru": "Неаполитанский сэндвич Мортаделла"}', NULL, 2700, ARRAY[]::varchar[], 10),
('v11-i049', 'v11-c04', 'v11', '{"en": "Neapolitan Sandwich Prosciutto & Parmesan", "hy": "Նեապոլիտանական սենդվիչ Պրոշուտո և Պարմեզան", "ru": "Неаполитанский сэндвич Прошутто и Пармезан"}', NULL, 2800, ARRAY[]::varchar[], 11),
('v11-i050', 'v11-c04', 'v11', '{"en": "Panino Milano", "hy": "Պանինո Միլանո", "ru": "Панино Милано"}', NULL, 2300, ARRAY[]::varchar[], 12),
('v11-i051', 'v11-c04', 'v11', '{"en": "Panino Mortadella", "hy": "Պանինո Մորտադելլա", "ru": "Панино Мортаделла"}', NULL, 2400, ARRAY[]::varchar[], 13),
('v11-i052', 'v11-c04', 'v11', '{"en": "Panino Crudo", "hy": "Պանինո Կրուդո", "ru": "Панино Крудо"}', NULL, 2500, ARRAY[]::varchar[], 14);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c05', 'v11', '{"en": "Main Dishes", "hy": "Գլխավոր ուտեստներ", "ru": "Основные блюда"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i053', 'v11-c05', 'v11', '{"en": "Chicken Breast Citrus", "hy": "Հավի կրծքամիս ցիտրուսով", "ru": "Куриная грудка цитрус"}', NULL, 2800, ARRAY[]::varchar[], 0),
('v11-i054', 'v11-c05', 'v11', '{"en": "Chicken Steak Mushroom", "hy": "Հավի սթեյք սնկով", "ru": "Куриный стейк с грибами"}', NULL, 3600, ARRAY[]::varchar[], 1),
('v11-i055', 'v11-c05', 'v11', '{"en": "Tuscan Pork Ribs", "hy": "Տոսկանական խոզի կողիկներ", "ru": "Тосканские свиные ребрышки"}', NULL, 3800, ARRAY[]::varchar[], 2),
('v11-i056', 'v11-c05', 'v11', '{"en": "Signature Pork Steak", "hy": "Ֆիրմային խոզի սթեյք", "ru": "Фирменный свиной стейк"}', NULL, 4600, ARRAY[]::varchar[], 3),
('v11-i057', 'v11-c05', 'v11', '{"en": "Mignon Steak", "hy": "Մինյոն սթեյք", "ru": "Стейк миньон"}', NULL, 5900, ARRAY[]::varchar[], 4),
('v11-i058', 'v11-c05', 'v11', '{"en": "BBQ Ribs", "hy": "BBQ կողիկներ", "ru": "Ребрышки барбекю"}', NULL, 6200, ARRAY[]::varchar[], 5),
('v11-i059', 'v11-c05', 'v11', '{"en": "Salmon Steak", "hy": "Սաղմոնի սթեյք", "ru": "Стейк из лосося"}', NULL, 7100, ARRAY[]::varchar[], 6);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c06', 'v11', '{"en": "Pasta & Risotto", "hy": "Պաստա և ռիզոտո", "ru": "Паста и ризотто"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i060', 'v11-c06', 'v11', '{"en": "Orzo Carbonara", "hy": "Օրզո Կարբոնարա", "ru": "Орзо Карбонара"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v11-i061', 'v11-c06', 'v11', '{"en": "Fettuccine Marinara", "hy": "Ֆետուչինի Մարինարա", "ru": "Феттуччине Маринара"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v11-i062', 'v11-c06', 'v11', '{"en": "Gnocchi Pesto", "hy": "Նյոկի պեստոյով", "ru": "Ньокки с песто"}', NULL, 2900, ARRAY[]::varchar[], 2),
('v11-i063', 'v11-c06', 'v11', '{"en": "Fettuccine Alfredo", "hy": "Ֆետուչինի Ալֆրեդո", "ru": "Феттуччине Альфредо"}', NULL, 3100, ARRAY[]::varchar[], 3),
('v11-i064', 'v11-c06', 'v11', '{"en": "Fettuccine Formaggi", "hy": "Ֆետուչինի ֆորմաջի", "ru": "Феттуччине Формаджи"}', NULL, 3200, ARRAY[]::varchar[], 4),
('v11-i065', 'v11-c06', 'v11', '{"en": "Fettuccine Bolognese", "hy": "Ֆետուչինի Բոլոնյեզե", "ru": "Феттуччине Болоньезе"}', NULL, 3300, ARRAY[]::varchar[], 5),
('v11-i066', 'v11-c06', 'v11', '{"en": "Pasta Viennese", "hy": "Վիեննական պաստա", "ru": "Паста по-венски"}', NULL, 4300, ARRAY[]::varchar[], 6),
('v11-i067', 'v11-c06', 'v11', '{"en": "Fettuccine with Salmon", "hy": "Ֆետուչինի սաղմոնով", "ru": "Феттуччине с лососем"}', NULL, 4900, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c07', 'v11', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i068', 'v11-c07', 'v11', '{"en": "Farmer Salad", "hy": "Ֆերմերական աղցան", "ru": "Фермерский салат"}', NULL, 2800, ARRAY[]::varchar[], 0),
('v11-i069', 'v11-c07', 'v11', '{"en": "Caesar Salad", "hy": "Կեսար աղցան", "ru": "Салат Цезарь"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v11-i070', 'v11-c07', 'v11', '{"en": "Greek Salad", "hy": "Հունական աղցան", "ru": "Греческий салат"}', NULL, 2800, ARRAY[]::varchar[], 2),
('v11-i071', 'v11-c07', 'v11', '{"en": "Caprese Salad", "hy": "Կապրեզե աղցան", "ru": "Салат Капрезе"}', NULL, 2900, ARRAY[]::varchar[], 3),
('v11-i072', 'v11-c07', 'v11', '{"en": "Steak Salad", "hy": "Սթեյք աղցան", "ru": "Стейк-салат"}', NULL, 3900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c08', 'v11', '{"en": "Appetizers", "hy": "Նախուտեստներ", "ru": "Закуски"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i073', 'v11-c08', 'v11', '{"en": "Bruschettas", "hy": "Բրուսկետաներ", "ru": "Брускетты"}', NULL, 2400, ARRAY[]::varchar[], 0),
('v11-i074', 'v11-c08', 'v11', '{"en": "Chicken Tempura", "hy": "Հավի տեմպուրա", "ru": "Куриная темпура"}', NULL, 2100, ARRAY[]::varchar[], 1),
('v11-i075', 'v11-c08', 'v11', '{"en": "Mozzarella Sticks", "hy": "Մոցառելլա ձխիկներ", "ru": "Палочки моцарелла"}', NULL, 2600, ARRAY[]::varchar[], 2),
('v11-i076', 'v11-c08', 'v11', '{"en": "Shrimp Tempura", "hy": "Ինտեմպո միս", "ru": "Креветки темпура"}', NULL, 3600, ARRAY[]::varchar[], 3),
('v11-i077', 'v11-c08', 'v11', '{"en": "Meat Platter", "hy": "Մսի տեսականի", "ru": "Мясное ассорти"}', NULL, 3900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c09', 'v11', '{"en": "Soups", "hy": "Ապուրներ", "ru": "Супы"}', 9);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i078', 'v11-c09', 'v11', '{"en": "Papa al Pomodoro", "hy": "Պապա ալ պոմոդորո", "ru": "Папа аль помодоро"}', NULL, 1900, ARRAY[]::varchar[], 0),
('v11-i079', 'v11-c09', 'v11', '{"en": "Five Cheese Gnocchi Soup", "hy": "Հինգ պանրով նյոկի ապուր", "ru": "Суп ньокки с пятью сырами"}', NULL, 2100, ARRAY[]::varchar[], 1),
('v11-i080', 'v11-c09', 'v11', '{"en": "Cream of Mushroom", "hy": "Սնկով կրեմ-ապուր", "ru": "Грибной крем-суп"}', NULL, 2400, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c10', 'v11', '{"en": "Desserts", "hy": "Աղանդեր", "ru": "Десерты"}', 10);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i081', 'v11-c10', 'v11', '{"en": "Berry Tart", "hy": "Հատապտղային տարտ", "ru": "Ягодный тарт"}', NULL, 1300, ARRAY[]::varchar[], 0),
('v11-i082', 'v11-c10', 'v11', '{"en": "Honey Cake", "hy": "Մեղրով տորթ", "ru": "Медовик"}', NULL, 1800, ARRAY[]::varchar[], 1),
('v11-i083', 'v11-c10', 'v11', '{"en": "Brownie", "hy": "Բրաունի", "ru": "Брауни"}', NULL, 1900, ARRAY[]::varchar[], 2),
('v11-i084', 'v11-c10', 'v11', '{"en": "Tiramisu", "hy": "Տիրամիսու", "ru": "Тирамису"}', NULL, 2600, ARRAY[]::varchar[], 3),
('v11-i085', 'v11-c10', 'v11', '{"en": "San Sebastian Cheesecake", "hy": "Սան Սեբաստիան չիզքեյք", "ru": "Чизкейк Сан-Себастьян"}', NULL, 2500, ARRAY[]::varchar[], 4),
('v11-i086', 'v11-c10', 'v11', '{"en": "Sweet Focaccias", "hy": "Քաղցր ֆոկաչաներ", "ru": "Сладкие фокаччи"}', NULL, 3900, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v11-c11', 'v11', '{"en": "Drinks", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 11);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v11-i087', 'v11-c11', 'v11', '{"en": "Water", "hy": "Ջուր", "ru": "Вода"}', NULL, 500, ARRAY[]::varchar[], 0),
('v11-i088', 'v11-c11', 'v11', '{"en": "Coca-Cola 0.33l", "hy": "Կոկա-կոլա 0.33լ", "ru": "Кока-кола 0.33л"}', NULL, 600, ARRAY[]::varchar[], 1);

-- ═══ If You Know You Know (v12) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v12', 'If You Know You Know', 'iykyk',
 '{"en": "If You Know You Know — a popular restaurant in Yerevan."}',
 ARRAY['Cocktails','Bar','Tapas'], 3, 4.7, 45,
 'Amiryan St 4/6, Yerevan 0010', 40.1801, 44.5168, '+374 10 606060',
 ARRAY['WiFi','Air Conditioning','Live Music'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v12', 'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=800', 0),
('v12', 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=800', 1),
('v12', 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v12', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v12-z1', 'v12', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v12-z2', 'v12', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v12-t1', 'v12', 'v12-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v12-t2', 'v12', 'v12-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v12-t3', 'v12', 'v12-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v12-t4', 'v12', 'v12-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v12-t5', 'v12', 'v12-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v12-t6', 'v12', 'v12-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000012', 'v12', 'If You Know You Know Admin', 'admin-iykyk@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 606060', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v12-c00', 'v12', '{"en": "Burgers", "hy": "Բուրգերներ", "ru": "Бургеры"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v12-i001', 'v12-c00', 'v12', '{"en": "Classic Smashburger Single", "hy": "Դասական Սմեշբուրգեր մեկտեղանոց", "ru": "Классический Смашбургер одинарный"}', NULL, 2100, ARRAY[]::varchar[], 0),
('v12-i002', 'v12-c00', 'v12', '{"en": "Classic Smashburger Double", "hy": "Դասական Սմեշբուրգեր երկտեղանոց", "ru": "Классический Смашбургер двойной"}', NULL, 2600, ARRAY[]::varchar[], 1),
('v12-i003', 'v12-c00', 'v12', '{"en": "Classic Smashburger Triple", "hy": "Դասական Սմեշբուրգեր երեքտեղանոց", "ru": "Классический Смашбургер тройной"}', NULL, 3100, ARRAY[]::varchar[], 2),
('v12-i004', 'v12-c00', 'v12', '{"en": "Chicken Nashville Burger", "hy": "Հավի Նեշվիլ Բուրգեր", "ru": "Куриный Нэшвилл Бургեր"}', NULL, 2800, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v12-c01', 'v12', '{"en": "Appetizers", "hy": "Նախուտեստներ", "ru": "Закуски"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v12-i005', 'v12-c01', 'v12', '{"en": "French Fries", "hy": "Ֆրի", "ru": "Картофель фри"}', NULL, 1200, ARRAY[]::varchar[], 0),
('v12-i006', 'v12-c01', 'v12', '{"en": "Nashville Hot Chicken Nuggets", "hy": "Նեշվիլ կծու հավի նագեթներ", "ru": "Острые куриные наггетсы Нэшвилл"}', NULL, 1900, ARRAY[]::varchar[], 1),
('v12-i007', 'v12-c01', 'v12', '{"en": "Truffle Smashed Potato", "hy": "Տրյուֆելով ճզմված կարտոֆիլ", "ru": "Размятый картофель с трюфелем"}', NULL, 1900, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v12-c02', 'v12', '{"en": "Lent Menu", "hy": "Պահքի մենյու", "ru": "Постное меню"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v12-i008', 'v12-c02', 'v12', '{"en": "Nashville Cauliflower Nuggets", "hy": "Նեշվիլ ծաղկակաղամբի նագեթներ", "ru": "Наггетсы из цветной капусты Нэшвилл"}', NULL, 1400, ARRAY[]::varchar[], 0);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v12-c03', 'v12', '{"en": "Sauces", "hy": "Սոուսներ", "ru": "Соусы"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v12-i009', 'v12-c03', 'v12', '{"en": "Secret Sauce", "hy": "Գաղտնի սոուս", "ru": "Секретный соус"}', NULL, 400, ARRAY[]::varchar[], 0),
('v12-i010', 'v12-c03', 'v12', '{"en": "Truffle Sauce", "hy": "Տրյուֆելի սոուս", "ru": "Трюфельный соус"}', NULL, 600, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v12-c04', 'v12', '{"en": "Drinks", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v12-i011', 'v12-c04', 'v12', '{"en": "Coca-Cola (0.5l)", "hy": "Կոկա-Կոլա (0.5լ)", "ru": "Кока-Кола (0.5л)"}', NULL, 600, ARRAY[]::varchar[], 0),
('v12-i012', 'v12-c04', 'v12', '{"en": "Fanta (0.5l)", "hy": "Ֆանտա (0.5լ)", "ru": "Фанта (0.5л)"}', NULL, 600, ARRAY[]::varchar[], 1),
('v12-i013', 'v12-c04', 'v12', '{"en": "Peach Iced Tea (400ml)", "hy": "Դեղձի սառը թեյ (400մլ)", "ru": "Персиковый холодный чай (400мл)"}', NULL, 700, ARRAY[]::varchar[], 2);

-- ═══ Kamancha Restaurant (v13) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v13', 'Kamancha Restaurant', 'kamancha',
 '{"en": "Kamancha Restaurant — a popular restaurant in Yerevan."}',
 ARRAY['Armenian','Traditional','Grill'], 3, 4.8, 178,
 'Teryan St 72, Yerevan 0009', 40.1888, 44.5098, '+374 10 616161',
 ARRAY['WiFi','Live Music','Outdoor Seating','Valet Parking'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v13', 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800', 0),
('v13', 'https://images.unsplash.com/photo-1544148103-0773bf10d330?w=800', 1),
('v13', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v13', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v13-z1', 'v13', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v13-z2', 'v13', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v13-t1', 'v13', 'v13-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v13-t2', 'v13', 'v13-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v13-t3', 'v13', 'v13-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v13-t4', 'v13', 'v13-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v13-t5', 'v13', 'v13-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v13-t6', 'v13', 'v13-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000013', 'v13', 'Kamancha Restaurant Admin', 'admin-kamancha@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 616161', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c00', 'v13', '{"en": "Special Offers", "hy": "Հատուկ առաջարկներ", "ru": "Специальные предложения"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i001', 'v13-c00', 'v13', '{"en": "Kamancha assorted", "hy": "Քամանչա տեսականի", "ru": "Ассорти Каманча"}', NULL, 28500, ARRAY[]::varchar[], 0),
('v13-i002', 'v13-c00', 'v13', '{"en": "Assorted BBQ (big)", "hy": "Խորովածի տեսականի (մեծ)", "ru": "Ассорти барбекю (большое)"}', NULL, 45500, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c01', 'v13', '{"en": "Breakfast", "hy": "Նախաճաշ", "ru": "Завтрак"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i003', 'v13-c01', 'v13', '{"en": "Strained matsoni with honey and walnuts", "hy": "Քամած մածուն մեղրով և ընկույզով", "ru": "Цежец мацун с медом и грецкими орехами"}', NULL, 1300, ARRAY[]::varchar[], 0);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c02', 'v13', '{"en": "Appetizers", "hy": "Նախուտեստներ", "ru": "Закуски"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i004', 'v13-c02', 'v13', '{"en": "Armenian cheese plate", "hy": "Հայկական պանրի տեսականի", "ru": "Армянская сырная тарелка"}', NULL, 2100, ARRAY[]::varchar[], 0),
('v13-i005', 'v13-c02', 'v13', '{"en": "Vegetables assortment", "hy": "Բանջարեղենի տեսականի", "ru": "Овощное ассорти"}', NULL, 2500, ARRAY[]::varchar[], 1),
('v13-i006', 'v13-c02', 'v13', '{"en": "Lemon and olives", "hy": "Լիմոն և ձիթապտուղ", "ru": "Лимон и оливки"}', NULL, 1400, ARRAY[]::varchar[], 2),
('v13-i007', 'v13-c02', 'v13', '{"en": "Homemade pickles assorted", "hy": "Տնական թթվի տեսականի", "ru": "Ассорти домашних солений"}', NULL, 1400, ARRAY[]::varchar[], 3),
('v13-i008', 'v13-c02', 'v13', '{"en": "Ghavurma", "hy": "Ղավուրմա", "ru": "Кавурма"}', NULL, 4500, ARRAY[]::varchar[], 4),
('v13-i009', 'v13-c02', 'v13', '{"en": "Assortment of greens", "hy": "Կանաչու տեսականի", "ru": "Ассорти зелени"}', NULL, 1300, ARRAY[]::varchar[], 5),
('v13-i010', 'v13-c02', 'v13', '{"en": "Fish assorted", "hy": "Ձկան տեսականի", "ru": "Рыбное ассорти"}', NULL, 4500, ARRAY[]::varchar[], 6),
('v13-i011', 'v13-c02', 'v13', '{"en": "Eggplant rolls", "hy": "Սմբուկով ռուլետներ", "ru": "Рулетики из баклажанов"}', NULL, 1900, ARRAY[]::varchar[], 7),
('v13-i012', 'v13-c02', 'v13', '{"en": "Strained yogurt", "hy": "Քամած մածուն", "ru": "Цежец мацун"}', NULL, 1000, ARRAY[]::varchar[], 8),
('v13-i013', 'v13-c02', 'v13', '{"en": "Rezhan", "hy": "Ռեժան", "ru": "Режан"}', NULL, 1200, ARRAY[]::varchar[], 9),
('v13-i014', 'v13-c02', 'v13', '{"en": "Tandoor bread and lavash", "hy": "Թոնրի հաց և լավաշ", "ru": "Тандырный хлеб и лаваш"}', NULL, 550, ARRAY[]::varchar[], 10),
('v13-i015', 'v13-c02', 'v13', '{"en": "European cheese assortment", "hy": "Եվրոպական պանիրների տեսականի", "ru": "Ассорти европейских сыров"}', NULL, 6700, ARRAY[]::varchar[], 11),
('v13-i016', 'v13-c02', 'v13', '{"en": "Crackers with garlic", "hy": "Չորահաց սխտորով", "ru": "Сухарики с чесноком"}', NULL, 1100, ARRAY[]::varchar[], 12),
('v13-i017', 'v13-c02', 'v13', '{"en": "Vegetables with lemon", "hy": "Բանջարեղեն լիմոնով", "ru": "Овощи с лимоном"}', NULL, 900, ARRAY[]::varchar[], 13),
('v13-i018', 'v13-c02', 'v13', '{"en": "Puree Maro", "hy": "Մարո պյուրե", "ru": "Пюре Маро"}', NULL, 1700, ARRAY[]::varchar[], 14),
('v13-i019', 'v13-c02', 'v13', '{"en": "Hummus", "hy": "Հումուս", "ru": "Хумус"}', NULL, 1200, ARRAY[]::varchar[], 15),
('v13-i020', 'v13-c02', 'v13', '{"en": "Pghpeghani", "hy": "Պղպեղանի", "ru": "Пхпегани"}', NULL, 2600, ARRAY[]::varchar[], 16),
('v13-i021', 'v13-c02', 'v13', '{"en": "Assortment of Armenian canned goods", "hy": "Հայկական պահածոների տեսականի", "ru": "Ассорти армянских консервов"}', NULL, 2500, ARRAY[]::varchar[], 17);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c03', 'v13', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i022', 'v13-c03', 'v13', '{"en": "Beef, walnut and eggplant salad", "hy": "Աղցան տավարի մսով, ընկույզով և սմբուկով", "ru": "Салат с говядиной, грецким орехом и баклажанами"}', NULL, 3400, ARRAY[]::varchar[], 0),
('v13-i023', 'v13-c03', 'v13', '{"en": "Tarragon, horats cheese and grape salad", "hy": "Աղցան թարխունով, հորած պանրով և խաղողով", "ru": "Салат с тархуном, сыром хорац и виноградом"}', NULL, 2800, ARRAY[]::varchar[], 1),
('v13-i024', 'v13-c03', 'v13', '{"en": "Chicken breast, quinoa and vegetable salad", "hy": "Աղցան հավի կրծքամսով, կինոայով և բանջարեղենով", "ru": "Салат с куриной грудкой, киноа и овощами"}', NULL, 2300, ARRAY[]::varchar[], 2),
('v13-i025', 'v13-c03', 'v13', '{"en": "Caesar salad", "hy": "Կեսար աղցան", "ru": "Салат Цезарь"}', NULL, 2800, ARRAY[]::varchar[], 3),
('v13-i026', 'v13-c03', 'v13', '{"en": "Summer salad", "hy": "Ամառային աղցան", "ru": "Летний салат"}', NULL, 1500, ARRAY[]::varchar[], 4),
('v13-i027', 'v13-c03', 'v13', '{"en": "Tabbouleh", "hy": "Թաբուլե", "ru": "Табуле"}', NULL, 1600, ARRAY[]::varchar[], 5),
('v13-i028', 'v13-c03', 'v13', '{"en": "Strained yogurt, cucumber and walnuts salad", "hy": "Աղցան քամած մածունով, վարունգով և ընկույզով", "ru": "Салат из цежец мацуна, огурцов и грецких орехов"}', NULL, 1200, ARRAY[]::varchar[], 6),
('v13-i029', 'v13-c03', 'v13', '{"en": "Sorrel, tomato and strained yogurt salad", "hy": "Աղցան ավելուկով, լոլիկով և քամած մածունով", "ru": "Салат со щавелем, помидорами и цежец мацуном"}', NULL, 1800, ARRAY[]::varchar[], 7),
('v13-i030', 'v13-c03', 'v13', '{"en": "Greek salad", "hy": "Հունական աղցան", "ru": "Греческий салат"}', NULL, 2600, ARRAY[]::varchar[], 8),
('v13-i031', 'v13-c03', 'v13', '{"en": "Arti salad", "hy": "Արտի աղցան", "ru": "Арти салат"}', NULL, 3000, ARRAY[]::varchar[], 9);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c04', 'v13', '{"en": "Main Dishes", "hy": "Տաք ուտեստներ", "ru": "Основные блюда"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i032', 'v13-c04', 'v13', '{"en": "Nazeli", "hy": "Նազելի", "ru": "Назели"}', NULL, 3500, ARRAY[]::varchar[], 0),
('v13-i033', 'v13-c04', 'v13', '{"en": "Syuniki Khashntur", "hy": "Սյունիքի Խաշնտուր", "ru": "Сюникский Хашнтур"}', NULL, 8700, ARRAY[]::varchar[], 1),
('v13-i034', 'v13-c04', 'v13', '{"en": "Assorted tolma", "hy": "Տոլմայի տեսականի", "ru": "Ассорти толмы"}', NULL, 7500, ARRAY[]::varchar[], 2),
('v13-i035', 'v13-c04', 'v13', '{"en": "Stuffed Pork Loin Yeghegnadzor", "hy": "Լցոնված խոզի չալաղաջ Եղեգնաձոր", "ru": "Фаршированная свиная корейка Ехегнадзор"}', NULL, 6400, ARRAY[]::varchar[], 3),
('v13-i036', 'v13-c04', 'v13', '{"en": "Pide (Two meat / Lahmajo / Cheese)", "hy": "Պիդե (Երկու միս / Լահմաջո / Պանիր)", "ru": "Пиде (Два мяса / Ламаджо / Сыр)"}', NULL, 2600, ARRAY[]::varchar[], 4),
('v13-i037', 'v13-c04', 'v13', '{"en": "Summer tolma", "hy": "Ամառային տոլմա", "ru": "Летняя толма"}', NULL, 3900, ARRAY[]::varchar[], 5),
('v13-i038', 'v13-c04', 'v13', '{"en": "Tolma (Grape leaves / Cabbage)", "hy": "Տոլմա (Խաղողի թերթ / Կաղամբ)", "ru": "Толма (Виноградные листья / Капуста)"}', NULL, 2700, ARRAY[]::varchar[], 6),
('v13-i039', 'v13-c04', 'v13', '{"en": "Garni Yarakh", "hy": "Գառնի Յարախ", "ru": "Гарни Ярах"}', NULL, 2500, ARRAY[]::varchar[], 7),
('v13-i040', 'v13-c04', 'v13', '{"en": "Arishta with ghavurma", "hy": "Արիշտա ղավուրմայով", "ru": "Аришта с кавурмой"}', NULL, 4200, ARRAY[]::varchar[], 8),
('v13-i041', 'v13-c04', 'v13', '{"en": "Tjvjik", "hy": "Տժվժիկ", "ru": "Тжвжик"}', NULL, 2100, ARRAY[]::varchar[], 9),
('v13-i042', 'v13-c04', 'v13', '{"en": "Beef khashlama", "hy": "Տավարի խաշլամա", "ru": "Хашлама из говядины"}', NULL, 3900, ARRAY[]::varchar[], 10),
('v13-i043', 'v13-c04', 'v13', '{"en": "Lamb khashlama", "hy": "Գառան խաշլամա", "ru": "Хашлама из ягненка"}', NULL, 4400, ARRAY[]::varchar[], 11),
('v13-i044', 'v13-c04', 'v13', '{"en": "Lamb shoulder in the stove", "hy": "Գառան թիակ վառարանում", "ru": "Лопатка ягненка в печи"}', NULL, 12900, ARRAY[]::varchar[], 12),
('v13-i045', 'v13-c04', 'v13', '{"en": "Boiled trout", "hy": "Խաշած իշխան", "ru": "Вареная форель"}', NULL, 4200, ARRAY[]::varchar[], 13),
('v13-i046', 'v13-c04', 'v13', '{"en": "Imeretian khachapuri", "hy": "Իմերեթական խաչապուրի", "ru": "Имеретинский хачапури"}', NULL, 2200, ARRAY[]::varchar[], 14),
('v13-i047', 'v13-c04', 'v13', '{"en": "Kalagyosh", "hy": "Քալագյոշ", "ru": "Калагёш"}', NULL, 3700, ARRAY[]::varchar[], 15),
('v13-i048', 'v13-c04', 'v13', '{"en": "Yerevan roast Areni", "hy": "Երևանյան տապակա Արենի", "ru": "Ереванское жаркое Арени"}', NULL, 7500, ARRAY[]::varchar[], 16),
('v13-i049', 'v13-c04', 'v13', '{"en": "Tolma with lamb", "hy": "Տոլմա գառան մսով", "ru": "Толма с ягненком"}', NULL, 2600, ARRAY[]::varchar[], 17),
('v13-i050', 'v13-c04', 'v13', '{"en": "Boiled whitefish", "hy": "Խաշած սիգ", "ru": "Вареный сиг"}', NULL, 3600, ARRAY[]::varchar[], 18),
('v13-i051', 'v13-c04', 'v13', '{"en": "Pide Pepperoni", "hy": "Պիդե Պեպերոնի", "ru": "Пиде Пепперони"}', NULL, 2900, ARRAY[]::varchar[], 19),
('v13-i052', 'v13-c04', 'v13', '{"en": "Lamb Pide", "hy": "Պիդե գառան մսով", "ru": "Пиде с ягненком"}', NULL, 2600, ARRAY[]::varchar[], 20),
('v13-i053', 'v13-c04', 'v13', '{"en": "Khurjin", "hy": "Խուրջին", "ru": "Хурджин"}', NULL, 3900, ARRAY[]::varchar[], 21),
('v13-i054', 'v13-c04', 'v13', '{"en": "Kufta with cream sauce", "hy": "Քյուֆթա սերուցքային սոուսով", "ru": "Кюфта в сливочном соусе"}', NULL, 2800, ARRAY[]::varchar[], 22),
('v13-i055', 'v13-c04', 'v13', '{"en": "Sausage set", "hy": "Նրբերշիկի հավաքածու", "ru": "Набор сосисок"}', NULL, 7900, ARRAY[]::varchar[], 23),
('v13-i056', 'v13-c04', 'v13', '{"en": "Pork shawarma with dough", "hy": "Խոզի շաուրմա խմորով", "ru": "Шаурма из свинины в тесте"}', NULL, 2900, ARRAY[]::varchar[], 24),
('v13-i057', 'v13-c04', 'v13', '{"en": "Tapaka Armavir With beef fillet", "hy": "Տապակա Արմավիր տավարի ֆիլեով", "ru": "Тапака Армавир с говяжьим филе"}', NULL, 6900, ARRAY[]::varchar[], 25),
('v13-i058', 'v13-c04', 'v13', '{"en": "Tapaka Armavir With lamb loin", "hy": "Տապակա Արմավիր գառան չալաղաջով", "ru": "Тапака Армавир с бараньей корейкой"}', NULL, 7500, ARRAY[]::varchar[], 26),
('v13-i059', 'v13-c04', 'v13', '{"en": "Tapaka Armavir With trout fillet", "hy": "Տապակա Արմավիր իշխանի ֆիլեով", "ru": "Тапака Армавир с филе форели"}', NULL, 6100, ARRAY[]::varchar[], 27),
('v13-i060', 'v13-c04', 'v13', '{"en": "Tapaka Armavir With pork bacon", "hy": "Տապակա Արմավիր խոզի բեկոնով", "ru": "Тапака Армавир со свиным беконом"}', NULL, 5800, ARRAY[]::varchar[], 28),
('v13-i061', 'v13-c04', 'v13', '{"en": "Tapaka Armavir With chicken fillet", "hy": "Տապակա Արմավիր հավի ֆիլեով", "ru": "Тапака Армавир с куриным филе"}', NULL, 3900, ARRAY[]::varchar[], 29),
('v13-i062', 'v13-c04', 'v13', '{"en": "Tapaka Armavir With vegetables", "hy": "Տապակա Արմավիր բանջարեղենով", "ru": "Тапака Армавир с овощами"}', NULL, 2800, ARRAY[]::varchar[], 30);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c05', 'v13', '{"en": "Grill / BBQ", "hy": "Խորոված և Քյաբաբ", "ru": "Гриль / Барбекю"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i063', 'v13-c05', 'v13', '{"en": "Sturgeon barbecue", "hy": "Թառափի խորոված", "ru": "Шашлык из осетрины"}', NULL, 10900, ARRAY[]::varchar[], 0),
('v13-i064', 'v13-c05', 'v13', '{"en": "Beef fillet BBQ", "hy": "Տավարի ֆիլեի խորոված", "ru": "Шашлык из говяжьего филе"}', NULL, 4500, ARRAY[]::varchar[], 1),
('v13-i065', 'v13-c05', 'v13', '{"en": "Lamb loin BBQ", "hy": "Գառան չալաղաջի խորոված", "ru": "Шашлык из бараньей корейки"}', NULL, 4300, ARRAY[]::varchar[], 2),
('v13-i066', 'v13-c05', 'v13', '{"en": "Trout barbecue", "hy": "Իշխանի խորոված", "ru": "Шашлык из форели"}', NULL, 4200, ARRAY[]::varchar[], 3),
('v13-i067', 'v13-c05', 'v13', '{"en": "Pork loin BBQ", "hy": "Խոզի չալաղաջի խորոված", "ru": "Шашлык из свиной корейки"}', NULL, 3800, ARRAY[]::varchar[], 4),
('v13-i068', 'v13-c05', 'v13', '{"en": "Small assortment of barbecue", "hy": "Խորովածի փոքր տեսականի", "ru": "Малое ассорти шашлыка"}', NULL, 16200, ARRAY[]::varchar[], 5),
('v13-i069', 'v13-c05', 'v13', '{"en": "Lamb kebab", "hy": "Գառան քյաբաբ", "ru": "Кебаб из ягненка"}', NULL, 1800, ARRAY[]::varchar[], 6),
('v13-i070', 'v13-c05', 'v13', '{"en": "Beef kebab", "hy": "Տավարի քյաբաբ", "ru": "Кебаб из говядины"}', NULL, 1600, ARRAY[]::varchar[], 7),
('v13-i071', 'v13-c05', 'v13', '{"en": "Chicken kebab", "hy": "Հավի քյաբաբ", "ru": "Кебаб из курицы"}', NULL, 1300, ARRAY[]::varchar[], 8),
('v13-i072', 'v13-c05', 'v13', '{"en": "Potato BBQ", "hy": "Կարտոֆիլի խորոված", "ru": "Картофель на гриле"}', NULL, 700, ARRAY[]::varchar[], 9),
('v13-i073', 'v13-c05', 'v13', '{"en": "Onion / Hot pepper BBQ", "hy": "Սոխ / Կծու պղպեղ խորոված", "ru": "Лук / Острый перец на гриле"}', NULL, 600, ARRAY[]::varchar[], 10);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c06', 'v13', '{"en": "Desserts", "hy": "Աղանդեր", "ru": "Десерты"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i074', 'v13-c06', 'v13', '{"en": "Ghapama (big)", "hy": "Ղափամա (մեծ)", "ru": "Хапама (большая)"}', NULL, 13500, ARRAY[]::varchar[], 0),
('v13-i075', 'v13-c06', 'v13', '{"en": "Sweet «Kamancha»", "hy": "Քաղցր «Քամանչա»", "ru": "Сладкая «Каманча»"}', NULL, 12000, ARRAY[]::varchar[], 1),
('v13-i076', 'v13-c06', 'v13', '{"en": "Assorted fruit", "hy": "Մրգի տեսականի", "ru": "Фруктовое ассорти"}', NULL, 4500, ARRAY[]::varchar[], 2),
('v13-i077', 'v13-c06', 'v13', '{"en": "Cheesecake", "hy": "Չիզքեյք", "ru": "Чизкейк"}', NULL, 1900, ARRAY[]::varchar[], 3),
('v13-i078', 'v13-c06', 'v13', '{"en": "Pakhlava / Gata / Bird''s milk", "hy": "Փախլավա / Գաթա / Թռչնի կաթ", "ru": "Пахлава / Гата / Птичье молоко"}', NULL, 1700, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v13-c07', 'v13', '{"en": "Drinks", "hy": "Ըմպելիքներ և Սոուսներ", "ru": "Напитки"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v13-i079', 'v13-c07', 'v13', '{"en": "Homemade compote (1l)", "hy": "Տնական կոմպոտ (1լ)", "ru": "Домашний компот (1л)"}', NULL, 1250, ARRAY[]::varchar[], 0),
('v13-i080', 'v13-c07', 'v13', '{"en": "Tan (1l)", "hy": "Թան (1լ)", "ru": "Тан (1л)"}', NULL, 1300, ARRAY[]::varchar[], 1),
('v13-i081', 'v13-c07', 'v13', '{"en": "Beer (Kilikia/Gyumri 0.33l)", "hy": "Գարեջուր (Կիլիկիա/Գյումրի 0.33լ)", "ru": "Пиво (Киликия/Гюмри 0.33л)"}', NULL, 1100, ARRAY[]::varchar[], 2),
('v13-i082', 'v13-c07', 'v13', '{"en": "Soft drinks (Coke/Fanta/Water 0.5l)", "hy": "Զովացուցիչ ըմպելիքներ (Կոկա-կոլա/Ֆանտա/Ջուր 0.5լ)", "ru": "Безалкогольные напитки (Кока-кола/Фанта/Вода 0.5л)"}', NULL, 450, ARRAY[]::varchar[], 3),
('v13-i083', 'v13-c07', 'v13', '{"en": "Sauces (Garlic, Ghars, Hot, Tkemali, Narsharab)", "hy": "Սոուսներ (Սխտորի, Ղարսի, Կծու, Տղեմալի, Նարշարաբ)", "ru": "Соусы (Чесночный, Карс, Острый, Ткемали, Наршараб)"}', NULL, 500, ARRAY[]::varchar[], 4);

-- ═══ Ktoor (v14) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v14', 'Ktoor', 'ktoor',
 '{"en": "Ktoor — a popular restaurant in Yerevan."}',
 ARRAY['Seafood','Mediterranean','Armenian'], 3, 4.6, 134,
 'Tamanyan St 2, Yerevan 0009', 40.1916, 44.512, '+374 10 626262',
 ARRAY['WiFi','Air Conditioning','Outdoor Seating','Valet Parking'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v14', 'https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?w=800', 0),
('v14', 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800', 1),
('v14', 'https://images.unsplash.com/photo-1592861956120-e524fc739696?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v14', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v14-z1', 'v14', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v14-z2', 'v14', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v14-t1', 'v14', 'v14-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v14-t2', 'v14', 'v14-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v14-t3', 'v14', 'v14-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v14-t4', 'v14', 'v14-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v14-t5', 'v14', 'v14-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v14-t6', 'v14', 'v14-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000014', 'v14', 'Ktoor Admin', 'admin-ktoor@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 626262', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c00', 'v14', '{"en": "Lent Menu", "hy": "Պահքի մենյու", "ru": "Постное меню"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i001', 'v14-c00', 'v14', '{"en": "Hummus", "hy": "Հումուս", "ru": "Хумус"}', NULL, 1100, ARRAY[]::varchar[], 0),
('v14-i002', 'v14-c00', 'v14', '{"en": "Red bean salad", "hy": "Կարմիր լոբով աղցան", "ru": "Салат из красной фасоли"}', NULL, 1300, ARRAY[]::varchar[], 1),
('v14-i003', 'v14-c00', 'v14', '{"en": "Lenten tolma / Pasuts tolma", "hy": "Պասուց տոլմա", "ru": "Постная толма / Пасуц толма"}', NULL, 1500, ARRAY[]::varchar[], 2),
('v14-i004', 'v14-c00', 'v14', '{"en": "Rice with vegetables", "hy": "Բրինձ բանջարեղենով", "ru": "Рис с овощами"}', NULL, 1500, ARRAY[]::varchar[], 3),
('v14-i005', 'v14-c00', 'v14', '{"en": "Muhammara", "hy": "Մուհամմարա", "ru": "Мухаммара"}', NULL, 1700, ARRAY[]::varchar[], 4),
('v14-i006', 'v14-c00', 'v14', '{"en": "Fried spinach", "hy": "Տապակած սպանախ", "ru": "Жареный шпинат"}', NULL, 1700, ARRAY[]::varchar[], 5),
('v14-i007', 'v14-c00', 'v14', '{"en": "Purslane and beans salad", "hy": "Դանդուռով և լոբով աղցան", "ru": "Салат из портулака и фасоли"}', NULL, 1800, ARRAY[]::varchar[], 6),
('v14-i008', 'v14-c00', 'v14', '{"en": "Mushrooms with potatoes", "hy": "Սունկ կարտոֆիլով", "ru": "Грибы с картофелем"}', NULL, 1800, ARRAY[]::varchar[], 7),
('v14-i009', 'v14-c00', 'v14', '{"en": "Borani with potatoes", "hy": "Բորանի կարտոֆիլով", "ru": "Борани с картофелем"}', NULL, 1800, ARRAY[]::varchar[], 8),
('v14-i010', 'v14-c00', 'v14', '{"en": "Mushrooms BBQ", "hy": "Սնկի խորոված", "ru": "Грибы на гриле"}', NULL, 1900, ARRAY[]::varchar[], 9),
('v14-i011', 'v14-c00', 'v14', '{"en": "Lenten lahmacun", "hy": "Պահքի լահմաջո", "ru": "Постный лахмаджо"}', NULL, 2000, ARRAY[]::varchar[], 10),
('v14-i012', 'v14-c00', 'v14', '{"en": "Summer salad", "hy": "Ամառային աղցան", "ru": "Летний салат"}', NULL, 2200, ARRAY[]::varchar[], 11),
('v14-i013', 'v14-c00', 'v14', '{"en": "Tabbouleh", "hy": "Թաբուլե", "ru": "Табуле"}', NULL, 2300, ARRAY[]::varchar[], 12),
('v14-i014', 'v14-c00', 'v14', '{"en": "Broccoli salad", "hy": "Բրոկոլիով աղցան", "ru": "Салат из брокколи"}', NULL, 2700, ARRAY[]::varchar[], 13),
('v14-i015', 'v14-c00', 'v14', '{"en": "Yerevan lunch", "hy": "Երևանյան լանչ", "ru": "Ереванский обед"}', NULL, 2800, ARRAY[]::varchar[], 14),
('v14-i016', 'v14-c00', 'v14', '{"en": "Lenten salad", "hy": "Պահքի աղցան", "ru": "Постный салат"}', NULL, 3200, ARRAY[]::varchar[], 15),
('v14-i017', 'v14-c00', 'v14', '{"en": "Patato plech", "hy": "Կարտոֆիլի պլեճ", "ru": "Картофель плеч"}', NULL, 900, ARRAY[]::varchar[], 16);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c01', 'v14', '{"en": "Main Dishes", "hy": "Հիմնական ուտեստներ", "ru": "Основные блюда"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i018', 'v14-c01', 'v14', '{"en": "Cutlet by grandma", "hy": "Տատիկի կոտլետ", "ru": "Котлета по-бабушкиному"}', NULL, 2300, ARRAY[]::varchar[], 0),
('v14-i019', 'v14-c01', 'v14', '{"en": "Vegetables BBQ", "hy": "Բանջարեղենի խորոված", "ru": "Овощи на гриле"}', NULL, 2800, ARRAY[]::varchar[], 1),
('v14-i020', 'v14-c01', 'v14', '{"en": "Borani", "hy": "Բորանի", "ru": "Борани"}', NULL, 3400, ARRAY[]::varchar[], 2),
('v14-i021', 'v14-c01', 'v14', '{"en": "Bukhari qufta", "hy": "Բուխարի քյուֆթա", "ru": "Бухари кюфта"}', NULL, 3700, ARRAY[]::varchar[], 3),
('v14-i022', 'v14-c01', 'v14', '{"en": "Hagani from Sevan", "hy": "Հագանի Սևանից", "ru": "Хагани из Севана"}', NULL, 4500, ARRAY[]::varchar[], 4),
('v14-i023', 'v14-c01', 'v14', '{"en": "Bumbar from Ktoor (0.5m)", "hy": "Բումբար Կտուրից (0.5մ)", "ru": "Бумбар от Ктур (0.5м)"}', NULL, 5000, ARRAY[]::varchar[], 5),
('v14-i024', 'v14-c01', 'v14', '{"en": "Khashlama with rejan", "hy": "Խաշլամա ռեժանով", "ru": "Хашлама с режаном"}', NULL, 6100, ARRAY[]::varchar[], 6),
('v14-i025', 'v14-c01', 'v14', '{"en": "Lamb Khashlama", "hy": "Գառան խաշլամա", "ru": "Хашлама из баранины"}', NULL, 6300, ARRAY[]::varchar[], 7),
('v14-i026', 'v14-c01', 'v14', '{"en": "Mess in Ktoor", "hy": "Խառնաշփոթ Կտուրում", "ru": "Беспорядок в Ктуре"}', NULL, 12200, ARRAY[]::varchar[], 8),
('v14-i027', 'v14-c01', 'v14', '{"en": "Steak Ktoor", "hy": "Սթեյք Կտուր", "ru": "Стейк Ктур"}', NULL, 14000, ARRAY[]::varchar[], 9),
('v14-i028', 'v14-c01', 'v14', '{"en": "Ktoor Castle", "hy": "Կտուր Ամրոց", "ru": "Замок Ктур"}', NULL, 30000, ARRAY[]::varchar[], 10),
('v14-i029', 'v14-c01', 'v14', '{"en": "Veal shank with broad beans", "hy": "Հորթի սրունք բակլայով", "ru": "Телячья голяшка с бобами"}', NULL, 33000, ARRAY[]::varchar[], 11);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c02', 'v14', '{"en": "BBQ and Grill", "hy": "Խորոված և Գրիլ", "ru": "Барбекю и гриль"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i030', 'v14-c02', 'v14', '{"en": "Potatoes plech", "hy": "Կարտոֆիլի պլեճ", "ru": "Картофель плеч"}', NULL, 900, ARRAY[]::varchar[], 0),
('v14-i031', 'v14-c02', 'v14', '{"en": "Kebab Chicken", "hy": "Քյաբաբ հավի", "ru": "Люля-кебаб из курицы"}', NULL, 1700, ARRAY[]::varchar[], 1),
('v14-i032', 'v14-c02', 'v14', '{"en": "Kebab Veal", "hy": "Քյաբաբ հորթի", "ru": "Люля-кебаб из телятины"}', NULL, 1900, ARRAY[]::varchar[], 2),
('v14-i033', 'v14-c02', 'v14', '{"en": "Kebab Almast", "hy": "Քյաբաբ Ալմաստ", "ru": "Кебаб Алмаст"}', NULL, 2100, ARRAY[]::varchar[], 3),
('v14-i034', 'v14-c02', 'v14', '{"en": "Kebab Adana", "hy": "Քյաբաբ Ադանա", "ru": "Кебаб Адана"}', NULL, 2200, ARRAY[]::varchar[], 4),
('v14-i035', 'v14-c02', 'v14', '{"en": "Shish tawook", "hy": "Շիշ տաուկ", "ru": "Шиш таук"}', NULL, 2400, ARRAY[]::varchar[], 5),
('v14-i036', 'v14-c02', 'v14', '{"en": "Kebab Ktoor", "hy": "Քյաբաբ Կտուր", "ru": "Кебаб Ктур"}', NULL, 2500, ARRAY[]::varchar[], 6),
('v14-i037', 'v14-c02', 'v14', '{"en": "White fish BBQ", "hy": "Սպիտակ ձկան խորոված", "ru": "Белая рыба на гриле"}', NULL, 3300, ARRAY[]::varchar[], 7),
('v14-i038', 'v14-c02', 'v14', '{"en": "Pork chops", "hy": "Խոզի չալաղաջ", "ru": "Свиные отбивные"}', NULL, 3900, ARRAY[]::varchar[], 8),
('v14-i039', 'v14-c02', 'v14', '{"en": "Fried chicken wings", "hy": "Տապակած հավի թևիկներ", "ru": "Жареные куриные крылышки"}', NULL, 4000, ARRAY[]::varchar[], 9),
('v14-i040', 'v14-c02', 'v14', '{"en": "Pork ribs", "hy": "Խոզի կողեր", "ru": "Свиные ребрышки"}', NULL, 4200, ARRAY[]::varchar[], 10),
('v14-i041', 'v14-c02', 'v14', '{"en": "Veal fillet", "hy": "Հորթի ֆիլե", "ru": "Филе телятины"}', NULL, 4200, ARRAY[]::varchar[], 11),
('v14-i042', 'v14-c02', 'v14', '{"en": "Pork loin", "hy": "Խոզի փափկամիս", "ru": "Свиная корейка"}', NULL, 4400, ARRAY[]::varchar[], 12),
('v14-i043', 'v14-c02', 'v14', '{"en": "Lamb BBQ", "hy": "Գառան խորոված", "ru": "Шашлык из баранины"}', NULL, 4700, ARRAY[]::varchar[], 13),
('v14-i044', 'v14-c02', 'v14', '{"en": "Veal tenderloin", "hy": "Հորթի փափկամիս", "ru": "Телячья вырезка"}', NULL, 6900, ARRAY[]::varchar[], 14),
('v14-i045', 'v14-c02', 'v14', '{"en": "Under one roof", "hy": "Մեկ հարկի տակ", "ru": "Под одной крышей"}', NULL, 24000, ARRAY[]::varchar[], 15),
('v14-i046', 'v14-c02', 'v14', '{"en": "Sterlet BBQ", "hy": "Ստերլետի խորոված", "ru": "Стерлядь на гриле"}', NULL, 26000, ARRAY[]::varchar[], 16);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c03', 'v14', '{"en": "Pideh & Lahmajo", "hy": "Պիդե և Լահմաջո", "ru": "Пиде и Лахмаджо"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i047', 'v14-c03', 'v14', '{"en": "Sailboat", "hy": "Առագաստ", "ru": "Парусник"}', NULL, 2000, ARRAY[]::varchar[], 0),
('v14-i048', 'v14-c03', 'v14', '{"en": "Garden", "hy": "Պարտեզ", "ru": "Сад"}', NULL, 2000, ARRAY[]::varchar[], 1),
('v14-i049', 'v14-c03', 'v14', '{"en": "Lahmajo", "hy": "Լահմաջո", "ru": "Лахмаджо"}', NULL, 2000, ARRAY[]::varchar[], 2),
('v14-i050', 'v14-c03', 'v14', '{"en": "Tomato pideh", "hy": "Լոլիկով պիդե", "ru": "Томатное пиде"}', NULL, 2100, ARRAY[]::varchar[], 3),
('v14-i051', 'v14-c03', 'v14', '{"en": "Cheesy pideh", "hy": "Պանրով պիդե", "ru": "Сырное пиде"}', NULL, 2400, ARRAY[]::varchar[], 4),
('v14-i052', 'v14-c03', 'v14', '{"en": "Pepperoni pideh", "hy": "Պեպերոնի պիդե", "ru": "Пиде пепперони"}', NULL, 2700, ARRAY[]::varchar[], 5),
('v14-i053', 'v14-c03', 'v14', '{"en": "Sujukh pideh", "hy": "Սուջուխով պիդե", "ru": "Пиде с суджухом"}', NULL, 2800, ARRAY[]::varchar[], 6),
('v14-i054', 'v14-c03', 'v14', '{"en": "Khashkhash pideh", "hy": "Խաշխաշ պիդե", "ru": "Хашхаш пиде"}', NULL, 2900, ARRAY[]::varchar[], 7),
('v14-i055', 'v14-c03', 'v14', '{"en": "Kars pideh", "hy": "Կարսի պիդե", "ru": "Карс пиде"}', NULL, 3600, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c04', 'v14', '{"en": "Appetizers", "hy": "Նախուտեստներ", "ru": "Закуски"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i056', 'v14-c04', 'v14', '{"en": "Strained matzoun", "hy": "Քամած մածուն", "ru": "Камац мацун"}', NULL, 900, ARRAY[]::varchar[], 0),
('v14-i057', 'v14-c04', 'v14', '{"en": "Bread Basket", "hy": "Հացի զամբյուղ", "ru": "Хлебная корзина"}', NULL, 900, ARRAY[]::varchar[], 1),
('v14-i058', 'v14-c04', 'v14', '{"en": "French fries", "hy": "Կարտոֆիլ ֆրի", "ru": "Картофель фри"}', NULL, 1100, ARRAY[]::varchar[], 2),
('v14-i059', 'v14-c04', 'v14', '{"en": "Imam bayildi", "hy": "Իմամ բայալդի", "ru": "Имам баянди"}', NULL, 1400, ARRAY[]::varchar[], 3),
('v14-i060', 'v14-c04', 'v14', '{"en": "Appetite", "hy": "Ախորժակ", "ru": "Аппетит"}', NULL, 1400, ARRAY[]::varchar[], 4),
('v14-i061', 'v14-c04', 'v14', '{"en": "Rejan", "hy": "Ռեժան", "ru": "Режан"}', NULL, 1400, ARRAY[]::varchar[], 5),
('v14-i062', 'v14-c04', 'v14', '{"en": "Dzadziki", "hy": "Ձաձիկի", "ru": "Дзадзики"}', NULL, 1500, ARRAY[]::varchar[], 6),
('v14-i063', 'v14-c04', 'v14', '{"en": "Greens", "hy": "Կանաչի", "ru": "Зелень"}', NULL, 1700, ARRAY[]::varchar[], 7),
('v14-i064', 'v14-c04', 'v14', '{"en": "Homemade fried potato", "hy": "Տնական տապակած կարտոֆիլ", "ru": "Домашний жареный картофель"}', NULL, 1800, ARRAY[]::varchar[], 8),
('v14-i065', 'v14-c04', 'v14', '{"en": "Cheese balls", "hy": "Պանրե գնդիկներ", "ru": "Сырные шарики"}', NULL, 1900, ARRAY[]::varchar[], 9),
('v14-i066', 'v14-c04', 'v14', '{"en": "Marinated olives", "hy": "Մարինացված ձիթապտուղ", "ru": "Маринованные оливки"}', NULL, 2100, ARRAY[]::varchar[], 10),
('v14-i067', 'v14-c04', 'v14', '{"en": "Pickled", "hy": "Թթուների տեսականի", "ru": "Соленья"}', NULL, 2300, ARRAY[]::varchar[], 11),
('v14-i068', 'v14-c04', 'v14', '{"en": "Eastern dips", "hy": "Արևելյան դիպեր", "ru": "Восточные дипы"}', NULL, 2400, ARRAY[]::varchar[], 12),
('v14-i069', 'v14-c04', 'v14', '{"en": "Aubergine rolls", "hy": "Սմբուկով ռուլետներ", "ru": "Рулетики из баклажанов"}', NULL, 2600, ARRAY[]::varchar[], 13),
('v14-i070', 'v14-c04', 'v14', '{"en": "Cheese assortment", "hy": "Պանրի տեսականի", "ru": "Сырное ассорти"}', NULL, 2800, ARRAY[]::varchar[], 14),
('v14-i071', 'v14-c04', 'v14', '{"en": "Curred beef roll", "hy": "Բաստուրմայով ռուլետ", "ru": "Рулет из вяленой говядины"}', NULL, 3100, ARRAY[]::varchar[], 15),
('v14-i072', 'v14-c04', 'v14', '{"en": "Meat assortment", "hy": "Մսի տեսականի", "ru": "Мясное ассорти"}', NULL, 4500, ARRAY[]::varchar[], 16),
('v14-i073', 'v14-c04', 'v14', '{"en": "Thal (Salted veal)", "hy": "Տհալ (Ղավուրմա)", "ru": "Тал (Соленая телятина)"}', NULL, 4700, ARRAY[]::varchar[], 17),
('v14-i074', 'v14-c04', 'v14', '{"en": "Wine cheese assortment", "hy": "Պանրի տեսականի գինու համար", "ru": "Сырное ассорти к вину"}', NULL, 6000, ARRAY[]::varchar[], 18);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c05', 'v14', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i075', 'v14-c05', 'v14', '{"en": "Red beans", "hy": "Կարմիր լոբի", "ru": "Красная фасоль"}', NULL, 1300, ARRAY[]::varchar[], 0),
('v14-i076', 'v14-c05', 'v14', '{"en": "Beans and dandur", "hy": "Լոբի և դանդուռ", "ru": "Фасоль и дандур"}', NULL, 1800, ARRAY[]::varchar[], 1),
('v14-i077', 'v14-c05', 'v14', '{"en": "Summer / Sorrel", "hy": "Ամառային / Ավելուկ", "ru": "Летний / Щавель"}', NULL, 2200, ARRAY[]::varchar[], 2),
('v14-i078', 'v14-c05', 'v14', '{"en": "Tabbouleh", "hy": "Թաբուլե", "ru": "Табуле"}', NULL, 2300, ARRAY[]::varchar[], 3),
('v14-i079', 'v14-c05', 'v14', '{"en": "Olivier", "hy": "Օլիվիե", "ru": "Оливье"}', NULL, 2500, ARRAY[]::varchar[], 4),
('v14-i080', 'v14-c05', 'v14', '{"en": "Greek / Broccoli", "hy": "Հունական / Բրոկոլի", "ru": "Греческий / Брокколи"}', NULL, 2700, ARRAY[]::varchar[], 5),
('v14-i081', 'v14-c05', 'v14', '{"en": "Grilled chicken", "hy": "Հավի խորովածով աղցան", "ru": "Курица гриль"}', NULL, 3000, ARRAY[]::varchar[], 6),
('v14-i082', 'v14-c05', 'v14', '{"en": "Salad Ktoor", "hy": "Աղցան Կտուր", "ru": "Салат Ктур"}', NULL, 3100, ARRAY[]::varchar[], 7),
('v14-i083', 'v14-c05', 'v14', '{"en": "Gandzak", "hy": "Գանձակ", "ru": "Гандзак"}', NULL, 3300, ARRAY[]::varchar[], 8),
('v14-i084', 'v14-c05', 'v14', '{"en": "Salad Thal", "hy": "Աղցան Տհալ", "ru": "Салат Тал"}', NULL, 3800, ARRAY[]::varchar[], 9);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v14-c06', 'v14', '{"en": "Soups", "hy": "Ապուրներ", "ru": "Супы"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v14-i085', 'v14-c06', 'v14', '{"en": "Spas", "hy": "Սպաս", "ru": "Спас"}', NULL, 1100, ARRAY[]::varchar[], 0),
('v14-i086', 'v14-c06', 'v14', '{"en": "Aveluk", "hy": "Ավելուկ", "ru": "Авелук"}', NULL, 1300, ARRAY[]::varchar[], 1),
('v14-i087', 'v14-c06', 'v14', '{"en": "Lentil", "hy": "Ոսպապուր", "ru": "Чечевичный"}', NULL, 1300, ARRAY[]::varchar[], 2),
('v14-i088', 'v14-c06', 'v14', '{"en": "Chicken", "hy": "Հավի ապուր", "ru": "Куриный"}', NULL, 1400, ARRAY[]::varchar[], 3),
('v14-i089', 'v14-c06', 'v14', '{"en": "Ishli soup", "hy": "Իշլի ապուր", "ru": "Ишли суп"}', NULL, 1600, ARRAY[]::varchar[], 4),
('v14-i090', 'v14-c06', 'v14', '{"en": "Bean soup", "hy": "Լոբով ապուր", "ru": "Фасолевый суп"}', NULL, 1700, ARRAY[]::varchar[], 5),
('v14-i091', 'v14-c06', 'v14', '{"en": "Borsch", "hy": "Բորշ", "ru": "Борщ"}', NULL, 1900, ARRAY[]::varchar[], 6),
('v14-i092', 'v14-c06', 'v14', '{"en": "Soltwort", "hy": "Սոլյանկա", "ru": "Солянка"}', NULL, 2500, ARRAY[]::varchar[], 7),
('v14-i093', 'v14-c06', 'v14', '{"en": "Kharcho", "hy": "Խարչո", "ru": "Харчо"}', NULL, 2700, ARRAY[]::varchar[], 8);

-- ═══ Mao (v15) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v15', 'Mao', 'mao',
 '{"en": "Mao — a popular restaurant in Yerevan."}',
 ARRAY['Asian','Chinese','Sushi','Wok'], 2, 4.4, 98,
 'Amiryan St 26, Yerevan 0010', 40.1798, 44.5182, '+374 10 636363',
 ARRAY['WiFi','Air Conditioning','Takeout','Delivery'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v15', 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?w=800', 0),
('v15', 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800', 1),
('v15', 'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v15', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v15-z1', 'v15', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v15-z2', 'v15', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v15-t1', 'v15', 'v15-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v15-t2', 'v15', 'v15-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v15-t3', 'v15', 'v15-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v15-t4', 'v15', 'v15-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v15-t5', 'v15', 'v15-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v15-t6', 'v15', 'v15-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000015', 'v15', 'Mao Admin', 'admin-mao@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 636363', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c00', 'v15', '{"en": "Appetizers", "hy": "Նախուտեստներ", "ru": "Закуски"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i001', 'v15-c00', 'v15', '{"en": "Kimchi Cucumber", "hy": "Կիմչի վարունգով", "ru": "Кимчи из огурцов"}', NULL, 2750, ARRAY[]::varchar[], 0),
('v15-i002', 'v15-c00', 'v15', '{"en": "Kimchi Pineapple", "hy": "Կիմչի անանասով", "ru": "Кимчи из ананаса"}', NULL, 2970, ARRAY[]::varchar[], 1),
('v15-i003', 'v15-c00', 'v15', '{"en": "Deep Fried Sweet Potato Shrimps", "hy": "Տապակած մրգային կարտոֆիլով (բատատ) ծովախեցգետիններ", "ru": "Креветки во фритюре со сладким картофелем"}', NULL, 4290, ARRAY[]::varchar[], 2),
('v15-i004', 'v15-c00', 'v15', '{"en": "Crispy Prawn with Mango Salsa and Wasabi Sauce", "hy": "Խրթխրթան ծովախեցգետին մանգոյի սալսայով և վասաբի սոուսով", "ru": "Хрустящие креветки с сальсой из манго и соусом васаби"}', NULL, 4290, ARRAY[]::varchar[], 3),
('v15-i005', 'v15-c00', 'v15', '{"en": "Fresh Spring Rolls with Vegetables", "hy": "Թարմ սփրինգ ռոլլեր բանջարեղենով", "ru": "Свежие спринг-роллы с овощами"}', NULL, 3850, ARRAY[]::varchar[], 4),
('v15-i006', 'v15-c00', 'v15', '{"en": "Edamame Classic", "hy": "Էդամամե դասական", "ru": "Эдамаме классические"}', NULL, 2750, ARRAY[]::varchar[], 5),
('v15-i007', 'v15-c00', 'v15', '{"en": "Edamame Spicy", "hy": "Էդամամե կծու", "ru": "Эдамаме острые"}', NULL, 2750, ARRAY[]::varchar[], 6),
('v15-i008', 'v15-c00', 'v15', '{"en": "Peking Duck Soft Tacos", "hy": "Պեկինյան բադով փափուկ տակոներ", "ru": "Мягкие тако с уткой по-пекински"}', NULL, 4290, ARRAY[]::varchar[], 7),
('v15-i009', 'v15-c00', 'v15', '{"en": "Rock Shrimp Tempura", "hy": "Ռոք ծովախեցգետին տեմպուրա", "ru": "Креветки Рок Темпура"}', NULL, 6050, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c01', 'v15', '{"en": "Poke Bowls", "hy": "Պոկե բոուլներ", "ru": "Поке боулы"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i010', 'v15-c01', 'v15', '{"en": "Salmon Poke Bowl", "hy": "Պոկե բոուլ սաղմոնով", "ru": "Поке боул с лососем"}', NULL, 6490, ARRAY[]::varchar[], 0),
('v15-i011', 'v15-c01', 'v15', '{"en": "Vegetable Poke Bowl", "hy": "Բանջարեղենային պոկե բոուլ", "ru": "Овощной поке боул"}', NULL, 4290, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c02', 'v15', '{"en": "Soups", "hy": "Ապուրներ", "ru": "Супы"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i012', 'v15-c02', 'v15', '{"en": "Miso Soup", "hy": "Միսո ապուր", "ru": "Мисо суп"}', NULL, 2750, ARRAY[]::varchar[], 0),
('v15-i013', 'v15-c02', 'v15', '{"en": "Tom Yum Goong", "hy": "Տոմ Յամ Գունգ", "ru": "Том Ям Гунг"}', NULL, 4290, ARRAY[]::varchar[], 1),
('v15-i014', 'v15-c02', 'v15', '{"en": "Hot and Sour Soup", "hy": "Թթվակծու ապուր", "ru": "Кисло-острый суп"}', NULL, 2750, ARRAY[]::varchar[], 2),
('v15-i015', 'v15-c02', 'v15', '{"en": "Corn Crab Soup", "hy": "Եգիպտացորենի ապուր խեցգետնով", "ru": "Кукурузный суп с крабом"}', NULL, 2750, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c03', 'v15', '{"en": "Salads", "hy": "Աղցաններ", "ru": "Салаты"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i016', 'v15-c03', 'v15', '{"en": "Chuka Wakawe with Sesame Sauce", "hy": "Չուկա Վակամե քունջութի սոուսով", "ru": "Чука Вакаме с кунжутным соусом"}', NULL, 3850, ARRAY[]::varchar[], 0),
('v15-i017', 'v15-c03', 'v15', '{"en": "Mango and Cucumber Salad with Seared Fresh Tuna", "hy": "Մանգոյով և վարունգով աղցան թեթև տապակած թյուննոսով", "ru": "Салат с манго и огурцом с обожженным свежим тунцом"}', NULL, 4730, ARRAY[]::varchar[], 1),
('v15-i018', 'v15-c03', 'v15', '{"en": "Vietnamese Glass Noodle Salad with Baby Squids", "hy": "Վիետնամական ապակյա լապշայով աղցան փոքր կաղամարներով", "ru": "Вьетнамский салат из стеклянной лапши с маленькими кальмарами"}', NULL, 3850, ARRAY[]::varchar[], 2),
('v15-i019', 'v15-c03', 'v15', '{"en": "Pig Ear Salad", "hy": "Խոզի ականջով աղցան", "ru": "Салат из свиных ушей"}', NULL, 3850, ARRAY[]::varchar[], 3),
('v15-i020', 'v15-c03', 'v15', '{"en": "Thai Pomelo Salad (Yam Som O)", "hy": "Թայլանդական պոմելոյով աղցան (Յամ Սոմ Օ)", "ru": "Тайский салат из помело (Ям Сом О)"}', NULL, 3850, ARRAY[]::varchar[], 4),
('v15-i021', 'v15-c03', 'v15', '{"en": "Spicy Sechuan Beef Salad", "hy": "Կծու սեչուանյան տավարի մսով աղցան", "ru": "Острый салат с говядиной по-сычуаньски"}', NULL, 4730, ARRAY[]::varchar[], 5),
('v15-i022', 'v15-c03', 'v15', '{"en": "Crispy Duck Salad", "hy": "Խրթխրթան բադով աղցան", "ru": "Салат с хрустящей уткой"}', NULL, 4730, ARRAY[]::varchar[], 6),
('v15-i023', 'v15-c03', 'v15', '{"en": "Spicy Mango Salad (Yam Mamuang)", "hy": "Կծու մանգոյով աղցան (Յամ Մամուանգ)", "ru": "Острый салат из манго (Ям Мамуанг)"}', NULL, 3850, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c04', 'v15', '{"en": "Noodles", "hy": "Լապշա", "ru": "Лапша"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i024', 'v15-c04', 'v15', '{"en": "Pad Siu Beef", "hy": "Փադ Սիու տավարի մսով", "ru": "Пад Сиу с говядиной"}', NULL, 5390, ARRAY[]::varchar[], 0),
('v15-i025', 'v15-c04', 'v15', '{"en": "Roast Duck Chow Mein", "hy": "Չաու Մեյն տապակած բադով", "ru": "Чоу мейн с жареной уткой"}', NULL, 5390, ARRAY[]::varchar[], 1),
('v15-i026', 'v15-c04', 'v15', '{"en": "Pad Thai with Shrimps", "hy": "Փադ Թայ ծովախեցգետիններով", "ru": "Пад Тай с креветками"}', NULL, 5830, ARRAY[]::varchar[], 2),
('v15-i027', 'v15-c04', 'v15', '{"en": "Yaki Udon Seafood", "hy": "Յակի Ուդոն ծովամթերքով", "ru": "Яки удон с морепродуктами"}', NULL, 5830, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c05', 'v15', '{"en": "Rice", "hy": "Բրինձ", "ru": "Рис"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i028', 'v15-c05', 'v15', '{"en": "Garlic Egg Fried Rice", "hy": "Սխտորով և ձվով տապակած բրինձ", "ru": "Жареный рис с чесноком и яйцом"}', NULL, 2750, ARRAY[]::varchar[], 0),
('v15-i029', 'v15-c05', 'v15', '{"en": "Chao Fan Rice with Vegetables", "hy": "Չաո Ֆան բրինձ բանջարեղենով", "ru": "Рис Чао Фань с овощами"}', NULL, 2750, ARRAY[]::varchar[], 1),
('v15-i030', 'v15-c05', 'v15', '{"en": "Chicken Fried Rice in Teriyaki Sauce", "hy": "Հավի մսով տապակած բրինձ տերիյակի սոուսով", "ru": "Жареный рис с курицей в соусе терияки"}', NULL, 2750, ARRAY[]::varchar[], 2),
('v15-i031', 'v15-c05', 'v15', '{"en": "Seafood Fried Rice", "hy": "Ծովամթերքով տապակած բրինձ", "ru": "Жареный рис с морепродуктами"}', NULL, 3850, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c06', 'v15', '{"en": "Main Dishes", "hy": "Հիմնական ուտեստներ", "ru": "Основные блюда"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i032', 'v15-c06', 'v15', '{"en": "Oyster Sauce Beef", "hy": "Տավարի միս ոստրեի սոուսով", "ru": "Говядина в устричном соусе"}', NULL, 6930, ARRAY[]::varchar[], 0),
('v15-i033', 'v15-c06', 'v15', '{"en": "Cantonese Style Dorade (Shiitake, Ginger & Green Onions)", "hy": "Կանտոնական ոճի դորադո (շիիտակե, կոճապղպեղ և կանաչ սոխ)", "ru": "Дорадо по-кантонски (шиитаке, имбирь и зеленый лук)"}', NULL, 13090, ARRAY[]::varchar[], 1),
('v15-i034', 'v15-c06', 'v15', '{"en": "Wok Fried Shrimps in Tamarind Sauce", "hy": "Վոկ տապակած ծովախեցգետիններ թամարինդի սոուսով", "ru": "Креветки на воке в тамариндовом соусе"}', NULL, 7590, ARRAY[]::varchar[], 2),
('v15-i035', 'v15-c06', 'v15', '{"en": "Sweet and Sour Chicken", "hy": "Թթվաքաղցր հավի միս", "ru": "Кисло-сладкая курица"}', NULL, 5390, ARRAY[]::varchar[], 3),
('v15-i036', 'v15-c06', 'v15', '{"en": "Mongolian Beef", "hy": "Մոնղոլական տավարի միս", "ru": "Говядина по-монгольски"}', NULL, 6930, ARRAY[]::varchar[], 4),
('v15-i037', 'v15-c06', 'v15', '{"en": "Green Basil Lamb", "hy": "Գառան միս կանաչ ռեհանով", "ru": "Ягнятина с зеленым базиликом"}', NULL, 5390, ARRAY[]::varchar[], 5),
('v15-i038', 'v15-c06', 'v15', '{"en": "Kung Pao Chicken", "hy": "Կունգ Պաո հավի միս", "ru": "Курица Кунг Пао"}', NULL, 5390, ARRAY[]::varchar[], 6),
('v15-i039', 'v15-c06', 'v15', '{"en": "Peking Duck Half", "hy": "Պեկինյան բադ (կես)", "ru": "Утка по-пекински (половина)"}', NULL, 10890, ARRAY[]::varchar[], 7),
('v15-i040', 'v15-c06', 'v15', '{"en": "Peking Duck Whole", "hy": "Պեկինյան բադ (ամբողջական)", "ru": "Утка по-пекински (целая)"}', NULL, 19690, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c07', 'v15', '{"en": "Sashimi", "hy": "Սաշիմի", "ru": "Сашими"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i041', 'v15-c07', 'v15', '{"en": "Eel Sashimi", "hy": "Սաշիմի օձաձկով", "ru": "Сашими с угрем"}', NULL, 3960, ARRAY[]::varchar[], 0),
('v15-i042', 'v15-c07', 'v15', '{"en": "Salmon Sashimi", "hy": "Սաշիմի սաղմոնով", "ru": "Сашими с лососем"}', NULL, 3960, ARRAY[]::varchar[], 1),
('v15-i043', 'v15-c07', 'v15', '{"en": "Shrimp Sashimi", "hy": "Սաշիմի ծովախեցգետնով", "ru": "Сашими с креветкой"}', NULL, 3520, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c08', 'v15', '{"en": "Nigiri", "hy": "Նիգիրի", "ru": "Нигири"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i044', 'v15-c08', 'v15', '{"en": "Scallop Nigiri", "hy": "Նիգիրի սանրիկով", "ru": "Нигири с гребешком"}', NULL, 5390, ARRAY[]::varchar[], 0),
('v15-i045', 'v15-c08', 'v15', '{"en": "Eel Nigiri", "hy": "Նիգիրի օձաձկով", "ru": "Нигири с угрем"}', NULL, 3960, ARRAY[]::varchar[], 1),
('v15-i046', 'v15-c08', 'v15', '{"en": "Salmon Nigiri", "hy": "Նիգիրի սաղմոնով", "ru": "Нигири с лососем"}', NULL, 3960, ARRAY[]::varchar[], 2),
('v15-i047', 'v15-c08', 'v15', '{"en": "Shrimp Nigiri", "hy": "Նիգիրի ծովախեցգետնով", "ru": "Нигири с креветкой"}', NULL, 3410, ARRAY[]::varchar[], 3);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c09', 'v15', '{"en": "Rolls", "hy": "Ռոլլեր", "ru": "Роллы"}', 9);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i048', 'v15-c09', 'v15', '{"en": "Osaka Roll", "hy": "Օսակա ռոլլ", "ru": "Осака ролл"}', NULL, 6490, ARRAY[]::varchar[], 0),
('v15-i049', 'v15-c09', 'v15', '{"en": "Sendai Roll", "hy": "Սենդայ ռոլլ", "ru": "Сендай ролл"}', NULL, 6490, ARRAY[]::varchar[], 1),
('v15-i050', 'v15-c09', 'v15', '{"en": "Gold Dragon Roll", "hy": "Ոսկե վիշապ ռոլլ", "ru": "Ролл Золотой дракон"}', NULL, 6490, ARRAY[]::varchar[], 2),
('v15-i051', 'v15-c09', 'v15', '{"en": "Scallop Tartare Roll", "hy": "Սանրիկի տարտարով ռոլլ", "ru": "Ролл с тартаром из гребешка"}', NULL, 6490, ARRAY[]::varchar[], 3),
('v15-i052', 'v15-c09', 'v15', '{"en": "Alaska Roll", "hy": "Ալյասկա ռոլլ", "ru": "Аляска ролл"}', NULL, 6490, ARRAY[]::varchar[], 4),
('v15-i053', 'v15-c09', 'v15', '{"en": "Classic Philadelphia Roll", "hy": "Դասական Ֆիլադելֆիա ռոլլ", "ru": "Классический ролл Филадельфия"}', NULL, 5060, ARRAY[]::varchar[], 5),
('v15-i054', 'v15-c09', 'v15', '{"en": "Green Dragon Roll", "hy": "Կանաչ վիշապ ռոլլ", "ru": "Ролл Зеленый дракон"}', NULL, 4620, ARRAY[]::varchar[], 6),
('v15-i055', 'v15-c09', 'v15', '{"en": "California Roll", "hy": "Կալիֆորնիա ռոլլ", "ru": "Калифорния ролл"}', NULL, 4620, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v15-c10', 'v15', '{"en": "Chef''s Combos", "hy": "Շեֆի կոմբոներ", "ru": "Комбо от шефа"}', 10);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v15-i056', 'v15-c10', 'v15', '{"en": "Mao''s Big Garden", "hy": "Մաոյի մեծ այգի", "ru": "Большой сад Мао"}', NULL, 39600, ARRAY[]::varchar[], 0),
('v15-i057', 'v15-c10', 'v15', '{"en": "Mao''s Small Garden", "hy": "Մաոյի փոքր այգի", "ru": "Маленький сад Мао"}', NULL, 19800, ARRAY[]::varchar[], 1),
('v15-i058', 'v15-c10', 'v15', '{"en": "Mao''s Big Sashimi Set", "hy": "Մաոյի սաշիմի մեծ հավաքածու", "ru": "Большой сет сашими Мао"}', NULL, 13200, ARRAY[]::varchar[], 2),
('v15-i059', 'v15-c10', 'v15', '{"en": "Mao''s Small Sashimi Set", "hy": "Մաոյի սաշիմի փոքր հավաքածու", "ru": "Маленький сет сашими Мао"}', NULL, 8690, ARRAY[]::varchar[], 3);

-- ═══ Mozzarella (v16) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v16', 'Mozzarella', 'mozzarella',
 '{"en": "Mozzarella — a popular restaurant in Yerevan."}',
 ARRAY['Italian','Pizza','Pasta'], 2, 4.3, 167,
 'Mashtots Ave 32, Yerevan 0015', 40.1856, 44.5076, '+374 10 646464',
 ARRAY['WiFi','Takeout','Delivery','Air Conditioning'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v16', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', 0),
('v16', 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800', 1),
('v16', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v16', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v16-z1', 'v16', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v16-z2', 'v16', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v16-t1', 'v16', 'v16-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v16-t2', 'v16', 'v16-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v16-t3', 'v16', 'v16-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v16-t4', 'v16', 'v16-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v16-t5', 'v16', 'v16-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v16-t6', 'v16', 'v16-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000016', 'v16', 'Mozzarella Admin', 'admin-mozzarella@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 646464', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v16-c00', 'v16', '{"en": "Pizza Neapolitan", "hy": "Պիցցա Նեապոլիտանական", "ru": "Пицца Неаполитанская"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v16-i001', 'v16-c00', 'v16', '{"en": "Signature pizza with meat", "hy": "Ֆիրմային պիցցա մսով", "ru": "Фирменная пицца с мясом"}', NULL, 4500, ARRAY[]::varchar[], 0),
('v16-i002', 'v16-c00', 'v16', '{"en": "Pizza with prosciutto and arugula", "hy": "Պիցցա պրոշուտոյով և ռուկոլայով", "ru": "Пицца с прошутто и рукколой"}', NULL, 4800, ARRAY[]::varchar[], 1),
('v16-i003', 'v16-c00', 'v16', '{"en": "Pizza with salmon", "hy": "Պիցցա սաղմոնով", "ru": "Пицца с лососем"}', NULL, 4500, ARRAY[]::varchar[], 2),
('v16-i004', 'v16-c00', 'v16', '{"en": "Pizza Maria", "hy": "Պիցցա Մարիա", "ru": "Пицца Мария"}', NULL, 4500, ARRAY[]::varchar[], 3),
('v16-i005', 'v16-c00', 'v16', '{"en": "Burrata Pesto / Burrata Bomb", "hy": "Բուրատա Պեստո / Բուրատա Բոմբ", "ru": "Буррата Песто / Буррата Бомб"}', NULL, 5500, ARRAY[]::varchar[], 4),
('v16-i006', 'v16-c00', 'v16', '{"en": "Pizza Pepperoni / Pizza Neapolitan", "hy": "Պիցցա Պեպերոնի / Պիցցա Նեապոլիտանական", "ru": "Пицца Пепперони / Пицца Неаполитанская"}', NULL, 4200, ARRAY[]::varchar[], 5),
('v16-i007', 'v16-c00', 'v16', '{"en": "Pizza with bacon and mascarpone", "hy": "Պիցցա բեկոնով և մասկարպոնեով", "ru": "Пицца с беконом и маскарпоне"}', NULL, 3900, ARRAY[]::varchar[], 6),
('v16-i008', 'v16-c00', 'v16', '{"en": "This is not four cheese", "hy": "Սա չորս պանիր չէ", "ru": "Это не четыре сыра"}', NULL, 3900, ARRAY[]::varchar[], 7),
('v16-i009', 'v16-c00', 'v16', '{"en": "Pizza Capricciosa", "hy": "Պիցցա Կապրիչիոզա", "ru": "Пицца Капричоза"}', NULL, 3900, ARRAY[]::varchar[], 8),
('v16-i010', 'v16-c00', 'v16', '{"en": "Pizza with chicken and mushrooms", "hy": "Պիցցա հավով և սնկով", "ru": "Пицца с курицей и грибами"}', NULL, 3600, ARRAY[]::varchar[], 9),
('v16-i011', 'v16-c00', 'v16', '{"en": "Calzone (Pepperoni or Bolognese)", "hy": "Կալցոնե (Պեպերոնի կամ Բոլոնյեզե)", "ru": "Кальцоне (Пепперони или Болоньезе)"}', NULL, 3300, ARRAY[]::varchar[], 10),
('v16-i012', 'v16-c00', 'v16', '{"en": "Pizza Margherita / Sweet pizza", "hy": "Պիցցա Մարգարիտա / Քաղցր պիցցա", "ru": "Пицца Маргарита / Сладкая пицца"}', NULL, 2900, ARRAY[]::varchar[], 11);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v16-c01', 'v16', '{"en": "Pasta & Risotto", "hy": "Պաստա և Ռիզոտո", "ru": "Паста и Ризотто"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v16-i013', 'v16-c01', 'v16', '{"en": "Tagliatelle (Shrimp or Salmon)", "hy": "Տալյատելե (ծովախեցգետնով կամ սաղմոնով)", "ru": "Тальятелле (с креветками или лососем)"}', NULL, 3900, ARRAY[]::varchar[], 0),
('v16-i014', 'v16-c01', 'v16', '{"en": "Tagliatelle Bolognese / Conchiglie Bolognese", "hy": "Տալյատելե Բոլոնյեզե / Կոնկիլյե Բոլոնյեզե", "ru": "Тальятелле Болоньезе / Конкилье Болоньезе"}', NULL, 3700, ARRAY[]::varchar[], 1),
('v16-i015', 'v16-c01', 'v16', '{"en": "Pasta Four cheese", "hy": "Պաստա Չորս պանիր", "ru": "Паста Четыре сыра"}', NULL, 3300, ARRAY[]::varchar[], 2),
('v16-i016', 'v16-c01', 'v16', '{"en": "Pasta Carbonara / Lasagna", "hy": "Պաստա Կարբոնարա / Լազանյա", "ru": "Паста Карбонара / Лазанья"}', NULL, 3200, ARRAY[]::varchar[], 3),
('v16-i017', 'v16-c01', 'v16', '{"en": "Risotto (Shrimps or Marbled Beef)", "hy": "Ռիզոտո (ծովախեցգետնով կամ մարմարյա տավարի մսով)", "ru": "Ризотто (с креветками или мраморной говядиной)"}', NULL, 3200, ARRAY[]::varchar[], 4),
('v16-i018', 'v16-c01', 'v16', '{"en": "Alfredo / Ravioli with eggplant", "hy": "Ալֆրեդո / Ռավիոլի սմբուկով", "ru": "Альфредо / Равиоли с баклажаном"}', NULL, 2900, ARRAY[]::varchar[], 5),
('v16-i019', 'v16-c01', 'v16', '{"en": "Arrabiata", "hy": "Արաբիատա", "ru": "Аррабиата"}', NULL, 2800, ARRAY[]::varchar[], 6),
('v16-i020', 'v16-c01', 'v16', '{"en": "Gnocchi Four cheeses", "hy": "Նյոկի Չորս պանիր", "ru": "Ньокки Четыре сыра"}', NULL, 2200, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v16-c02', 'v16', '{"en": "Main Dishes & Paninis", "hy": "Հիմնական ուտեստներ և Պանինի", "ru": "Основные блюда и Панини"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v16-i021', 'v16-c02', 'v16', '{"en": "Trout with warm green salad", "hy": "Իշխան տաք կանաչ աղցանով", "ru": "Форель с теплым зеленым салатом"}', NULL, 4900, ARRAY[]::varchar[], 0),
('v16-i022', 'v16-c02', 'v16', '{"en": "Veal tenderloin with mashed potatoes", "hy": "Հորթի փափկամիս կարտոֆիլի պյուրեով", "ru": "Телячья вырезка с картофельным пюре"}', NULL, 4900, ARRAY[]::varchar[], 1),
('v16-i023', 'v16-c02', 'v16', '{"en": "Grilled ribs with French fries", "hy": "Գրիլ արված կողիկներ կարտոֆիլ ֆրիով", "ru": "Ребрышки на гриле с картофелем фри"}', NULL, 4800, ARRAY[]::varchar[], 2),
('v16-i024', 'v16-c02', 'v16', '{"en": "Shrimp from the oven", "hy": "Ծովախեցգետին ջեռոցից", "ru": "Креветки из печи"}', NULL, 3900, ARRAY[]::varchar[], 3),
('v16-i025', 'v16-c02', 'v16', '{"en": "Chicken schnitzel with fried potatoes", "hy": "Հավի շնիցել տապակած կարտոֆիլով", "ru": "Куриный шницель с жареным картофелем"}', NULL, 2900, ARRAY[]::varchar[], 4),
('v16-i026', 'v16-c02', 'v16', '{"en": "Panini with prosciutto", "hy": "Պանինի պրոշուտոյով", "ru": "Панини с прошутто"}', NULL, 2900, ARRAY[]::varchar[], 5),
('v16-i027', 'v16-c02', 'v16', '{"en": "Panini with roast beef", "hy": "Պանինի ռոստբիֆով", "ru": "Панини с ростбифом"}', NULL, 1900, ARRAY[]::varchar[], 6),
('v16-i028', 'v16-c02', 'v16', '{"en": "Grilled Vegetables", "hy": "Գրիլ արված բանջարեղեն", "ru": "Овощи на гриле"}', NULL, 1900, ARRAY[]::varchar[], 7);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v16-c03', 'v16', '{"en": "Salads & Appetizers", "hy": "Աղցաններ և Նախուտեստներ", "ru": "Салаты и Закуски"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v16-i029', 'v16-c03', 'v16', '{"en": "Burrata with tomatoes", "hy": "Բուրատա լոլիկով", "ru": "Буррата с помидорами"}', NULL, 4900, ARRAY[]::varchar[], 0),
('v16-i030', 'v16-c03', 'v16', '{"en": "Roast beef salad / Salad with salmon", "hy": "Աղցան ռոստբիֆով / Աղցան սաղմոնով", "ru": "Салат с ростбифом / Салат с лососем"}', NULL, 3900, ARRAY[]::varchar[], 1),
('v16-i031', 'v16-c03', 'v16', '{"en": "Salad with shrimps, arugula, and vegetables", "hy": "Աղցան ծովախեցգետնով, ռուկոլայով և բանջարեղենով", "ru": "Салат с креветками, рукколой и овощами"}', NULL, 3800, ARRAY[]::varchar[], 2),
('v16-i032', 'v16-c03', 'v16', '{"en": "Caesar (Shrimp)", "hy": "Կեսար (ծովախեցգետնով)", "ru": "Цезарь (с креветками)"}', NULL, 3500, ARRAY[]::varchar[], 3),
('v16-i033', 'v16-c03', 'v16', '{"en": "Caesar (Chicken)", "hy": "Կեսար (հավով)", "ru": "Цезарь (с курицей)"}', NULL, 2900, ARRAY[]::varchar[], 4),
('v16-i034', 'v16-c03', 'v16', '{"en": "Ruby pear / Panzanella with spicy feta", "hy": "Ռուբինե տանձ / Պանցանելա կծու ֆետա պանրով", "ru": "Рубиновая груша / Панцанелла с острым сыром фета"}', NULL, 2900, ARRAY[]::varchar[], 5),
('v16-i035', 'v16-c03', 'v16', '{"en": "Salad Gianna (Goat cheese & tangerine)", "hy": "Աղցան Ջաննա (այծի պանիր և մանդարին)", "ru": "Салат Джанна (козий сыр и мандарин)"}', NULL, 2800, ARRAY[]::varchar[], 6),
('v16-i036', 'v16-c03', 'v16', '{"en": "Bruschetta with prosciutto / Bombolone", "hy": "Բրուսկետա պրոշուտոյով / Բոմբոլոնե", "ru": "Брускетта с прошутто / Бомболоне"}', NULL, 2300, ARRAY[]::varchar[], 7),
('v16-i037', 'v16-c03', 'v16', '{"en": "Antipasto", "hy": "Անտիպաստո", "ru": "Антипасто"}', NULL, 2100, ARRAY[]::varchar[], 8),
('v16-i038', 'v16-c03', 'v16', '{"en": "Croquettes with chicken / Grilled eggplant", "hy": "Կրոկետներ հավով / Գրիլ արված սմբուկ", "ru": "Крокеты с курицей / Баклажан на гриле"}', NULL, 1900, ARRAY[]::varchar[], 9);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v16-c04', 'v16', '{"en": "Desserts & Soups", "hy": "Աղանդեր և Ապուրներ", "ru": "Десерты и Супы"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v16-i039', 'v16-c04', 'v16', '{"en": "Viva Italy", "hy": "Վիվա Իտալիա", "ru": "Вива Италия"}', NULL, 2900, ARRAY[]::varchar[], 0),
('v16-i040', 'v16-c04', 'v16', '{"en": "Brownie with nuts and ice cream", "hy": "Բրաունի ընկույզով և պաղպաղակով", "ru": "Брауни с орехами и мороженым"}', NULL, 2500, ARRAY[]::varchar[], 1),
('v16-i041', 'v16-c04', 'v16', '{"en": "Tart with pecan", "hy": "Տարտ պեկանով", "ru": "Тарт с пеканом"}', NULL, 2300, ARRAY[]::varchar[], 2),
('v16-i042', 'v16-c04', 'v16', '{"en": "San Sebastian (Seasonal fruits/berries)", "hy": "Սան Սեբաստիան (սեզոնային մրգեր/հատապտուղներ)", "ru": "Сан-Себастьян (сезонные фрукты/ягоды)"}', NULL, 2100, ARRAY[]::varchar[], 3),
('v16-i043', 'v16-c04', 'v16', '{"en": "Cream soup with lentils and roast beef", "hy": "Ոսպով կրեմ-ապուր ռոստբիֆով", "ru": "Крем-суп из чечевицы с ростбифом"}', NULL, 1900, ARRAY[]::varchar[], 4),
('v16-i044', 'v16-c04', 'v16', '{"en": "Tartletka with mango", "hy": "Տարտլետկա մանգոյով", "ru": "Тартлетка с манго"}', NULL, 1900, ARRAY[]::varchar[], 5);

-- ═══ Patrick Pastry (v17) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v17', 'Patrick Pastry', 'patrick-pastry',
 '{"en": "Patrick Pastry — a popular restaurant in Yerevan."}',
 ARRAY['Bakery','Pastry','Coffee','Desserts'], 2, 4.5, 142,
 'Abovyan St 28, Yerevan 0001', 40.184, 44.5148, '+374 10 656565',
 ARRAY['WiFi','Takeout','Air Conditioning'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v17', 'https://images.unsplash.com/photo-1517433670267-08bbd4be890f?w=800', 0),
('v17', 'https://images.unsplash.com/photo-1486427944544-d2c246c4df14?w=800', 1),
('v17', 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v17', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v17-z1', 'v17', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v17-z2', 'v17', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v17-t1', 'v17', 'v17-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v17-t2', 'v17', 'v17-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v17-t3', 'v17', 'v17-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v17-t4', 'v17', 'v17-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v17-t5', 'v17', 'v17-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v17-t6', 'v17', 'v17-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000017', 'v17', 'Patrick Pastry Admin', 'admin-patrickpastry@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 656565', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c00', 'v17', '{"en": "Lent Menu", "hy": "Պահքի մենյու", "ru": "Постное меню"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i001', 'v17-c00', 'v17', '{"en": "Broccoli cream-soup", "hy": "Բրոկոլիի կրեմ-ապուր", "ru": "Крем-суп из брокколи"}', NULL, 2000, ARRAY[]::varchar[], 0),
('v17-i002', 'v17-c00', 'v17', '{"en": "Pasta Arrabiata", "hy": "Պաստա Արաբիատա", "ru": "Паста Аррабьята"}', NULL, 2800, ARRAY[]::varchar[], 1),
('v17-i003', 'v17-c00', 'v17', '{"en": "Village potatoes", "hy": "Գյուղական կարտոֆիլ", "ru": "Картофель по-деревенски"}', NULL, 1500, ARRAY[]::varchar[], 2),
('v17-i004', 'v17-c00', 'v17', '{"en": "French fries", "hy": "Կարտոֆիլ ֆրի", "ru": "Картофель фри"}', NULL, 1200, ARRAY[]::varchar[], 3),
('v17-i005', 'v17-c00', 'v17', '{"en": "Grilled vegetables", "hy": "Խորոված բանջարեղեն", "ru": "Овощи на гриле"}', NULL, 2400, ARRAY[]::varchar[], 4),
('v17-i006', 'v17-c00', 'v17', '{"en": "Eco yogurt with strawberry and chia", "hy": "Էկո յոգուրտ ելակով և չիայով", "ru": "Эко-йогурт с клубникой и чиа"}', NULL, 1700, ARRAY[]::varchar[], 5),
('v17-i007', 'v17-c00', 'v17', '{"en": "Green salad", "hy": "Կանաչ աղցան", "ru": "Зеленый салат"}', NULL, 2800, ARRAY[]::varchar[], 6),
('v17-i008', 'v17-c00', 'v17', '{"en": "Pesto", "hy": "Պեստո", "ru": "Песто"}', NULL, 2600, ARRAY[]::varchar[], 7),
('v17-i009', 'v17-c00', 'v17', '{"en": "Vegetable burger", "hy": "Բանջարեղենային բուրգեր", "ru": "Овощной бургер"}', NULL, 2900, ARRAY[]::varchar[], 8),
('v17-i010', 'v17-c00', 'v17', '{"en": "Tomato soup", "hy": "Լոլիկի ապուր", "ru": "Томатный суп"}', NULL, 2100, ARRAY[]::varchar[], 9),
('v17-i011', 'v17-c00', 'v17', '{"en": "Pumpkin cream soup", "hy": "Դդմի կրեմ-ապուր", "ru": "Тыквенный крем-суп"}', NULL, 1900, ARRAY[]::varchar[], 10),
('v17-i012', 'v17-c00', 'v17', '{"en": "Guacamole", "hy": "Գուակամոլե", "ru": "Гуакамоле"}', NULL, 2700, ARRAY[]::varchar[], 11),
('v17-i013', 'v17-c00', 'v17', '{"en": "Sweet potato fries", "hy": "Քաղցր կարտոֆիլ ֆրի (բատատ)", "ru": "Батат фри"}', NULL, 1500, ARRAY[]::varchar[], 12),
('v17-i014', 'v17-c00', 'v17', '{"en": "Chocolate mousse", "hy": "Շոկոլադե մուս", "ru": "Шоколадный мусс"}', NULL, 1600, ARRAY[]::varchar[], 13),
('v17-i015', 'v17-c00', 'v17', '{"en": "Hummus with avocado mesh", "hy": "Հումուս ավոկադոյով", "ru": "Хумус с авокадо"}', NULL, 2600, ARRAY[]::varchar[], 14),
('v17-i016', 'v17-c00', 'v17', '{"en": "Crispy eggplant", "hy": "Խրթխրթան սմբուկ", "ru": "Хрустящие баклажаны"}', NULL, 2500, ARRAY[]::varchar[], 15),
('v17-i017', 'v17-c00', 'v17', '{"en": "Spring roll", "hy": "Սփրինգ ռոլ", "ru": "Спринг-ролл"}', NULL, 2500, ARRAY[]::varchar[], 16),
('v17-i018', 'v17-c00', 'v17', '{"en": "Vegetable soup", "hy": "Բանջարեղենային ապուր", "ru": "Овощной суп"}', NULL, 2000, ARRAY[]::varchar[], 17),
('v17-i019', 'v17-c00', 'v17', '{"en": "Salad with quinoa", "hy": "Աղցան քինոայով", "ru": "Салат с киноа"}', NULL, 2700, ARRAY[]::varchar[], 18),
('v17-i020', 'v17-c00', 'v17', '{"en": "Ruby Delicacy", "hy": "Ռուբինե դելիկատես", "ru": "Рубиновый деликатес"}', NULL, 2200, ARRAY[]::varchar[], 19),
('v17-i021', 'v17-c00', 'v17', '{"en": "Golden batat", "hy": "Ոսկեփայլ բատատ", "ru": "Золотой батат"}', NULL, 2400, ARRAY[]::varchar[], 20),
('v17-i022', 'v17-c00', 'v17', '{"en": "Vanilla pie", "hy": "Վանիլային կարկանդակ", "ru": "Ванильный пирог"}', NULL, 1700, ARRAY[]::varchar[], 21),
('v17-i023', 'v17-c00', 'v17', '{"en": "Pistachio boulls", "hy": "Պիստակե գնդիկներ", "ru": "Фисташковые шарики"}', NULL, 2300, ARRAY[]::varchar[], 22);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c01', 'v17', '{"en": "Breakfast", "hy": "Նախաճաշ", "ru": "Завтрак"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i024', 'v17-c01', 'v17', '{"en": "French breakfast", "hy": "Ֆրանսիական նախաճաշ", "ru": "Французский завтрак"}', NULL, 3800, ARRAY[]::varchar[], 0),
('v17-i025', 'v17-c01', 'v17', '{"en": "Omelet with tomatoes", "hy": "Օմլետ լոլիկով", "ru": "Омлет с помидорами"}', NULL, 1800, ARRAY[]::varchar[], 1),
('v17-i026', 'v17-c01', 'v17', '{"en": "Classic omelet", "hy": "Դասական օմլետ", "ru": "Классический омлет"}', NULL, 1400, ARRAY[]::varchar[], 2),
('v17-i027', 'v17-c01', 'v17', '{"en": "English breakfast", "hy": "Անգլիական նախաճաշ", "ru": "Английский завтрак"}', NULL, 3100, ARRAY[]::varchar[], 3),
('v17-i028', 'v17-c01', 'v17', '{"en": "Benedict (Smoked Salmon & Brioche)", "hy": "Բենեդիկտ (ապխտած սաղմոն և բրիոշ)", "ru": "Бенедикт (копченый лосось и бриошь)"}', NULL, 3900, ARRAY[]::varchar[], 4),
('v17-i029', 'v17-c01', 'v17', '{"en": "Belgian waffle", "hy": "Բելգիական վաֆլի", "ru": "Бельгийская вафля"}', NULL, 2900, ARRAY[]::varchar[], 5),
('v17-i030', 'v17-c01', 'v17', '{"en": "Tuna toasts", "hy": "Թյուննոսով տոստեր", "ru": "Тосты с тунцом"}', NULL, 2400, ARRAY[]::varchar[], 6),
('v17-i031', 'v17-c01', 'v17', '{"en": "Croissant (Scrambled Egg & Cheese)", "hy": "Կրուասան (սկրեմբլ և պանիր)", "ru": "Круассан (скрэмбл и сыр)"}', NULL, 2300, ARRAY[]::varchar[], 7),
('v17-i032', 'v17-c01', 'v17', '{"en": "Benedict (Bacon & Guacamole)", "hy": "Բենեդիկտ (բեկոն և գուակամոլե)", "ru": "Бенедикт (бекон и гуакамоле)"}', NULL, 3700, ARRAY[]::varchar[], 8),
('v17-i033', 'v17-c01', 'v17', '{"en": "Croissant (Poached Egg & Parmesan)", "hy": "Կրուասան (պաշոտ ձու և պարմեզան)", "ru": "Круассан (яйцо пашот и пармезан)"}', NULL, 2900, ARRAY[]::varchar[], 9),
('v17-i034', 'v17-c01', 'v17', '{"en": "Cottage cheese balls", "hy": "Կաթնաշոռային գնդիկներ", "ru": "Творожные шарики"}', NULL, 2200, ARRAY[]::varchar[], 10);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c02', 'v17', '{"en": "Sandwiches and Burgers", "hy": "Սենդվիչներ և բուրգերներ", "ru": "Сэндвичи и бургеры"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i035', 'v17-c02', 'v17', '{"en": "Bagel with salmon", "hy": "Բեյգլ սաղմոնով", "ru": "Бейгл с лососем"}', NULL, 3600, ARRAY[]::varchar[], 0),
('v17-i036', 'v17-c02', 'v17', '{"en": "Burger Adelbert", "hy": "Բուրգեր Ադելբերտ", "ru": "Бургер Адельберт"}', NULL, 4200, ARRAY[]::varchar[], 1),
('v17-i037', 'v17-c02', 'v17', '{"en": "Burger Donella", "hy": "Բուրգեր Դոնելլա", "ru": "Бургер Донелла"}', NULL, 3700, ARRAY[]::varchar[], 2),
('v17-i038', 'v17-c02', 'v17', '{"en": "Croissant with ham and cheese", "hy": "Կրուասան խոզապուխտով և պանրով", "ru": "Круассан с ветчиной и сыром"}', NULL, 2600, ARRAY[]::varchar[], 3),
('v17-i039', 'v17-c02', 'v17', '{"en": "Quesadilla", "hy": "Քեսադիլյա", "ru": "Кесадилья"}', NULL, 3700, ARRAY[]::varchar[], 4),
('v17-i040', 'v17-c02', 'v17', '{"en": "Club sandwich", "hy": "Քլաբ սենդվիչ", "ru": "Клаб-сэндвич"}', NULL, 3700, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c03', 'v17', '{"en": "Pizza", "hy": "Պիցցա", "ru": "Пицца"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i041', 'v17-c03', 'v17', '{"en": "Pizza Mortadella", "hy": "Պիցցա Մորտադելլա", "ru": "Пицца Мортаделла"}', NULL, 4400, ARRAY[]::varchar[], 0),
('v17-i042', 'v17-c03', 'v17', '{"en": "Pizza with Shrimp", "hy": "Պիցցա ծովախեցգետնով", "ru": "Пицца с креветками"}', NULL, 5200, ARRAY[]::varchar[], 1),
('v17-i043', 'v17-c03', 'v17', '{"en": "Pizza Pepperoni", "hy": "Պիցցա Պեպերոնի", "ru": "Пицца Пепперони"}', NULL, 3900, ARRAY[]::varchar[], 2),
('v17-i044', 'v17-c03', 'v17', '{"en": "Four Cheese Pizza", "hy": "Պիցցա Չորս պանիր", "ru": "Пицца Четыре сыра"}', NULL, 4100, ARRAY[]::varchar[], 3),
('v17-i045', 'v17-c03', 'v17', '{"en": "Pizza Margherita", "hy": "Պիցցա Մարգարիտա", "ru": "Пицца Маргарита"}', NULL, 3200, ARRAY[]::varchar[], 4),
('v17-i046', 'v17-c03', 'v17', '{"en": "Pizza Regina", "hy": "Պիցցա Ռեջինա", "ru": "Пицца Реджина"}', NULL, 4100, ARRAY[]::varchar[], 5),
('v17-i047', 'v17-c03', 'v17', '{"en": "Pizza Barbecue", "hy": "Պիցցա Բարբեքյու", "ru": "Пицца Барбекю"}', NULL, 3900, ARRAY[]::varchar[], 6),
('v17-i048', 'v17-c03', 'v17', '{"en": "Pizza with Prosciutto", "hy": "Պիցցա պրոշուտոյով", "ru": "Пицца с прошутто"}', NULL, 4200, ARRAY[]::varchar[], 7),
('v17-i049', 'v17-c03', 'v17', '{"en": "Pizza Tuscany", "hy": "Պիցցա Տոսկանա", "ru": "Пицца Тоскана"}', NULL, 4100, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c04', 'v17', '{"en": "Pasta & Risotto", "hy": "Պաստա և ռիզոտո", "ru": "Паста и ризотто"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i050', 'v17-c04', 'v17', '{"en": "Risotto with seafood", "hy": "Ռիզոտո ծովամթերքով", "ru": "Ризотто с морепродуктами"}', NULL, 4800, ARRAY[]::varchar[], 0),
('v17-i051', 'v17-c04', 'v17', '{"en": "Pasta Carbonara", "hy": "Պաստա Կարբոնարա", "ru": "Паста Карбонара"}', NULL, 3100, ARRAY[]::varchar[], 1),
('v17-i052', 'v17-c04', 'v17', '{"en": "Pasta Alfredo", "hy": "Պաստա Ալֆրեդո", "ru": "Паста Альфредо"}', NULL, 2900, ARRAY[]::varchar[], 2),
('v17-i053', 'v17-c04', 'v17', '{"en": "Pesto Pasta", "hy": "Պաստա Պեստո", "ru": "Паста Песто"}', NULL, 2600, ARRAY[]::varchar[], 3),
('v17-i054', 'v17-c04', 'v17', '{"en": "Risotto with curry", "hy": "Ռիզոտո կարրիով", "ru": "Ризотто с карри"}', NULL, 4100, ARRAY[]::varchar[], 4),
('v17-i055', 'v17-c04', 'v17', '{"en": "Risotto with fennel and champignons", "hy": "Ռիզոտո ֆենխելով և շամպինյոններով", "ru": "Ризотто с фенхелем и шампиньонами"}', NULL, 3700, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c05', 'v17', '{"en": "Appetizers", "hy": "Նախուտեստներ", "ru": "Закуски"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i056', 'v17-c05', 'v17', '{"en": "Chicken frites", "hy": "Հավի ֆրիտ", "ru": "Куриные фриты"}', NULL, 2500, ARRAY[]::varchar[], 0),
('v17-i057', 'v17-c05', 'v17', '{"en": "Bruschetta mix", "hy": "Բրուսկետաների միքս", "ru": "Микс брускетт"}', NULL, 3400, ARRAY[]::varchar[], 1),
('v17-i058', 'v17-c05', 'v17', '{"en": "Angus tacos", "hy": "Անգուս տակոս", "ru": "Тако с ангусом"}', NULL, 3700, ARRAY[]::varchar[], 2),
('v17-i059', 'v17-c05', 'v17', '{"en": "Meat and cheese mix", "hy": "Մսի և պանրի տեսականի", "ru": "Мясное и сырное ассорти"}', NULL, 7800, ARRAY[]::varchar[], 3),
('v17-i060', 'v17-c05', 'v17', '{"en": "Bao with chicken", "hy": "Բաո հավով", "ru": "Бао с курицей"}', NULL, 2900, ARRAY[]::varchar[], 4),
('v17-i061', 'v17-c05', 'v17', '{"en": "Shrimp Popcorn", "hy": "Ծովախեցգետնի պոպկորն", "ru": "Попкорн из креветок"}', NULL, 3700, ARRAY[]::varchar[], 5);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c06', 'v17', '{"en": "Salads & Soups", "hy": "Աղցաններ և ապուրներ", "ru": "Салаты и супы"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i062', 'v17-c06', 'v17', '{"en": "Salad Donella", "hy": "Աղցան Դոնելլա", "ru": "Салат Донелла"}', NULL, 3400, ARRAY[]::varchar[], 0),
('v17-i063', 'v17-c06', 'v17', '{"en": "Caesar (Shrimp)", "hy": "Կեսար (ծովախեցգետնով)", "ru": "Цезарь (креветки)"}', NULL, 4700, ARRAY[]::varchar[], 1),
('v17-i064', 'v17-c06', 'v17', '{"en": "Caesar (Chicken)", "hy": "Կեսար (հավով)", "ru": "Цезарь (курица)"}', NULL, 3400, ARRAY[]::varchar[], 2),
('v17-i065', 'v17-c06', 'v17', '{"en": "Salad with salmon", "hy": "Աղցան սաղմոնով", "ru": "Салат с лососем"}', NULL, 3900, ARRAY[]::varchar[], 3),
('v17-i066', 'v17-c06', 'v17', '{"en": "Tom-Yum", "hy": "Տոմ-յամ", "ru": "Том-ям"}', NULL, 4100, ARRAY[]::varchar[], 4),
('v17-i067', 'v17-c06', 'v17', '{"en": "Mushroom cream-soup", "hy": "Սնկի կրեմ-ապուր", "ru": "Грибной крем-суп"}', NULL, 2300, ARRAY[]::varchar[], 5),
('v17-i068', 'v17-c06', 'v17', '{"en": "Chicken soup", "hy": "Հավի ապուր", "ru": "Куриный суп"}', NULL, 1900, ARRAY[]::varchar[], 6);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c07', 'v17', '{"en": "Croissants & Pastries", "hy": "Կրուասաններ և թխվածքաբլիթներ", "ru": "Круассаны и выпечка"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i069', 'v17-c07', 'v17', '{"en": "Almond Croissant", "hy": "Նշով կրուասան", "ru": "Миндальный круассан"}', NULL, 1300, ARRAY[]::varchar[], 0),
('v17-i070', 'v17-c07', 'v17', '{"en": "Torsade", "hy": "Տորսադ", "ru": "Торсад"}', NULL, 1100, ARRAY[]::varchar[], 1),
('v17-i071', 'v17-c07', 'v17', '{"en": "Classic Croissant", "hy": "Դասական կրուասան", "ru": "Классический круассан"}', NULL, 700, ARRAY[]::varchar[], 2),
('v17-i072', 'v17-c07', 'v17', '{"en": "Cheese Croissant", "hy": "Պանրով կրուասան", "ru": "Круассан с сыром"}', NULL, 900, ARRAY[]::varchar[], 3),
('v17-i073', 'v17-c07', 'v17', '{"en": "Cinnamon Roll", "hy": "Դարչինով թխվածք", "ru": "Ролл с корицей"}', NULL, 900, ARRAY[]::varchar[], 4),
('v17-i074', 'v17-c07', 'v17', '{"en": "Raisin Roll", "hy": "Չամիչով թխվածք", "ru": "Ролл с изюмом"}', NULL, 900, ARRAY[]::varchar[], 5),
('v17-i075', 'v17-c07', 'v17', '{"en": "Croissant Onigiri (Pistachio)", "hy": "Կրուասան Օնիգիրի (պիստակ)", "ru": "Круассан Онигири (фисташковый)"}', NULL, 1600, ARRAY[]::varchar[], 6),
('v17-i076', 'v17-c07', 'v17', '{"en": "Croissant Onigiri (Chocolate)", "hy": "Կրուասան Օնիգիրի (շոկոլադ)", "ru": "Круассан Онигири (шоколадный)"}', NULL, 1500, ARRAY[]::varchar[], 7),
('v17-i077', 'v17-c07', 'v17', '{"en": "Danish Pastry (Exotic/Blueberry/Berry/Fruit)", "hy": "Դանիշ (էկզոտիկ/հապալաս/հատապտուղ/միրգ)", "ru": "Даниш (экзотик/черника/ягода/фрукты)"}', NULL, 1750, ARRAY[]::varchar[], 8);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c08', 'v17', '{"en": "Desserts", "hy": "Աղանդեր", "ru": "Десерты"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i078', 'v17-c08', 'v17', '{"en": "Saint Sebastian", "hy": "Սան Սեբաստիան", "ru": "Сан-Себастьян"}', NULL, 2300, ARRAY[]::varchar[], 0),
('v17-i079', 'v17-c08', 'v17', '{"en": "Eclair (Chocolate/Vanilla/Pistachio)", "hy": "Էկլեր (շոկոլադ/վանիլ/պիստակ)", "ru": "Эклер (шоколад/ваниль/фисташка)"}', NULL, 1400, ARRAY[]::varchar[], 1),
('v17-i080', 'v17-c08', 'v17', '{"en": "Cheesecake (Classic/Blueberry/Pistachio)", "hy": "Չիզքեյք (դասական/հապալաս/պիստակ)", "ru": "Чизкейк (классика/черника/фисташка)"}', NULL, 2300, ARRAY[]::varchar[], 2),
('v17-i081', 'v17-c08', 'v17', '{"en": "Tiramisu", "hy": "Տիրամիսու", "ru": "Тирамису"}', NULL, 2250, ARRAY[]::varchar[], 3),
('v17-i082', 'v17-c08', 'v17', '{"en": "Macaroon (1 pc)", "hy": "Մակարուն (1 հատ)", "ru": "Макарон (1 шт.)"}', NULL, 500, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v17-c09', 'v17', '{"en": "Beverages", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 9);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v17-i083', 'v17-c09', 'v17', '{"en": "Coffee (Espresso/Americano)", "hy": "Սուրճ (էսպրեսո/ամերիկանո)", "ru": "Кофе (эспрессо/американо)"}', NULL, 1250, ARRAY[]::varchar[], 0),
('v17-i084', 'v17-c09', 'v17', '{"en": "Cappuccino / Latte", "hy": "Կապուչինո / Լատտե", "ru": "Капучино / Латте"}', NULL, 1750, ARRAY[]::varchar[], 1),
('v17-i085', 'v17-c09', 'v17', '{"en": "Fresh Juices (Orange/Apple/Carrot)", "hy": "Թարմ քամած հյութեր (նարինջ/խնձոր/գազար)", "ru": "Свежевыжатые соки (апельсин/яблоко/морковь)"}', NULL, 1800, ARRAY[]::varchar[], 2),
('v17-i086', 'v17-c09', 'v17', '{"en": "Lemonades", "hy": "Լիմոնադներ", "ru": "Лимонады"}', NULL, 2150, ARRAY[]::varchar[], 3),
('v17-i087', 'v17-c09', 'v17', '{"en": "Soft Drinks (0.25l)", "hy": "Զովացուցիչ ըմպելիքներ (0.25լ)", "ru": "Безалкогольные напитки (0.25л)"}', NULL, 600, ARRAY[]::varchar[], 4);

-- ═══ Segafredo (v18) ═══════════════════════════════════
INSERT INTO venues (id, name, slug, description, cuisine, price_range, rating, review_count, address, latitude, longitude, phone, features, policies, floor_plan_width, floor_plan_height) VALUES
('v18', 'Segafredo', 'segafredo',
 '{"en": "Segafredo — a popular restaurant in Yerevan."}',
 ARRAY['Coffee','Italian','Cafe'], 2, 4.1, 88,
 'Nalbandyan St 7, Yerevan 0001', 40.182, 44.516, '+374 10 666666',
 ARRAY['WiFi','Outdoor Seating','Takeout'],
 '{"en": "Free cancellation 2 hours before.", "ru": "Бесплатная отмена за 2 часа."}',
 560, 400);

INSERT INTO venue_images (venue_id, url, sort_order) VALUES
('v18', 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800', 0),
('v18', 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=800', 1),
('v18', 'https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=800', 2);

INSERT INTO venue_hours (venue_id, day, open_time, close_time) VALUES
('v18', 'Mon-Sun', '10:00', '23:00');

INSERT INTO floor_zones (id, venue_id, name, x, y, width, height, color) VALUES
('v18-z1', 'v18', '{"en":"Main Hall","ru":"Основной зал"}', 0, 0, 560, 200, '#FFF3E0'),
('v18-z2', 'v18', '{"en":"Second Hall","ru":"Второй зал"}', 0, 200, 560, 200, '#E3F2FD');

INSERT INTO floor_tables (id, venue_id, zone_id, x, y, width, height, shape, seats, label, default_status) VALUES
('v18-t1', 'v18', 'v18-z1', 40, 40, 80, 80, 'circle', 4, 'T1', 'available'),
('v18-t2', 'v18', 'v18-z1', 180, 40, 80, 80, 'circle', 2, 'T2', 'available'),
('v18-t3', 'v18', 'v18-z1', 320, 40, 100, 60, 'rect', 6, 'T3', 'available'),
('v18-t4', 'v18', 'v18-z2', 40, 240, 80, 80, 'circle', 4, 'T4', 'available'),
('v18-t5', 'v18', 'v18-z2', 180, 240, 100, 60, 'rect', 8, 'T5', 'available'),
('v18-t6', 'v18', 'v18-z2', 340, 240, 80, 80, 'circle', 2, 'T6', 'available');

INSERT INTO admin_users (id, venue_id, name, email, password_hash, phone, role) VALUES
('d0000000-0000-0000-0000-000000000018', 'v18', 'Segafredo Admin', 'admin-segafredo@seatify.com', '$2a$10$KnvDsPxLSJ3ek8aUiQu4n.sgCxwmSyZMaiiUrDCovnJb4SNm4clT2', '+374 10 666666', 'owner');

INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c00', 'v18', '{"en": "Lent Menu", "hy": "Պահքի մենյու", "ru": "Постное меню"}', 0);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i001', 'v18-c00', 'v18', '{"en": "Vegetable Wok", "hy": "Բանջարեղենային վոկ", "ru": "Овощной вок"}', '{"en": "Plant-based vegetable wok", "hy": "Բուսական բանջարեղենային վոկ", "ru": "Растительный овощной вок"}', 1700, ARRAY[]::varchar[], 0),
('v18-i002', 'v18-c00', 'v18', '{"en": "Lenten Pizza", "hy": "Պահքի պիցցա", "ru": "Постная пицца"}', NULL, 2400, ARRAY[]::varchar[], 1),
('v18-i003', 'v18-c00', 'v18', '{"en": "Hummus", "hy": "Հումուս", "ru": "Хумус"}', NULL, 1600, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c01', 'v18', '{"en": "Breakfast", "hy": "Նախաճաշ", "ru": "Завтрак"}', 1);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i004', 'v18-c01', 'v18', '{"en": "The Full English", "hy": "Լիարժեք անգլիական նախաճաշ", "ru": "Полный английский завтрак"}', '{"en": "Hearty English breakfast", "hy": "Սննդարար անգլիական նախաճաշ", "ru": "Сытный английский завтрак"}', 2900, ARRAY[]::varchar[], 0),
('v18-i005', 'v18-c01', 'v18', '{"en": "Royal Salmon Benedict", "hy": "Ռոյալ Բենեդիկտ սաղմոնով", "ru": "Королевский бенедикт с лососем"}', NULL, 4200, ARRAY[]::varchar[], 1),
('v18-i006', 'v18-c01', 'v18', '{"en": "Nutella Banana Pancakes", "hy": "Նուտելլայով և բանանով փանկեյքեր", "ru": "Блинчики с нутеллой и бананом"}', NULL, 2400, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c02', 'v18', '{"en": "Pizza & Pasta", "hy": "Պիցցա և պաստա", "ru": "Пицца и паста"}', 2);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i007', 'v18-c02', 'v18', '{"en": "Pizza Margherita", "hy": "Պիցցա Մարգարիտա", "ru": "Пицца Маргарита"}', NULL, 3100, ARRAY[]::varchar[], 0),
('v18-i008', 'v18-c02', 'v18', '{"en": "Spaghetti Carbonara", "hy": "Սպագետի Կարբոնարա", "ru": "Спагетти Карбонара"}', NULL, 2900, ARRAY[]::varchar[], 1),
('v18-i009', 'v18-c02', 'v18', '{"en": "Salmon Pasta", "hy": "Պաստա սաղմոնով", "ru": "Паста с лососем"}', NULL, 4100, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c03', 'v18', '{"en": "Burgers & Sandwiches", "hy": "Բուրգերներ և սենդվիչներ", "ru": "Бургеры и сэндвичи"}', 3);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i010', 'v18-c03', 'v18', '{"en": "Beef Burger", "hy": "Տավարի մսով բուրգեր", "ru": "Бургер с говядиной"}', NULL, 3700, ARRAY[]::varchar[], 0),
('v18-i011', 'v18-c03', 'v18', '{"en": "Club Sandwich", "hy": "Քլաբ սենդվիչ", "ru": "Клаб-сэндвич"}', NULL, 3100, ARRAY[]::varchar[], 1);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c04', 'v18', '{"en": "Main Dishes", "hy": "Գլխավոր ուտեստներ", "ru": "Основные блюда"}', 4);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i012', 'v18-c04', 'v18', '{"en": "Salmon Steak", "hy": "Սաղմոնի սթեյք", "ru": "Стейк из лосося"}', NULL, 7900, ARRAY[]::varchar[], 0),
('v18-i013', 'v18-c04', 'v18', '{"en": "Signature Striploin", "hy": "Ֆիրմային սթրիփլոյն", "ru": "Фирменный стриплойн"}', NULL, 7600, ARRAY[]::varchar[], 1),
('v18-i014', 'v18-c04', 'v18', '{"en": "Meat Platter", "hy": "Մսային տեսականի", "ru": "Мясное ассорти"}', NULL, 9700, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c05', 'v18', '{"en": "Salads & Soups", "hy": "Աղցաններ և ապուրներ", "ru": "Салаты и супы"}', 5);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i015', 'v18-c05', 'v18', '{"en": "Caesar Salad", "hy": "Կեսար աղցան", "ru": "Салат Цезарь"}', NULL, 3200, ARRAY[]::varchar[], 0),
('v18-i016', 'v18-c05', 'v18', '{"en": "Beef Salad", "hy": "Տավարի մսով աղցան", "ru": "Салат с говядиной"}', NULL, 3400, ARRAY[]::varchar[], 1),
('v18-i017', 'v18-c05', 'v18', '{"en": "Broccoli and Roquefort Cream Soup", "hy": "Բրոկոլիի և ռոկֆորի կրեմ-ապուր", "ru": "Крем-суп из брокколи и рокфора"}', NULL, 2900, ARRAY[]::varchar[], 2);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c06', 'v18', '{"en": "Bakery & Desserts", "hy": "Թխվածք և դեսերտներ", "ru": "Выпечка и десерты"}', 6);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i018', 'v18-c06', 'v18', '{"en": "Dubai Chocolate Croissant", "hy": "Դուբայական շոկոլադե կրուասան", "ru": "Дубайский шоколадный круассан"}', NULL, 1700, ARRAY[]::varchar[], 0),
('v18-i019', 'v18-c06', 'v18', '{"en": "Pistachio Croissant", "hy": "Պիստակով կրուասան", "ru": "Фисташковый круассан"}', NULL, 1450, ARRAY[]::varchar[], 1),
('v18-i020', 'v18-c06', 'v18', '{"en": "Classic Tiramisu", "hy": "Դասական տիրամիսու", "ru": "Классический тирамису"}', NULL, 2200, ARRAY[]::varchar[], 2),
('v18-i021', 'v18-c06', 'v18', '{"en": "Cheesecake", "hy": "Չիզքեյք", "ru": "Чизкейк"}', NULL, 2400, ARRAY[]::varchar[], 3),
('v18-i022', 'v18-c06', 'v18', '{"en": "Stevia Sweetened Cake", "hy": "Ստևիայով քաղցրացված տորթ", "ru": "Торт со стевией"}', NULL, 1900, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c07', 'v18', '{"en": "Drinks", "hy": "Ըմպելիքներ", "ru": "Напитки"}', 7);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i023', 'v18-c07', 'v18', '{"en": "Lotus Biscoff Latte", "hy": "Լոտուս Բիսկոֆ Լատտե", "ru": "Лотус Бискофф Латте"}', NULL, 2600, ARRAY[]::varchar[], 0),
('v18-i024', 'v18-c07', 'v18', '{"en": "Milkshake", "hy": "Միլքշեյք", "ru": "Милкшейк"}', NULL, 2500, ARRAY[]::varchar[], 1),
('v18-i025', 'v18-c07', 'v18', '{"en": "Espresso Martini", "hy": "Էսպրեսո Մարտինի", "ru": "Эспрессо Мартини"}', NULL, 2700, ARRAY[]::varchar[], 2),
('v18-i026', 'v18-c07', 'v18', '{"en": "Negroni", "hy": "Նեգրոնի", "ru": "Негрони"}', NULL, 3100, ARRAY[]::varchar[], 3),
('v18-i027', 'v18-c07', 'v18', '{"en": "Aperol Spritz", "hy": "Ապերոլ Շպրից", "ru": "Апероль Шприц"}', NULL, 3700, ARRAY[]::varchar[], 4);
INSERT INTO menu_categories (id, venue_id, name, sort_order) VALUES ('v18-c08', 'v18', '{"en": "Lunch Specials", "hy": "Լանչի առաջարկներ", "ru": "Ланч-меню"}', 8);
INSERT INTO menu_items (id, category_id, venue_id, name, description, price, tags, sort_order) VALUES
('v18-i028', 'v18-c08', 'v18', '{"en": "Chicken Breast with French Fries", "hy": "Հավի կրծքամիս ֆրիով", "ru": "Куриная грудка с картофелем фри"}', '{"en": "Includes a free drink (12:00–16:00)", "hy": "Ներառում է անվճար ըմպելիք (12:00–16:00)", "ru": "Включает бесплатный напиток (12:00–16:00)"}', 2500, ARRAY[]::varchar[], 0),
('v18-i029', 'v18-c08', 'v18', '{"en": "Beef Stroganoff with Mashed Potatoes", "hy": "Բեֆստրոգանով կարտոֆիլի պյուրեով", "ru": "Бефстроганов с картофельным пюре"}', '{"en": "Includes a free drink (12:00–16:00)", "hy": "Ներառում է անվճար ըմպելիք (12:00–16:00)", "ru": "Включает бесплатный напиток (12:00–16:00)"}', 2900, ARRAY[]::varchar[], 1);
