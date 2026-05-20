-- dmap_object_gen_tag : type : view name : dercorp_rep_est_datos_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_rep_est_datos_vw"  ("id_empresa", "tipo", "grupo", "accionista", "rfc", "pais", "capital_fijo", "capital_variable", "porcentaje", "total") as select id_empresa, tipo, grupo, accionista, rfc, pais, capital_fijo, capital_variable, porcentaje, total  from (
select
mt.id_empresa,
'Elemento' as tipo,
mt.val_c8 as grupo,
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 40::NUMERIC
and   id_catalogo_valor = mt.val_c1::NUMERIC) as accionista,
coalesce((select atributo1
from dercorp_add_campo_cat_val_tab
where id_catalogo = 40::NUMERIC
and   id_catalogo_valor = mt.val_c1::NUMERIC),'') as rfc,
coalesce((select atributo2
from dercorp_add_campo_cat_val_tab
where id_catalogo = 40::NUMERIC
and   id_catalogo_valor = mt.val_c1::NUMERIC),'Mexico') as pais,
to_number(mt.val_c3::text, '999999999999.999999') as capital_fijo,
to_number(mt.val_c4::text, '999999999999.999999') as capital_variable,
to_number(mt.val_c5::text, '999999999999.999999') as porcentaje,
to_number(mt.val_c6::text, '999999999999.999999') as "total"
from dercorp_metatbl_tab  mt
where mt.id_flex_tbl = 7::NUMERIC
union all
select
mt.id_empresa,
'TOTAL' as tipo,
'' as grupo,
'' as accionista,
'' as rfc,
'' as pais,
sum(to_number(mt.val_c3::text, '999999999999.999999')) as capital_fijo,
sum(to_number(mt.val_c4::text, '999999999999.999999')) as acapital_variable,
sum(to_number(mt.val_c5::text, '999999999999.999999')) as porcentaje,
sum(to_number(mt.val_c6::text, '999999999999.999999')) as "total"
from dercorp_metatbl_tab  mt
where mt.id_flex_tbl = 7::NUMERIC
group by mt.id_empresa, 'TOTAL', '') tot;/* dmap converted statement end */
-- estimed cost of view [ dercorp_rep_est_datos_vw ]: 1.80;
