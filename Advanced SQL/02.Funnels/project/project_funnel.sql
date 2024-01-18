 -- Step 1
 /*select * 
 from survey
 limit 10;*/

 -- Step 2
 /*SELECT question,
   COUNT(DISTINCT user_id) as answered
FROM survey
GROUP BY question;*/

/* 500, 475, 380, 361, 270 */

-- Step 3
/*SELECT 500/500*100 as perc_1,
  475.0/500.0*100 as perc_2,
  380.0/500.0*100 as perc_3,
  361.0/500.0*100 as perc_4,
  270.0/500.0*100 as perc_5;*/

/* 100%, 75%, 76%, 72.2%, 54% */

-- Step 4
/*SELECT * from quiz
limit 5;*/
/* user_id, style, fit */

/*SELECT * from home_try_on
LIMIT 5;*/
/* user_id, number_of_pairs */

/*SELECT * from purchase
LIMIT 5;*/
/* user_id, product_id, style */

-- Step 5
/*SELECT DISTINCT home.user_id,
  home.user_id IS NOT NULL as 'is_home_try_on',
  home.number_of_pairs,
  c.user_id IS NOT NULL as 'is_purchase'
FROM home_try_on as 'home'
LEFT JOIN purchase as 'c'
  ON home.user_id = c.user_id
LEFT JOIN quiz as 'q'
 ON home.user_id = q.user_id
limit 20;*/

-- Step 6
WITH funnel as (
  SELECT DISTINCT home.user_id as 'user',
    home.user_id IS NOT NULL as 'is_home_try_on',
    home.number_of_pairs,
    c.user_id IS NOT NULL as 'is_purchase'
  FROM home_try_on as 'home'
  LEFT JOIN purchase as 'c'
    ON home.user_id = c.user_id
  LEFT JOIN quiz as 'q'
   ON home.user_id = q.user_id)
SELECT
  count(*) 'browsed',
  sum(is_home_try_on) as 'tried_on',
  sum(is_purchase) as 'purchase',
  100.0 * SUM(is_purchase) / sum(is_home_try_on) AS 'perc_purch'
FROM funnel;
--GROUP BY 'user';

/* 66% purchase rate from those who tried on at home*/