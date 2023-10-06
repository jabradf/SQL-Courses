/*
You can create many indexes on a table, but only one can be a clustered index.
Because PostgreSQL does not automatically recluster on INSERT, UPDATE and DELETE statements, those statements might run faster than equivalent statements using a different system. The flip side of this coin though is that after time, the more your table is modified the less useful the cluster will be on your searches
*/
-- cluster using an existing index
-- CLUSER <table_name_needing_new_cluster> USING <index_name>;
CLUSTER customers USING customers_last_name_idx;

-- apply the index to the table
-- CLUSTER <table_name_for_recluster>;
CLUSTER customers;

-- cluster every table
--CLUSTER;