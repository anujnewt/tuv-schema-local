create or replace procedure usrdrc.dercorp_captura_pkg_borrar_reg_flex_adm_pr (li_id_empresa integer) as $body$
declare
j record;
-- pgv moved types start
-- pgv moved types end
linidflex     numeric := 0;
add_campo_cur cursor for
select    id_add_campo,
cod_campo
from      dercorp_add_campo_tab
where     1=1
and       id_seccion = 20
and       id_subseccion = 30
and       des_tipo_campo = 'CHECKBOX_A'
order by  id_agrupacion
;
add_campo_valor_cur cursor(tsidempresa numeric, tsidaddcampo varchar) for
select  count(1) as existe
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa   = tsidempresa
and     id_add_campo = tsidaddcampo
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in add_campo_cur
loop
for j in select * from add_campo_valor_cur(li_id_empresa, i.id_add_campo)
loop
begin
select  id_flex_tbl
into strict    linidflex
from    dercorp_add_campo_tab
where   1=1
and     id_seccion     = 20
and     id_subseccion  = 30
and     des_tipo_campo = 'CHECKBOX_A'
and     id_add_campo   = i.id_add_campo
;
exception
when no_data_found then
linidflex := 0;
end;/* dmap converted statement start */
if j.existe = 0 then
perform dbms_output.put_line( concat(i.id_add_campo, ' ', j.existe, ' ', linidflex)) ;/* dmap converted statement end */
/*
delete  from dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = linidflex
and     id_empresa  = li_id_empresa
;
*/
--ecm 19 mayo 2016 cambiar borrado fisico a logico.
update  dercorp_metatbl_tab
set     val_c14  = null
where   1=1
and     id_flex_tbl = linidflex
and     id_empresa  = li_id_empresa
;
elsif j.existe = 1 then
--ecm 19 mayo 2016 cambiar borrado fisico a logico.
update  dercorp_metatbl_tab
set     val_c14 = 1
where   1=1
and     id_flex_tbl = linidflex
and     id_empresa  = li_id_empresa
;
end if;
end loop;
end loop;end;
$body$
language plpgsql
;
