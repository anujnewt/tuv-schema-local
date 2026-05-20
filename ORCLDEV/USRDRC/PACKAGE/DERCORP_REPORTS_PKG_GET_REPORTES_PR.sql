create or replace procedure usrdrc.dercorp_reports_pkg_get_reportes_pr ( piinidrol numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstin     varchar(3000);
lstquery  varchar(5000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select atributo2 into strict lstin
from   ss_rol_tab
where  id_rol = piinidrol;
if nullif(lstin::text, '') is null then
lstin := '0';
end if;
exception
when others then
lstin := '0';
end;
if piinidrol = 0 then
lstquery := 'SELECT * FROM DERCORP_REPORTE_TAB  ORDER BY  NOM_REPORTE;'; /* dmap converted statement start *//* dmap converted statement */
else
lstquery :=  concat('SELECT * FROM DERCORP_REPORTE_TAB WHERE ID_REPORTE IN( ', lstin , ' )  ORDER BY  NOM_REPORTE') ; /* dmap converted statement end *//* dmap converted statement */
end if;
open resultset for execute lstquery;end;
$body$
language plpgsql
;
