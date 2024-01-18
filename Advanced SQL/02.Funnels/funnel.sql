/*Now, let’s build our first basic funnel!

Count the number of distinct user_id who answered each question_text.

You can do this by using a simple GROUP BY command.

What is the number of responses for each question?*/

SELECT question_text,
   COUNT(DISTINCT user_id)
FROM survey_responses
GROUP BY 1;