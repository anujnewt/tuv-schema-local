create or replace procedure usrdrc.dercorp_reportflex_pkg_get_param_info_pr (resultset inout refcursor, paramfilter varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
id_add_campo,
--to_char(id_add_campo),
(
case id_add_campo
when 520 then atributo6
when 1077 then atributo6
else
nom_campo end
) nom_campo,
id_catalogo,
des_tipo_campo as tipo_campo
from
dercorp_add_campo_tab
where
paramfilter like  concat('%', id_add_campo , '%'
) union
select
id_flex_colum  * 10000,
--cod_flex_colum,
des_flex_colum,
id_catalogo,
des_tipo_colum as tipo_campo
from
dercorp_flex_colums_tab
where
paramfilter like  concat('%', (id_flex_colum * 10000) , '%'
) --paramfilter like % || cod_flex_colum || %
;/* dmap converted statement end */end;
$body$
language plpgsql
;
