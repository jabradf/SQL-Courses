CREATE TRIGGER insert_trigger
  BEFORE INSERT ON customers
  FOR EACH ROW
  EXECUTE PROCEDURE insert_function();
  -- or EXECUTE FUNCTION <function>

SELECT * FROM customers;

INSERT INTO customers (first_name, last_name)
VALUES ('John', 'Doe');

SELECT * FROM customers;
