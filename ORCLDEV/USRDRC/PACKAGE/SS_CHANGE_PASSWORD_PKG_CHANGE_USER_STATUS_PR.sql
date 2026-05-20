create or replace procedure usrdrc.ss_change_password_pkg_change_user_status_pr ( pinuserid numeric, pinstatusid numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update     ss_user_tab
set        ss_user_tab.id_status     =  pinstatusid
where      ss_user_tab.id_user       =  pinuserid;
/* commit; */
delete from ss_user_access_log_tab
where       id_user = pinuserid
and         des_session_close_mode = 'INCORRECT_PASSWORD';
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
'UNBLOCKED'
);end;
$body$
language plpgsql
;
