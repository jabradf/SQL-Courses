# Traffic Analytics
In this project you’ll use what you’ve learned about database maintenance to manage a table that receives constant updates from a network of sensors.

Imagine that your company provides information about vehicle traffic around it’s retail locations. After anyone passes by one of your company’s cameras, an observation is created with the time, location, time spent in the observation area (in seconds), and their distance traveled in the observation area (in meters). To start, we’ll have a single table in the database named `sensors.observations` with the following format.
```
         Table "sensors.observations"
+-----------------+-----------------------------+
|     Column      |            Type             |
+-----------------+-----------------------------+
| id              | text                        |
| datetime        | timestamp without time zone |
| location_id     | int                         |
| duration        | double precision            |
| distance_meters | double precision            |
| category        | text                        |
+-----------------+-----------------------------+
Indexes:
    "observations_pkey" PRIMARY KEY, btree (id)
    "observations_location_id_datetime_idx" btree (location_id, datetime)
```


## Exploring Data
1. Let’s first try to understand the size of the table. Write a query to return the total size of the table (excluding indexes).

Remember that wrapping your answer in `pg_size_pretty` will format the value to `kB`, `MB` or `GB` rather than the raw byte count.


2. Does this table have any indexes? Refer to the output from the beginning of this lesson to get the names of these indexes.

Write a query that returns the size of each of these indexes. What’s the name of the largest index on this table?


3. Is the table’s total relation size consistent with the size of the table data and any indexes?

Write a query that returns the size of the table’s data, indexes, and the total relation size as three separate columns.


## Implementing a large UPDATE and INSERT
4. Imagine that `sensors.observations` is updated by some software that’s running on each camera. The code that runs on the camera has been updated and will now include the `distance` field in feet instead of meters.

Write a query that `UPDATE`s the value of `distance` to feet. You can do this by multiplying the current value of the column by 3.281.


5. Check the size of the tables and indexes now, are they significantly larger following the `UPDATE`?


6. Run a regular vacuum on the table, what effect do you think this will have on table size? Check your hypothesis by querying the database for this table’s `pg_table_size`.

7. Let’s add some additional data to this table. The original dataset contained 10000 observations of pedestrians, cyclists, and motor vehicles.

A new software update has allowed us to add another 1000 observations of dogs, motorbikes, and trucks.

Use the SQL below to add the additional observations to the table.
```
\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;
```

8. Check the table size of `sensors.observations` now. Given that we’ve just VACUUMed the table, what do you think will have happened to the table’s total size on disk?


9. Looks like this table hasn’t increased it’s space on disk because of the insert. Run a` VACUUM FULL` on this table to return any excess space this table is consuming to the operating system.

Check the size of the table’s data now? How does this compare to the original value you found in Step 1?


## Implementing a large DELETE
10. Let’s remove some of the sensors from our dataset, perhaps these cameras were faulty and need to be repaired before they can be re-deployed and have their observations included in the dataset. Write a query that `DELETE`s all cameras at a `location_id` greater than 24.


11. What effect do you expect this `DELETE` would have on the table’s disk usage? Check the size of the table’s data.


## Reloading The Table
12. Using `TRUNCATE`, clear all the values from `sensors.observations`.


13. To compare the results of `TRUNCATE` and `VACUUM FULL`, paste the following statements into the editor. These will load the values from the original (10,000 obs.) and supplemental (1,000 obs.) into the table. How would you expect the size of this table to compare to the size you found in step 9?
```
\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './original_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;
```

14. Write a query that checks the total table, index, and combined size of the table now. How does the size of the table size compare to the table size following the `VACUUM FULL` you ran earlier in this project?