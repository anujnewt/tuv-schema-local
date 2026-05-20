create or replace procedure usrdrc.dercorp_poderes_pkg_query_catalogo_poderes_pr (porcrsresultado inout refcursor ,pinid_poder_pk numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select *
from pendium_catalogo_poderes_tab
where id_poder_pk    =  pinid_poder_pk
and   ind_status  =  1
order by  des_podertipo;end;
$body$
language plpgsql
;
create or replace procedure usrdrc.dercorp_poderes_pkg_query_catalogo_poderes_pr (porcrsresultado inout refcursor ,pstind_podertipo varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select *
from pendium_catalogo_poderes_tab
where ind_podertipo    =  pstind_podertipo
and   ind_status  =  1
order by  des_podertipo;end;
$body$
language plpgsql
;
create or replace procedure usrdrc.dercorp_poderes_pkg_query_catalogo_poderes_pr (porcrsresultado inout refcursor ,pstind_podertipo varchar ,pstdes_podertipo varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select *
from pendium_catalogo_poderes_tab
where ind_podertipo    =  pstind_podertipo
and   lower(des_podertipo)   like  concat('%', lower(pstdes_podertipo), '%'
) and   ind_status  =  1
order by  des_podertipo;/* dmap converted statement end */end;
$body$
language plpgsql
;
