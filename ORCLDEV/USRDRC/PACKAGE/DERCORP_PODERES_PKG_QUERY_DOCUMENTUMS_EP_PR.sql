create or replace procedure usrdrc.dercorp_poderes_pkg_query_documentums_ep_pr (porcrsresultado inout refcursor ,pinid_ep_fk numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select
*
from pendium_documentums_ep_tab
where
id_ep_fk  = pinid_ep_fk and
ind_status = 1
order by  desc_title;end;
$body$
language plpgsql
;
