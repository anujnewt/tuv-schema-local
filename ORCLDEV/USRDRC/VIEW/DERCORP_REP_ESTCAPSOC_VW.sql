-- dmap_object_gen_tag : type : view name : dercorp_rep_estcapsoc_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_rep_estcapsoc_vw"  ("id_empresa", "denom_actual") as select  emp.id_empresa,
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = emp.id_empresa::NUMERIC
and id_add_campo = 500::NUMERIC)
)         as "denom_actual"
from dercorp_empresa_tab emp;/* dmap converted statement end */
-- estimed cost of view [ dercorp_rep_estcapsoc_vw ]: 1.00;
