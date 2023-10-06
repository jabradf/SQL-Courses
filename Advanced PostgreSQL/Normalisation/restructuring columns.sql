/*
Up to this point, we have examined problems with this database design and implications for queries and modifications. In this exercise, we’ll start to redesign our database to address some of these problems.

First, we saw that every student with the same advisor has identical information recorded in all advisor-related columns in the college table. One way to address this is by moving the four advisor-related columns into their own table, with only one row per unique advisor. This helps ensure every table has its own purpose or concern.
*/

CREATE TABLE advisors AS
SELECT distinct advisor_email, advisor_name, advisor_department
FROM college;

/*
We can also delete columns from our original table once we have moved them. For example, the following code drops the columns major_1 and major_1_credits_reqd from the college table.

Note that we need to keep advisor_email (or some sort of advisor identifier) in the college table to ensure that we can still match advisors to students.
*/

ALTER TABLE college
DROP COLUMN advisor_name, 
DROP COLUMN advisor_department;

/*
Query the new advisors table for all rows where 'Brunson' is listed as the advisor_name. Note that this information is now condensed to a single row in our database!
*/
select * from advisors where advisor_name = 'Brunson';