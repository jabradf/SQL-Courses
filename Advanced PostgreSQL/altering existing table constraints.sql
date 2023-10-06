ALTER TABLE speakers
ALTER COLUMN name SET NOT NULL;

-- remove constraint
--ALTER TABLE talks
--ALTER COLUMN session_timeslot DROP NOT NULL

-- back fill before adding constraint
UPDATE speakers
SET organization = 'TBD'
WHERE organization IS NULL;

-- now add the constraint
ALTER TABLE speakers
ALTER COLUMN organization SET NOT NULL;