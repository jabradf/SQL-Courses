select * from customers limit 10;
select * from orders limit 10;
select * from books limit 10;

-- step 2
SELECT * FROM pg_Indexes WHERE tablename = 'customers';
SELECT * FROM pg_Indexes WHERE tablename = 'orders';
SELECT * FROM pg_Indexes WHERE tablename = 'books';

-- step 3
EXPLAIN ANALYZE SELECT customer_id, quantity
from orders
where quantity > 18;

-- step 4
CREATE INDEX quantity_18_idx ON orders (customer_id, quantity)
where quantity > 18;

-- step 5
EXPLAIN ANALYZE SELECT customer_id, quantity
from orders
where quantity > 18;

-- step 6
EXPLAIN ANALYZE SELECT customer_id, last_name
from customers
where customer_id < 30000;

ALTER TABLE customers ADD CONSTRAINT customers_pkey
    PRIMARY KEY (customer_id);

EXPLAIN ANALYZE SELECT customer_id, last_name
from customers
where customer_id < 30000;

-- step 7
CLUSTER customers USING customers_pkey;
select * from customers limit 10;

-- step 8
CREATE INDEX customer_book_id_idx ON orders (customer_id, book_id);

-- step 9
DROP INDEX IF EXISTS customer_book_id_idx;

EXPLAIN ANALYZE SELECT customer_id, book_id, quantity
from orders
order by quantity;

CREATE INDEX customer_book_id_idx ON orders (customer_id, book_id, quantity ASC);

EXPLAIN ANALYZE SELECT customer_id, book_id, quantity
from orders
order by quantity;

-- step 10
CREATE INDEX author_title_idx ON books (author, title);

-- step 11
EXPLAIN ANALYZE SELECT (quantity * price_base) as total_price
FROM orders;

-- step 12
CREATE INDEX quant_x_price_idx ON orders ((quantity * price_base));

-- step 13
EXPLAIN ANALYZE SELECT (quantity * price_base) as total_price
FROM orders;