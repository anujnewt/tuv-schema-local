create or replace procedure usrdrc.dercorp_captura_pkg_borrar_porcentaje_par_pr (li_id_empresa integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstsocioexterno  varchar(2) := null;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select val_cat_val
into strict   lstsocioexterno
from   dercorp_add_campo_cat_val_tab
where  1=1
and    id_catalogo = 18
and    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    1=1
and      id_empresa   = li_id_empresa
and      id_add_campo = 521
)
;
exception
when no_data_found then
lstsocioexterno := null;
end;
if lstsocioexterno = 'No' then
update dercorp_add_campo_valor_tab
set    val_valor = null
where  1=1
and    id_empresa   = li_id_empresa
and    id_add_campo = 522
;
end if;end;
$body$
language plpgsql
;
