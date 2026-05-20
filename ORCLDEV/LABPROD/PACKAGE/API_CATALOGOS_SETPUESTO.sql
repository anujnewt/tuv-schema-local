create or replace procedure labprod.api_catalogos_setpuesto ( id_transaccion varchar, pue_keypue varchar, pue_despue varchar, pue_refcon varchar, pue_nu1aux varchar, pue_nu2aux varchar, pue_nu3aux varchar, pue_nu4aux varchar, pue_nu5aux varchar, pue_ca1aux varchar, pue_ca2aux varchar, pue_ca3aux varchar, pue_ca4aux varchar, pue_ca5aux varchar, pue_sueniv numeric, pue_subniv numeric, pue_keysue varchar, pue_cobert varchar, pue_arepue varchar, pue_subare varchar , pue_nivpue numeric, pue_grppue varchar, pue_subgrp varchar, pue_tippue varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
bandpues numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
if id_transaccion = '0' then
status:= 'OK';
code := '0';
message:= 'PRUEBA DE SERVICIO';
else
status := 'ok';
code := '1';
if length(pue_keypue) >	16	then message:='PUE_KEYPUE LONGITUD MAYOR A 16'; status := 'ERROR'; code := '4'; end if;
if length(pue_despue) >	60	then message:='PUE_DESPUE LONGITUD MAYOR A 60'; status := 'ERROR'; code := '4'; end if;
if length(pue_refcon) >	20	then message:='PUE_REFCON LONGITUD MAYOR A 20'; status := 'ERROR'; code := '4'; end if;
if length(pue_nu1aux) >  10	then message:='PUE_NU1AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_nu2aux) >	10	then message:='PUE_NU2AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_nu3aux) >	10	then message:='PUE_NU3AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_nu4aux) >	10	then message:='PUE_NU4AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_nu5aux) >	10	then message:='PUE_NU5AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_ca1aux) >	10	then message:='PUE_CA1AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_ca2aux) >	10	then message:='PUE_CA2AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_ca3aux) >	10	then message:='PUE_CA3AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_ca4aux) >	10	then message:='PUE_CA4AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_ca5aux) >	10	then message:='PUE_CA5AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(pue_keysue) >	4	then message:='PUE_KEYSUE LONGITUD MAYOR A 4';  status := 'ERROR'; code := '4'; end if;
if length(pue_cobert) >	2	then message:='PUE_COBERT LONGITUD MAYOR A 2';  status := 'ERROR'; code := '4'; end if;
if length(pue_arepue) >	6	then message:='PUE_AREPUE LONGITUD MAYOR A 6';  status := 'ERROR'; code := '4'; end if;
if length(pue_subare) >	6	then message:='PUE_SUBARE LONGITUD MAYOR A 6';  status := 'ERROR'; code := '4'; end if;
if length(pue_grppue) >	16	then message:='PUE_GRPPUE LONGITUD MAYOR A 16'; status := 'ERROR'; code := '4'; end if;
if length(pue_subgrp) >	16	then message:='PUE_SUBGRP LONGITUD MAYOR A 16'; status := 'ERROR'; code := '4'; end if;
if length(pue_tippue) >	2	then message:='PUE_TIPPUE LONGITUD MAYOR A 2';  status := 'ERROR'; code := '4'; end if;
if code = '1' then
insert into api_puesto(id_transaccion,pue_keypue ,pue_despue ,pue_refcon ,pue_nu1aux ,pue_nu2aux ,pue_nu3aux ,pue_nu4aux ,pue_nu5aux ,pue_ca1aux ,pue_ca2aux ,pue_ca3aux ,pue_ca4aux ,pue_ca5aux ,
pue_sueniv ,pue_subniv ,pue_keysue ,pue_cobert ,pue_arepue ,pue_subare ,pue_nivpue ,
pue_grppue ,pue_subgrp ,pue_tippue,status,code,message,fecha,fecha_insert,fecha_proc)
values (id_transaccion,pue_keypue ,pue_despue ,pue_refcon ,pue_nu1aux ,pue_nu2aux ,pue_nu3aux ,
pue_nu4aux ,pue_nu5aux ,pue_ca1aux ,pue_ca2aux ,pue_ca3aux ,pue_ca4aux ,pue_ca5aux ,
pue_sueniv ,pue_subniv ,pue_keysue ,pue_cobert ,pue_arepue ,pue_subare ,pue_nivpue ,
pue_grppue ,pue_subgrp ,pue_tippue ,'PENDIENTE','0','PENDIENTE A PROCESAR',clock_timestamp(),clock_timestamp(),clock_timestamp());
/* commit; */
begin
select count(*) into strict bandpues from labprod.nmcopues where nmcopues.pue_keypue= setpuesto.pue_keypue;
if bandpues = 1 then
update labprod.nmcopues set
nmcopues.pue_despue = setpuesto.pue_despue,
nmcopues.pue_refcon = setpuesto.pue_refcon,
nmcopues.pue_nu1aux = setpuesto.pue_nu1aux,
nmcopues.pue_nu2aux = setpuesto.pue_nu2aux,
nmcopues.pue_nu3aux = setpuesto.pue_nu3aux,
nmcopues.pue_nu4aux = setpuesto.pue_nu4aux,
nmcopues.pue_nu5aux = setpuesto.pue_nu5aux,
nmcopues.pue_ca1aux = setpuesto.pue_ca1aux,
nmcopues.pue_ca2aux = setpuesto.pue_ca2aux,
nmcopues.pue_ca3aux = setpuesto.pue_ca3aux,
nmcopues.pue_ca4aux = setpuesto.pue_ca4aux,
nmcopues.pue_ca5aux = setpuesto.pue_ca5aux,
nmcopues.pue_sueniv = setpuesto.pue_sueniv,
nmcopues.pue_subniv = setpuesto.pue_subniv,
nmcopues.pue_keysue = setpuesto.pue_keysue,
nmcopues.pue_cobert = setpuesto.pue_cobert,
nmcopues.pue_arepue = setpuesto.pue_arepue,
nmcopues.pue_subare = setpuesto.pue_subare,
nmcopues.pue_nivpue = setpuesto.pue_nivpue,
nmcopues.pue_grppue = setpuesto.pue_grppue,
nmcopues.pue_subgrp = setpuesto.pue_subgrp,
nmcopues.pue_tippue = setpuesto.pue_tippue
where nmcopues.pue_keypue=setpuesto.pue_keypue;
/* commit; */
update  api_puesto set status='OK', message ='Se proceso con exito', code= '3'
where api_puesto.id_transaccion=id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proceso con exito';
end if;
if bandpues = 0 then
insert into nmcopues(pue_keypue,pue_despue,pue_refcon,pue_nu1aux,pue_nu2aux,pue_nu3aux,pue_nu4aux,pue_nu5aux,
pue_ca1aux,pue_ca2aux,pue_ca3aux,pue_ca4aux,pue_ca5aux,pue_sueniv,pue_subniv,pue_keysue,pue_cobert,pue_arepue,pue_subare,
pue_nivpue,pue_grppue,pue_subgrp,pue_tippue)
values (pue_keypue ,pue_despue ,pue_refcon ,pue_nu1aux ,pue_nu2aux ,pue_nu3aux ,pue_nu4aux ,pue_nu5aux ,
pue_ca1aux ,pue_ca2aux ,pue_ca3aux ,pue_ca4aux ,pue_ca5aux ,pue_sueniv ,pue_subniv ,pue_keysue ,
pue_cobert ,pue_arepue ,pue_subare ,pue_nivpue ,pue_grppue ,pue_subgrp ,pue_tippue);
/* commit; */
update  api_puesto set status='OK', message ='Se proceso con exito', code= '3' where api_puesto.id_transaccion=id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proceso con exito';
end if;
/* commit; */
exception   when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 149);
end;
end if;
end if;
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 149);end;
$body$
language plpgsql
;
