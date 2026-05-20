-- dmap_object_gen_tag : type : view name : dercorp_rep_apo_eje_soc_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_rep_apo_eje_soc_vw"  ("id_empresa", "nom_empresa", "fec_dictamen_fiscal", "fec_dic_finan", "fec_inf_comi", "fec_constancia", "fec_anual", "ejerciciosocial") as select id_empresa, nom_empresa, fec_dictamen_fiscal, fec_dic_finan, fec_inf_comi, fec_constancia, fec_anual, ejerciciosocial  from (
select empre.id_empresa,
--empre.nom_empresa,
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = empre.id_empresa::NUMERIC
and id_add_campo = 500))as nom_empresa,
a.fec_dictamen_fiscal,
a.fec_dic_finan,
a.fec_inf_comi,
a.fec_constancia,
a.fec_anual,
a.ejerciciosocial
from dercorp_empresa_tab empre
left outer join (select emp.id_empresa,
meta.val_c51 as fec_dictamen_fiscal,
meta.val_c46 as fec_dic_finan,
meta.val_c41 as fec_inf_comi,
meta.val_c88 as fec_constancia,
meta.val_c36 as fec_anual,
meta.val_c5  as ejerciciosocial
from    dercorp_empresa_tab emp,
dercorp_metatbl_tab meta
where   emp.id_empresa = meta.id_empresa::NUMERIC
and     meta.id_flex_tbl = 23::NUMERIC) a on (empre.id_empresa = a.id_empresa)  order by  2
) t
where   1=1
and     nullif(t.nom_empresa::text, '') is not null;/* dmap converted statement end */
-- estimed cost of view [ dercorp_rep_apo_eje_soc_vw ]: 1.00;
