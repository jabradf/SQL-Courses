-- ********************************** TASK 9 : Export the list of Inactive Customers ********************************** 


-- Step 9.1 Setup the right context for your worksheet ---

/* IMPORTANT : Make Sure to setup the right context for this SQL Worksheet.
			The current role determines which operations can be performed on Snowflake objects based on the access control privileges granted to the role. 
			First select a role, then select a warehouse that the role has privileges to use. Then Select Database and the Schema.

*/ 

-- YOU CAN USE UI to setup the context OR run SQL SCRIPT BELOW : 

USE ROLE ACCOUNTADMIN; -- Or the same role you used to load the data. 
USE WAREHOUSE COMPUTE_WH; -- Or any other Virtual WAREHOUSE you can use. 
USE DATABASE COURSERA;
USE SCHEMA PUBLIC;



-- Step 9.2 Create a View to scale and save your work ---
/* 
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/sql/create-view.html
	SYNTAX : CREATE OR REPLACE VIEW myview AS SELECT col1, col2 FROM MYTABLE;
	
*/

-- Bring together all bits and pieces from previous tasks    

-- Tasks 1 to 7 : Extracting First & Last Names, Extracting Dates, Calculating new Columns, Eliminating Nulls & Blanks
SELECT 
    ID, 
	SPLIT_PART(TRIM(NAME,' 0'),',',2) AS FIRST_NAME, 
    SPLIT_PART(TRIM(NAME,' 0'),', ',1) AS LAST_NAME, 
    EMAIL,
    TO_DATE(DoB, 'MMMM DD, YYYY' ) as DoB,
    DATEDIFF(year, TO_DATE(DoB, 'MMMM DD, YYYY' ), current_date()) as AGE,
	TO_DATE(LastTransaction,'AUTO') AS LastTransaction,
    DATEDIFF(days, LastTransaction, current_date()) as DaysSinceLastTrans,
    iff(((COMPANY IS NULL) OR (COMPANY = '') ),'N/A', COMPANY) AS COMPANY,
	LTRIM(PHONE, '+0' ) AS PHONE,
	ADDRESS, postalZip, Region , COUNTRY
FROM
    CUSTOMERS
WHERE 
    NOT(email is null OR email='');

-- Task 8 What about duplicates ? 
  
/* Create a View to Store the query 
	** NOTE**  : add a WITH to interconnect both queries. WITH clause defines a temporary data set whose output is available to be referenced in subsequent queries. 
		DOCUMENTATION : https://docs.snowflake.com/en/sql-reference/constructs/with.html
*/ 

-- Your Query Here
CREATE OR REPLACE VIEW CUSTOMERS_VW as(
WITH Listids as (    
    SELECT 
        -- this is a window function!
	    ID, Name, Email, LastTransaction,
	    rank() over (partition by email order by TO_DATE(LastTransaction,'AUTO') desc) RANK 
        from CUSTOMERS QUALIFY RANK =1
    )
    SELECT 
        ID, 
	    SPLIT_PART(TRIM(NAME,' 0'),',',2) AS FIRST_NAME, 
        SPLIT_PART(TRIM(NAME,' 0'),', ',1) AS LAST_NAME, 
        EMAIL,
        TO_DATE(DoB, 'MMMM DD, YYYY' ) as DoB,
        DATEDIFF(year, TO_DATE(DoB, 'MMMM DD, YYYY' ), current_date()) as AGE,
	    TO_DATE(LastTransaction,'AUTO') AS LastTransaction,
        DATEDIFF(days, LastTransaction, current_date()) as DaysSinceLastTrans,
        iff(((COMPANY IS NULL) OR (COMPANY = '') ),'N/A', COMPANY) AS COMPANY,
	    LTRIM(PHONE, '+0' ) AS PHONE,
	    ADDRESS, postalZip, Region , COUNTRY
    FROM customers
    WHERE NOT(email is null OR email='') AND ID in (SELECT ID FROM ListIDs));

-- Step 9.3 Query CUSTOMERS_VW (newly created View) to find the list of inactive Customers then export results in CSV ---
/* 
	DOCUMENTATION  : https://docs.snowflake.com/en/sql-reference/sql/create-view.html#examples
	SYNTAX : SELECT .... FROM MY_VIEW WHERE ...
*/

-- <Your SQL Script Here>
SELECT * FROM customers_vw where DaysSinceLastTrans > 90;

-- Step 9.4 Query CUSTOMERS_VW (newly created View) to find the list of inactive Customers then export results in CSV ---
/* 
	Use the UI to export the list of customers in a CSV files
	
*/
