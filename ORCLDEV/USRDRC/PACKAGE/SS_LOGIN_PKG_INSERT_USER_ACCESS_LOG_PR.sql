create or replace procedure usrdrc.ss_login_pkg_insert_user_access_log_pr ( pinuserid numeric ,pinoutaccesslogid inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
pinoutaccesslogid:= nextval('ss_user_access_log_sq');
insert into ss_user_access_log_tab(
id_user_access_log
,id_user
,fec_session_start_date
,fec_session_end_date
,des_session_close_mode
)
values (
pinoutaccesslogid
,pinuserid
,clock_timestamp()
,null
,'LOGIN_EXITOSO'
);
update ss_user_tab
set    id_status = 3
where  id_user   =  pinuserid;
--jjaq 04/09/2017 se inserta tambien en la tabla pendium_ss_log_stat_conect_tab para para el
--cierre de sesion automatico y no espere despues de un minuto a insertar en esta tabla.
usrdrc.pendium_ss_log_stat_conect_pkg_insertar_log_stat_conect_pr(pinuserid);end;
$body$
language plpgsql
;
