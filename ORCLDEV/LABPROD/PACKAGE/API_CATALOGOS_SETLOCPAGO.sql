create or replace procedure labprod.api_catalogos_setlocpago ( id_transaccion varchar, loc_keyloc varchar, loc_desloc varchar, loc_domloc varchar, loc_colloc varchar, loc_ciuloc varchar, loc_estloc varchar, loc_codpos varchar, loc_lardis varchar, loc_teluno varchar, loc_teldos varchar, loc_teltre varchar, loc_cvezon numeric, loc_reggeo varchar, loc_keyban varchar, loc_keysuc varchar, loc_ca1aux varchar, loc_ca2aux varchar, loc_ca3aux varchar, loc_ca4aux varchar, loc_ca5aux varchar, loc_refcon varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
bandloc numeric;
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
if length(loc_keyloc) >	16 then message := 'LOC_KEYLOC LONGITUD MAYOR A 12 '; status := 'ERROR'; code := '4'; end if;
if length(loc_desloc) >	40 then message := 'LOC_DESLOC LONGITUD MAYOR A 40 '; status := 'ERROR'; code := '4'; end if;
if length(loc_domloc) >	30 then message := 'LOC_DOMLOC LONGITUD MAYOR A 30 '; status := 'ERROR'; code := '4'; end if;
if length(loc_colloc) >	20 then message := 'LOC_COLLOC LONGITUD MAYOR A 20 '; status := 'ERROR'; code := '4'; end if;
if length(loc_ciuloc) >	6  then message := 'LOC_CIULOC LONGITUD MAYOR A 6 ';  status := 'ERROR'; code := '4'; end if;
if length(loc_estloc) >	6  then message := 'LOC_ESTLOC LONGITUD MAYOR A 6 ';  status := 'ERROR'; code := '4'; end if;
if length(loc_codpos) >	6  then message := 'LOC_CODPOS LONGITUD MAYOR A 6  '; status := 'ERROR'; code := '4'; end if;
if length(loc_lardis) >	5  then message := 'LOC_LARDIS LONGITUD MAYOR A 5';   status := 'ERROR'; code := '4'; end if;
if length(loc_teluno) >	10 then message := 'LOC_TELUNO LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_teldos) >	10 then message := 'LOC_TELDOS LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_teltre) >	10 then message := 'LOC_TELTRE LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_reggeo) >	10 then message := 'LOC_REGGEO LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_keyban) >	3  then message := 'LOC_KEYBAN LONGITUD MAYOR A 3 ';  status := 'ERROR'; code := '4'; end if;
if length(loc_keysuc) >	4  then message := 'LOC_KEYSUC LONGITUD MAYOR A 4 ';  status := 'ERROR'; code := '4'; end if;
if length(loc_ca1aux) >	10 then message := 'LOC_CA1AUX LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_ca2aux) >	10 then message := 'LOC_CA2AUX LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_ca3aux) >	10 then message := 'LOC_CA3AUX LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_ca4aux) >	10 then message := 'LOC_CA4AUX LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_ca5aux) >	10 then message := 'LOC_CA5AUX LONGITUD MAYOR A 10 '; status := 'ERROR'; code := '4'; end if;
if length(loc_refcon) >	30 then message := 'LOC_REFCON LONGITUD MAYOR A 30 '; status := 'ERROR'; code := '4'; end if;
if  code = '1' then
insert into api_locpago(id_transaccion,loc_keyloc,loc_desloc,loc_domloc,loc_colloc,loc_ciuloc,
loc_estloc,loc_codpos ,loc_lardis,loc_teluno,loc_teldos,loc_teltre,
loc_cvezon,loc_reggeo,loc_keyban,loc_keysuc,loc_ca1aux,loc_ca2aux,loc_ca3aux,
loc_ca4aux,loc_ca5aux,loc_refcon,status,code,message,fecha,fecha_insert,fecha_proc)
values (id_transaccion,loc_keyloc,loc_desloc,loc_domloc,loc_colloc,loc_ciuloc,
loc_estloc,loc_codpos,loc_lardis,loc_teluno,loc_teldos,loc_teltre,loc_cvezon,
loc_reggeo,loc_keyban,loc_keysuc,loc_ca1aux,loc_ca2aux,loc_ca3aux,loc_ca4aux,
loc_ca5aux,loc_refcon,'PENDIENTE','0','PENDIENTE A PROCESAR',clock_timestamp(),clock_timestamp(),clock_timestamp());
/* commit; */
begin
select count(*) into strict bandloc from nmlolocp  where loc_keyloc = setlocpago.loc_keyloc;
if  bandloc = 1 then
update nmlolocp set
nmlolocp.loc_desloc =setlocpago.loc_desloc
where nmlolocp.loc_keyloc=setlocpago.loc_keyloc;
commit work;
update  api_locpago set status='OK', message='Se proceso con exito', code='3'
where api_locpago.id_transaccion=setlocpago.id_transaccion;
perform dbms_output.put_line('api_locpago');
/* commit; */
status:= 'OK';
code:='3';
message:='Se proceso con exito';
end if;
if bandloc = 0 then
insert into nmlolocp(loc_keyloc,loc_desloc,loc_domloc,loc_colloc,loc_ciuloc,loc_estloc,loc_codpos,loc_lardis,
loc_teluno,loc_teldos,loc_teltre,loc_cvezon,loc_reggeo,loc_keyban,loc_keysuc,loc_ca1aux,loc_ca2aux,loc_ca3aux,
loc_ca4aux,loc_ca5aux,loc_refcon)
values (
loc_keyloc,loc_desloc,loc_domloc,loc_colloc,loc_ciuloc,loc_estloc,loc_codpos ,loc_lardis  ,
loc_teluno,loc_teldos,loc_teltre,loc_cvezon,loc_reggeo,loc_keyban,loc_keysuc,loc_ca1aux,
loc_ca2aux,loc_ca3aux,loc_ca4aux,loc_ca5aux,loc_refcon );
/* commit; */
update  api_locpago set status='OK', message='Se proceso con exito', code='3'
where api_locpago.id_transaccion=setlocpago.id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proceso con exito';
end if;
/* commit; */
exception when others then
status := 'ERROR';
code :=sqlstate;
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
