/*
You can create many indexes on a table, but only one can be a clustered index, so what about the rest? They are known as non-clustered indexes. Non-clustered indexes have records of the columns they are indexing and a pointer back to the actual data in the table. 

The main take away is that a clustered index contains all the information in your table and physically reorganizes the way it is stored in memory. A non-clustered index creates a key on the columns you indicate and a pointer back to the main table for any columns not part of the index.
*/

CREATE INDEX customers_state_name_idx ON customers(state_name);

select last_name, state_name
from customers
where state_name = 'Texas'
order by last_name;