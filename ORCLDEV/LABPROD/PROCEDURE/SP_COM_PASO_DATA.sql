create or replace procedure labprod."sp_com_paso_data"  (noctvo integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vs_activo       char(1);
vn_existr       integer;
vg_keyemp       integer;
vg_keypar       varchar(2);
vg_valpar        char(30);
begin
select dat_keyemp,trim(both dat_keypar),dat_valpar into strict vg_keyemp,vg_keypar,vg_valpar
from com_orac_sips_data where ora_noctvo=noctvo;/* dmap converted statement start */
if length(vg_keypar) = 1 then vg_keypar :=  concat('0', trim(both vg_keypar)) ; /* dmap converted statement end */end if;
select count(*) into strict vn_existr from datapaso where  dat_keyemp=vg_keyemp and  dat_keypar=vg_keypar;
if vn_existr = 0 or nullif(vn_existr::text, '') is null then
insert into datapaso(dat_keyemp,dat_keypar,dat_valpar)
values (vg_keyemp,vg_keypar,vg_valpar);
else
update datapaso set dat_valpar=vg_valpar where dat_keyemp=vg_keyemp and dat_keypar=vg_keypar;
end if;end;
$body$
language plpgsql
;
