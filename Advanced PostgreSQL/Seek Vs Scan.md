# Seek vs Scan
Learn about the difference between a seek search and a scan search

## Overview
In this article, we are going to go a little deeper into the different ways a database server looks for the data you request in your queries.

We will cover:

* What is a seek search in a database
* What is a scan search in a database
* When are each of them used by the system
* What control you have as a programmer on which method the server will use
* When the system will completely ignore your best laid plans

As a note, we are using the terms Seek and Scan, however, you should be aware that different database servers use different terminology for very similar things. For instance, SQL Server uses Seek and Scan, PostgreSQL uses Scan, Index Scan and Bitmap Heap Scan. Make sure you familiarize yourself with the specific way the server you are working in searches for records requested by your queries and the ways you can improve them to take advantage of the server you are using.

## Definition
There are two major ways that a database searches for rows in a table/view when you run any query. This isn’t limited to `SELECT` statements — this applies to every type of query that needs to find specific rows. For example, in a database of orders, an `UPDATE` query for orders over $10k would need to search for those records. The two basic ways searches are performed are via a seek or a scan.

A scan searches through every record in a database table/view to find the records being asked for. So in our example, if you wanted customers that have spent over $10k, the system would need to check every record to see if their order amount was over this threshold.

Multiple choice
A database scan searches by:

* (Selected)Correct: Looking at every record.
* Using an index to jump to the desired record(s).
* Using a “best guess” to try and find a good starting point to find the record(s).

👏
You got it!

On the other hand, a seek uses an index to find the specific records being asked for by jumping to their location and either grabbing the data or, if it is a reference, using it to get the information. Let’s look at our example, but this time, let’s assume that the table has an index on the amount spent. When you search for rows where the amount spent is over $10K, now the system can jump almost immediately to the records you are searching for (barring some restrictions we will cover in a bit).

Multiple choice
A database seek searches by:
* Looking at every record in the database for the desired record(s).
* This is a trick question, there is no such thing as a seek in a database.
* (Selected)Correct:
Using an index to jump to the record(s).

👏
You got it!

## When does the server decide to use one over the other?
In general, the database server will use a seek or a scan based on the specific query and it makes its best guess of which way would be faster. This is part of the pre-processing that a server does before it actually runs any query you write. For instance, if you are doing a search on a primary key column for a limited subset of the entire table, the server will most likely use a seek to jump right to the records you are looking for. If you are looking up table records by a column(s) with no index or for a large percentage of the total table, the server will most likely use a scan. In these cases the system would have to look at all or almost all records anyway, so using a seek wouldn’t offer any benefit and could possibly take longer.

Multiple choice
If your query is filtering records on an index, but the number of expected rows from the table you are searching on is about 85%, which search method will the database most likely use?
* A seek.
* (Selected)Correct:
A scan.

👏
Correct, because of the large percentage of the table being returned the system will ignore the index and just look at every record.

## What can you do?
A seek can only be done when the database server has an organized way to search through the target table/view. This is done by having an index covering your search criteria. Make sure to plan your database tables/views with good indexes (including primary keys) to increase the chance that a seek can be used to improve the efficiency of queries.

Here is a simple example of when a scan and a seek would be used by the server:

### Scan
```
SELECT *
FROM customers;
```
Because the query is looking for every record in the table, the server will use a scan to search through every record.

### Seek
```
SELECT *
FROM customers
WHERE city = 'Pittsburgh';
```
This would use a seek (assuming the `customers` table has an index on `city` and customers in ‘Pittsburgh’ don’t make up a large portion of all records), jumping almost instantly right to the specific record you are searching for.

Multiple choice
As a developer you have no control over if the server uses a seek or a scan.
* (Selected)Correct: False. You can write your queries to take advantage of indexes, and if appropriate, create/delete them to further improve the database. You can also plan your queries to start with the most limiting queries to encourage seek searches.
* True. The server uses it’s historical records to make a best guess about when to use a seek or a scan.

👏
You got it!

## What is out of your hands
The DB server decides if it should use a seek or scan. This means that even if you write your query to take advantage of a good index, the server might ignore this and run the query using a scan. But why would it do this? If you are examining over 50% - 70% of the records in the table then seeking no longer offers any advantage. If you are regularly skipping the benefits of your indexes, they might need to be reexamined to see if the costs outweigh the benefits.

Let’s look at when a seek can go wrong:
```
SELECT *
FROM customers
WHERE customer_id > 100;
```
This is very similar to the example we had before where we searched for records equal to 100. But in this case, we are looking for all records greater than 100. If our database has a reasonable number of clients, for instance in the thousands, then the system will ignore the seek option and instead scan through every record in the table. The server will predict that the number of rows returned will be large enough that seeking for each match would not be any faster.

## Conclusion
In this article, you learned about how the system uses searches based on seek vs scan.

Some of the main things you should take away are:

* A scan search in a database is where every record in the table/view is searched to find the records requested by the query.
* A seek search in a database is where the server jumps to specific records using an index. If more information is needed, it then looks back at the pointer to the main dataset to retrieve the corresponding information.
* A database server will try to use a seek search when it can, but it needs an index to work from that matches the search criteria and the number of anticipated records is a small enough subset of the total records in the table/view.
* You may need to re-examine your indexes to either remove, update, or create them if they aren't being used properly.

## Bonus tip for speeding up queries
If you are searching the same set of records from a table/view more than once in a block of code, put the filtered rows into an object such as a temp table, table variable, or view depending on the situation. This will eliminate the need to have to search the table/view for the same set of records more than once.

As a small example, you could search for two different things in a database of book orders, both of which need the same set of customers and their orders, but then are restricted by the books. This could be written as:

```
SELECT
    c.first_name,
    c.last_name,
    b.title,
    b.original_language
FROM customers    AS c
INNER JOIN orders    AS o    ON o.customer_id = c.customer_id
INNER JOIN books    AS b    ON b.book_id = o.book_id
WHERE c.state_name = 'Texas'
    AND b.original_language = 'Czech';
    
SELECT
    c.first_name,
    c.last_name,
    b.title,
    b.original_language
FROM customers    AS c
INNER JOIN orders    AS o    ON o.customer_id = c.customer_id
INNER JOIN books    AS b    ON b.book_id = o.book_id
WHERE c.state_name = 'Texas'
    AND b.first_published  < 1990;
```

Alternatively, you could create a temp table and filter the customers and their orders first. Since you want the same set of information in both queries, this saves the server from repeating work. Here is how you could rewrite the above using a temp table.

```
CREATE TEMP TABLE myTemp(first_name VARCHAR(100), last_name VARCHAR(100), book_id INTEGER);

INSERT INTO myTemp (first_name, last_name, book_id)
SELECT
    c.first_name,
    c.last_name,
    o.book_id
FROM customers    AS c
INNER JOIN orders    AS o    ON o.customer_id = c.customer_id
WHERE c.state_name = 'Texas';

SELECT
    m.first_name,
    m.last_name,
    b.title,
    b.original_language
FROM myTemp    AS m
INNER JOIN books    AS b    ON b.book_id = m.book_id
    AND b.original_language = 'Czech';
    
SELECT
    m.first_name,
    m.last_name,
    b.title,
    b.original_language
FROM myTemp    AS m
INNER JOIN books    AS b    ON b.book_id = m.book_id
    AND b.first_published  < 1990;

        
DROP TABLE myTemp;
```