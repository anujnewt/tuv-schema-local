-- dmap_object_gen_tag : type : view name : dercorp_apoderados_names_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "dercorp_apoderados_names_vw"  ("id_empresa", "nom_empresa", "des_escritura", "num_tipo_poder", "tipo_poder", "des_grupo", "id_catalogo", "id_catalogo_valor", "val_cat_val", "des_tipo_baja", "des_documento", "fec_fecha_baja") as select
emp.id_empresa,
emp.nom_empresa,
esc.escritura as des_escritura,
apod.num_tipo_poder,
cat_tipo.val_cat_val tipo_poder,
apod.des_grupo,
apod.id_catalogo,
apod.id_catalogo_valor,
cat_elem.val_cat_val,
apod.des_tipo_baja,
apod.des_documento,
apod.fec_fecha_baja
from
dercorp_empresa_tab emp
inner join dercorp_escrituras_vw esc on esc.id_empresa = emp.id_empresa
left join dercorp_apoderados_tab apod on apod.id_empresa = emp.id_empresa
and apod.des_escritura = esc.escritura
and apod.id_catalogo = 32
left join dercorp_add_campo_cat_val_tab cat_tipo on cat_tipo.id_catalogo_valor = apod.num_tipo_poder
left join dercorp_add_campo_cat_val_tab cat_elem on cat_elem.id_catalogo_valor = apod.id_catalogo_valor
--where
--  emp.id_empresa = 1064;
-- estimed cost of view [ dercorp_apoderados_names_vw ]: 1.00;/* dmap converted statement end */
