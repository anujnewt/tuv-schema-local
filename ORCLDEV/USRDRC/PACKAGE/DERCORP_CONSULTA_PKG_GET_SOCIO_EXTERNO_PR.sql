create or replace procedure usrdrc.dercorp_consulta_pkg_get_socio_externo_pr (postvalor inout varchar ,piinidempresa numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select  val_cat_val
into strict    postvalor
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo_valor = (
select   val_valor
from     dercorp_add_campo_valor_tab
where    1=1
and      id_add_campo in (521)
and      id_empresa = piinidempresa
)
;
exception
when no_data_found then
postvalor:= null;end;
$body$
language plpgsql
;
