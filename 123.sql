DROP TABLE IF EXISTS 'shop';
DROP TABLE IF EXISTS 'product';
DROP TABLE IF EXISTS 'warehouse';
DROP TABLE IF EXISTS 'worker';

CREATE TABLE shop(
    id integer PRIMARY KEY AUTOINCREMENT,
    name_ VARCHAR(255) NOT NULL,
    balance FLOAT NOT NULL
);

CREATE TABLE product(
    id integer PRIMARY KEY AUTOINCREMENT,
    name_ VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE warehouse(
    shop_id INTEGER REFERENCES shop(id),
    product_id INTEGER REFERENCES shop(id),
    quanity INTEGER NOT NULL
);

CREATE TABLE worker (
    worker_id INTEGER PRIMARY KEY,
    shop_id INTEGER REFERENCES shop(id),
    name_ VARCHAR(255) NOT NULL,
    salary INTEGER NOT NULL,
    position VARCHAR(255) NOT NULL 
);

INSERT INTO worker VALUES(1, (SELECT id FROM shop WHERE name_ = 'ПИВНУХА'), 'РАЙАН ГОСЛИНГ', 600000, 'ВОДИТЕЛЬ');
INSERT INTO worker VALUES(2, (SELECT id FROM shop WHERE name_ = 'СОЧИСОЧНАЯ'), 'ПАТРИК БЕЙТМАН', 5, 'БИЗНЕСМЕН');
INSERT INTO worker VALUES(3, (SELECT id FROM shop WHERE name_ = 'РЮМОЧНАЯ'), 'ТАЙЛЕР ДЁРДЕН', 35, 'БЕЗРАБОТНЫЙ');
INSERT INTO worker VALUES(4, (SELECT id FROM shop WHERE name_ = 'РЮМОЧНАЯ'), 'ДЖОКЕР', 20000, 'КЛОУН');
INSERT INTO worker VALUES(5, (SELECT id FROM shop WHERE name_ = 'КРАСНОЕ И БЕЛОЕ'), 'СЭМ СУЛЕК', 2000000, 'ФИТНЕС ТРЕНЕР');

INSERT INTO shop VALUES(1, 'ПИВНУХА', 500000);
INSERT INTO shop VALUES(2, 'КРАСНОЕ И БЕЛОЕ', 1000000);
INSERT INTO shop VALUES(3, 'РЮМОЧНАЯ', 450000);
INSERT INTO shop VALUES(4, 'БУРГЕР КИНГ', 700000);
INSERT INTO shop VALUES(5, 'СОЧИСОЧНАЯ', 400000);

INSERT INTO product VALUES(1, 'ПИВО CВЕТЛОЕ', 100);
INSERT INTO product VALUES(2, 'ПИВО ТЁМНОЕ', 120);
INSERT INTO product VALUES(3, 'ПИВО ВИШНЁВОЕ', 200);
INSERT INTO product VALUES(4, 'ПИНАКОЛАДА', 500);
INSERT INTO product VALUES(5, 'НАСТОЙКА НА СМОРОДИНЕ', 100);
INSERT INTO product VALUES(6, 'КЛУБНИЧНЫЙ ЛИКЁР', 100);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'ПИВНУХА'), (SELECT id FROM product WHERE name_ = 'ПИВО CВЕТЛОЕ'), 20);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'ПИВНУХА'), (SELECT id FROM product WHERE name_ = 'ПИВО ТЁМНОЕ'), 30);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'ПИВНУХА'), (SELECT id FROM product WHERE name_ = 'ПИВО ВИШНЁВОЕ'), 15);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'КРАСНОЕ И БЕЛОЕ'), (SELECT id FROM product WHERE name_ = 'ПИВО CВЕТЛОЕ'), 40);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'КРАСНОЕ И БЕЛОЕ'), (SELECT id FROM product WHERE name_ = 'ПИНАКОЛАДА'), 15);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'КРАСНОЕ И БЕЛОЕ'), (SELECT id FROM product WHERE name_ = 'КЛУБНИЧНЫЙ ЛИКЁР'), 10);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'РЮМОЧНАЯ'), (SELECT id FROM product WHERE name_ = 'ПИНАКОЛАДА'), 20);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'РЮМОЧНАЯ'), (SELECT id FROM product WHERE name_ = 'НАСТОЙКА НА СМОРОДИНЕ'), 30);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'РЮМОЧНАЯ'), (SELECT id FROM product WHERE name_ = 'КЛУБНИЧНЫЙ ЛИКЁР'), 20);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'БУРГЕР КИНГ'), (SELECT id FROM product WHERE name_ = 'ПИВО CВЕТЛОЕ'), 15);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'БУРГЕР КИНГ'), (SELECT id FROM product WHERE name_ = 'ПИВО ТЁМНОЕ'), 15);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'СОЧИСОЧНАЯ'), (SELECT id FROM product WHERE name_ = 'ПИНАКОЛАДА'), 20);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'СОЧИСОЧНАЯ'), (SELECT id FROM product WHERE name_ = 'НАСТОЙКА НА СМОРОДИНЕ'), 30);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name_ = 'СОЧИСОЧНАЯ'), (SELECT id FROM product WHERE name_ = 'КЛУБНИЧНЫЙ ЛИКЁР'), 20);

SELECT * FROM worker WHERE name_ != 'ДЖОКЕР' ORDER BY shop_id, position;

SELECT shop_id, product_id, sum(quanity) as количество_пива from warehouse where product_id < 4 GROUP BY shop_id ORDER BY количество_пива DESC;

SELECT shop.name_, sum(warehouse.quanity) as count_pivo
FROM warehouse, shop 
WHERE warehouse.product_id < 4 AND shop.id = warehouse.shop_id
GROUP BY shop.name_ 
ORDER BY count_pivo DESC;

SELECT product.name_, sum(warehouse.quanity) as count
FROM product, warehouse
WHERE product.id = warehouse.product_id AND product.name_ LIKE '%ПИВО%'
GROUP BY product.name_ 
ORDER BY count DESC;