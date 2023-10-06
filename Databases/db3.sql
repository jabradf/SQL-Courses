DROP SCHEMA IF EXISTS cc_user CASCADE;
CREATE SCHEMA cc_user;
SET SEARCH_PATH = cc_user;

CREATE TABLE orders
	(
	order_id		INTEGER			GENERATED ALWAYS AS IDENTITY	PRIMARY KEY,
  quantity  INTEGER NULL,
	notes		VARCHAR(100) NULL
	);

CREATE OR REPLACE FUNCTION update_first() RETURNS TRIGGER AS $$
	BEGIN
		NEW.notes = CONCAT(NEW.notes, 'update_first ran ');
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION update_second() RETURNS TRIGGER AS $$
	BEGIN
		NEW.notes = CONCAT(NEW.notes,'update_second ran ');
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;

\COPY orders FROM 'customers.txt' DELIMITER ',' CSV HEADER;

SELECT SETVAL(pg_get_serial_sequence('orders', 'order_id'), 
              (SELECT MAX(order_id) FROM orders)); 