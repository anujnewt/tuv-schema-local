create or replace procedure labprod."sv_formato"  ( num numeric, formato inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open formato for select to_char(dia_ini, 'dd'), to_char(dia_ini, 'Month'), to_char(dia_ini, 'yyyy'), to_char(dia_fin, 'dd'), to_char(dia_fin, 'Month'), to_char(dia_fin, 'yyyy'), num_dia, sta_sol
from svtempsc
where (svtempsc.sta_sol = 'P' or svtempsc.sta_sol = 'A') and svtempsc.num_emp = num;end;
$body$
language plpgsql
;
