create or replace procedure usrdrc.ss_change_password_pkg_delete_user_pr ( pinuserid numeric, pineliminadopor numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ginremainadminusers           numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pinuserid <> 1
then
--jjaq para bitacora de usuarios y grupos baja
insert into ss_user_change_log_tab(
id_user_change_log,
id_user,
fec_change_date,
des_status,
num_last_updated_by
)
values (
nextval('ss_user_change_log_sq'),
pinuserid,
clock_timestamp(),
'DELETED USER',
pineliminadopor
);
delete from ss_user_rol_tab
where       id_user = pinuserid;
delete from ss_user_tab
where       id_user = pinuserid;
else
raise exception '%', 'El super usuario admin no puede ser eliminado' using errcode = '45101';
end if;
/* commit; */
delete from ss_user_rol_tab
where  id_user = pinuserid;
/*
insert into ss_user_change_log_tab (
id_user_change_log,
id_user,
cve_password,
fec_change_date,
des_status
)
values (
ss_user_change_log_sq.nextval,
pinuserid,
,
now() at time zone current_setting('TIMEZONE'),
deleted user
);*/
end;
$body$
language plpgsql
;
