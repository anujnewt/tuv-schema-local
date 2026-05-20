create or replace procedure labprod."sp_passtoimss"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert into nmlopas
select emp_keyemp, oracle.substr(emp_regims,8,4)
from nmcoempl
where emp_status = 1
and emp_keypro <> 6
and emp_keyemp not in (select pas_keyemp from nmlopas)
and emp_keyemp not in (select pas_keyemp from pasexep);end;
$body$
language plpgsql
;
