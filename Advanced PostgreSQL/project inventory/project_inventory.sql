select * from parts
limit 10;

-- step 2
ALTER TABLE parts
ALTER COLUMN code SET NOT NULL;

ALTER TABLE parts
ADD UNIQUE(code);

-- step 3
UPDATE parts
SET description = code || ' missing desc'
-- not sure why these don't work but at least it's not null!
--SET description = concat_ws(code, ' missing desc')
WHERE description IS NULL;

-- step 4
ALTER TABLE parts
ALTER COLUMN description SET NOT NULL;

-- step 5 
-- works great, commenting out to avoid error for following steps
/*INSERT INTO parts (id, code, manufacturer_id)
VALUES (54, 'V1-009', 9);*/

-- step 6
ALTER TABLE reorder_options
ALTER COLUMN price_usd SET NOT NULL;
ALTER TABLE reorder_options
ALTER COLUMN quantity SET NOT NULL;

-- step 7
ALTER TABLE reorder_options 
ADD CHECK (price_usd > 0);
ALTER TABLE reorder_options 
ADD CHECK (quantity > 0);

-- step 8
ALTER TABLE reorder_options 
ADD CHECK (price_usd/quantity > 0.02 AND price_usd/quantity < 25.00);

-- step 9
-- no primary key on first table, so lets add it:
ALTER TABLE parts
ADD PRIMARY KEY (id); 

ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id)
REFERENCES parts (id);

-- step 10
ALTER TABLE locations 
ADD CHECK (qty > 0);

-- step 11
ALTER TABLE locations
ADD UNIQUE (part_id, location);

-- step 12
-- remove offending line before adding foreign key constraint
delete from locations
where part_id = 54;

ALTER TABLE locations
ADD FOREIGN KEY (part_id)
REFERENCES parts (id);

-- step 13
ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers (id);

-- step 14
INSERT INTO manufacturers VALUES (11, 'Pip-NNC Industrial');

-- step 15
UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id =  1 OR manufacturer_id =  2;

select * from parts
where manufacturer_id = 11;