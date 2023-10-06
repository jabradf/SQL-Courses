
CREATE ROLE analyst WITH NOSUPERUSER LOGIN;
CREATE ROLE analyst_mgmt WITH NOSUPERUSER CREATEROLE LOGIN;

/*
Roles
Permission Name	  Function
SUPERUSER	  Is the role a superuser?
CREATEROLE	  Is the role permitted to create additional roles?
CREATEDB	  Is the role able to create databases?
LOGIN	  Is the role able to login?
IN ROLE	  List of existing roles that a role will be added
to as a new member.

*/

ALTER ROLE analyst_mgmt WITH CREATEDB;

-- test this created role
SET ROLE analyst_mgmt;

CREATE ROLE wilson WITH LOGIN;

SELECT * FROM pg_catalog.pg_roles 
ORDER BY rolname;