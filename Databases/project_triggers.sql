-- step 1
select * from customers
order by customer_id;

select * from customers_log;
--order by customer_id

-- step 2
CREATE TRIGGER customer_update
AFTER UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE log_customers_change();

-- step 3
UPDATE customers
SET first_name = 'Steve'
WHERE last_name = 'Lewis';

select * from customers
order by customer_id;

select * from customers_log;

-- step 4
UPDATE customers
SET email_address = 'changed@hotmail.com'
WHERE last_name = 'Lewis';

select * from customers
order by customer_id;

select * from customers_log;

-- step 5
CREATE TRIGGER customer_insert
AFTER INSERT ON customers
FOR EACH STATEMENT
EXECUTE PROCEDURE log_customers_change();

-- step 6 
INSERT INTO customers (first_name, last_name, email_address, home_phone, city, state_name, years_old)
VALUES ('Jeffrey', 'Cook', 'jeffo@metoo.com', '45654566', 'Jersey City', 'New Jersey', 66);
INSERT INTO customers (first_name, last_name, email_address, home_phone, city, state_name, years_old)
VALUES ('Tom', 'Jones', 'tj00072@hmail.com', '8547-542-5555', 'Bayside', 'WA', 42);

select * from customers
order by customer_id;

select * from customers_log;

-- step 7
CREATE TRIGGER customer_min_age
    BEFORE UPDATE ON customers
    FOR EACH ROW
    WHEN (NEW.years_old < 13)
    EXECUTE PROCEDURE override_with_min_age();

-- step 8
UPDATE customers
SET years_old = 9
WHERE last_name = 'Lewis';

UPDATE customers
SET years_old = 95
WHERE last_name = 'Hall';

select last_name, years_old from customers
order by customer_id;

select * from customers_log;

-- step 9
UPDATE customers
SET years_old = 9,
first_name = 'Teddy'
WHERE last_name = 'Lewis';

select * from customers_log;

-- step 10
DROP TRIGGER customer_min_age ON customers;
-- step 11
SELECT * FROM information_schema.triggers;