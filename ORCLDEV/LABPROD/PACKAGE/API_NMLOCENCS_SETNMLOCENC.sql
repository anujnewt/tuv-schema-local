create or replace procedure labprod.api_nmlocencs_setnmlocenc ( id_transaccion varchar, cen_keycen varchar, cen_descen varchar, cen_refcon varchar, cen_nu1aux varchar, cen_nu2aux varchar, cen_nu3aux varchar, cen_nu4aux varchar, cen_nu5aux varchar, cen_ca1aux varchar, cen_ca2aux varchar, cen_ca3aux varchar, cen_ca4aux varchar, cen_ca5aux varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
centrocosto numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
if id_transaccion = '0' then
fecha := clock_timestamp();
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
begin
status := 'OK';
code := '1';
message := 'SE INSERTO EN STAGGIN CON EXITO';
if  length(cen_keycen) > 16 then
message:= 'CEN_KEYCEN  LONGITUD MAYOR A 16 ';
status := 'ERROR';
code := '4';
end if;
if  length(cen_descen) > 40 then
message:= 'CEN_DESCEN LONGITUD MAYOR A 40 ';
status := 'ERROR';
code := '4';
end if;
if code = '1' then
begin
insert into labprod.api_nmlocenc(id_transaccion,cen_keycen,cen_descen,cen_refcon,cen_nu1aux,cen_nu2aux,cen_nu3aux,cen_nu4aux,cen_nu5aux,cen_ca1aux,cen_ca2aux,cen_ca3aux,cen_ca4aux,cen_ca5aux,
fecha_insert,estatus,code,message)
values (id_transaccion,cen_keycen,cen_descen,cen_refcon,cen_nu1aux,cen_nu2aux,cen_nu3aux,cen_nu4aux,cen_nu5aux,cen_ca1aux,cen_ca2aux,cen_ca3aux,cen_ca4aux,cen_ca5aux
,fecha,status,code,message);
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 150);
/* commit; */
end;
select count(*) into strict centrocosto from labprod.nmlocenc where nmlocenc.cen_keycen = setnmlocenc.cen_keycen;
if  centrocosto = 0  then
begin
insert into labprod.nmlocenc(cen_keycen,cen_descen,cen_refcon,cen_nu1aux,cen_nu2aux,cen_nu3aux,cen_nu4aux,cen_nu5aux,cen_ca1aux,cen_ca2aux,cen_ca3aux,cen_ca4aux,cen_ca5aux)
values (setnmlocenc.cen_keycen,setnmlocenc.cen_descen,setnmlocenc.cen_refcon,setnmlocenc.cen_nu1aux,setnmlocenc.cen_nu2aux,setnmlocenc.cen_nu3aux,
call setnmlocenc.cen_nu4aux,setnmlocenc.cen_nu5aux,setnmlocenc.cen_ca1aux,setnmlocenc.cen_ca2aux,setnmlocenc.cen_ca3aux,setnmlocenc.cen_ca4aux,setnmlocenc.cen_ca5aux);
/* commit; */
status := 'OK';
code := '3';
message := 'Se proceso con exito';
update labprod.api_nmlocenc set estatus=setnmlocenc.status,code=setnmlocenc.code,message=setnmlocenc.message,fecha_proc=clock_timestamp() where api_nmlocenc.id_transaccion =setnmlocenc.id_transaccion;
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 150);
update labprod.api_nmlocenc set estatus=setnmlocenc.status,code=setnmlocenc.code,message=setnmlocenc.message,fecha_proc=clock_timestamp() where api_nmlocenc.id_transaccion =setnmlocenc.id_transaccion;
/* commit; */
end;
end if;
if centrocosto > 0 then
begin
update labprod.nmlocenc set
cen_keycen =setnmlocenc.cen_keycen,
cen_descen =setnmlocenc.cen_descen,
cen_refcon =setnmlocenc.cen_refcon,
cen_nu1aux =setnmlocenc.cen_nu1aux,
cen_nu2aux =setnmlocenc.cen_nu2aux,
cen_nu3aux =setnmlocenc.cen_nu3aux,
cen_nu4aux =setnmlocenc.cen_nu4aux,
cen_nu5aux =setnmlocenc.cen_nu5aux,
cen_ca1aux =setnmlocenc.cen_ca1aux,
cen_ca2aux =setnmlocenc.cen_ca2aux,
cen_ca3aux =setnmlocenc.cen_ca3aux,
cen_ca4aux =setnmlocenc.cen_ca4aux,
cen_ca5aux =setnmlocenc.cen_ca5aux
where cen_keycen =setnmlocenc.cen_keycen;
status := 'OK';
code := '3';
message := 'Se proceso con exito';
update labprod.api_nmlocenc set api_nmlocenc.estatus=setnmlocenc.status,api_nmlocenc.code=setnmlocenc.code,api_nmlocenc.message=setnmlocenc.message,fecha_proc=clock_timestamp() where api_nmlocenc.id_transaccion =setnmlocenc.id_transaccion;
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 150);
--update labprod.api_nmlocenc set api_nmlocenc.estatus=setnmlocenc.status,api_nmlocenc.code=setnmlocenc.code,api_nmlocenc.message=setnmlocenc.message,fecha_proc=sysdate where api_nmlocenc.id_transaccion = setnmlocenc.id_transaccion;
/* commit; */
end;
end if;
end if;
end;
end if;end;
$body$
language plpgsql
;
