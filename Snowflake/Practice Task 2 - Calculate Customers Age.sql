-- ********************************** PRACTICE TASK 2 : Calculate Customers' Age ********************************** 


-- Step 2.1 Setup the right context for your worksheet ---

/* IMPORTANT : Make Sure to setup the right context for this SQL Worksheet.
			The current role determines which operations can be performed on Snowflake objects based on the access control privileges granted to the role. 
			First select a role, then select a warehouse that the role has privileges to use. Then Select Database and the Schema.

*/ 

-- YOU CAN USE UI to setup the context OR run SQL SCRIPT BELOW : 

-- USE ROLE ACCOUNTADMIN; -- Or the same role you used to load the data. 
-- USE WAREHOUSE COMPUTE_WH; -- Or any other Virtual WAREHOUSE you can use. 
-- USE DATABASE COURSERA;
-- USE SCHEMA PUBLIC;



-- Step 2.2 Use DATEDIFF() to count Age of each Customer in "YEARS"  ---
/* 
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/functions/datediff.html#
	SYNTAX : DATEDIFF( <date_or_time_part>, <date_or_time_expr1>, <date_or_time_expr2> );
    ** Notes : CURRENT_DATE() Returns the current date of the system. For more information, visit this link : 
				https://docs.snowflake.com/en/sql-reference/functions/current_date.html
*/

-- <Your SQL Script Here> 




-- "BONUS" Step 2.3 Combine all in one Select Statement  ---

-- Try it yourself !!! 
 
/*
SELECT 
    ID, 
	SPLIT_PART(TRIM(NAME,' 0'),', ', 1) as FIRST_NAME, 
    SPLIT_PART(TRIM(NAME,' 0'),', ', 2) as LAST_NAME, 
    EMAIL,
    TO_DATE(DOB,'MMMM DD, YYYY') DOB,
	TO_DATE(LastTransaction,'AUTO') AS LastTransaction,
	DATEDIFF(days, TO_DATE(LastTransaction,'AUTO'), current_date()) as DaysSinceLastTrans,
	DATEDIFF(days, TO_DATE(DOB,'MMMM DD, YYYY'), current_date()) as Age,
    LTRIM(PHONE,'0+') as Standarized_Phone,
    ADDRESS, 
    REGION , 
    COUNTRY,
    COMPANY
FROM
    CUSTOMERS;
*/

select
SPLIT_PART(trim(name, ' 0'), ',', 1) as Last_Name,
SPLIT_PART(trim(name, ' 0'), ', ', 2) as First_Name,
to_date(DOB, 'MMMM DD, YYYY') as date_of_birth,

DATEDIFF(year, to_date(DOB, 'MMMM DD, YYYY'), current_date()) as age

from customers
