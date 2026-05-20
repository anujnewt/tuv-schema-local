create or replace procedure labprod."sp_capdes"  (empleado integer, capacidad inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-----------------------------------globales
total numeric;
base varchar(10);
begin
base := labprod.fn_basedatos_emp(empleado);
call sp_capdes_local (empleado, capacidad);
/*
apsi
231009 cambio para tu
if base = 'TVNOMINA' then
call sp_capdes_local (empleado, capacidad);
else
sp_capdes_local__rtelecom (empleado, capacidad);
end if;
*/
end;
$body$
language plpgsql
;
