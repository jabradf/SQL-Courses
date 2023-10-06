-- row level security or RLS
CREATE POLICY emp_rls_policy ON accounts FOR SELECT 
TO sales USING (salesperson=current_user);

-- must enable the policy, otherwise it is inactive
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;

SET ROLE alice;

/*
As alice, run the SQL give below. Which rows do you think this query will effect? Does the table contain any rows with a contract_amt under 10000? Who is listed as the salesperson for these rows?
*/
DELETE FROM accounts 
WHERE contract_amt < 10000;

SELECT * FROM accounts;