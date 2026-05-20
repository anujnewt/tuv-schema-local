create or replace procedure usrdrc.ss_change_password_pkg_create_user_admin_pr ( pinrolid numeric, pstuserlongname varchar, pstusername varchar, pstnewpasswd1 varchar, pstoutprocessresult inout varchar, pincreadopor numeric, pinnumempleado varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
gstencryptednewpassword     varchar(255);
ginuseridnextval            numeric;
gstoutprocessresult         varchar(255);
liminnumcarpas              numeric;
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
0
,3
,pstnewpasswd1
,gstoutprocessresult
);/* dmap converted statement start */
if gstoutprocessresult = '0'
then
pstoutprocessresult :=   concat('El nuevo password debe contener numeros, ', 'letras mayusculas, minusculas y '
, 'un simbolo [__#$%&()_].'
, 'Longitud minima es de ', liminnumcarpas, ' chars. '
) --||longitud minima para usuarios -8 chars.
--||longitud minima para admin - 10 chars.
;/* dmap converted statement end */
return;
end if;
call ss_change_password_pkg_check_if_user_exists(  pstusername
,gstoutprocessresult
);/* dmap converted statement start */
if gstoutprocessresult = '0'
then
pstoutprocessresult :=   concat('El usuario ', pstusername, ' ya existe') ;/* dmap converted statement end */
return;
end if;
gstencryptednewpassword := ss_crypto_pkg.encrypt_fn(pstnewpasswd1);
select  nextval('ss_user_sq')
into strict    ginuseridnextval
;
insert into    ss_user_tab(
id_user,
nom_user_long_name,
nom_username,
cve_password,
id_status,
num_created_by,
fec_creation_date,
atributo1
)
values (
ginuseridnextval,
pstuserlongname,
pstusername,
gstencryptednewpassword,
1,
pincreadopor,
clock_timestamp(),
pinnumempleado
);
insert into dercorp_control_seccion(
id_user
)
values (
ginuseridnextval
);
insert into ss_user_rol_tab(
id_user
,id_rol
)
values (
ginuseridnextval
,pinrolid
);
/* commit; */
pstoutprocessresult := 'Usuario Creado Satisfactoriamente';
insert into ss_user_change_log_tab(
id_user_change_log,
id_user,
cve_password,
fec_change_date,
des_status,
num_created_by
)
values (
nextval('ss_user_change_log_sq'),
ginuseridnextval,
gstencryptednewpassword,
clock_timestamp(),
'NEW USER',
pincreadopor
);end;
$body$
language plpgsql
;
