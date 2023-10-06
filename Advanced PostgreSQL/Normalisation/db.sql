DROP SCHEMA IF EXISTS cc_user CASCADE;
CREATE SCHEMA cc_user;
SET SEARCH_PATH = cc_user;


CREATE TABLE college (
  "student_id" INTEGER PRIMARY KEY,
  "full_name" VARCHAR(100) NULL DEFAULT NULL,
  "student_year" VARCHAR(50) NULL DEFAULT NULL,
  "student_email" VARCHAR(100) UNIQUE,
  "major_1" VARCHAR(100) NULL DEFAULT NULL,
  "major_1_credits_reqd" INTEGER NULL DEFAULT NULL,
  "major_2" VARCHAR(100) NULL DEFAULT NULL,
  "major_2_credits_reqd" INTEGER NULL DEFAULT NULL,
  "advisor_name" VARCHAR(100) NULL DEFAULT NULL,
  "advisor_department" VARCHAR(100) NULL DEFAULT NULL,
  "advisor_email" VARCHAR(100) NULL DEFAULT NULL
);

\copy college FROM 'college.txt' delimiter ',' NULL AS 'NULL' csv header