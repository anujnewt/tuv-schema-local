create or replace procedure usrdrc.ss_login_pkg_check_if_pwd_is_effective_pr ( pobjuserinforow ss_login_pkg_user_info_typ ) as $body$
declare
-- pgv moved types start
--dmap moved type current package ss_login_pkg;
--dmap moved type current package ss_login_pkg;
-- pgv moved types end
ginpasswordchangecount    numeric;
gindayselapsed            numeric; -- since last password change
ginpasswordchangeadmincount numeric;
ginchangepasswordflag     numeric;
limaxnumcon               numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  coalesce(val_config,0)
into strict    limaxnumcon
from    app_config_tab
where   1=1
--and     id_config = 18
and cod_config = 'MaxNumCon'
;
exception
when no_data_found then
limaxnumcon:=0;
when data_exception then
perform dbms_output.put_line('Conversion of string to number failed');
limaxnumcon:=0;
when others then
limaxnumcon:=0;
end;
--
-- select  count(*)
--into    ginpasswordchangeadmincount
--from    ss_user_change_log_tab
--where   id_user       =   pobjuserinforow.user_id
--and     des_status    <>  change password;
select  count(*)
into strict    ginpasswordchangecount
from    ss_user_change_log_tab
where   id_user       =   pobjuserinforow.user_id
and     des_status    <>  'NEW USER';
if ginpasswordchangecount = 0
then
raise exception 'password_set_req_exception' using errcode = '50003';
end if;
select    num_change_password
into strict      ginchangepasswordflag
from      ss_user_tab
where     ss_user_tab.id_user   =   pobjuserinforow.user_id;
if ginchangepasswordflag = 1
then
raise exception 'password_set_req_exception' using errcode = '50003';
end if;
--last record from ss_user_change_log
select    min(trunc(clock_timestamp()-fec_change_date))
into strict      gindayselapsed
from      ss_user_change_log_tab
where     id_user   =   pobjuserinforow.user_id
--and     rownum    =   1
order by   id_user_change_log  desc;
--ecm 29 septiembre 2016 --maximo numero de contrase?a.
--if gindayselapsed >= pobjuserinforow.password_expiration_days
if gindayselapsed >= limaxnumcon
then
raise exception 'password_change_req_exception' using errcode = '50002';
end if;end;
$body$
language plpgsql
;
