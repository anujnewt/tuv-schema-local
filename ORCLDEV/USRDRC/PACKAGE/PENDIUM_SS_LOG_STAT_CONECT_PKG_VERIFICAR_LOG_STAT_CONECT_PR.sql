create or replace procedure usrdrc.pendium_ss_log_stat_conect_pkg_verificar_log_stat_conect_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
giuseractivos numeric := 3;
ldfec timestamp(0);
--lidiezmin number := 0.0006944; 1 min
lidiezmin numeric := 0.006944; --10 min
user_activos_cur cursor for
select  id_user
from    ss_user_tab
where   1=1
and     id_status = giuseractivos
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in user_activos_cur
loop
begin
select max(to_date((to_char(fec_log,'DD/MM/YYYY, HH24:MI:SS')),'DD/MM/YYYY, HH24:MI:SS')) as fec
into strict   ldfec
from   pendium_ss_log_stat_conect_tab
where  1=1
and    id_user = i.id_user
;
exception
when no_data_found then
ldfec := clock_timestamp();
end;/* dmap converted statement start */
if (clock_timestamp() - ldfec) > lidiezmin then
perform dbms_output.put_line( concat(ldfec, ' es mayor a 10 minutos.')) ;/* dmap converted statement end */
delete from pendium_ss_log_stat_conect_tab
where  1=1
and    id_user = i.id_user
;
update  ss_user_tab
set     id_status = 1
where   1=1
and     id_user = i.id_user
;
--update ss_user_tab set id_status = 1 where id_status = 3;
insert into ss_user_access_log_tab(
id_user_access_log
,id_user,fec_session_start_date
,fec_session_end_date
,des_session_close_mode
)
values (
nextval('ss_user_access_log_sq')
,i.id_user
,clock_timestamp()
,clock_timestamp()
,'FORCED_LOGOUT'
);
/*
update ss_user_access_log_tab
set fec_session_end_date    = sysdate,
des_session_close_mode    = forced_logout
where fec_session_end_date is null;
update dercorp_control_seccion set
status = 0
where
id_user in (
select
usr.id_user
from
ss_user_tab usr
left join ss_user_access_log_tab iual on usr.id_user = iual.id_user
where
iual.id_user_access_log = ( select
max(int_t.id_user_access_log)
from
ss_user_access_log_tab int_t
where
int_t.id_user = usr.id_user)
and
iual.des_session_close_mode = forced_logout
);
*/
delete from dercorp_control_meta_row
where
id_user = i.id_user; /*in (
select
usr.id_user
from
ss_user_tab usr
left join ss_user_access_log_tab iual on usr.id_user = iual.id_user
where
iual.id_user_access_log = ( select
max(int_t.id_user_access_log)
from
ss_user_access_log_tab int_t
where
int_t.id_user = usr.id_user)
and
iual.des_session_close_mode = forced_logout
);*/
/* commit; */
end if;
end loop;end;
$body$
language plpgsql
;
