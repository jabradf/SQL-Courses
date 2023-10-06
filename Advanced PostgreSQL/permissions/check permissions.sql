
select * 
from pg_catalog.pg_roles;

-- change o the analyst role for the next test
set role analyst;

-- check permissions for the user
select grantee, table_name, privilege_type
from information_schema.table_privileges
where grantee = 'analyst';

-- test the role
SELECT * FROM event_log WHERE id = 1;