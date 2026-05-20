create or replace procedure usrdrc.dercorp_panel_control_pkg_delete_empresa_pr ( pinidempresa numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
delete
from  dercorp_add_campo_cat_val_tab
where val_cat_val = (select nom_empresa
from dercorp_empresa_tab
where id_empresa = pinidempresa)
and id_catalogo   in (1,40);
delete
from  dercorp_empresa_tab
where id_empresa = pinidempresa;
--borra rfc y pais
delete from dercorp_add_campo_valor_tab
where id_empresa = pinidempresa;
--and   id_add_campo in (509,529);
delete from dercorp_metatbl_tab
where id_empresa = pinidempresa;
exception when others
then
pstouterror := sqlerrm;
end;end;
$body$
language plpgsql
;
