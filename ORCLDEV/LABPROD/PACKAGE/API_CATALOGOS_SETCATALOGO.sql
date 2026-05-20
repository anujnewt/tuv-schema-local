create or replace procedure labprod.api_catalogos_setcatalogo ( id_transaccion varchar, pam_keypar varchar, pam_cvesec varchar, pam_nompar varchar, pam_folini varchar, pam_folfin varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_code numeric;
v_errm varchar(64);
valor varchar(6);
keypar varchar(4);
band varchar(6);
folini varchar(2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
folini:= oracle.substr(setcatalogo.pam_cvesec,1,2);
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
status := 'OK';
code := '1';
if length(pam_keypar) > 4   then message := 'PAM_KEYPAR LONGITUD MAYOR A 4 ';   status := 'ERROR'; code := '4'; end if;
if length(pam_cvesec) > 6   then message := 'PAM_CVESEC LONGITUD MAYOR A 6 ';   status := 'ERROR'; code := '4'; end if;
if length(pam_nompar) > 100 then message := 'PAM_NOMPAR LONGITUD MAYOR A 100';  status := 'ERROR'; code := '4'; end if;
if length(pam_folini) > 100 then message := 'PAM_FOLINI LONGITUD MAYOR A 100';  status := 'ERROR'; code := '4'; end if;
if length(pam_folfin) > 100 then message := 'PAM_FOLFIN LONGITUD MAYOR A 100';  status := 'ERROR'; code := '4'; end if;
if code = '1' then
insert into api_catalogo(
id_transaccion,pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin,fecha_insert,fecha_proc,
status,code,message)
values (
id_transaccion,pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin,clock_timestamp(),clock_timestamp(),'OK','1','PENDIENTE A PROCESAR');
/* commit; */
status := 'OK';
code := '1';
message := ' Se inserto a staging con exito.';
--escoger la clave de la tabla
begin
if  pam_keypar != 'EF' and
pam_keypar != 'MU' and
pam_keypar != 'FP' and
pam_keypar != 'TD' and
pam_keypar != 'IEST'
then
status := 'ERROR';
code := '02';/* dmap converted statement start */
message := ( concat('La clave del catalogo  ', setcatalogo.pam_keypar , '  no es una de las claves para esta interface')) ;/* dmap converted statement end */
update api_catalogo set status=setcatalogo.status, message=setcatalogo.message, code=setcatalogo.code,fecha_proc=clock_timestamp() where api_catalogo.id_transaccion=setcatalogo.id_transaccion;
/* commit; */
else
select count(*)  into strict band from labprod.glcopams where  pam_keypar = setcatalogo.pam_keypar and pam_cvesec=setcatalogo.pam_cvesec;
if  band = 0  then
if pam_keypar = 'MU' then
insert into glcopams(pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin)
values (pam_keypar,pam_cvesec,pam_nompar,folini,pam_folfin);
/* commit; */
update api_catalogo
set status='ok' ,message='Se proceso con exito', code='3',fecha_proc=clock_timestamp()
where  api_catalogo.id_transaccion=setcatalogo.id_transaccion;
/* commit; */
status := 'OK';
code := '3';
message := 'Se proceso con exito';
else
insert into glcopams(pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin)
values (pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin);
/* commit; */
update api_catalogo set status='ok' ,message='Se proceso con exito', code='3',fecha_proc=clock_timestamp()
where  api_catalogo.id_transaccion=setcatalogo.id_transaccion;
/* commit; */
status := 'OK';
code := '3';
message := 'Se proceso con exito';
end if;
end if;
if   band > 0  then
if pam_keypar = 'MU' then
update glcopams set pam_nompar = setcatalogo.pam_nompar, pam_folini = folini
--, pam_folfin = setcatalogo.pam_folfin
where pam_keypar = setcatalogo.pam_keypar and pam_cvesec = setcatalogo.pam_cvesec;
/* commit; */
update api_catalogo  set status='ok' ,message='Se proceso con exito',
code='3' where  api_catalogo.id_transaccion=setcatalogo.id_transaccion;
perform dbms_output.put_line('Modifica en api_catalogo MU ');
/* commit; */
status := 'OK';
code := '3';
message := 'Se proceso con exito';
else
update glcopams set pam_nompar = setcatalogo.pam_nompar
where pam_keypar = setcatalogo.pam_keypar and pam_cvesec = setcatalogo.pam_cvesec;
/* commit; */
update api_catalogo  set status='ok' ,message='Se proceso con exito',
code='3' where  api_catalogo.id_transaccion=setcatalogo.id_transaccion;
/* commit; */
status := 'OK';
code := '3';
message := 'Se proceso con exito';
end if;
end if;
end if;
exception when others then
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
