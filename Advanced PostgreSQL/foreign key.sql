ALTER TABLE talks
ADD FOREIGN KEY (speaker_id)
REFERENCES speakers (id);  -- this is the foreign key reference

INSERT INTO talks VALUES (21, 'Data Warehousing Best Practises', 101, 30, '2020-08-15 18:00');
