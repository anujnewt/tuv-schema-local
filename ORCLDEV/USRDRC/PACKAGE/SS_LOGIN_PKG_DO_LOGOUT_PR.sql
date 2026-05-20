create or replace procedure usrdrc.ss_login_pkg_do_logout_pr ( pinuserid numeric ,pinuseraccesslogid numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update ss_user_tab
set    id_status = 1
where  id_user   =  pinuserid;
update  dercorp_control_seccion
set     status = '0'
where   id_user = pinuserid;
delete  from dercorp_control_meta_row
where   id_user = pinuserid;
insert into ss_user_access_log_tab(fec_session_end_date,des_session_close_mode,id_user_access_log,id_user)
values (clock_timestamp(),'NORMAL_LOGOUT',nextval('ss_user_access_log_sq'),pinuserid);
/*
update ss_user_access_log_tab
set    fec_session_end_date   = sysdate
,des_session_close_mode = normal_logout
where  id_user_access_log     = pinuseraccesslogid;*/
end;
$body$
language plpgsql
;
