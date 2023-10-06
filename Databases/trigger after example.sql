select * from customers
order by customer_id;

CREATE TRIGGER after_trigger
AFTER UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE log_customers_change();

update customers
set years_old = years_old + 10
where customer_id = 1;

select * from customers
order by customer_id;

select * from customers_log;