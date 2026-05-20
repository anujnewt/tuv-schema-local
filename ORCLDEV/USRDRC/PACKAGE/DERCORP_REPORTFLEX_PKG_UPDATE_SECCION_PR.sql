create or replace procedure usrdrc.dercorp_reportflex_pkg_update_seccion_pr (idsecc integer, nomsecc varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update dercorp_reportflex_seccion_tab set
nom_seccion = nomsecc
where
id_seccion = idsecc;end;
$body$
language plpgsql
;
