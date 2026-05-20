create or replace procedure usrdrc.dercorp_catalogs_pkg_get_catalog_poderes_pr (lstfilter varchar, lstcurrentids varchar, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
cat.id_poder_pk as id_catalogo,
case cat.ind_podertipo
when 'PG' then  concat(cat.ind_podertipo, ' - ', cat.des_podertipo
) else   concat('CP/PE - ', cat.des_podertipo)  end as val_cat_val
from
pendium_catalogo_poderes_tab cat
where
cat.ind_status = 1
order by
cat.ind_podertipo desc,cat.des_podertipo;/* dmap converted statement end */end;
$body$
language plpgsql
;
