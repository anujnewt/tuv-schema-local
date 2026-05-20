-- dmap_object_gen_tag : type : view name : dercorp_bitacora_modif_man_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_bitacora_modif_man_vw"  ("id_empresa", "nom_empresa", "creado_por", "fec_creacion", "modificado_por", "fec_ultima_modif") as select empre.id_empresa,
--empre.nom_empresa,
(select val_cat_val
from usrdrc.dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = empre.id_empresa::NUMERIC
and id_add_campo = 500))as nom_empresa,
a.creado_por,
a.fec_creacion,
a.modificado_por,
a.fec_ultima_modif
from   usrdrc.dercorp_empresa_tab empre,
(select emp.id_empresa,
(select  nom_user_long_name
from    usrdrc.ss_user_tab
where   id_user = cv.num_created_by::NUMERIC) as creado_por,
cv.fec_creation_date as fec_creacion,
(select  nom_user_long_name
from    usrdrc.ss_user_tab
where   id_user = cv.num_last_updated_by::NUMERIC) as modificado_por,
cv.fec_last_update_date as "fec_ultima_modif"
from    usrdrc.dercorp_empresa_tab emp,
usrdrc.dercorp_add_campo_valor_tab cv
where   emp.id_empresa = cv.id_empresa::NUMERIC
and     cv.id_add_campo = 502::NUMERIC) a
where   empre.id_empresa = a.id_empresa::NUMERIC
union all
select meta.id_empresa,
(select val_cat_val
from usrdrc.dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from usrdrc.dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa::NUMERIC
and id_add_campo = 500))as nom_empresa,
(select  nom_user_long_name
from    usrdrc.ss_user_tab
where   id_user = meta.num_created_by::NUMERIC) as creado_por,
meta.fec_creation_date as fec_creacion,
(select  nom_user_long_name
from    usrdrc.ss_user_tab
where   id_user = meta.num_last_updated_by::NUMERIC) as modificado_por,
meta.fec_last_update_date as "fec_ultima_modif"
from usrdrc.dercorp_metatbl_tab meta
union all
select pod.id_empresa,
(select val_cat_val
from usrdrc.dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from usrdrc.dercorp_add_campo_valor_tab
where id_empresa = pod.id_empresa::NUMERIC
and id_add_campo = 500))as nom_empresa,
(select  nom_user_long_name
from    usrdrc.ss_user_tab
where   id_user = pod.num_created_by::NUMERIC) as creado_por,
pod.fec_creation_date as fec_creacion,
(select  nom_user_long_name
from    usrdrc.ss_user_tab
where   id_user = pod.num_last_updated_by::NUMERIC) as modificado_por,
pod.fec_last_update_date as "fec_ultima_modif"
from pendium_escritura_poder_tab pod
order by  2;/* dmap converted statement end */
-- estimed cost of view [ dercorp_bitacora_modif_man_vw ]: 1.00;
