create or replace procedure usrdrc.xxtv_rep_apoderados_pkg_get_empresas_pr (resultset inout refcursor, paramempresas varchar, paramapoderados varchar, parampoder varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if length(trim(both parampoder)) > 0 then
open resultset for
select
id_empresa,
--nom_empresa
(select val_cat_val
from dercorp_add_campo_cat_val_tab ac
where id_catalogo = 1
and   ac.id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = emp.id_empresa
and id_add_campo = 500))as nom_empresa
from
dercorp_empresa_tab emp
where ( concat(',', coalesce(paramempresas,id_empresa) , ',')  like  concat('%,', id_empresa , ',%')
) and
id_empresa in (
select id_empresa
from dercorp_apoderados_names_vw
where ( concat(',', paramapoderados , ',')  like  concat('%,', id_catalogo_valor , ',%')
)
) and
id_empresa in (
select id_empresa
from dercorp_apoderados_poderes_vw
where ( concat(',', parampoder , ',')  like  concat('%,', id_catalogo_valor , ',%')
)
)  order by  nom_empresa
;/* dmap converted statement end *//* dmap converted statement start */
else
open resultset for
select
id_empresa,
--nom_empresa
(select val_cat_val
from dercorp_add_campo_cat_val_tab ac
where id_catalogo = 1
and   ac.id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = emp.id_empresa
and id_add_campo = 500))as nom_empresa
from
dercorp_empresa_tab emp
where ( concat(',', coalesce(paramempresas,id_empresa) , ',')  like  concat('%,', id_empresa , ',%')
) and
id_empresa in (
select id_empresa
from dercorp_apoderados_names_vw
where ( concat(',', paramapoderados , ',')  like  concat('%,', id_catalogo_valor , ',%')
)
)  order by  nom_empresa
;/* dmap converted statement end */
end if;end;
$body$
language plpgsql
;
