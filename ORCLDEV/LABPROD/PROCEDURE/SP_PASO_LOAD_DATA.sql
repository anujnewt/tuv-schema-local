create or replace procedure labprod."sp_paso_load_data"  (keyemp integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vs_activo       varchar(1);
vn_existr       integer;
vg_keyemp       integer;
vg_keypar       varchar(4);
vg_valpar       varchar(30);
vg_largo        smallint;
namedcursor cursor for
select trim(both dat_keyemp), trim(both dat_keypar), trim(both dat_valpar)
into strict vg_keyemp,vg_keypar,vg_valpar from datapaso where dat_keyemp =  keyemp;
begin
open namedcursor;
loop
fetch namedcursor into vg_keyemp,vg_keypar,vg_valpar;
exit when not found; /* apply on namedcursor */
select count(*) into strict  vn_existr from nmlodata
where  dat_keyemp=vg_keyemp and  dat_keypar=vg_keypar;
if (vn_existr = 0 or nullif(vn_existr::text, '') is null)  and nullif(vg_keyemp::text, '') is not null then
insert into nmlodata(dat_keyemp,dat_keypar,dat_valpar) values (vg_keyemp,vg_keypar,vg_valpar);
else
update nmlodata set dat_valpar=vg_valpar where dat_keyemp=vg_keyemp and dat_keypar=vg_keypar;
end if;
end loop;
close namedcursor;end;
$body$
language plpgsql
;
