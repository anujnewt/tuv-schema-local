create or replace procedure usrdrc.dercorp_consulta_pkg_get_campos_reporte_ecs_pr (empresaid numeric, subsectionid numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
--c.* ,
c.id_add_campo,
c.cod_campo,
c.nom_campo,
c.des_campo,
c.des_tipo_campo,
c.can_tamanno_campo,
c.des_formula,
c.id_flex_tbl,
c.id_catalogo,
c.id_seccion,
c.id_subseccion,
c.id_agrupacion,
c.atributo1,
c.atributo2,
c.atributo3,
c.atributo4,
c.atributo5,
c.atributo11,
c.atributo12,
c.atributo13,
c.atributo14,
c.atributo15,
c.id_order,
v.val_valor
from
dercorp_add_campo_tab c
left join dercorp_add_campo_valor_tab v on v.id_add_campo     = c.id_add_campo
and v.id_empresa      = empresaid
where
c.id_subseccion = subsectionid and
nullif(c.atributo7::text, '') is null
and c.des_tipo_campo not in ('CHECKBOX_D','CHECKBOX')
order by
id_seccion,
id_subseccion,
c.id_agrupacion,
(c.id_order)::numeric;end;
$body$
language plpgsql
;
