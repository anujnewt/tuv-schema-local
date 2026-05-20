create or replace procedure usrdrc.ss_login_pkg_do_login_pr ( pstusername varchar ,pstpassword varchar ,pstoutprocessresult inout varchar ,pstoutprocessmessage inout varchar ,pinoutuserid inout numeric ,pstoutuserlongname inout varchar ,pstoutrolid inout varchar ,pstoutrolname inout varchar ,pinoutuseraccesslogid inout numeric ) as $body$
declare
-- pgv moved types start
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
-- pgv moved types end
gobjuserinforow       ss_login_pkg_ss_login_pkg_user_info_typ;
linstatusid           numeric;
limaxnumintacceso     numeric;
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
call ss_login_pkg_check_if_user_exist_pr(
pstusername
,pobjoutuserinforow => gobjuserinforow
);
call ss_login_pkg_check_if_user_is_active_pr(
gobjuserinforow
);
call ss_login_pkg_check_if_pwd_is_correct_pr(
pstpassword
,gobjuserinforow
);
--
-- validar sinle login
--
call ss_login_pkg_check_if_pwd_is_effective_pr(
gobjuserinforow
);
call ss_login_pkg_check_if_user_is_logged_in_pr(
gobjuserinforow
);
call ss_login_pkg_check_if_user_change_pwd_req(
gobjuserinforow
);
call ss_login_pkg_insert_user_access_log_pr(
gobjuserinforow.user_id
,pinoutuseraccesslogid
);
pstoutprocessresult     :=  'OK';
pstoutprocessmessage:= null;
call ss_login_pkg_set_output_vars_pr(
gobjuserinforow
,pinoutuserid
,pstoutuserlongname
,pstoutrolid
,pstoutrolname
);
exception
when sqlstate '50010' then
pstoutprocessresult   := 'USER_NOT_FOUND';
pstoutprocessmessage  := 'El nombre de usuario es incorrecto.';
when sqlstate '50009' then
pstoutprocessresult   := 'ROL_NOT_FOUND';
pstoutprocessmessage  := 'El usuario no tiene asignado un Rol dentro de la aplicacion. Comuniquese con el administrador del sistema.';
when sqlstate '50008' then
pstoutprocessresult   := 'MORE_THAN_ONE_ROL';
pstoutprocessmessage  := 'El usuario tiene asignado mas de un Rol dentro de la aplicacion. Comuniquese con el administrador del sistema.';
when sqlstate '50007' then
pstoutprocessresult   := 'INCORRECT_PASSWORD';/* dmap converted statement start */
pstoutprocessmessage  :=  concat('El password es incorrecto. Por seguridad la cuenta se bloqueara al intento ', limaxnumintacceso
, ' incorrecto de acceso.') ;/* dmap converted statement end */
when sqlstate '50006' then
pstoutprocessresult   := 'USER_JUST_BLOCKED';/* dmap converted statement start */
pstoutprocessmessage  :=  concat('El password es incorrecto. Por seguridad LA CUENTA HA SIDO BLOQUEADA despues de ', limaxnumintacceso
, ' intentos incorrectos de acceso. Comuniquese con el administrador del sistema.') ;/* dmap converted statement end */
when sqlstate '50005' then
pstoutprocessresult   := 'USER_NOT_ACTIVE';
pstoutprocessmessage  := 'El usuario se encuentra Bloqueado. Comuniquese con el administrador del sistema.';
when sqlstate '50004' then
pstoutprocessresult   := 'USER_YET_LOGGED';/* dmap converted statement start */
pstoutprocessmessage  := 'El usuario se encuentra Conectado desde otra computadora. '
concat(--||no es posible iniciar una segunda sesion.
, 'De lo contrario espere 10 minutos.'
) ;/* dmap converted statement end */
when sqlstate '50003' then
pstoutprocessresult   := 'PASSWORD_SET_REQ';
pstoutprocessmessage  := 'Por favor, defina una contrase?a personalizada.';
call ss_login_pkg_set_output_vars_pr(gobjuserinforow,pinoutuserid, pstoutuserlongname, pstoutrolid,pstoutrolname);
when sqlstate '50002' then
pstoutprocessresult  := 'PASSWORD_CHANGE_REQ';
pstoutprocessmessage := 'Su contrase?a ha caducado. Por favor, defina una nueva contrase?a.';
call ss_login_pkg_set_output_vars_pr(gobjuserinforow,pinoutuserid, pstoutuserlongname, pstoutrolid,pstoutrolname);
when sqlstate '50001' then
pstoutprocessresult  := 'CHANGE_PWD_REQUIRED_REQ';
pstoutprocessmessage := 'Por favor, defina una contrase?a personalizada.';
call ss_login_pkg_set_output_vars_pr(gobjuserinforow,pinoutuserid, pstoutuserlongname, pstoutrolid,pstoutrolname);end;
$body$
language plpgsql
;
