create or replace  function  usrsiho."sp_hrsituacion"  (vn_keypro integer, vs_keyper varchar, vn_keyemp integer) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
vn_regimen     integer;
begin
-- inicializa variables
vn_regimen := 0;
-- obtiene el regimen del empleado
select coalesce(sum(his_import),0)
into strict vn_regimen
from nmlohism
where his_keypro = vn_keypro
and his_keyper = vs_keyper
and his_keyemp = vn_keyemp
and his_keycon = 'H87';
return vn_regimen;end;
--dmap converted function completed
$body$
language plpgsql
stable;
