create or replace procedure admp."admp_codigo_memo_pr"  ( piinidcanal numeric ,piinnumanio numeric ,poinnumcodigo inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
select  cod_memo::numeric + 1
into strict    poinnumcodigo
from    admp.admp_memo_cod_tab
where   id_canal = piinidcanal
and     num_anio =  piinnumanio;
update  admp.admp_memo_cod_tab set  cod_memo = cod_memo::numeric + 1
where   id_canal = piinidcanal
and     num_anio =  piinnumanio;
exception when no_data_found then
insert into admp.admp_memo_cod_tab(id_memo_cod,
num_anio,
id_canal,
cod_memo,
num_created_by,
fec_creation_date,
num_last_update,
fec_last_update,
num_last_update_login)
values (0,
piinnumanio,
piinidcanal,
1,
0,
clock_timestamp(),
0,
clock_timestamp(),
0);
poinnumcodigo := 1;
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001'
;/* dmap converted statement end */end;
$body$
language plpgsql
;
