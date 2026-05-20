create or replace procedure usrdrc.ss_login_pkg_insert_inc_login_attempt_pr (pinuserid numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into ss_user_access_log_tab(
id_user_access_log
,id_user,fec_session_start_date
,fec_session_end_date
,des_session_close_mode
)
values (
nextval('ss_user_access_log_sq')
,pinuserid
,clock_timestamp()
,clock_timestamp()
,'INCORRECT_PASSWORD'
);end;
$body$
language plpgsql
;
