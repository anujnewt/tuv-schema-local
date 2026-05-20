create or replace  function  usrdrc.dercorp_catalogs_pkg_get_element_descrip_fn (catalogelementid varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
description varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select
val_cat_val into strict description
from
dercorp_add_campo_cat_val_tab
where
id_catalogo_valor = catalogelementid;
return description;
exception
when others then
return '-';
end;end;
$body$
language plpgsql
;
