create or replace procedure usrdrc.app_config_pkg_delete_app_config_pr (piinidcon numeric ,postmsg inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from app_config_tab where 1=1 and id_config = piinidcon;
/* commit; */
postmsg := 'Registro borrado correctamente en la tabla APP_CONFIG_TAB.';/* dmap converted statement start */
exception
when no_data_found then
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
postmsg :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end *//* dmap converted statement start */
when others then
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
postmsg :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
