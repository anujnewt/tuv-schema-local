create or replace procedure usrdrc.dercorp_reportflex_pkg_insert_seccion_pr (idreportflex integer, nomsecc varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linnewid integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('dercorp_reportflex_seccion_seq') + 1 into strict linnewid
;
insert into dercorp_reportflex_seccion_tab(id_seccion, id_reportflex, nom_seccion)
values (linnewid, idreportflex, nomsecc)
;end;
$body$
language plpgsql
;
