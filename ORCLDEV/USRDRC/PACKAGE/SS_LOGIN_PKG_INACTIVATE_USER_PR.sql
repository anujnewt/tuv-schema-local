create or replace procedure usrdrc.ss_login_pkg_inactivate_user_pr ( pinuserid numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update  ss_user_tab
set     id_status =   2
where   id_user   =   pinuserid;
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
'',
clock_timestamp(),
'BLOCKED'
);
insert into ss_user_access_log_tab(
id_user_access_log
,id_user
,fec_session_start_date
,fec_session_end_date
,des_session_close_mode
)
values (
nextval('ss_user_access_log_sq')
,pinuserid
,null
,clock_timestamp()
,'BLOCKED'
);end;
$body$
language plpgsql
;
