-- Triggers that run at the same time run in alphabetical order
CREATE TRIGGER update_bravo
BEFORE UPDATE ON orders
FOR EACH ROW
EXECUTE PROCEDURE update_first();

CREATE TRIGGER update_alpha
BEFORE UPDATE ON orders
FOR EACH ROW
EXECUTE PROCEDURE update_second();


select * from orders
order by order_id;


update orders
set quantity = 5
where order_id = '1234';

select * from orders
order by order_id;