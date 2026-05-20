-- dmap_object_gen_tag : type : view name : dercorp_cat_personas_total_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "dercorp_cat_personas_total_vw"  ("id_catalogo_valor", "id_catalogo", "nombre") as select  ac.id_catalogo_valor,
ac.id_catalogo,
trim(both ac.val_cat_val) as "nombre"
from    dercorp_add_campo_cat_val_tab ac
where   1=1
and     ac.id_catalogo in (10/*,40*/
,32,56,57)
and     ac.val_cat_val not in (
select    ds.val_cat_val
from      dercorp_add_campo_cat_val_tab ds
where     1=1
and       ds.id_catalogo = 1
and       ac.val_cat_val = ds.val_cat_val
)
order by  ac.val_cat_val;/* dmap converted statement end */
-- estimed cost of view [ dercorp_cat_personas_total_vw ]: 1.00;
