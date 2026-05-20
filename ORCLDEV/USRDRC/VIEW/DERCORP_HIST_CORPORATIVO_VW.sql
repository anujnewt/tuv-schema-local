-- dmap_object_gen_tag : type : view name : dercorp_hist_corporativo_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_hist_corporativo_vw"  ("id_empresa", "id_meta_row", "id_flex_tbl", "nom_flex", "val_c1", "val_c2", "val_c3", "val_c4", "val_c5", "val_c6", "val_c7", "val_c8", "val_c9") as select
meta.id_empresa,
meta.id_meta_row,
flex.id_flex_tbl,
flex.nom_flex,
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
else meta.val_c83 end         as "val_c9    -- semaforo"
from
dercorp_metatbl_tab meta
left join dercorp_add_campo_cat_val_tab cat on cat.id_catalogo_valor::NUMERIC = meta.val_c2::NUMERIC
left join dercorp_flex_tbls_tab flex on flex.id_flex_tbl::NUMERIC = meta.id_flex_tbl::NUMERIC
where
--meta.id_flex_tbl in (17,18, 20, 21, 22, 23, 28, 29, 31, 32, 33, 34, 35, 30, 27)
flex.atributo15 like '%HIST_CORP%';/* dmap converted statement end */
-- estimed cost of view [ dercorp_hist_corporativo_vw ]: 1.00;
