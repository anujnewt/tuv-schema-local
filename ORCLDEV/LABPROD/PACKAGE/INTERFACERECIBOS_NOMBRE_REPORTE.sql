create or replace procedure labprod.interfacerecibos_nombre_reporte (keypro numeric, keyper varchar, reporte inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
keynom numeric(10) := null;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
reporte := 'reciboTV10.rpt';
select per_keynom into strict keynom
from labprod.nmloperi
where per_keypro = keypro
and per_keyper = keyper;
if keynom = 25 then
reporte := 'reciboTV25.rpt';
end if;
exception
when others then
--call utils_handleerror(sqlcode,sqlerrm);
return;end;
$body$
language plpgsql
;
