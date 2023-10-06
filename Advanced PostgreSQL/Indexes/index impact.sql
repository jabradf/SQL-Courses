-- check the size of customers table
SELECT pg_size_pretty (pg_total_relation_size('customers'));

-- create index using the last_name colum of customers
CREATE INDEX customers_last_name_idx ON customers (last_name);

-- examine the size of the table again
SELECT pg_size_pretty (pg_total_relation_size('customers'));