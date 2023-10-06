/*
Create a table called majors that contains the major_1 and major_1_credits_reqd columns (in that order) from the college table. Use the DISTINCT key word to only include one row per unique major (note: for simplicity, we are assuming — correctly — that all possible majors are represented in the major_1 column).
*/

CREATE TABLE majors AS
SELECT distinct major_1, major_1_credits_reqd
FROM college;

/*
Below your first CREATE TABLE statement from step 1: Copy, paste, and fill in the blanks in the following code to create a table called students_majors containing all unique student-major pairs. To identify a unique student, use the student_id column.
*/

CREATE TABLE students_majors AS
SELECT major_1 as major, student_id 
FROM college
UNION ALL
SELECT major_2 as major, student_id
FROM college
WHERE major_2 IS NOT NULL;

/*
Below the two CREATE TABLE statements from steps 1 and 2, write an ALTER TABLE statement to delete the major_1, major_1_credits_reqd, major_2, and major_2_credits_reqd columns from the original college table.
*/
ALTER TABLE college
DROP COLUMN major_1, 
DROP COLUMN major_1_credits_reqd,
DROP COLUMN major_2, 
DROP COLUMN major_2_credits_reqd;

/*
Below all of your CREATE TABLE and ALTER TABLE statements from the previous steps, query the students_majors table to print the first 10 rows (and all columns), ordered by student_id. Does it look as expected?
*/
select * from students_majors order by student_id limit 10;