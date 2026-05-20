-- dmap_object_gen_tag : type : view name : dercorp_control_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_control_vw"  ("id_empresa", "id_meta_row", "id_flex_tbl", "nom_flex", "val_c1", "val_c2", "val_c3", "val_c4", "val_c5", "val_c6", "val_c7", "val_c8", "val_c9", "id_escritura", "ind_tipo_escritura") as select
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
when 27 then meta.val_c2
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
null as id_escritura,
null as "ind_tipo_escritura"
from
dercorp_metatbl_tab meta
left join dercorp_add_campo_cat_val_tab cat on cat.id_catalogo_valor::NUMERIC = meta.val_c2::NUMERIC
left join dercorp_flex_tbls_tab flex on flex.id_flex_tbl::NUMERIC = meta.id_flex_tbl::NUMERIC
where
--meta.id_flex_tbl in (17,18, 20, 21, 22, 23, 28, 29, 31, 32, 33, 34, 35, 30, 27)
flex.atributo15 like '%CONTROL%'
union all
select esc.id_empresa,
99999 as id_meta_row,
100 as id_flex_tbl,
'Poderes' as nom_flex,
esc.fec_fecha as val_c1,
(select val_cat_val from dercorp_add_campo_cat_val_tab
where id_catalogo=49::NUMERIC and id_catalogo_valor=esc.ind_delegado_por::NUMERIC) as val_c2,
case esc.ind_tipo_escritura
when 'ER' then 'Revocacion de Poderes'
when 'PG' then
case(select count(distinct esc_temp.ind_tipo_escritura) from pendium_escritura_poder_tab esc_temp inner join pendium_otorgapoder_ep_tab pod_temp
on esc_temp.id_ep_pk::NUMERIC = pod_temp.id_ep_fk::NUMERIC
where esc_temp.des_escritura = esc.des_escritura::VARCHAR
and esc_temp.id_empresa=esc.id_empresa::NUMERIC group by esc_temp.id_empresa)
when 1 then 'Otorgamiento de Poderes Generales'
else 'Otorgamiento de Poderes Generales y Especiales' end
when 'PE' then 'Otorgamiento de Poderes Especiales'
end  as val_c3,
(case coalesce(ind_aplica_status,0) when 1 then
case ind_status_ac when '6' then
case when nullif(id_ent_resp::text, '') is not null then
case when nullif(fec_ent::text, '') is not null then 'semaforo_green.png'
else 'semaforo_red.png' end
else 'semaforo_red.png' end
else 'semaforo_red.png' end
else 'semaforo_gray.png' end) as val_c4,
esc.des_escritura as val_c5,
esc.fec_otorgamiento_instr as val_c6,
(case esc.ind_requiere_inscr_rppc
when '1' then 'Si'
else 'No' end) as val_c7,
esc.fec_registro as val_c8,
(case(case coalesce(ind_requiere_proto,0) when 1 then
case when nullif(des_escritura::text, '') is not null then
case when nullif(num_documentum_instr::text, '') is not null then
case when nullif(fec_otorgamiento_instr::text, '') is not null then
case when nullif(num_licenciado::text, '') is not null then 1
else 0 end
else 0 end
else 0 end
else 0 end
else 1 end) when 1 then
case(case coalesce(ind_requiere_inscr_rppc,'0') when '1' then
case when nullif(fec_registro::text, '') is not null then
case when nullif(num_folio_merc::text, '') is not null then 1
else 0 end
else 0 end
else 1 end) when 1 then 'semaforo_green.png'
else 'semaforo_red.png' end
else 'semaforo_red.png' end) as val_c9,
esc.id_ep_pk,
esc.ind_tipo_escritura as "ind_tipo_escritura"
from (
select pendium_escritura_poder_tab.*
from pendium_escritura_poder_tab inner join dercorp_add_campo_cat_val_tab
on ind_delegado_por::NUMERIC=id_catalogo_valor::NUMERIC
where 1=1
and val_cat_val!='Apoderado'
and ind_tipo_escritura in ('PG'::VARCHAR)
and ind_status=1::NUMERIC
and (case pendium_escritura_poder_tab.ind_tipo_escritura when 'ER' then 1
else (select count(distinct esc.ind_tipo_escritura) from pendium_escritura_poder_tab esc inner join pendium_otorgapoder_ep_tab pod
on esc.id_ep_pk::NUMERIC = pod.id_ep_fk::NUMERIC
where esc.des_escritura = pendium_escritura_poder_tab.des_escritura::VARCHAR
and esc.id_empresa=pendium_escritura_poder_tab.id_empresa::NUMERIC group by esc.id_empresa)end)=2
union all
select pendium_escritura_poder_tab.*
from pendium_escritura_poder_tab inner join dercorp_add_campo_cat_val_tab
on ind_delegado_por::NUMERIC=id_catalogo_valor::NUMERIC
where 1=1
and val_cat_val!='Apoderado'
and ind_tipo_escritura in ('PG'::VARCHAR,'PE'::VARCHAR,'ER'::VARCHAR)
and ind_status=1::NUMERIC
and (case pendium_escritura_poder_tab.ind_tipo_escritura when 'ER' then 1
else (select count(distinct esc.ind_tipo_escritura) from pendium_escritura_poder_tab esc inner join pendium_otorgapoder_ep_tab pod
on esc.id_ep_pk::NUMERIC = pod.id_ep_fk::NUMERIC
where esc.des_escritura = pendium_escritura_poder_tab.des_escritura::VARCHAR
and esc.id_empresa=pendium_escritura_poder_tab.id_empresa::NUMERIC group by esc.id_empresa)end)=1
) esc;/* dmap converted statement end */
-- estimed cost of view [ dercorp_control_vw ]: 1.00;
