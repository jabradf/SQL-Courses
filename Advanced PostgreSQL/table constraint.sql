CREATE TABLE speakers (
    id integer not null,
    email varchar NOT NULL,
    name varchar NOT NULL,
    organization varchar,
    title varchar,
    years_in_role integer
);

INSERT INTO speakers (id, email, organization, title, years_in_role)
VALUES (1, 'awilson@ABCcorp.com', 'ABC Corp.', 'CTO', 6);

-- correct test
INSERT INTO speakers (id, email, name, organization, title, years_in_role)
VALUES (1, 'awilson@ABCcorp.com', 'A. Wilson', 'ABC Corp.', 'CTO', 6);


-- adding constraint to table
ALTER TABLE Persons
ADD UNIQUE (ID); 
