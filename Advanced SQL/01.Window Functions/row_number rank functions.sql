SELECT 
   ROW_NUMBER() OVER (
      ORDER BY streams_millions DESC
   ) AS 'row_num', 
   artist, 
   week,
   streams_millions
FROM
   streams;


   /*
  
RANK will follow standard ranking rules so that when two values are the same, they will have the same rank 
whereas with ROW_NUMBER they would not.
   */

SELECT 
   RANK() OVER (
      --PARTITION BY week  -- see the most streamed artist per week
      ORDER BY streams_millions DESC
   ) AS 'rank', 
   artist, 
   week,
   streams_millions
FROM
   streams;