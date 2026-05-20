create or replace procedure usrdrc.dercorp_reportflex_pkg_update_report_pr (idreportflex integer, nomreport varchar, descreport varchar, descrfc varchar, descpais varchar, saltopag varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update dercorp_reportflex_tab set
nom_reporte = nomreport,
des_reporte = descreport,
atributo1 = descrfc,
atributo2 = descpais,
atributo15 = saltopag
where
id_reportflex = idreportflex;end;
$body$
language plpgsql
;
