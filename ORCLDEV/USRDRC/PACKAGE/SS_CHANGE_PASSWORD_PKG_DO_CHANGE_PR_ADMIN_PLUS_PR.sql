create or replace procedure usrdrc.ss_change_password_pkg_do_change_pr_admin_plus_pr ( pinuserid numeric, pinrolid numeric, pstnewpasswd1 varchar, pstnomcompl varchar, pstnomusr varchar, pststatus varchar, pstoutprocessresult inout varchar, pincreadopor numeric, pinnumempleado varchar--se agrega numero de empleado en jams
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
gstencryptednewpassword varchar(255);
gstoutprocessresult     varchar(255);
liminnumcarpas          numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  coalesce(val_config,0)
into strict    liminnumcarpas
from    app_config_tab
where   1=1
and     id_config = 19
;
exception
when no_data_found then
liminnumcarpas:=0;
when data_exception then
perform dbms_output.put_line('Conversion of string to number failed');
liminnumcarpas:=0;
when others then
liminnumcarpas:=0;
end;
call ss_change_password_pkg_check_if_password_is_valid_pr(
pinuserid
,3
,pstnewpasswd1
,gstoutprocessresult
);/* dmap converted statement start */
if gstoutprocessresult = '0'
then
pstoutprocessresult :=   concat('El nuevo password debe contener numeros, ', 'letras mayusculas, minusculas y '
, 'un simbolo [__#$%&()_].'
, 'Longitud minima para usuarios ', liminnumcarpas, ' chars. '
) --||longitud minima para usuarios -8 chars.
--||longitud minima para admin - 10 chars.
;/* dmap converted statement end */
return;
end if;
gstencryptednewpassword := ss_crypto_pkg.encrypt_fn(pstnewpasswd1);
update    ss_user_tab
set       ss_user_tab.cve_password          =  gstencryptednewpassword,
ss_user_tab.num_change_password   =  0,
ss_user_tab.nom_user_long_name    =  pstnomcompl,
ss_user_tab.nom_username          =  pstnomusr,
ss_user_tab.id_status             =  pststatus,
num_last_updated_by               =  pincreadopor,
ss_user_tab.atributo1             =  pinnumempleado, --se agrega numero de empleado en jams
fec_last_update_date              =  clock_timestamp()
where     ss_user_tab.id_user               = pinuserid;
if pststatus = '1'
then
delete from dercorp_control_meta_row
where dercorp_control_meta_row.id_user = pinuserid;
update      dercorp_control_seccion
set         dercorp_control_seccion.status = 0
where       dercorp_control_seccion.id_user = pinuserid;
end if;
update ss_user_rol_tab
set    id_rol = pinrolid
where  id_user = pinuserid;
insert into ss_user_change_log_tab(
id_user_change_log,
id_user,
cve_password,
fec_change_date,
des_status,
num_last_updated_by
)
values (
nextval('ss_user_change_log_sq'),
pinuserid,
gstencryptednewpassword,
clock_timestamp(),
'PASSWORD CHANGE',
pincreadopor
);
/* commit; */
pstoutprocessresult := 'OK';end;
$body$
language plpgsql
;
