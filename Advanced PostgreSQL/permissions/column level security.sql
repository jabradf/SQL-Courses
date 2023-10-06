GRANT SELECT ON projects to manager;
-- can also GRANT SELECT if restricting read access
GRANT UPDATE (project_name, project_status) ON projects to manager;

select * 
from information_schema.column_privileges
where grantee = 'manager';