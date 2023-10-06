EXPLAIN ANALYZE SELECT *
FROM customers
WHERE first_name = 'David';
/*
-- returns:
QUERY PLAN
Seq Scan on customers (cost=0.00..2614.00 rows=500 width=466) (actual time=0.018..10.020 rows=538 loops=1)
  Filter: ((first_name)::text = 'David'::text)
  Rows Removed by Filter: 99462
Planning time: 0.250 ms
Execution time: 10.060 ms
*/
-- the column is not indexed (seq scan)

EXPLAIN ANALYZE SELECT *
FROM customers
WHERE last_name = 'Jones';

/*
--Returns: 
QUERY PLAN
Bitmap Heap Scan on customers (cost=12.29..1003.86 rows=500 width=466) (actual time=0.262..0.880 rows=1008 loops=1)
  Recheck Cond: ((last_name)::text = 'Jones'::text)
  Heap Blocks: exact=714
  -> Bitmap Index Scan on customers_last_name_idx (cost=0.00..12.17 rows=500 width=0) (actual time=0.187..0.188 rows=1008 loops=1)
        Index Cond: ((last_name)::text = 'Jones'::text)
Planning time: 0.109 ms
Execution time: 0.943 ms
*/
-- the column not indexed (bitmap heap scan)