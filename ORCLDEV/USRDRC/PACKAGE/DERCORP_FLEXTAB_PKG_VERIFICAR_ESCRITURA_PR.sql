create or replace procedure usrdrc.dercorp_flextab_pkg_verificar_escritura_pr (p_id_empresa integer ,p_id_flex_tab varchar ,p_id_meta_row varchar ,p_out_msg inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
psinumescritura numeric :=0;
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  count(1)
into strict    psinumescritura
from    dercorp_apoderados_tab
where   1=1
and     id_empresa = p_id_empresa
and     des_escritura = (
select case when nullif(val_c8::text, '') is null then  concat((select val_cat_val from dercorp_add_campo_cat_val_tab where id_catalogo_valor = val_c1), '-', coalesce(val_c3,'SF') ) when val_c8='N/A' then  concat((select val_cat_val from dercorp_add_campo_cat_val_tab where id_catalogo_valor = val_c1), '-', coalesce(val_c3,'SF') )  else val_c8 end
from   dercorp_metatbl_tab
where  1=1
and    id_meta_row = p_id_meta_row
and    id_flex_tbl = p_id_flex_tab
and    id_empresa  = p_id_empresa
)
;/* dmap converted statement end */
exception
when no_data_found then
psinumescritura := 0;
when others then
psinumescritura := 0;
end;
if psinumescritura > 0 then
p_out_msg := 'Existe la escritura en grupos y/o poderes en la pesta??a de Apoderados.';
else
delete from dercorp_metatbl_tab where 1=1 and id_meta_row = p_id_meta_row;
p_out_msg := 'OK';
end if;end;
$body$
language plpgsql
;
