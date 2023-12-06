DROP TABLE IF EXISTS 'shop';
DROP TABLE IF EXISTS 'product';
DROP TABLE IF EXISTS 'warehouse';
DROP TABLE IF EXISTS 'worker';

CREATE TABLE shop(
    id integer PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    balance FLOAT NOT NULL
);

CREATE TABLE product(
    id integer PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE warehouse(
    shop_id INTEGER REFERENCES shop(id),
    product_id INTEGER REFERENCES shop(id),
    quantity INTEGER NOT NULL
);

CREATE TABLE worker (
    worker_id INTEGER PRIMARY KEY AUTOINCREMENT,
    shop_id INTEGER REFERENCES shop(id),
    name VARCHAR(255) NOT NULL,
    salary INTEGER NOT NULL,
    position VARCHAR(255) NOT NULL 
);

INSERT INTO worker (shop_id, name, salary, position) VALUES((SELECT id FROM shop WHERE name = 'СЫТО ПЬЯНО'), 'РАЙАН ГОСЛИНГ', 600000, 'ВОДИТЕЛЬ');
INSERT INTO worker (shop_id, name, salary, position) VALUES((SELECT id FROM shop WHERE name = 'ДИКСИ'), 'ПАТРИК БЕЙТМАН', 5, 'БИЗНЕСМЕН');
INSERT INTO worker (shop_id, name, salary, position) VALUES((SELECT id FROM shop WHERE name = 'АШАН'), 'ТАЙЛЕР ДЁРДЕН', 35, 'БЕЗРАБОТНЫЙ');
INSERT INTO worker (shop_id, name, salary, position) VALUES((SELECT id FROM shop WHERE name = 'АШАН'), 'ЛЁШКА БОДАНЮК', 20000000000, 'ЛЕГЕНДА');
INSERT INTO worker (shop_id, name, salary, position) VALUES((SELECT id FROM shop WHERE name = 'КБ'), 'СЭМ СУЛЕК', 2000000, 'ФИТНЕС ТРЕНЕР');

INSERT INTO shop VALUES('СЫТО ПЬЯНО', 500000);
INSERT INTO shop VALUES('КБ', 1000000);
INSERT INTO shop VALUES('АШАН', 450000);
INSERT INTO shop VALUES('БУРГЕР КИНГ', 700000);
INSERT INTO shop VALUES('ДИКСИ', 400000);

INSERT INTO product (name, quantity) VALUES('ПИВО CВЕТЛОЕ', 100);
INSERT INTO product (name, quantity) VALUES('ПИВО ТЁМНОЕ', 120);
INSERT INTO product (name, quantity) VALUES('ПИВО ВИШНЁВОЕ', 200);
INSERT INTO product (name, quantity) VALUES('ЧАПМАН ВИШНЁВЫЙ', 500);
INSERT INTO product (name, quantity) VALUES('ЧАПМАН ШОКОЛАДНЫЙ', 100);
INSERT INTO product (name, quantity) VALUES('КЛУБНИЧНЫЙ ЛИКЁР', 100);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'СЫТО ПЬЯНО'), (SELECT id FROM product WHERE name = 'ПИВО CВЕТЛОЕ'), 20);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'СЫТО ПЬЯНО'), (SELECT id FROM product WHERE name = 'ПИВО ТЁМНОЕ'), 30);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'СЫТО ПЬЯНО'), (SELECT id FROM product WHERE name = 'ПИВО ВИШНЁВОЕ'), 15);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'КБ'), (SELECT id FROM product WHERE name = 'ПИВО CВЕТЛОЕ'), 40);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'КБ'), (SELECT id FROM product WHERE name = 'ЧАПМАН ВИШНЁВЫЙ'), 15);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'КБ'), (SELECT id FROM product WHERE name = 'КЛУБНИЧНЫЙ ЛИКЁР'), 10);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'АШАН'), (SELECT id FROM product WHERE name = 'ЧАПМАН ВИШНЁВЫЙ'), 20);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'АШАН'), (SELECT id FROM product WHERE name = 'ЧАПМАН ШОКОЛАДНЫЙ'), 30);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'АШАН'), (SELECT id FROM product WHERE name = 'КЛУБНИЧНЫЙ ЛИКЁР'), 20);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'БУРГЕР КИНГ'), (SELECT id FROM product WHERE name = 'ПИВО CВЕТЛОЕ'), 15);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'БУРГЕР КИНГ'), (SELECT id FROM product WHERE name = 'ПИВО ТЁМНОЕ'), 15);

INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'ДИКСИ'), (SELECT id FROM product WHERE name = 'ЧАПМАН ВИШНЁВЫЙ'), 20);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'ДИКСИ'), (SELECT id FROM product WHERE name = 'ЧАПМАН ШОКОЛАДНЫЙ'), 30);
INSERT INTO warehouse VALUES((SELECT id FROM shop WHERE name = 'ДИКСИ'), (SELECT id FROM product WHERE name = 'КЛУБНИЧНЫЙ ЛИКЁР'), 20);

SELECT * FROM worker WHERE name != 'ДЖОКЕР' ORDER BY shop_id, position;

SELECT shop_id, product_id, sum(quantity) as product_product_count from warehouse where product_id < 4 GROUP BY shop_id ORDER BY product_product_count DESC;

SELECT shop.name, sum(warehouse.quantity) as product_count_tovars
FROM warehouse, shop 
WHERE warehouse.product_id < 4 AND shop.id = warehouse.shop_id
GROUP BY shop.name 
ORDER BY product_product_count DESC;

SELECT product.name, sum(warehouse.quanity) as product_count
FROM product, warehouse
WHERE product.id = warehouse.product_id AND product.name LIKE '%ПИВО%'
GROUP BY product.name 
ORDER BY product_count DESC;