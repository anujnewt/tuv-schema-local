create or replace procedure usrdrc.dercorp_reportflex_pkg_insert_report_pr (nomreport varchar, descreport varchar, descrfc varchar, descpais varchar, piinidrol integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linnewid integer;
lstinrol varchar(2500);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('dercorp_reportflex_seq') into strict linnewid
;
insert into dercorp_reportflex_tab(id_reportflex, nom_reporte, des_reporte, atributo1, atributo2)
values (linnewid, nomreport, descreport, descrfc, descpais);
begin
select atributo3 into strict lstinrol
from   ss_rol_tab
where  id_rol   = piinidrol;
exception
when others then
lstinrol := null;
end;
if nullif(lstinrol::text, '') is null then
update ss_rol_tab
set    atributo3  = linnewid
where  id_rol     = piinidrol;/* dmap converted statement start */
else
update ss_rol_tab
set    atributo3  =  concat(atributo3, ',', linnewid
) where  id_rol     = piinidrol;/* dmap converted statement end */
end if;end;
$body$
language plpgsql
;
