CREATE INDEX customers_city_idx ON customers (city);

/*
-- Given the query, create an index that would speed the query up:

SELECT
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS NumOforders
FROM customers       AS c
INNER JOIN orders    AS o    
ON o.customer_id = c.customer_id
WHERE c.last_name IN ('Smith', 'Jones')
GROUP BY c.first_name, c.last_name;

*/

CREATE INDEX customers_last_name_idx ON customers (last_name);


----------------------
-- multi column indexes
EXPLAIN ANALYZE SELECT *
FROM customers
WHERE last_name = 'Jones' and first_name='David';

/*
-- result is:
Seq Scan on customers (cost=0.00..1691.36 rows=1 width=466) (actual time=1.182..13.461 rows=9 loops=1)
  Filter: (((last_name)::text = 'Jones'::text) AND ((first_name)::text = 'David'::text))
  Rows Removed by Filter: 99991
Planning time: 0.197 ms
Execution time: 13.477 ms

*/
-- create the multi column index
CREATE INDEX customers_last_name_first_name_idx ON customers (last_name, first_name);



EXPLAIN ANALYZE SELECT *
FROM customers
WHERE last_name = 'Jones' and first_name='David';

/*
-- result is now:
Bitmap Heap Scan on customers (cost=4.44..12.24 rows=2 width=466) (actual time=0.046..0.056 rows=9 loops=1)
  Recheck Cond: (((last_name)::text = 'Jones'::text) AND ((first_name)::text = 'David'::text))
  Heap Blocks: exact=9
  -> Bitmap Index Scan on customers_last_name_first_name_idx (cost=0.00..4.44 rows=2 width=0) (actual time=0.042..0.042 rows=9 loops=1)
        Index Cond: (((last_name)::text = 'Jones'::text) AND ((first_name)::text = 'David'::text))
Planning time: 0.136 ms
Execution time: 0.081 ms
*/