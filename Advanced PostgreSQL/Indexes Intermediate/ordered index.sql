-- no ordering
CREATE INDEX customers_state_name_email_address_idx ON customers (state_name, email_address);


/*
If your column contains NULLs you can also specify the order they appear by adding NULLS FIRST or NULLS LAST to fit your needs. By default, PostgreSQL orders indexes by ascending order with NULLs last, so if this is the order you desire, you do not need to do anything.
*/

EXPLAIN ANALYZE SELECT state_name,
  email_address
  FROM customers
where state_name = 'California' or state_name = 'Ohio'
order by state_name desc, email_address;

-- ordered
CREATE INDEX customers_state_name_email_address_ordered_idx ON customers (state_name DESC, email_address ASC);

EXPLAIN ANALYZE SELECT state_name,
  email_address
  FROM customers
where state_name = 'California' or state_name = 'Ohio'
order by state_name desc, email_address;