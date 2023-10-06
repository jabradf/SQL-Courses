explain analyze select * from customers
where years_old between 13 and 19;


CREATE INDEX customers_years_old_teen_idx ON customers (years_old)
where years_old between 13 and 19;


explain analyze select * from customers
where years_old between 13 and 19;
