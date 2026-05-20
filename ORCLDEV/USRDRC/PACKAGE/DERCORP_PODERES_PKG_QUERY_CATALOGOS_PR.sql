create or replace procedure usrdrc.dercorp_poderes_pkg_query_catalogos_pr (porcrsresultado inout refcursor, pinid_catalogo numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select *
from dercorp_add_campo_cat_val_tab
where id_catalogo = pinid_catalogo
order by  upper(translate(val_cat_val,'AEIOUaeiou','AEIOUAEIOU'));end;
$body$
language plpgsql
;
