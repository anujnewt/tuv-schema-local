create or replace procedure usrdrc.dercorp_reportflex_pkg_insert_row_pr (idseccion integer, numfields integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linnewid integer;
linnewidcampo integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('dercorp_reportflex_s_row_seq') + 1 into strict linnewid
;
insert into dercorp_reportflex_s_row_tab(
id_seccion_row,
id_seccion,
id_order,
atributo1
)
values (
linnewid,
idseccion,
linnewid,
numfields
);
select
nextval('dercorp_reportflex_campo_seq') into strict linnewidcampo
;
insert into dercorp_reportflex_campo_tab(
id_campo,
id_seccion_row,
id_add_campo,
id_order
)
values (
linnewidcampo,
linnewid,
0,
1
);
if numfields = 2 then
select
nextval('dercorp_reportflex_campo_seq') into strict linnewidcampo
;
insert into dercorp_reportflex_campo_tab(
id_campo,
id_seccion_row,
id_add_campo,
id_order
)
values (
linnewidcampo,
linnewid,
0,
2
);
end if;end;
$body$
language plpgsql
;
