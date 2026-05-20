create or replace procedure usrdrc.ss_login_pkg_check_if_user_is_logged_in_pr ( pobjuserinforow ss_login_pkg_user_info_typ ) as $body$
declare
-- pgv moved types start
--dmap moved type current package ss_login_pkg;
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pobjuserinforow.status_id = 3
then
raise exception 'user_yet_logged_exception' using errcode = '50004';
end if;end;
$body$
language plpgsql
;
