-- Step 1
/*SELECT *
FROM subscriptions
LIMIT 20;

SELECT COUNT(DISTINCT segment) as unique_seg
FROM subscriptions;*/
/* 2 unique segments: 87 and 30 */

-- Step 2
/*SELECT MIN(subscription_start)
FROM subscriptions;

SELECT MAX(subscription_start)
FROM subscriptions;*/

/*
Min is 2016-12-01
Max is 2017-03-30
*/

-- Step 3 & 4
/*WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months)
SELECT *
FROM cross_join
LIMIT 100;*/

-- Step  5
/*WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
-- Temporary status table
status AS (
SELECT id, segment, first_day as month,
CASE
WHEN segment = 30 AND -- 87, 30
  (subscription_start < first_day)
  AND (
    subscription_end > first_day
    OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END AS is_active_30,
CASE
WHEN segment = 87 AND -- 87, 30
  (subscription_start < first_day)
  AND (
    subscription_end > first_day
    OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END AS is_active_87
FROM cross_join)
 
SELECT *
FROM status
LIMIT 20;*/

-- Step 6
/*WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
-- Step 5 Temporary status table for active members
status AS (
SELECT id, segment, first_day as month,
CASE
WHEN segment = 30 AND -- 87, 30
  (subscription_start < first_day)
  AND (
    subscription_end > first_day
    OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END AS is_active_30,
CASE
WHEN segment = 87 AND -- 87, 30
  (subscription_start < first_day)
  AND (
    subscription_end > first_day
    OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END AS is_active_87,
-- Step 6 add cancelled
CASE 
  WHEN 
    subscription_end BETWEEN first_day 
    AND last_day AND segment=30 THEN 1
  ELSE 0
END as is_canceled_30,
CASE 
  WHEN 
    subscription_end BETWEEN first_day 
    AND last_day AND segment=87 THEN 1
  ELSE 0
END as is_canceled_87
FROM cross_join),
-- Step 7 add aggregate
status_aggregate AS
(SELECT
  month,
  SUM(is_active_87) as sum_active_87,
  SUM(is_active_30) as sum_active_30,
  SUM(is_canceled_87) as sum_canceled_87,
  SUM(is_canceled_30) as sum_canceled_30
FROM status
GROUP BY month)
-- Step 8 - Calculate churn
SELECT month,
  1.0 * sum_canceled_87/sum_active_87 as churn_rate_87,
  1.0 * sum_canceled_87/sum_active_30 as churn_rate_30
FROM status_aggregate;*/

/*SELECT *
-- cross_join
--FROM status
FROM status_aggregate
LIMIT 20;*/

-- Step 9 Bonus
WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
-- Temporary status table
status AS (
SELECT id, first_day as month, segment,
CASE
WHEN segment = 30 AND -- 87, 30
  (subscription_start < first_day)
  AND (
    subscription_end > first_day
    OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END AS is_active_30,
CASE
WHEN segment = 87 AND -- 87, 30
  (subscription_start < first_day)
  AND (
    subscription_end > first_day
    OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END AS is_active_87,
-- add cancelled
CASE 
  WHEN 
    subscription_end BETWEEN first_day 
    AND last_day THEN 1
  ELSE 0
END as is_canceled_30,
CASE 
  WHEN 
    subscription_end BETWEEN first_day 
    AND last_day THEN 1
  ELSE 0
END as is_canceled_87
FROM cross_join),
-- add aggregate
status_aggregate AS
(SELECT
  month,
  SUM(is_active_87) as sum_active_87,
  SUM(is_active_30) as sum_active_30,
  SUM(is_canceled_87) as sum_canceled_87,
  SUM(is_canceled_30) as sum_canceled_30
FROM status
GROUP BY month, segment
)
-- Calculate churn
SELECT month,
  1.0 * sum_canceled_87/sum_active_87 as churn_rate_87,
  1.0 * sum_canceled_87/sum_active_30 as churn_rate_30
FROM status_aggregate;