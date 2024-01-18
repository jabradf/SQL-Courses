/*
Let’s create a funnel using the joined tables from the previous query..

1. First, add a column that counts the total number of rows in funnels.
Alias this column as ‘num_browse’.
This is the number of users in the “browse” step of the funnel.

2. Second, add another column that sums the is_checkout in funnels.
Alias this column as ‘num_checkout’.
This is the number of users in the “checkout” step of the funnel.

3. Third, add another column that sums the is_purchase column in funnels.
Alias this column as ‘num_purchase’.
This is the number of users in the “purchase” step of the funnel.

4. Finally, let’s do add some more calculations to make the results more in depth.
Let’s add these two columns:
Percentage of users from browse to checkout
Percentage of users from checkout to purchase
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
SELECT COUNT(*) as 'num_browse',
  SUM(is_checkout) as 'num_checkout',
  SUM(is_purchase) as 'num_purchase',
  1.0 * SUM(is_checkout) / COUNT(user_id) as 'b2c',
  1.0 * SUM(is_purchase) / SUM(is_checkout) as 'perc_c2p'
FROM funnels;