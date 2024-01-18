-- examples here: https://www.sqlshack.com/overview-and-examples-of-sql-server-lead-function/
SELECT
   artist,
   week,
   streams_millions,
   LEAD(streams_millions, 1) OVER (
      PARTITION BY artist
      ORDER BY week
   ) - streams_millions AS 'streams_millions_change',
   chart_position,
   chart_position - LEAD(chart_position, 1) OVER ( 
      PARTITION BY artist
      ORDER BY week 
) AS 'chart_position_change'
FROM
   streams;