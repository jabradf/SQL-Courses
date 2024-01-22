/*
Here's the first-touch query, in case you need it
*/

/*WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;*/

-- Step 1
SELECT COUNT(DISTINCT utm_campaign) as campaigns,
  COUNT(DISTINCT utm_source) as sources
from page_visits;
/*
campaigns	sources
8	6
*/

select DISTINCT utm_campaign, utm_source
from page_visits;
/*
utm_campaign	utm_source
getting-to-know-cool-tshirts	nytimes
weekly-newsletter	email
ten-crazy-cool-tshirts-facts	buzzfeed
retargetting-campaign	email
retargetting-ad	facebook
interview-with-cool-tshirts-founder	medium
paid-search	google
cool-tshirts-search	google
*/

-- Step 2
SELECT DISTINCT page_name
FROM page_visits;
/*
1 - landing_page
2 - shopping_cart
3 - checkout
4 - purchase*/

-- Step 3
/*WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr as (
  SELECT ft.user_id,
      ft.first_touch_at,
      pv.utm_source,
		  pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
  )
SELECT ft_attr.utm_source,
ft_attr.utm_campaign,
COUNT(*) as 'camp_count'
FROM ft_attr
GROUP BY utm_source, utm_campaign
ORDER BY camp_count DESC;*/

/*
utm_source	utm_campaign	camp_count
medium	interview-with-cool-tshirts-founder	622
nytimes	getting-to-know-cool-tshirts	612
buzzfeed	ten-crazy-cool-tshirts-facts	576
google	cool-tshirts-search	169
*/

-- Step 4
/*WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr as (
  SELECT lt.user_id,
      lt.last_touch_at,
      pv.utm_source,
		  pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
  )
SELECT lt_attr.utm_source,
lt_attr.utm_campaign,
COUNT(*) as 'camp_count'
FROM lt_attr
GROUP BY utm_source, utm_campaign
ORDER BY camp_count DESC;*/

/*
utm_source	utm_campaign	camp_count
email	weekly-newsletter	447
facebook	retargetting-ad	443
email	retargetting-campaign	245
nytimes	getting-to-know-cool-tshirts	232
buzzfeed	ten-crazy-cool-tshirts-facts	190
medium	interview-with-cool-tshirts-founder	184
google	paid-search	178
google	cool-tshirts-search	60
*/

-- Step 5
SELECT COUNT(DISTINCT user_id) as 'users_purch'
FROM page_visits
WHERE page_name = '4 - purchase';
/* There were 361 distinct user purchases */

-- Step 6
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_attr as (
  SELECT lt.user_id,
      lt.last_touch_at,
      pv.utm_source,
		  pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
  )
SELECT lt_attr.utm_source,
lt_attr.utm_campaign,
COUNT(*) as 'camp_count'
FROM lt_attr
GROUP BY utm_source, utm_campaign
ORDER BY camp_count DESC;

/*
utm_source	utm_campaign	camp_count
email	weekly-newsletter	115
facebook	retargetting-ad	113
email	retargetting-campaign	54
google	paid-search	52
buzzfeed	ten-crazy-cool-tshirts-facts	9
nytimes	getting-to-know-cool-tshirts	9
medium	interview-with-cool-tshirts-founder	7
google	cool-tshirts-search	2
*/

-- Step 7
/*
The first touches had a lot of hits, but the last touch with purchase were more successful overall (they generate sales):
- weekly-newsletter
- retargetting-ad
- retargetting-campaign
- paid-search
- ten-crazy-cool-tshirts-facts
