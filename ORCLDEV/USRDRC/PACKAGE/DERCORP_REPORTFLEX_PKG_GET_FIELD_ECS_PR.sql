create or replace procedure usrdrc.dercorp_reportflex_pkg_get_field_ecs_pr (resultset inout refcursor, idfield integer,idempresa varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_isac numeric := 0;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select usrdrc.xxtv_capital_soc_pkg_get_tipo_sociedad_fn((idempresa)::numeric ) into strict v_isac;
if v_isac = 1
then
open resultset for
select * from (
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
and v.id_empresa      = idempresa
where
c.id_subseccion = 29
and nullif(c.atributo7::text, '') is null
--and (( v.val_valor is not null) or (des_tipo_campo = flextable))
--and v.val_valor != 0
and nullif(v.val_valor::text, '') is not null --jjaq 21-03-2019 cambio para el reporte de ecs punto numero 1 de los prioritarios
and c.id_add_campo not in (1030,1031,1022,1028,1029,541)--jjaq 21-03-2019 cambio para el reporte de ecs punto numero 1 de los prioritarios
union
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
and v.id_empresa      = idempresa
where
c.id_subseccion = 29
and nullif(c.atributo7::text, '') is null
and des_tipo_campo = 'FLEXTABLE'
)tmp
order by
id_seccion,
id_subseccion,
id_agrupacion,
(id_order)::numeric;
else
open resultset for
select * from (
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
and v.id_empresa      = idempresa
where
c.id_subseccion = 29
and nullif(c.atributo7::text, '') is null
--and (( v.val_valor is not null) or (des_tipo_campo = flextable))
--and v.val_valor != 0
and nullif(v.val_valor::text, '') is not null --jjaq 21-03-2019 cambio para el reporte de ecs punto numero 1 de los prioritarios
and c.id_add_campo not in (1030,1031,1022)--jjaq 21-03-2019 cambio para el reporte de ecs punto numero 1 de los prioritarios
union
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
and v.id_empresa      = idempresa
where
c.id_subseccion = 29
and nullif(c.atributo7::text, '') is null
and des_tipo_campo = 'FLEXTABLE'
)tmp
order by
id_seccion,
id_subseccion,
id_agrupacion,
(id_order)::numeric;
end if;end;
$body$
language plpgsql
;
