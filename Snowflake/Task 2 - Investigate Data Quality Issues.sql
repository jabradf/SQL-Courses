-- ********************************** TASK 2 : Investigate Data Quality Issues ********************************** 


-- Step 2.1 Setup the right context for your worksheet ---

/* IMPORTANT : Make Sure to setup the right context for this SQL Worksheet.
			The current role determines which operations can be performed on Snowflake objects based on the access control privileges granted to the role. 
			First select a role, then select a warehouse that the role has privileges to use. Then Select Database and the Schema.



-- YOU CAN USE UI to setup the context OR run SQL SCRIPT BELOW : 

-- USE ROLE ACCOUNTADMIN; -- Or the same role you used to load the data.
-- USE WAREHOUSE COMPUTE_WH; -- Or any other Virtual WAREHOUSE you can use. 
-- USE DATABASE COURSERA;
-- USE SCHEMA PUBLIC;

*/ 


-- Step 2.2 Write a Select * statement to visualise the data. ---
/* 
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/sql/select.html 
	SYNTAX : SELECT {<object_name>|<alias>}.<col_name> / * FROM {<DATABASE>.<SCHEMA>.}<TABLE> ;
	
	***OPTIONAL*** Add ORDER BY RANDOM() if dealing with Massive dataset  ---	
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/functions/random.html 
	SYNTAX : RAND() 
	** NOTES ** : The function RANDOM() generates a random value for each row in the table.
			The ORDER BY clause sorts all rows in the table by the random number generated by the RAND() function.
			The LIMIT clause picks the first row in the result set sorted randomly.
*/


-- <Your SQL Script Here>  
SELECT * FROM CUSTOMERS
--ORDER BY RANDOM(23)	-- use for large datasets so you get a randomised returned result which is useful when using LIMIT
	
--- Step 2.3 Use the Contextual Statistcis Panel  ---
/* 
	DOCUMENTATION : https://docs.snowflake.com/en/user-guide/ui-snowsight-query.html#automatic-contextual-statistics 
	** NOTES ** Up to 10,000 rows can be displayed in the results. If your query returns more than 10,000 rows, the statistics still reflect the entire result set.
*/

-- 1- Check Data Types 

-- 2- Use the Result Panel from UI