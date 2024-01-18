/*NTILE allows you to break your data into roughly equal groups, based on what ntile you’d like: 
so if you were using quartile, it would divide the data into four groups (quarters).

When using NTILE you are required to provide a bucket, which represents the number of groups 
you’d like your data broken down into: NTILE(4) would be four “buckets” which would represent quartiles.*/

SELECT 
   NTILE(5) OVER (
      -- PARTITION BY week  -- separate by week
      ORDER BY streams_millions DESC
   ) AS 'weekly_streams_group', 
   artist, 
   week,
   streams_millions
FROM
   streams;

/*
Because we have 5 buckets, this NTILE would represent quintiles or fifths. The top quintile is made almost 
entirely of Drake. The Weeknd and Bad Bunny also had enough weekly streams to land them a few spots in the top quintile.
*/