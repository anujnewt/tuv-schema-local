create or replace procedure usrdrc.dercorp_captura_pkg_cambiar_nombre_corto_pr (param_id_empresa integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update dercorp_add_campo_valor_tab set val_valor = (
select    nom_cat_val
from      dercorp_add_campo_cat_val_tab
where     1=1
and       id_catalogo = 1
and       id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 500 --denominacion actual
)
)
where 1=1
and   id_empresa = param_id_empresa
and   id_add_campo = 501 --nombre corto
;
update dercorp_add_campo_valor_tab  set val_valor = (
select    id_catalogo_valor
from      dercorp_add_campo_cat_val_tab
where     1=1
and       id_catalogo = 7
and       val_cat_val = (
select    trim(both atributo2)
from      dercorp_add_campo_cat_val_tab
where     1=1
and       id_catalogo = 1
and       id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 500 --denominacion actual
)
)
)
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo = 509 --pais
;
update dercorp_add_campo_valor_tab set val_valor = (
select    atributo1
from      dercorp_add_campo_cat_val_tab
where     1=1
and       id_catalogo = 1
and       id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 500 --denominacion actual
)
)
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo = 529 --rfc
;/* dmap converted statement start */
/* commit; */
exception
when others then
perform dbms_output.put_line( concat('ERROR CODE: ', sqlstate)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ERROR MSG: ', sqlerrm)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
