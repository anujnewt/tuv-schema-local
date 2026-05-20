create or replace procedure labprod.api_catalogos_setdepartamento ( id_transaccion varchar, dep_keydep varchar, dep_desdep varchar, dep_refcon varchar, dep_keycen varchar, dep_tipdep varchar, dep_nu1aux varchar, dep_nu2aux varchar, dep_nu3aux varchar, dep_nu4aux varchar, dep_nu5aux varchar, dep_ca1aux varchar, dep_ca2aux varchar, dep_ca3aux varchar, dep_ca4aux varchar, dep_ca5aux varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
banddeps numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
status := 'OK';
code := '1';
if length(dep_keydep)>	16 then message := 'DEP_KEYDEP LONGITUD MAYOR A 16'; status := 'ERROR'; code := '4'; end if;
if length(dep_desdep)>	40 then message := 'DEP_DESDEP LONGITUD MAYOR A 40'; status := 'ERROR'; code := '4'; end if;
if length(dep_refcon)>	52 then message := 'DEP_REFCON LONGITUD MAYOR A 52'; status := 'ERROR'; code := '4'; end if;
if length(dep_keycen)>  16 then message := 'DEP_KEYCEN LONGITUD MAYOR A 16'; status := 'ERROR'; code := '4'; end if;
if length(dep_tipdep)>	1  then message := 'DEP_TIPDEP LONGITUD MAYOR A 16'; status := 'ERROR'; code := '4'; end if;
if length(dep_nu1aux) >	10 then	message := 'DEP_NU1AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_nu2aux) >	10 then message := 'DEP_NU2AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_nu3aux) >	10 then message := 'DEP_NU3AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_nu4aux) >	10 then	message := 'DEP_NU4AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_nu5aux) >	10 then	message := 'DEP_NU5AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_ca1aux) > 10 then message := 'DEP_CA1AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_ca2aux)>	10 then message := 'DEP_CA2AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_ca3aux) >	10 then message := 'DEP_CA3AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_ca4aux) >	10 then message := 'DEP_CA4AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if length(dep_ca5aux) >	10 then message := 'DEP_CA5AUX LONGITUD MAYOR A 10'; status := 'ERROR'; code := '4'; end if;
if  code = '1' then
begin
insert into labprod.api_departamento(
id_transaccion,
dep_keydep ,dep_desdep ,dep_refcon ,dep_keycen ,dep_tipdep ,dep_nu1aux ,
dep_nu2aux ,dep_nu3aux ,dep_nu4aux ,dep_nu5aux ,dep_ca1aux ,dep_ca2aux ,
dep_ca3aux ,dep_ca4aux ,dep_ca5aux ,status,code,message,fecha,fecha_insert,fecha_proc)
values (
id_transaccion,
dep_keydep ,dep_desdep ,dep_refcon ,dep_keycen ,dep_tipdep ,dep_nu1aux ,
dep_nu2aux ,dep_nu3aux ,dep_nu4aux ,dep_nu5aux ,dep_ca1aux ,dep_ca2aux ,
dep_ca3aux ,dep_ca4aux ,dep_ca5aux ,'PENDIENTE','1','PENDIENTE A PROCESAR',
clock_timestamp(),clock_timestamp(),clock_timestamp());
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1, 149);
end;
begin
select count(*) into strict banddeps from labprod.nmcodeps where dep_keydep = setdepartamento.dep_keydep;
if  banddeps = 1 then
update nmcodeps set
nmcodeps.dep_desdep =setdepartamento.dep_desdep ,
nmcodeps.dep_refcon =setdepartamento.dep_refcon ,
nmcodeps.dep_keycen =setdepartamento.dep_keycen ,
nmcodeps.dep_tipdep =setdepartamento.dep_tipdep ,
nmcodeps.dep_nu1aux =setdepartamento.dep_nu1aux ,
nmcodeps.dep_nu2aux =setdepartamento.dep_nu2aux ,
nmcodeps.dep_nu3aux =setdepartamento.dep_nu3aux ,
nmcodeps.dep_nu4aux =setdepartamento.dep_nu4aux ,
nmcodeps.dep_nu5aux =setdepartamento.dep_nu5aux ,
nmcodeps.dep_ca1aux =setdepartamento.dep_ca1aux ,
nmcodeps.dep_ca2aux =setdepartamento.dep_ca2aux ,
nmcodeps.dep_ca3aux =setdepartamento.dep_ca3aux ,
nmcodeps.dep_ca4aux =setdepartamento.dep_ca4aux ,
nmcodeps.dep_ca5aux =setdepartamento.dep_ca5aux
where nmcodeps.dep_keydep =setdepartamento.dep_keydep;
/* commit; */
update  api_departamento set status='OK' , message='Se proceso con exito', code ='3'
where api_departamento.id_transaccion=setdepartamento.id_transaccion;
/* commit; */
status := 'OK';
code := '3';
message :='Se proceso con exito';
end if;
if banddeps = 0 then
insert into nmcodeps(
dep_keydep,dep_desdep,dep_refcon,dep_keycen,dep_tipdep,dep_nu1aux,dep_nu2aux,dep_nu3aux,dep_nu4aux,dep_nu5aux,
dep_ca1aux,dep_ca2aux,dep_ca3aux,dep_ca4aux,dep_ca5aux)
values (
dep_keydep ,dep_desdep ,dep_refcon ,dep_keycen ,dep_tipdep ,dep_nu1aux ,dep_nu2aux ,dep_nu3aux ,dep_nu4aux ,dep_nu5aux ,
dep_ca1aux ,dep_ca2aux ,dep_ca3aux ,dep_ca4aux ,dep_ca5aux  );
/* commit; */
update  api_departamento set status='OK' , message='Se proceso con exito', code ='3'
where api_departamento.id_transaccion=setdepartamento.id_transaccion;
/* commit; */
status := 'OK';
code := '3';
message :='Se proceso con exito';
end if;
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1, 149);
end;
end if;
end if;
exception when others then
status := 'ERROR';
code  := sqlstate;
message := oracle.substr(sqlerrm, 1 , 149);end;
$body$
language plpgsql
;
