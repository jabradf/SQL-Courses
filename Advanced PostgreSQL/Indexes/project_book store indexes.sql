-- step 1
select * from books limit 10;
select * from customers limit 10;
select * from orders limit 10;

-- step 2
SELECT * FROM pg_Indexes WHERE tablename = 'books';
SELECT * FROM pg_Indexes WHERE tablename = 'customers';
SELECT * FROM pg_Indexes WHERE tablename = 'orders';

--step 3
CREATE INDEX cust_book_id_idx ON orders (customer_id);

--step 4
EXPLAIN ANALYZE SELECT original_language,
  title,
  sales_in_millions
FROM books
WHERE original_language = 'French';

-- step 5
SELECT pg_size_pretty (pg_total_relation_size('books'));

-- step 6
CREATE INDEX lang_sales_title_idx ON books (original_language, title, sales_in_millions);

-- step 7
EXPLAIN ANALYZE SELECT original_language,
  title,
  sales_in_millions
FROM books
WHERE original_language = 'French';

SELECT pg_size_pretty (pg_total_relation_size('books'));

-- step 8
DROP INDEX IF EXISTS lang_sales_title_idx;

-- step 9
/*SELECT NOW();
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;
SELECT NOW();*/
-- runtime was a little over a second

-- step 10
SELECT NOW();
DROP INDEX IF EXISTS cust_book_id_idx;
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;
SELECT NOW();
-- runtime now ~0.2 seconds

-- step 10
CREATE INDEX name_email_idx ON customers (first_name, email_Address);
/*1. The answer here highly depends on if the customers database has a lot of select queries on it, and doesn't get updated too often.
2. We'd have to see what queries are in use to get a better idea.
3. That would depend on what queries are running
4. What other columns if any are used more than the given first_name or email_address columns
5. Indexes increase the size of the database, and actually slow it down if insert, update or delete queries are run 
*/


