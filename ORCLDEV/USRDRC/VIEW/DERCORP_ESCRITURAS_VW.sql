-- dmap_object_gen_tag : type : view name : dercorp_escrituras_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "dercorp_escrituras_vw"  ("id_empresa", "escritura") as select id_empresa,
val_c8 as "escritura"
from dercorp_metatbl_tab m
where 1         =1
and id_flex_tbl = 17
union all
select id_empresa,
val_c8 as "escritura"
from dercorp_metatbl_tab m
where 1         =1
and id_flex_tbl = 18
union all
select id_empresa,
val_valor as "escritura"
from dercorp_add_campo_valor_tab
where id_add_campo = 551;/* dmap converted statement end */
-- estimed cost of view [ dercorp_escrituras_vw ]: 1.00;
