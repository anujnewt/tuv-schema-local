create or replace procedure usrdrc.ss_change_password_pkg_do_change_pr_admin_pr ( pinuserid numeric, pinrolid numeric, pstnewpasswd1 varchar, pstoutprocessresult inout varchar ) as $body$
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
ss_user_tab.num_change_password   =  1
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
/* commit; */
pstoutprocessresult := 'OK';end;
$body$
language plpgsql
;
