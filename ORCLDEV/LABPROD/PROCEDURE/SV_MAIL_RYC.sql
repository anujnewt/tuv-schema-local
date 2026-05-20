create or replace procedure labprod."sv_mail_ryc"  ( num integer, ubicacion varchar, mail_ryc inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open mail_ryc for
select t3.email ,t1.emp_keyloc
from autryc t1, nmcoempl t2, mail t3
where t1.emp_keyloc = ubicacion
and t1.emp_keyemp =t3.emp_keyemp
and t2.emp_keyemp = num;end;
$body$
language plpgsql
;
