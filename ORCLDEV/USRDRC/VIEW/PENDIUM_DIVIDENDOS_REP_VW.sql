-- dmap_object_gen_tag : type : view name : pendium_dividendos_rep_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "pendium_dividendos_rep_vw"  ("id_empresa", "nom_empresa", "asunto", "check_dividendos", "decreto_dividendos", "dividendos", "fecha", "tipo_flex") as select  id_empresa,
/* (select nom_empresa
from dercorp_empresa_tab
where id_empresa = mtbl.id_empresa::NUMERIC)as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = mtbl.id_empresa::NUMERIC
and id_add_campo = 500))as nom_empresa,--argu
mtbl.val_c149 as asunto,
mtbl.val_c92 as check_dividendos,
case mtbl.val_c92
when 'No' then ''
when 'Si' then '/Decreto de Dividendos'
else
''
end as decreto_dividendos,
mtbl.val_c19 as dividendos,
mtbl.val_c3 as fecha,
'APROBACION_EJERCICIO_SOCIAL'as tipo_flex
from dercorp_metatbl_tab mtbl
where id_flex_tbl = 23::NUMERIC
and    mtbl.val_c92 = 'Si'
union all
select  id_empresa,
/*       (select nom_empresa
from dercorp_empresa_tab
where id_empresa = mtbl.id_empresa::NUMERIC)as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = mtbl.id_empresa::NUMERIC
and id_add_campo = 500))as nom_empresa,--argu
mtbl.val_c149 as asunto,
null as check_dividendos,
null as decreto_dividendos,
mtbl.val_c5 as dividendos,
mtbl.val_c3 as fecha,
'DECRETO_DIVIDENDOS'as tipo_flex
from dercorp_metatbl_tab mtbl
where id_flex_tbl = 31::NUMERIC;/* dmap converted statement end */
-- estimed cost of view [ pendium_dividendos_rep_vw ]: 1.00;
