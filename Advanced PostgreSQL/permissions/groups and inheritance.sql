-- CREATE ROLE marketing WITH NOLOGIN ROLE alice, bob;

/*
Create a group role called pgdba (Postgres Database Administrator) with SUPERUSER, CREATEDB, and NOLOGIN permissions. 
*/
-- don't use commas here!
CREATE ROLE pgdba WITH SUPERUSER CREATEDB NOLOGIN;
--GRANT finance TO charlie;

/*
Create a user named david with LOGIN. david should be added as a member of two (already existing) groups.

pgdba - The group you created in the previous exercise
employees - A group that already exists on the DB.
*/
CREATE ROLE david WITH LOGIN IN ROLE pgdba, employees; 

SELECT rolname, rolsuper
from pg_catalog.pg_roles
where rolname = 'david';

/*
Let’s confirm that david has inherited permissions from employees. employees has access to SELECT from a table named company_startdates. Do you expect david to have access to this table? Run the SQL below to test your hypothesis.
*/
SET ROLE david;

SELECT * 
FROM cc_user.company_startdates;