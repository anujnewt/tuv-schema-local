create or replace procedure usrdrc.dercorp_consulta_pkg_get_sub_secciones_con_info_pr ( sectionid numeric, empresaid numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
*
from
dercorp_add_campo_sub_sec_tab
where
id_seccion = (case sectionid when 0 then id_seccion else sectionid end)
and
(
(select count(*)
from dercorp_add_campo_valor_tab
where
id_empresa = empresaid
and
id_add_campo in (
select id_add_campo
from dercorp_add_campo_tab
where
id_subseccion = dercorp_add_campo_sub_sec_tab.id_subseccion
)
--and
--val_valor is not null      -- se agrego
and
coalesce(val_valor,'0') <> '0'      -- se agrego
) <> 0
or (select count(*)
from dercorp_add_campo_tab
where
id_seccion = sectionid
and
id_subseccion = dercorp_add_campo_sub_sec_tab.id_subseccion     --nava - 10-may-16 - faltaba condicion
--and
--des_tipo_campo in (flextable,ajax_page)                   --nava - 10-may-16 - se quito condicion
and (                                                       --nava - 10-may-16 - se agrego condicion compuesta
des_tipo_campo in ('AJAX_PAGE')
or
id_flex_tbl in (select id_flex_tbl from dercorp_metatbl_tab where id_empresa = empresaid)
or
id_flex_tbl in (2,36)--jjaq para que muestre observaciones grales y denom anteriores
)
) > 0
or id_seccion = 28
)
order by
num_order, id_seccion, id_subseccion;end;
$body$
language plpgsql
;
