/*
-- step 1 query
SELECT major_1 as major 
FROM college
UNION ALL
SELECT major_2 as major
FROM college
WHERE major_2 IS NOT NULL;
*/

-- final step, adding the original query to count the results
WITH majors AS(
  SELECT major_1 as major 
  FROM college
  UNION ALL
  SELECT major_2 as major
  FROM college
  WHERE major_2 IS NOT NULL
)
SELECT major, count(*)
FROM majors
GROUP BY major
ORDER BY count DESC;