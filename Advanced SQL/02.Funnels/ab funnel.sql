/* Using GROUP BY, count the number of distinct user_id‘s for each value of modal_text. This will tell us the number of users completing each step of the funnel.

This time, sort modal_text so that your funnel is in order.


3.
The previous query combined both the control and variant groups.

We can use a CASE statement within our COUNT() aggregate so that we only count user_ids whose ab_group is equal to ‘control’:
*/

SELECT modal_text,
   COUNT(DISTINCT CASE
     WHEN ab_group = 'control' THEN user_id
     END) as 'control_clicks'
FROM onboarding_modals
GROUP BY 1
ORDER BY modal_text;

/*

Add an additional column to your previous query that counts the number of clicks from the variant group 
and alias it as ‘variant_clicks’.
*/

SELECT modal_text,
   COUNT(DISTINCT CASE
     WHEN ab_group = 'control' THEN user_id
     END) as 'control_clicks',
     COUNT(DISTINCT CASE
     WHEN ab_group = 'variant' THEN user_id
     END) as 'variant_clicks'
FROM onboarding_modals
GROUP BY 1
ORDER BY modal_text;