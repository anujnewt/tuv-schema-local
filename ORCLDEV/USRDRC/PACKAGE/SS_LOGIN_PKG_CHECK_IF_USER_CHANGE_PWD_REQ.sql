create or replace procedure usrdrc.ss_login_pkg_check_if_user_change_pwd_req ( pobjuserinforow ss_login_pkg_user_info_typ ) as $body$
declare
-- pgv moved types start
--dmap moved type current package ss_login_pkg;
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pobjuserinforow.status_id = 4 --estatus 4 necesario cambio de contrase?a
then
raise exception 'change_pwd_required_exception' using errcode = '50001';
end if;end;
$body$
language plpgsql
;
