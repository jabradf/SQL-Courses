SET client_min_messages TO WARNING;

DROP SCHEMA IF EXISTS mock CASCADE;
CREATE SCHEMA mock;

-- id,broker_code,address,price
CREATE TABLE IF NOT EXISTS mock.house_prices (
  id int,
  broker_code varchar,
  address varchar,
  price numeric
);

\copy mock.house_prices FROM 'house_prices.csv' delimiter '|' csv header;

create unique index house_prices_pk on mock.house_prices using btree(id);