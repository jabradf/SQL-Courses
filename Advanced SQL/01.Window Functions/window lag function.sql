-- window function that uses LAG to look at the artist's current number of streams and their streams from the previous week.
-- more info https://www.sqlshack.com/sql-lag-function-overview-and-examples/
/*SELECT
   artist,
   week,
   streams_millions,
   LAG(streams_millions, 1, 0) OVER (
      ORDER BY week 
   ) previous_week_streams 
FROM
   streams 
WHERE
   artist = 'Lady Gaga';*/

-- LAG takes up to three arguments:

-- * column (required)
-- * offset (optional, default 1 row offset)
-- * default (optional, what to replace default null values with)

-- Show the change in streams for Lady Gaga per week:
/*SELECT
   artist,
   week,
   streams_millions,
   streams_millions - LAG(streams_millions, 1, streams_millions) OVER ( 
      ORDER BY week 
   ) streams_millions_change
FROM
   streams 
WHERE
   artist = 'Lady Gaga';*/

/*
Build upon our current query to use PARTITION BY to show the change in streams for “Lady Gaga” as well as the change in chart position.
*/
SELECT
   artist,
   week,
   streams_millions,
   streams_millions - LAG(streams_millions, 1, streams_millions) OVER ( 
      ORDER BY week 
   ) 'streams_millions_change',
   chart_position,
   LAG(chart_position, 1, chart_position) OVER ( 
      PARTITION BY artist
      ORDER BY week 
) - chart_position AS 'chart_position_change'
FROM
   streams 
WHERE
   artist = 'Lady Gaga';