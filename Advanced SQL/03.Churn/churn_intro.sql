/*
Single Month Churn
Churn = cancellations / total_subscribers

We’ve imported 4 months of data for a company from when they began selling subscriptions. This company has a minimum commitment of 1 month, so there are no cancellations in the first month.

The subscriptions table contains:

id
subscription_start
subscription_end
Use the methodology provided in the narrative to calculate the churn for January 2017.*/

SELECT 1.0 * 
(
  SELECT COUNT(*)
  FROM subscriptions
  WHERE subscription_start < '2017-01-01'
  AND (
    subscription_end 
    BETWEEN '2017-01-01' 
    AND '2017-01-31'
  )
) / (
  SELECT COUNT(*)
  FROM subscriptions
  WHERE subscription_start < '2017-01-01'
  AND (
    (subscription_end >= '2017-01-01')
    OR (subscription_end IS NULL)
  )
)
AS result;
