create or replace procedure usrdrc.dercorp_flextab_pkg_delete_pr (param_id_meta_row varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_metatbl_tab
where
id_meta_row = param_id_meta_row;end;
$body$
language plpgsql
;
