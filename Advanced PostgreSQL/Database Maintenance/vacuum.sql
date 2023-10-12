
SELECT pg_size_pretty(
    pg_total_relation_size('mock.stock_prices')
) as total_size;

--SELECT * FROM mock.stock_prices LIMIT 10;
/*
Due to an error, the prices (col: price_sh) in mock.stock_prices after Jan 1, 2020 have been reported as $10 lower than the correct price. Add $10 to all values after Jan 1, 2020 to correct this mistake.
*/
UPDATE mock.stock_prices 
SET price_sh = price_sh + 10 
WHERE trading_date > '2020-01-01';

-- Perform a regular VACUUM on mock.stock_prices
VACUUM mock.stock_prices;

/*
Check the total table size (i.e. including table data and indexes) now that the table’s been vacuumed. Has the disk usage of the table increased? decreased?
*/
SELECT pg_size_pretty(
    pg_total_relation_size('mock.stock_prices')
) as total_size;