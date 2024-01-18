-- returns the lowest number of posts

/*SELECT username,
   posts,
   FIRST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
   ) AS 'fewest_posts'
FROM social_media;
*/

/*SELECT username,
   posts,
   LAST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
   ) AS 'fewest_posts'
FROM social_media;
*/

-- using LAST_VALUE shows the last value instead of the most posts as we wanted, so we need to specify a frame

SELECT
   username,
   posts,
   LAST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
      RANGE BETWEEN UNBOUNDED PRECEDING AND 
      UNBOUNDED FOLLOWING
    ) most_posts
FROM
    social_media;