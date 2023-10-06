/*
The students, majors and students_majors tables have been created for you as outlined in the schema from this exercise. Suppose that you are asked to email students a reminder about the number of credits required for their major(s).

To answer this question, you’ll need to join the students, students_majors and majors tables back together. Fill in the code below to select the student_id, and credits_reqd columns from the appropriately joined table.
*/
/*SELECT student_id, credits_reqd
FROM students, students_majors, majors
WHERE students.id = students_majors.student_id
AND students_majors.major_id = majors.id;*/

/*
Now, edit your query from step 1 to replace the credits_reqd column with a column named total_credits that contains the total number of credits required by each student (to accomplish this, you’ll need to sum the credits_reqd values associated with each unique student_id).
*/
/*SELECT student_id, sum(credits_reqd) as total_credits
FROM students, students_majors, majors
WHERE students.id = students_majors.student_id
AND students_majors.major_id = majors.id
group by student_id;*/

/*
Finally, edit your query from steps 1 and 2 to also return the email column from the students table as a third column named student_email.

Note that, because you are grouping by student_id, you will need to aggregate any other column you query; However, because the email column is unique for every student_id, it doesn’t matter how you aggregate. We can, for example, use MIN(email) to get the first email associated with each student_id(and this would yield the same results as MAX(email)).*/

SELECT student_id, 
  sum(credits_reqd) as total_credits,
  min(email) as student_email
FROM students, students_majors, majors
WHERE students.id = students_majors.student_id
AND students_majors.major_id = majors.id
group by student_id;
