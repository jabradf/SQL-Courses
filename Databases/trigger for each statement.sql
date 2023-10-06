select * from customers
order by customer_id;

CREATE TRIGGER each_statement_trigger
AFTER UPDATE ON customers
FOR EACH STATEMENT    -- ROW will generate it for every row rather than once!
EXECUTE PROCEDURE statement_function();

update customers
set years_old = years_old + 1;
--where customer_id = 1;

select * from customers
order by customer_id;