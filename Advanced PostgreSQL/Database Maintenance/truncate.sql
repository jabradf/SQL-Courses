SELECT pg_size_pretty(
    pg_total_relation_size('mock.current_day_logins')
) as total_sizes;

-- expensive operation, as it scans first
/*DELETE * FROM rand WHERE true;
VACUUM FULL rand;*/

-- cheap operation as it just deletes everything without the scan
TRUNCATE mock.current_day_logins;

SELECT pg_size_pretty(
    pg_total_relation_size('mock.current_day_logins')
) as total_sizes;