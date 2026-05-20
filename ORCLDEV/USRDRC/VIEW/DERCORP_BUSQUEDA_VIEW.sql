-- dmap_object_gen_tag : type : view name : dercorp_busqueda_view
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "dercorp_busqueda_view"  ("id_empresa", "denom_actual", "denom_anterior", "clasificacion", "id_clasificacion", "pais", "id_pais", "atributo3") as select  emp.id_empresa,
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and id_add_campo = 500::NUMERIC)
)         as denom_actual,
mt.val_c1 as denom_anterior,
(select val_cat_val
from dercorp_add_campo_cat_val_tab ccv
where ccv.id_catalogo       = 6::NUMERIC
and   ccv.id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and id_add_campo = 507::NUMERIC)
)          as clasificacion,
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and id_add_campo = 507::NUMERIC)  as id_clasificacion,
(select val_cat_val
from dercorp_add_campo_cat_val_tab ccv
where ccv.id_catalogo       = 7::NUMERIC
and   ccv.id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and id_add_campo = 509::NUMERIC)
)          as pais,
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and id_add_campo = 509::NUMERIC) as id_pais,
(select atributo3
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1::NUMERIC
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and id_add_campo = 500::NUMERIC)
)         as "atributo3"
from dercorp_empresa_tab emp
left join dercorp_metatbl_tab mt
on  mt.id_empresa::NUMERIC = emp.id_empresa::NUMERIC::NUMERIC
and    mt.id_flex_tbl = 2::NUMERIC;/* dmap converted statement end */
-- estimed cost of view [ dercorp_busqueda_view ]: 1.00;
