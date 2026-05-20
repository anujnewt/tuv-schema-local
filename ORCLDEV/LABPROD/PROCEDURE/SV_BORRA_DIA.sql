create or replace procedure labprod."sv_borra_dia"  ( numero numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
delete from svtempdia where num_emp = numero;end;
$body$
language plpgsql
;
