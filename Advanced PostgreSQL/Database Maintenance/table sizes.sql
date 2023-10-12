/*
There is a table in the database named house_prices which contains several thousand fake house prices and locations. Write a query to find the total size of the table data in mock.house_prices, (i.e, the size excluding any indexes).
*/
SELECT 
    pg_size_pretty(pg_table_size('mock.house_prices')) as tbl_size;

/*
Write the query to find the total size of the indexes on house_prices.
*/
SELECT
    pg_size_pretty(pg_indexes_size('mock.house_prices')) as idx_size;
  
/* 
The table house_prices has only one index, mock.house_prices_pk. Call pg_total_relation_size() on this index, compare this result to your answer from the previous exercise. Are they the same?
*/
SELECT
   pg_size_pretty(pg_total_relation_size('mock.house_prices_pk')) as total_size;

/*
Find the total relation size of house_prices, this number should be the sum of index and table data. Is this number consistent with the answers you received in parts 1 and 2?
*/
SELECT 
   pg_size_pretty(pg_total_relation_size('mock.house_prices')) as total_size;

-- In postgreSQL, any modification to the database increases the database size, including a delete.
-- This is because the rows are marked invalid (creating dead tuples) and the new row is included.
-- Measures must be implemented to clean up the database; VACUUM, reclustering, etc.