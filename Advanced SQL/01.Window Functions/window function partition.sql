-- PARTITION BY is a subclause of the OVER clause and divides a query’s result set into parts. It’s very similar to GROUP BY except it does not reduce the number of rows returned.

-- While using GROUP BY only allows one row to be returned for each group, PARTITION BY allows you to see all of the resultant rows.

SELECT 
    username,
    month,
    change_in_followers,
    SUM(change_in_followers) OVER (
      PARTITION BY username 
      ORDER BY month
    ) 'running_total_followers_change',
    AVG(change_in_followers) OVER (
      PARTITION BY username
      ORDER BY month
    ) 'running_avg_followers_change'
FROM
    social_media;

-- The steadiest flow of followers would be the user with the most consistent average.