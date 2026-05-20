create or replace procedure usrdrc.ss_login_pkg_check_if_user_exist_pr ( pstusername varchar ,pobjoutuserinforow inout ss_login_pkg_user_info_typ ) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
-- pgv moved types end
cur_user_exist cursor for
select     ss_user.id_user                         user_id
,ss_user.nom_user_long_name              user_long_name
,ss_user.nom_username                    username
,ss_user.cve_password                    password
,ss_user.id_status                       status_id
,ss_rol.id_rol                           rol_id
,ss_rol.nom_name                         name
,ss_rol.des_description                  description
,ss_rol.num_password_expiration_days     password_expiration_days
from
ss_user_tab ss_user
left join ss_user_rol_tab     on ss_user_rol_tab.id_user    =   ss_user.id_user
left join ss_rol_tab ss_rol   on ss_rol.id_rol              =   ss_user_rol_tab.id_rol
where                            ss_user.nom_username       =   pstusername;
error_flag numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open cur_user_exist;
fetch cur_user_exist
into
pobjoutuserinforow.user_id
,pobjoutuserinforow.user_long_name
,pobjoutuserinforow.username
,pobjoutuserinforow.real_password
,pobjoutuserinforow.status_id
,pobjoutuserinforow.rol_id
,pobjoutuserinforow.rol_name
,pobjoutuserinforow.rol_description
,pobjoutuserinforow.password_expiration_days
;
if not found then
error_flag := 1;
else
if nullif(pobjoutuserinforow.rol_id::text, '') is null
then
error_flag := 2;
else
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount > 1
then
error_flag := 3;
end if;
end if;
end if;
close cur_user_exist;
if error_flag = 1
then
raise exception 'user_not_found_exception' using errcode = '50010';
end if;
if error_flag = 2
then
raise exception 'rol_not_found_exception' using errcode = '50009';
end if;
if error_flag = 3
then
raise exception 'more_than_one_rol_exception' using errcode = '50008';
end if;end;
$body$
language plpgsql
;
