/*
The management team suspects that conversion from checkout to purchase changes as the browse_date gets closer to Christmas Day.

We can make a few edits to this code to calculate the funnel for each browse_date using GROUP BY.

Edit the code in so that the first column in the result is browse_date.
Then, use GROUP BY so that we calculate num_browse, num_checkout, and num_purchase for each browse_date.
Also be sure to ORDER BY browse_date.
*/

WITH funnels AS (
  SELECT DISTINCT b.browse_date,
     b.user_id,
     c.user_id IS NOT NULL AS 'is_checkout',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM browse AS 'b'
  LEFT JOIN checkout AS 'c'
    ON c.user_id = b.user_id
  LEFT JOIN purchase AS 'p'
    ON p.user_id = c.user_id)
SELECT browse_date,
   COUNT(*) AS 'num_browse',
   SUM(is_checkout) AS 'num_checkout',
   SUM(is_purchase) AS 'num_purchase',
   1.0 * SUM(is_checkout) / COUNT(user_id) AS 'browse_to_checkout',
   1.0 * SUM(is_purchase) / SUM(is_checkout) AS 'checkout_to_purchase'
FROM funnels
GROUP BY browse_date
ORDER BY browse_date;