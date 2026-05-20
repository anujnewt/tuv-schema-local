create or replace procedure usrdrc.dercorp_catalogs_pkg_get_element_descrip_pr (catalogelementid varchar, description inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
val_cat_val into strict description
from
dercorp_add_campo_cat_val_tab
where
id_catalogo_valor = catalogelementid;end;
$body$
language plpgsql
;
