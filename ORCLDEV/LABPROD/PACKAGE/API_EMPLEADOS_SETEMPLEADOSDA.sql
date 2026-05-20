create or replace procedure labprod.api_empleados_setempleadosda ( id_transaccion varchar, dat_keyemp integer, dat_keypar varchar, dat_valpar varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
band numeric;
bandemp numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
code := '1';
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
if code = '1' then
begin
insert into labprod.api_empleadosda(id_transaccion,dat_keyemp,dat_keypar,dat_valpar,status,code,message,fecha)
values (id_transaccion,dat_keyemp,dat_keypar,dat_valpar,'PENDIENTE','0','PENDIENTE A PROCESAR',clock_timestamp());
/* commit; */
select count(*) into strict band from labprod.nmlodata where nmlodata.dat_keyemp=setempleadosda.dat_keyemp and nmlodata.dat_keypar=setempleadosda.dat_keypar;
if band = 1 then
update labprod.nmlodata set nmlodata.dat_valpar=setempleadosda.dat_valpar,nmlodata.dat_keypar=setempleadosda.dat_keypar
where nmlodata.dat_keyemp=setempleadosda.dat_keyemp and nmlodata.dat_keypar=setempleadosda.dat_keypar;
/* commit; */
update  labprod.api_empleadosda set status='OK', message = 'Se proces?? con ??xito', code='3' where id_transaccion=setempleadosda.id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proces?? con ??xito';
end if;
if band = 0 then
insert into labprod.nmlodata(dat_keyemp,dat_keypar,dat_valpar) values (dat_keyemp,dat_keypar,dat_valpar);
/* commit; */
update  labprod.api_empleadosda set status='OK', message = 'Se proces?? con ??xito', code='3' where id_transaccion=setempleadosda.id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proces?? con ??xito';
end if;
if dat_keypar = '133' then
update labprod.nmcoempl set emp_pobemp = dat_valpar where emp_keyemp = dat_keyemp;
end if;
exception when others then
begin
status := 'ERROR';
code :=  sqlstate;
message := oracle.substr(sqlerrm, 1 , 149);
end;
end;
end if;
end if;end;
$body$
language plpgsql
;
