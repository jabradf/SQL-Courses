/*
The owners of the bakery want to find out what day most people placed orders.

Use STRFTIME() with the COUNT() function to find out how many orders were made on each day. 
Show the results in descending order based on the daily number of orders.
*/

SELECT strftime('%d', order_date) AS 'order_day',
  COUNT(*) 
FROM bakery 
GROUP BY 1
ORDER BY 2 DESC;