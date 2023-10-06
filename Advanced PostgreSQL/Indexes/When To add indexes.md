# When should I add an Index?
You may be asking “When should I add an index to my database?” The simple answer is when the benefits of searching outweigh the burdens of storage size and Insert/Update/Delete speed. One thing to consider is whether searching will occur often enough to make the advantages worth the time and effort.

In the real world, this often becomes a grey area and one that you might have to go back to after trying for a while. You will want to look at what a table is used for and by who. As a very rough rule of thumb, think carefully about any index on a table that gets regular Insert/Update/Delete. In contrast, a table that is fairly stable but is searched regularly might be a good candidate for an index.

There are some other conditions that can impact your search times you should be aware of when using an index.

The higher the percentage of a table you are returning the less useful an index becomes. If we’re only searching for 1 record in 1,000,000, an index could be incredibly useful. However, if we are searching for 900,000 out of that same 1,000,000 the advantages of an index become useless. At higher percentages, the query planner might completely ignore your index and do a full table scan, making your index only a burden on the system.

Along this same line, if you are combining filtering conditions be aware of what you will be searching on. AND statements are normally fine and the query planner will try to use an indexed field before non-indexed fields to cut down on the total number of records needed to be searched. OR on the other hand, can be very dangerous; even if you have a single non-indexed condition, if it’s in an OR, the system will still have to check every record in your table, making your index useless.

For instance, if you have the following index on the `customers` table
```
CREATE INDEX customers_idx ON customers (last_name);
```
Then you ran the following two queries
```
EXPLAIN ANALYZE VERBOSE SELECT *
FROM customers
WHERE last_name = 'Jones'
  AND first_name = 'David';
 
EXPLAIN ANALYZE VERBOSE SELECT *
FROM customers
WHERE last_name = 'Jones'
  OR first_name = 'David';
```
The first would run in ~1ms, the second would take ~33ms (in a local version of the `customers` table with 100k records). Because the first one uses the index it can jump right to just the records with the `last_name = 'Jones'`. However, in the second with the OR, the index is useless since every record has to be searched anyway for any record with `first_name = 'David'`. The index is ignored and the system looks at every record once, checking both conditions.