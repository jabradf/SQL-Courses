--GRANT USAGE ON finance TO analyst;
--GRANT SELECT ON ALL TABLES IN finance TO analyst;

/*
Grant a role named writer the ability to SELECT, DELETE, UPDATE, and INSERT on a table named census.economic_survey. You may assume that the role already has USAGE on the schema.
*/
GRANT SELECT, DELETE, UPDATE, INSERT ON census.economic_survey TO writer;

/*
This schema will soon be populated with many tables containing data from other census surveys. Modify the DEFAULT PRIVILEGES so that SELECT, DELETE, UPDATE, and INSERT are granted to writer on newly created tables in the census schema.
*/
ALTER DEFAULT PRIVILEGES IN SCHEMA census
GRANT SELECT, DELETE, UPDATE, INSERT ON TABLES TO writer;

/*
Use the SQL given below to create a new table in the census schema. If we’ve set default permissions properly, then the permissions we just defined will automatically apply to this table as well:
*/
CREATE TABLE census.housing_survey (
    area_id int primary key, 
    median_rent int
);


/*
Let’s confirm that altering the default privileges has had the desired effect. Now that census.housing_survey has just been created, run the query below to confirm that all privileges appear in information_schema.table_privileges.
*/
SELECT
    grantee, 
    table_schema,
    table_name,
    privilege_type
FROM information_schema.table_privileges 
WHERE table_schema  = 'census'
AND grantee = 'writer';
