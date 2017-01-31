CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC NOT NULL DEFAULT 0
);

CREATE TYPE order_statuses AS ENUM (
    'open', 'in progress', 'shipped', 'returned');

CREATE TABLE ORDERS (
    id SERIAL PRIMARY KEY,
    status order_statuses NOT NULL DEFAULT 'open',
    created DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE order_products (
    order_id INT REFERENCES orders ON DELETE CASCADE,
    product_id INT REFERENCES products ON DELETE RESTRICT,
    quantity INT NOT NULL DEFAULT 1
);


INSERT INTO products (name, price) VALUES
    ('shirt', 25),
    ('pants', 42),
    ('hat', 23),
    ('monocle', 50);

INSERT INTO orders (status) VALUES
    ('open'),
    ('open'),
    ('shipped');

INSERT INTO order_products (order_id, product_id, quantity) VALUES
    (1, 1, 2),
    (1, 3, 1),
    (1, 4, 1),
    (2, 4, 5),
    (3, 1, 1),
    (3, 3, 1);

SELECT
    orders.id as "order id",
    orders.status,
    products.name as "product",
    products.price,
    order_products.quantity

    FROM orders
    INNER JOIN order_products
    ON orders.id = order_products.order_id
    INNER JOIN products
    on products.id = order_products.product_id;


SELECT
    orders.id as "order id",
    products.name as "product",
    products.price,
    order_products.quantity

    FROM orders
    INNER JOIN order_products
    ON orders.id = order_products.order_id
    AND orders.status = 'open'
    INNER JOIN products
    on products.id = order_products.product_id;


DELETE FROM products WHERE id = 1;

SELECT COUNT(*) FROM order_products where order_id = 1;
DELETE FROM orders WHERE id = 1;
SELECT COUNT(*) FROM order_products where order_id = 1;
