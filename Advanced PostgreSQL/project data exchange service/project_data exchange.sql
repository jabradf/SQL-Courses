-- step 1
select * 
from pg_catalog.pg_roles
where rolsuper = true;
-- user is ccuser

-- step 2
select * 
from pg_roles;

-- step 3
select * from current_user;

-- step 4
CREATE ROLE abc_open_data WITH NOSUPERUSER LOGIN;

-- step 5
CREATE ROLE publishers WITH NOSUPERUSER LOGIN IN ROLE abc_open_data; 

-- step 6
GRANT USAGE, CREATE ON SCHEMA analytics TO publishers;

-- step 7
GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO publishers;

-- step 8
SELECT * FROM information_schema.table_privileges
WHERE grantee = 'publishers';

-- step 9
set role abc_open_data;
SELECT * FROM information_schema.table_privileges
WHERE grantee = 'publishers';

SET ROLE ccuser;

-- step 10
select * 
from directory.datasets
limit 10;

-- step 11
GRANT USAGE ON SCHEMA directory TO publishers;

-- step 12
GRANT SELECT (id, create_date, hosting_path, publisher, src_size) ON directory.datasets TO publishers;

-- step 13
/*set role abc_open_data;
SELECT id, publisher, hosting_path, data_checksum
FROM directory.datasets;*/
-- will fail because it doesn't have the correct permissions

-- step 14
CREATE POLICY pub_rls_policy ON analytics.downloads 
FOR SELECT TO publishers USING (owner=current_user);

ALTER TABLE analytics.downloads ENABLE ROW LEVEL SECURITY;

-- step 15
select * from analytics.downloads limit 10;

set role abc_open_data;
select * from analytics.downloads limit 10;

