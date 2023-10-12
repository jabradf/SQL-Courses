-- check initial size (1024kb)
SELECT pg_size_pretty(
    pg_total_relation_size('mock.orders')
) as total_size;

-- check the dead tuples (7500)
select relname, n_dead_tup , last_vacuum
from pg_catalog.pg_stat_all_tables
where relname  = 'orders';

-- perform a full vacuum (copies the live data to a new table, allowing for a delete of the old data. This is a very intensive operation)
VACUUM FULL mock.orders;

-- check the size again (504kb)
SELECT pg_size_pretty(
    pg_total_relation_size('mock.orders')
) as total_size;