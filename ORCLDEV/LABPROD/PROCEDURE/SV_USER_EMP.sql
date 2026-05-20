create or replace procedure labprod."sv_user_emp"  ( num integer, user_emp inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open user_emp for
select distinct usuario from mail where emp_keyemp = num;end;
$body$
language plpgsql
;
