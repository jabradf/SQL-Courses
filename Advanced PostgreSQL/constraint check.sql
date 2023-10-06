ALTER TABLE speakers 
ADD CHECK (years_in_role < 100);


-- multiple checks can be done with AND, OR, etc
ALTER TABLE speakers 
ADD CHECK (years_in_role > 0 AND years_in_role < 100);


ALTER TABLE attendees 
ADD CHECK (total_tickets_reserved = standard_tickets_reserved + vip_tickets_reserved);