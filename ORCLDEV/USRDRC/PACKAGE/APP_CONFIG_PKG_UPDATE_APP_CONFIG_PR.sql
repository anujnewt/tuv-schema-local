create or replace procedure usrdrc.app_config_pkg_update_app_config_pr (piinidcon numeric ,pistcodcon varchar ,pistnomcon varchar ,pistdescon varchar ,pistvalcon varchar ,postmsg inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
gstencryptedpassword  varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pistcodcon = 'PWD_DOC'
then
gstencryptedpassword := ss_crypto_pkg.encrypt_fn(pistvalcon);
else
gstencryptedpassword := pistvalcon;
end if;
update app_config_tab
set    cod_config = pistcodcon
,nom_config = pistnomcon
,des_config = pistdescon
,val_config = gstencryptedpassword
where 1=1
and   id_config = piinidcon
;
/* commit; */
postmsg := 'Registro actualizado correctamente en la tabla APP_CONFIG_TAB.';/* dmap converted statement start */
exception
when no_data_found then
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
postmsg :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end *//* dmap converted statement start */
when others then
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
postmsg :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end */end;--end pr
$body$
language plpgsql
;
