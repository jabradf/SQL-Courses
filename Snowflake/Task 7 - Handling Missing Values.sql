-- ********************************** TASK 7 : Handling Missing Values ********************************** 


-- Step 7.1 Setup the right context for your worksheet ---

/* IMPORTANT : Make Sure to setup the right context for this SQL Worksheet.
			The current role determines which operations can be performed on Snowflake objects based on the access control privileges granted to the role. 
			First select a role, then select a warehouse that the role has privileges to use. Then Select Database and the Schema.

*/ 

-- YOU CAN USE UI to setup the context OR run SQL SCRIPT BELOW : 

USE ROLE ACCOUNTADMIN; -- Or the same role you used to load the data. 
USE WAREHOUSE COMPUTE_WH; -- Or any other Virtual WAREHOUSE you can use. 
USE DATABASE COURSERA;
USE SCHEMA PUBLIC;



-- Step 7.2 Handle Missing Data with Deletion  ---
/* 
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/functions/is-null.html
	SYNTAX : <expr> IS [ NOT ] NULL;
    ** Notes : Use Logical operators AND, NOT OR
*/

-- <Your SQL Script Here> 
SELECT name,
phone,
email

FROM customers
where  NOT (email is NULL or email='') AND
    NOT (phone is NULL or phone='');

-- Step 7.3 Handle Missing Data with Imputation  ---
/* 
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/functions/iff.html
	SYNTAX : IFF( <condition> , <expr1> , <expr2> )
*/

-- <Your SQL Script Here>
SELECT name, 
    IFF(company is null or company='', 'NA',company) as company_clean

FROM customers;