/*
Create the advisors table from the schema diagram, with columns in the same order. Make sure to include any relevant primary and foreign key constraints and add a UNIQUE constraint to the email column.
*/
CREATE TABLE advisors  (
  id int PRIMARY KEY,
  email varchar(100) UNIQUE,
  name varchar(100),
  department varchar(100)
);

/*
Add a second CREATE TABLE statement (below the first) to create the students table from the schema diagram, with columns in the same order. Make sure to include any relevant primary and foreign key constraints and add a UNIQUE constraint to the email column.
*/
CREATE TABLE students  (
  id int PRIMARY KEY,
  name varchar(100),
  year varchar(50),
  email varchar(100) UNIQUE,
  advisor_id int REFERENCES advisors(id)
);

/*
Add a third CREATE TABLE statement (below the first two) to create the majors table from the schema diagram, with columns in the same order. Make sure to include any relevant primary and foreign key constraints.
*/
CREATE TABLE majors  (
  id int PRIMARY KEY,
  major varchar(100),
  credits_reqd int
);

/*
Add a fourth CREATE TABLE statement (below the first three) to create the students_majors table from the schema diagram, with columns in the same order. Make sure to include any relevant primary and foreign key constraints.
*/
CREATE TABLE students_majors  (
  student_id int REFERENCES students(id),
  major_id int REFERENCES majors(id)
);





