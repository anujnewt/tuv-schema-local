create or replace procedure labprod."sv_mail"  ( num integer, mail_emp inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open mail_emp for
select distinct email from mail where emp_keyemp = num;end;
$body$
language plpgsql
;
