create or replace procedure usrdrc.dercorp_reportflex_pkg_get_info_map_ecs_pr (resultset inout refcursor, idempresa integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
cv.id_add_campo,
coalesce(cat.val_cat_val,cv.val_valor) valor_textual
from
dercorp_add_campo_valor_tab cv
inner join dercorp_add_campo_tab ac on ac.id_add_campo = cv.id_add_campo
left join dercorp_add_campo_cat_val_tab cat on (cat.id_catalogo)::numeric  = (coalesce(trim(both ac.id_catalogo),'0'))::numeric
and to_char(cat.id_catalogo_valor) = cv.val_valor
where
cv.id_empresa = idempresa
and id_seccion = 19
and id_subseccion = 29
and nullif(val_valor::text, '') is not null
and val_valor != '0'
;end;
$body$
language plpgsql
;
