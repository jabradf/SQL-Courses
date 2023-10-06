DROP SCHEMA IF EXISTS cc_user CASCADE;
CREATE SCHEMA cc_user;
SET SEARCH_PATH = cc_user;

CREATE TABLE customers
	(
	customer_id		INTEGER			GENERATED ALWAYS AS IDENTITY	PRIMARY KEY,
	first_name		VARCHAR(100)	NOT NULL,
	last_name		VARCHAR(100)	NOT NULL,
	email_address	VARCHAR(300)	NULL,
	home_phone		VARCHAR(100)	NULL,
	city				VARCHAR(50)		NULL,
	state_name		VARCHAR(50)		NULL,
	years_old		INTEGER			NULL
	);

CREATE OR REPLACE FUNCTION insert_function() RETURNS TRIGGER AS $$
	BEGIN
		NEW.last_name := 'UNKNOWN';
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION log_customers_change() RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO customers_log (changed_by, time_changed) VALUES (User, DATE_TRUNC('minute',NOW()));
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION statement_function() RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO customers (first_name, last_name)
    VALUES ('statement', 'run');
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;


\COPY customers FROM 'customers.txt' DELIMITER ',' CSV HEADER;

select setval(pg_get_serial_sequence('customers', 'customer_id'), 
              (select max(customer_id) from customers) 
       ); 