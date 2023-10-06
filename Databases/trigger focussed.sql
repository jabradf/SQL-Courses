CREATE TRIGGER update_trigger_high
BEFORE UPDATE ON clients
FOR EACH ROW
WHEN (NEW.total_spent >= 1000)
EXECUTE PROCEDURE set_high_spender();

CREATE TRIGGER update_trigger_low
BEFORE UPDATE ON clients
FOR EACH ROW
WHEN (NEW.total_spent < 1000)
EXECUTE PROCEDURE set_low_spender();

select * from clients
order by client_id;


update clients
set total_spent = 5000
where last_name = 'Campbell';

update clients
set total_spent = 100
where last_name = 'Lewis';

select * from clients
order by client_id;