# DATABASES
## Database Triggers
We are running an online watch store and need to make sure we have a record of when customer information is modified and to ensure changes match our business rules. We will be looking at a small subset of this database server and examining two tables, customers and customers_log. The information in these tables were randomly generated.

If you have trouble viewing information on any of the panels remember you can adjust the size of any of the windows by dragging on their edges.

## Existing Structure
1. Before we get started, take a moment to familiarize yourself with the database. There are two tables we will be working with: `customers` and `customers_log`. To make your life easier we would recommend ordering the customers table by `customer_id`.

## Update Triggers
2. Your boss has tasked you with creating a trigger to log anytime someone updates the `customers` table. There is already a procedure to insert into the `customers_log` table called `log_customers_change()`. This function will create a record in `customers_log` and we want it to fire anytime an `UPDATE` statement modifies `first_name` or `last_name`. Give the trigger an appropriate name. Are there other situations you might suggest creating triggers for as well?


3. Can you confirm your trigger is working as expected? Remember, it should only create a log for changes to `first_name` and/or `last_name`. We know what the state of the `customers` and `customers_log` tables are from our previous check so we can go directly to testing your trigger.

4. You should also check when you expect it to NOT create a record in `customers_log` as well as when you would expect it to. Since we confirmed the state of the two tables at the end of our first task, we don’t need to check the starting state again, we can jump right to the modification. Confirm no log is created when modifying a column not covered by the trigger function.


## Insert Triggers
5. You suggested to your boss that `INSERT` statements should also be included (you had also suggested `DELETE` and `TRUNCATE` be covered as well, but legal thought this wasn’t needed for some reason). They agreed, but thought that tracking every row for inserts wasn’t necessary — a single record of who did the bulk insert would be enough. Create the trigger to call the `log_customers_change` procedure once for every statement on `INSERT` to the `customers` table. Call it `customer_insert`.

6. Add three names to the `customers` table in one statement. Is your trigger working as expected and only inserting one row per insert statement, not per record? What would the log look like if you had your trigger fire on every row?

To complete these steps you’ll need to do the following:

* Use `INSERT INTO customers` to add three records to the customers table. For example, one record could look like `('Jeffrey','Cook','Jeffrey.Cook@example.com','202-555-0398','Jersey city','New Jersey',66)`
* `SELECT *` for the `customers` table and `ORDER BY customer_id`
* `SELECT *` for the `customers_log` table.

## Conditionals on your Triggers
7. Your boss has changed their mind again, and now has decided that the conditionals for when a change occurs should be on the trigger and not on the function it calls.

In this example, we’ll be using the function `override_with_min_age()`. The trigger should detect when age is updated to be below 13 and call this function. This function will assume this was a mistake and override the change and set the age to be 13. Name your trigger something appropriately, we called ours `customer_min_age`. What will happen with the `customers` and `customers_log` tables?


8. Let’s test this trigger — two more changes to the `customers` table have come in. Modify one record to set their age under 13 and another over 13, then check the results in the customers and `customers_log` table. Note, setting it to exactly 13 would still work, it would just be harder to confirm your trigger was working as expected. What do you expect to happen and why?

9. What would happen if you had an update on more columns at once, say modifications to the `first_name` and `years_old` in the same query? Try this now then run your check on `customers` (with the order we have been using) and `customers_log`.


## Trigger Cleanup
10. Though your trigger setting the `years_old` to never be under 13 is working, a better way to do the same thing would be with a constraint on the column itself. For now, let’s remove the trigger we created to set the minimum age. Ours was called `customer_min_age`.

11. Take a look at the triggers on the system to ensure your removal worked correctly.

12. Feel free to play around with this data set to practice your trigger knowledge.