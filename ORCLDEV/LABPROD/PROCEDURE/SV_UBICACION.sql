create or replace procedure labprod."sv_ubicacion"  (num integer, ubi inout nvarchar2) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
select emp_keyloc into strict ubi from nmcoempl where emp_keyemp = num;end;
$body$
language plpgsql
;
