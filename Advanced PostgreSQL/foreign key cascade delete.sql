-- methods can be:
-- ON UPDATE CASCADE, ON DELETE CASCADE
ALTER TABLE talks
ADD FOREIGN KEY (speaker_id)
REFERENCES speakers (id) ON DELETE CASCADE;

-- check the cascade
DELETE FROM speakers 
WHERE id = 2;
