/*
The students_majors and majors tables have been created for you. The students_majors table contains columns student_id and major_id; the majors table contains columns id, major, and credits_reqd

Fill in the blanks in the provided query to produce a list of majors and the number of students who have declared them, sorted by popularity.
*/
SELECT major, count(*)
FROM students_majors, majors
WHERE major_id = id
GROUP BY major
ORDER BY count DESC;

/*
An advisors table has been created for you with advisor email, name, and department. The email column is constrained as UNIQUE because we now expect no duplication in this column.

Below your query from step 1: copy, paste, and fill in the provided code to update the advisors table such that email = 'sophie@college.edu' in all rows where name = 'Sommer'. Unlike before, you should get an error because there are two professors with the name ‘Sommer’ and this update will therefore violate the UNIQUE constraint.
*/
UPDATE advisors
SET email = 'sophie@college.edu'
WHERE name = 'Sommer';