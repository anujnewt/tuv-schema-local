create or replace procedure usrdrc.app_config_pkg_add_app_config_pr (pistcodcon varchar ,pistnomcon varchar ,pistdescon varchar ,pistvalcon varchar ,postmsg inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstmaxidconfig        varchar(32767) := 0;
gstencryptedpassword  varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select max(id_config) into strict lstmaxidconfig from app_config_tab;
if pistcodcon = 'PWD_DOC'
then
gstencryptedpassword := ss_crypto_pkg.encrypt_fn(pistvalcon);
else
gstencryptedpassword := pistvalcon;
end if;
insert into app_config_tab(id_config
,cod_config
,nom_config
,des_config
,val_config
)values ((lstmaxidconfig)::numeric +1
,pistcodcon
,pistnomcon
,pistdescon
,gstencryptedpassword
)
;
/* commit; */
postmsg := 'Registro creado correctamente en la tabla APP_CONFIG_TAB.';
exception
when no_data_found then
lstmaxidconfig := 0;/* dmap converted statement start */
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
postmsg :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end */
when others then
lstmaxidconfig := 0;/* dmap converted statement start */
perform dbms_output.put_line( concat('ORA-ERROR: ', sqlstate)) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);/* dmap converted statement start */
postmsg :=  concat(sqlerrm, ' ', sqlstate) ;/* dmap converted statement end */end;--end pr
$body$
language plpgsql
;
