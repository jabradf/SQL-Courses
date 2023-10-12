-- step 1
SELECT pg_size_pretty(
    pg_total_relation_size('sensors.observations')
) as total_size;

-- step 2
SELECT '-' as Step_2;
-- get index names
SELECT
  tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'observations';

-- list index size, including schema name
SELECT pg_size_pretty(pg_total_relation_size('sensors.observations_pkey')) as idx_1_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations_location_id_datetime_idx')) as idx_2_size;

-- step 3
SELECT '-' as Step_3;
SELECT 
    pg_size_pretty(pg_table_size('sensors.observations')) as tbl_size, 
    pg_size_pretty(pg_indexes_size('sensors.observations')) as idx_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;

-- step 4
SELECT '-' as Step_4;
-- not sure why I'd want to convert to feet as it's an American unit....
--SELECT distance FROM sensors.observations LIMIT 1;
UPDATE sensors.observations 
SET distance = (distance * 3.281) 
WHERE TRUE;
--SELECT distance FROM sensors.observations LIMIT 1;

-- step 5
SELECT '-' as Step_5;
SELECT 
    pg_size_pretty(pg_table_size('sensors.observations')) as tbl_size, 
    pg_size_pretty(pg_indexes_size('sensors.observations')) as idx_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;
-- the table is larger since everything has been updated, leaving loads of dead tuples behind

-- step 6
SELECT '-' as Step_6;
-- time for some vacuuming to try and reduce it's size when more data is added. It shouldn't affect the size just yet.
VACUUM sensors.observations;

SELECT pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;

-- step 7
\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

-- step 8 
SELECT '-' as Step_8;
SELECT 
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;

-- step 9
VACUUM FULL sensors.observations;
SELECT '-' as Step_9;
SELECT 
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;
-- this runs a blocking operation and reduces the size properly.

-- step 10
DELETE from sensors.observations 
WHERE location_id > 24;

-- step 11
SELECT '-' as Step_11;
SELECT 
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;
-- Size is not affected as no vacuum is performed.

-- step 12
-- Delete everything quickly using TRUNCATE!
TRUNCATE sensors.observations;

-- step 13
--SELECT '-' as Step_13;
\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './original_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

-- step 14
SELECT '-' as Step_14;
SELECT 
    pg_size_pretty(pg_table_size('sensors.observations')) as tbl_size, 
    pg_size_pretty(pg_indexes_size('sensors.observations')) as idx_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;
-- table size is slightly larger, as we have data from camera 24+