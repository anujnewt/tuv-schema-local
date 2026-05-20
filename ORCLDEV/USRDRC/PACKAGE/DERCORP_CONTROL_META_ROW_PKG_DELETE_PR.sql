create or replace procedure usrdrc.dercorp_control_meta_row_pkg_delete_pr ( p_id_empresa dercorp_control_meta_row.id_empresa%type , p_id_user dercorp_control_meta_row.id_user%type , p_id_meta_row dercorp_control_meta_row.id_meta_row%type ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete
from dercorp_control_meta_row
where id_empresa = p_id_empresa
and id_user      = p_id_user
and id_meta_row  = p_id_meta_row;end;
$body$
language plpgsql
;
