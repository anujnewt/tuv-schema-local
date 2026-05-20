create or replace procedure usrdrc.ss_change_password_pkg_do_change_pr ( pinuserid numeric, pinrolid numeric, pstoldpassword varchar, pstnewpasswd1 varchar, pstnewpasswd2 varchar, pstoutprocessresult inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
gstcurrentpassword           varchar(255);
gstencryptedoldpassword      varchar(255);
gstencryptednewpassword      varchar(255);
ginrepetitions               numeric;
gstoutprocessresult          varchar(255);
lihistorialcontrasena numeric;
liminnumcarpas        numeric;
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
begin
select  coalesce(val_config,0)
into strict    lihistorialcontrasena
from    app_config_tab
where   1=1
and     id_config = 17
;
exception
when no_data_found then
lihistorialcontrasena:=0;
when data_exception then
perform dbms_output.put_line('Conversion of string to number failed');
lihistorialcontrasena:=0;
when others then
lihistorialcontrasena:=0;
end;
if pstnewpasswd1 = pstoldpassword
then
pstoutprocessresult := 'El nuevo password no puede ser igual al anterior';
return;
end if;
if pstnewpasswd1 <> pstnewpasswd2
then
pstoutprocessresult := 'El nuevo password no coincide con su confirmacion';
return;
end if;
--obtener el verdadero password actual
select  ss_user_tab.cve_password
into strict    gstcurrentpassword
from    ss_user_tab
where   ss_user_tab.id_user = pinuserid;
gstencryptedoldpassword := ss_crypto_pkg.encrypt_fn(pstoldpassword);
if gstencryptedoldpassword <> gstcurrentpassword
then
pstoutprocessresult := 'El password actual no es correcto';
return;
end if;
call ss_change_password_pkg_check_if_password_is_valid_pr(
pinuserid
,pinrolid
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
/*
/*select  count(*)
into    ginrepetitions
from    ss_user_change_log_tab
where   ss_user_change_log_tab.id_user      =  pinuserid
and     ss_user_change_log_tab.cve_password = gstencryptednewpassword;*/
--        select  count(*)
--        into    ginrepetitions
/* from    ss_user_change_log_tab
where   ss_user_change_log_tab.id_user      =  pinuserid
and     ss_user_change_log_tab.cve_password = gstencryptednewpassword;
*/
/*
from (select * from ss_user_change_log_tab
where id_user = pinuserid
and ss_user_change_log_tab.cve_password = gstencryptednewpassword
order by fec_change_date)
--where rownum < 7;
--ecm 29 septiembre 2016 historial de contrase?as
where rownum < lihistorialcontrasena;
*/
--ecm 29 septiembre 2016 historial de contrase?as
select count(*) into strict ginrepetitions from (
select  *
from (select * from ss_user_change_log_tab
where id_user = pinuserid
order by  fec_change_date) alias1 limit (lihistorialcontrasena - 1))a
where a.cve_password = gstencryptednewpassword
;
if ginrepetitions <> 0
then
pstoutprocessresult := 'Ya ha usado este password anteriormente. Debe definir uno nuevo';
return;
end if;
update    ss_user_tab
set       ss_user_tab.cve_password          = gstencryptednewpassword,
ss_user_tab.num_change_password   = 0,
ss_user_tab.id_status             = 1
where     ss_user_tab.id_user               = pinuserid;
insert into ss_user_change_log_tab(
id_user_change_log,
id_user,
cve_password,
fec_change_date,
des_status
)
values (
nextval('ss_user_change_log_sq'),
pinuserid,
gstencryptednewpassword,
clock_timestamp(),
'PASSWORD CHANGE'
);
pstoutprocessresult := 'OK';end;
$body$
language plpgsql
;
