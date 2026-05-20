create or replace procedure usrdrc.ss_login_pkg_check_if_pwd_is_correct_pr ( pstpassword varchar ,pobjuserinforow ss_login_pkg_user_info_typ ) as $body$
declare
-- pgv moved types start
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
-- pgv moved types end
gstencryptedpassword        varchar(255);
ginincorrectloginattempts   numeric;
limaxnumintacceso           numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  coalesce(val_config,0)
into strict    limaxnumintacceso
from    app_config_tab
where   1=1
--and     id_config = 20
and cod_config = 'MaxNumInt'
;
exception
when no_data_found then
limaxnumintacceso:=0;
when data_exception then
perform dbms_output.put_line('Conversion of string to number failed');
limaxnumintacceso:=0;
when others then
limaxnumintacceso:=0;
end;
if nullif(pstpassword::text, '') is null then
raise exception 'incorrect_password_exception' using errcode = '50007';
end if;
gstencryptedpassword := ss_crypto_pkg.encrypt_fn(pstpassword);
if pobjuserinforow.real_password <> gstencryptedpassword
then
select  count(*)
into strict    ginincorrectloginattempts
from    ss_user_access_log_tab
where   des_session_close_mode    =   'INCORRECT_PASSWORD'
and     id_user                   =   pobjuserinforow.user_id;
--ecm 30 septiembre 2016 maximo numero de intentos de acceso.
--if ginincorrectloginattempts >= 2
if ginincorrectloginattempts >= limaxnumintacceso then
call ss_login_pkg_inactivate_user_pr(
pobjuserinforow.user_id
);
raise exception 'user_just_blocked_exception' using errcode = '50006';
else
call ss_login_pkg_insert_inc_login_attempt_pr(
pobjuserinforow.user_id
);
raise exception 'incorrect_password_exception' using errcode = '50007';
end if;
else
delete from ss_user_access_log_tab
where       id_user                =   pobjuserinforow.user_id
and     des_session_close_mode =   'INCORRECT_PASSWORD';
end if;end;
$body$
language plpgsql
;
