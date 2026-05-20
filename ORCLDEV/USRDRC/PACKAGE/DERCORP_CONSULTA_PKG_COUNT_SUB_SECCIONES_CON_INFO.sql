create or replace  function  usrdrc.dercorp_consulta_pkg_count_sub_secciones_con_info ( sectionid numeric, empresaid numeric) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_count integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
count(*) into strict var_count
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
--val_valor is not null      -- se quito
and
coalesce(val_valor,'0') <> '0'       -- se agrego
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
)
) > 0
)
order by
id_seccion, id_subseccion;
return var_count;end;
$body$
language plpgsql
;
