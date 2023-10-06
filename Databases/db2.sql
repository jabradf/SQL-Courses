DROP SCHEMA IF EXISTS cc_user CASCADE;
CREATE SCHEMA cc_user;
SET SEARCH_PATH = cc_user;

CREATE TABLE clients
	(
	client_id		INTEGER			GENERATED ALWAYS AS IDENTITY	PRIMARY KEY,
  high_spender  INTEGER NULL,
	first_name		VARCHAR(100)	NOT NULL,
	last_name		VARCHAR(100)	NOT NULL,
	total_spent INTEGER NULL
	);

CREATE OR REPLACE FUNCTION set_low_spender() RETURNS TRIGGER AS $$
	BEGIN
		NEW.high_spender = 0;
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION set_high_spender() RETURNS TRIGGER AS $$
	BEGIN
		NEW.high_spender = 1;
		RETURN NEW;
	END;
$$ LANGUAGE PLPGSQL;

\COPY clients FROM 'customers.txt' DELIMITER ',' CSV HEADER;

select setval(pg_get_serial_sequence('clients', 'client_id'), 
              (select max(client_id) from clients) 
       ); 