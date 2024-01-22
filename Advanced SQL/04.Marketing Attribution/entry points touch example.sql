 -- Capture entry point information from UTM Parameters
 -- This example shows the 'last touch' principle
 /*
* First-touch attribution only considers the first source for each customer. 
 This is a good way of knowing how visitors initially discover a website.
* Last-touch attribution only considers the last source for each customer. 
 This is a good way of knowing how visitors are drawn back to a website, especially for making a final purchase.
 */
 SELECT user_id,
  MAX(timestamp) AS 'last_touch_at'
 FROM page_visits
 WHERE user_id = 10069 -- and utm_source = 'buzzfeed'
 GROUP BY user_id;

-- First touch example, joining to the page visits table
 WITH first_touch AS (
   SELECT user_id,
      MIN(timestamp) AS 'first_touch_at'
   FROM page_visits
   GROUP BY user_id)
SELECT ft.user_id,
  ft.first_touch_at,
  pv.utm_source
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp;
