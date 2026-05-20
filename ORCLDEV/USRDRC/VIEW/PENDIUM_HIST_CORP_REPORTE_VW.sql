-- dmap_object_gen_tag : type : view name : pendium_hist_corp_reporte_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "pendium_hist_corp_reporte_vw"  ("id_empresa", "id_meta_row", "id_flex_tbl", "nom_flex", "solicitado_por", "fec_prog_entrega", "fec_efectiva_entrega", "val_c1", "val_c2", "val_c3", "val_c4", "val_c5", "val_c6", "val_c7", "val_c8", "val_c9", "val_c10", "nom_responsable", "responsable") as select
meta.id_empresa,
meta.id_meta_row,
flex.id_flex_tbl,
flex.nom_flex,
case flex.id_flex_tbl
when 23 then meta.val_c91 --aprobacion del ejericcio social
when 21 then meta.val_c47 --reforma parcial de estatutos
when 20 then meta.val_c56 -- reforma total de estatutos
when 22 then meta.val_c54 --transformacion
/*when 28 then meta.val_c46 --acta otros
when 30 then meta.val_c30 --contratos
when 27 then meta.val_c47 --escritura otros
when 29 then meta.val_c40 --aumento de capital
when 31 then meta.val_c30 --decreto de dividendos
when 32 then meta.val_c40 --disminucion de capital
when 33 then meta.val_c50 --escicion
when 34 then meta.val_c53 --fusion
when 35 then meta.val_c30 --sesion de consejo
when 41 then meta.val_c30 --comites
*/
else meta.val_c119 end          as solicitado_por,     --solicitado por
case flex.id_flex_tbl
when 23 then meta.val_c67 --aprobacion del ejericcio social
when 21 then meta.val_c28 --reforma parcial de estatutos
when 20 then meta.val_c37 -- reforma total de estatutos
when 22 then meta.val_c35 --transformacion
else meta.val_c122 end          as fec_prog_entrega,     --fecha programada de entrega
case flex.id_flex_tbl
/*
when 30 then meta.val_c32--contratos
when 27 then meta.val_c49 --escritura otros
when 28 then meta.val_c45 --acta otros
when 29 then meta.val_c32 --aumento de capital
when 31 then meta.val_c32 --decreto de dividendos
when 32 then meta.val_c42 --disminucion de capital
when 33 then meta.val_c52 --escicion
when 34 then meta.val_c55 --fusion
when 35 then meta.val_c32 --sesion de consejo
when 41 then meta.val_c32 --comites
*/
when 23 then meta.val_c59 --aprobacion del ejericcio social
when 21 then meta.val_c20 --reforma parcial de estatutos
when 20 then meta.val_c29 -- reforma total de estatutos
when 22 then meta.val_c27 --transformacion
else meta.val_c121 end          as fec_efectiva_entrega,
case flex.id_flex_tbl
when 30 then meta.val_c4
when 27 then meta.val_c18
else meta.val_c3 end          as val_c1,     --fecha
case flex.id_flex_tbl
when 17 then dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c1)
when 18 then dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c1)
when 30 then dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c3)
else dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c2) end          as val_c2,     -- tipo de reunion (tipo contrato)
meta.val_c149                   as val_c3,                       --asunto
case flex.id_flex_tbl
when 17 then meta.val_c16
when 18 then meta.val_c16
else meta.val_c150 end         as val_c4,     -- semaforo
case flex.id_flex_tbl
when 17 then meta.val_c8
when 18 then meta.val_c8
when 23 then meta.val_c106
else meta.val_c86 end         as val_c5,     -- escritura
case flex.id_flex_tbl
when 17 then meta.val_c9
when 18 then meta.val_c9
when 23 then meta.val_c107
else meta.val_c87 end         as val_c6,     -- fecha escritura
case flex.id_flex_tbl
when 17 then meta.val_c5
when 18 then meta.val_c5
when 23 then meta.val_c107
else meta.val_c82 end         as val_c7,     -- rppc
case flex.id_flex_tbl
when 17 then meta.val_c19
when 18 then meta.val_c19
when 23 then meta.val_c115
else meta.val_c95 end         as val_c8,     -- fecha rppc
case flex.id_flex_tbl
when 17 then meta.val_c150
when 18 then meta.val_c150
when 23 then meta.val_c103
else meta.val_c83 end         as val_c9,     -- semaforo
case flex.id_flex_tbl
when 23 then meta.val_c37--meta.val_c116
when 30 then to_char(meta.val_c23)
when 27 then meta.val_c13
when 28 then meta.val_c16
when 29 then meta.val_c28
when 31 then meta.val_c18
when 32 then meta.val_c28
when 33 then meta.val_c30
when 34 then meta.val_c32
when 21 then meta.val_c13 --reforma parcial de estatutos
when 20 then to_char(meta.val_c22) --reforma total de estatutos
when 35 then meta.val_c17
when 22 then to_char(meta.val_c20)
else meta.val_c96 end         as val_c10,     -- folio_mercantil
(select (select val_cat_val
from dercorp_add_campo_cat_val_tab
where 1=1
and id_catalogo = 59::NUMERIC
and id_catalogo_valor = trim(both::NUMERIC cv.atributo3))
from dercorp_add_campo_cat_val_tab cv
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa::NUMERIC
and id_add_campo = 500))as nom_responsable,
(select (select id_catalogo_valor
from dercorp_add_campo_cat_val_tab
where 1=1
and id_catalogo = 59::NUMERIC
and id_catalogo_valor = trim(both::NUMERIC cv.atributo3))
from dercorp_add_campo_cat_val_tab cv
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa::NUMERIC
and id_add_campo = 500))as responsable
from
dercorp_metatbl_tab meta
left join dercorp_add_campo_cat_val_tab cat on cat.id_catalogo_valor::NUMERIC = meta.val_c2::NUMERIC
left join dercorp_flex_tbls_tab flex on flex.id_flex_tbl::NUMERIC = meta.id_flex_tbl::NUMERIC
where
--meta.id_flex_tbl in (17,18, 20, 21, 22, 23, 28, 29, 31, 32, 33, 34, 35, 30, 27)
flex.atributo15 like '%HIST_CORP%';/* dmap converted statement end */
-- estimed cost of view [ pendium_hist_corp_reporte_vw ]: 1.30;
