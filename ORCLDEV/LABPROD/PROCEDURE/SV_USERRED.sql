create or replace procedure labprod."sv_userred"  ( num_empleado numeric , usu_red varchar , fecha_s varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert
into userred(
num_emp,
emp_keyred,
fec_sol
)
values (
num_empleado,
usu_red,
fecha_s
);end;
$body$
language plpgsql
;
