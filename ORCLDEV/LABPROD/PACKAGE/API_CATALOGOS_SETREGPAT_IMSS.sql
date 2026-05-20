create or replace procedure labprod.api_catalogos_setregpat_imss ( id_transaccion varchar, ims_keyims varchar, ims_rfcims varchar, ims_razsoc varchar, ims_dirloc varchar, ims_numext varchar, ims_numint varchar, ims_colloc varchar, ims_codpos varchar, ims_munloc varchar, ims_entloc varchar, ims_numban varchar, ims_pririe numeric, ims_tiprie varchar, ims_luggui numeric, ims_actloc varchar, ims_keyban varchar, ims_numcot numeric, ims_bascal numeric, ims_totpag numeric, ims_keycia varchar, ims_cveedi varchar, ims_ca1aux varchar, ims_ca2aux varchar, ims_ca3aux varchar, ims_ca4aux varchar, ims_franum varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
bandimss numeric;
keyimss numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
status:='OK';
code:='1';
if length(ims_keyims)	>	14 then message := 'IMS_KEYIMS LONGITUD MAYOR A 14';  status := 'ERROR'; code := '4';  end if;
if length(ims_rfcims)	>	14 then message := 'IMS_RFCIMS LONGITUD MAYOR A 14 '; status := 'ERROR'; code := '4';  end if;
if length(ims_razsoc)	>	40 then message := 'IMS_RAZSOC LONGITUD MAYOR A 40';  status := 'ERROR'; code := '4';  end if;
if length(ims_dirloc)	>	40 then message := 'IMS_DIRLOC LONGITUD MAYOR A 40';  status := 'ERROR'; code := '4';  end if;
if length(ims_numext)	>	6  then message := 'IMS_NUMEXT LONGITUD MAYOR A 6';   status := 'ERROR'; code := '4';  end if;
if length(ims_numint)	>	6  then message := 'IMS_NUMINT LONGITUD MAYOR A 6';   status := 'ERROR'; code := '4';  end if;
if length(ims_colloc)	>	20 then message := 'IMS_COLLOC LONGITUD MAYOR A 20';  status := 'ERROR'; code := '4';  end if;
if length(ims_codpos)	>	5  then message := 'IMS_CODPOS LONGITUD MAYOR A 5';   status := 'ERROR'; code := '4';  end if;
if length(ims_munloc)	>	6  then message := 'IMS_MUNLOC LONGITUD MAYOR A 6';   status := 'ERROR'; code := '4';  end if;
if length(ims_entloc)	>	2  then message := 'IMS_ENTLOC LONGITUD MAYOR A 2';   status := 'ERROR'; code := '4';  end if;
if length(ims_numban)	>	20 then message := 'IMS_NUMBAN LONGITUD MAYOR A 20';  status := 'ERROR'; code := '4';  end if;
if length(ims_tiprie)	>	12 then message := 'IMS_TIPRIE LONGITUD MAYOR A 12';  status := 'ERROR'; code := '4';  end if;
if length(ims_actloc)	>	24 then message := 'IMS_ACTLOC LONGITUD MAYOR A 24';  status := 'ERROR'; code := '4';  end if;
if length(ims_keyban)	>	7  then message := 'IMS_KEYBAN LONGITUD MAYOR A 7';   status := 'ERROR'; code := '4';  end if;
if length(ims_keycia)	>	2  then message := 'IMS_KEYCIA LONGITUD MAYOR A 2';   status := 'ERROR'; code := '4';  end if;
if length(ims_cveedi)	>	16 then message := 'IMS_CVEEDI LONGITUD MAYOR A 16';  status := 'ERROR'; code := '4';  end if;
if length(ims_ca1aux)	>	30 then message := 'IMS_CA1AUX LONGITUD MAYOR A 30';  status := 'ERROR'; code := '4';  end if;
if length(ims_ca2aux)	>	20 then message := 'IMS_CA2AUX LONGITUD MAYOR A 20 '; status := 'ERROR'; code := '4';  end if;
if length(ims_ca3aux)	>	20 then message := 'IMS_CA3AUX LONGITUD MAYOR A 20';  status := 'ERROR'; code := '4';  end if;
if length(ims_ca4aux)	>	20 then message := 'IMS_CA4AUXLONGITUD MAYOR A 20';   status := 'ERROR'; code := '4';  end if;
if length(ims_franum)	>	8  then message := 'IMS_FRANUM LONGITUD MAYOR A 8';   status := 'ERROR'; code := '4';  end if;
if code = '1' then
insert into api_regpat_imss(id_transaccion,ims_keyims,ims_rfcims,ims_razsoc,ims_dirloc,ims_numext,
ims_numint,ims_colloc,ims_codpos,ims_munloc,ims_entloc,ims_numban,ims_pririe,
ims_tiprie,ims_luggui,ims_actloc,ims_keyban,ims_numcot,ims_bascal,ims_totpag,ims_keycia,
ims_cveedi,ims_ca1aux,ims_ca2aux,ims_ca3aux,ims_ca4aux,ims_franum,
status,code,message,fecha,fecha_insert,fecha_proc)
values (
id_transaccion,
ims_keyims,ims_rfcims,oracle.substr(ims_razsoc,1,40),ims_dirloc,ims_numext,ims_numint,ims_colloc,
ims_codpos,ims_munloc,ims_entloc,ims_numban,ims_pririe,ims_tiprie,ims_luggui,
ims_actloc,ims_keyban,ims_numcot,ims_bascal,ims_totpag,ims_keycia,
ims_cveedi,ims_ca1aux,ims_ca2aux,ims_ca3aux,ims_ca4aux,ims_franum,
'PENDIENTE','0','PENDIENTE A PROCESAR',clock_timestamp(),clock_timestamp(),clock_timestamp());
/* commit; */
begin
select count(*)  into strict bandimss from  nmloimss where nmloimss.ims_rfcims = setregpat_imss.ims_rfcims;
if bandimss = 1 then
update  nmloimss  set
nmloimss.ims_keyims=nmloimss.ims_keyims,
nmloimss.ims_rfcims=setregpat_imss.ims_rfcims,
nmloimss.ims_razsoc=oracle.substr(setregpat_imss.ims_razsoc,1,40),
nmloimss.ims_dirloc=setregpat_imss.ims_dirloc,
nmloimss.ims_numext=setregpat_imss.ims_numext,
nmloimss.ims_numint=setregpat_imss.ims_numint,
nmloimss.ims_colloc=setregpat_imss.ims_colloc,
nmloimss.ims_codpos=setregpat_imss.ims_codpos,
nmloimss.ims_munloc=setregpat_imss.ims_munloc,
nmloimss.ims_entloc=setregpat_imss.ims_entloc,
nmloimss.ims_numban=setregpat_imss.ims_numban,
nmloimss.ims_pririe=setregpat_imss.ims_pririe,
nmloimss.ims_tiprie=setregpat_imss.ims_tiprie,
nmloimss.ims_luggui=setregpat_imss.ims_luggui,
nmloimss.ims_actloc=setregpat_imss.ims_actloc,
nmloimss.ims_keyban=setregpat_imss.ims_keyban,
nmloimss.ims_numcot=setregpat_imss.ims_numcot,
nmloimss.ims_bascal=setregpat_imss.ims_bascal,
nmloimss.ims_totpag=setregpat_imss.ims_totpag,
nmloimss.ims_keycia=setregpat_imss.ims_keycia,
nmloimss.ims_cveedi=setregpat_imss.ims_cveedi,
nmloimss.ims_ca1aux=setregpat_imss.ims_ca1aux,
nmloimss.ims_ca2aux=setregpat_imss.ims_ca2aux,
nmloimss.ims_ca3aux=setregpat_imss.ims_ca3aux,
nmloimss.ims_ca4aux=setregpat_imss.ims_ca4aux,
nmloimss.ims_franum=setregpat_imss.ims_franum
where nmloimss.ims_rfcims=setregpat_imss.ims_rfcims;
/* commit; */
update  api_regpat_imss set status='OK', message='Se proceso con exito', code='3'
where  api_regpat_imss.id_transaccion=setregpat_imss.id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proceso con exito';
end if;
if bandimss = 0 then
insert into nmloimss(
ims_keyims,ims_rfcims,ims_razsoc,ims_dirloc,
ims_numext,ims_numint,ims_colloc,ims_codpos,
ims_munloc,ims_entloc,ims_numban,ims_pririe,
ims_tiprie,ims_luggui,ims_actloc,ims_keyban,
ims_numcot,ims_bascal,ims_totpag,ims_keycia,
ims_cveedi,ims_ca1aux,ims_ca2aux,ims_ca3aux,ims_ca4aux,
ims_franum  ) values (
nextval('labprod.sec_nmloimss'),ims_rfcims,oracle.substr(ims_razsoc,1,40),ims_dirloc,ims_numext,ims_numint,
ims_colloc,ims_codpos,ims_munloc,ims_entloc,ims_numban,ims_pririe,ims_tiprie,
ims_luggui,ims_actloc,ims_keyban,ims_numcot,ims_bascal,ims_totpag,ims_keycia,
ims_cveedi,ims_ca1aux,ims_ca2aux,ims_ca3aux,ims_ca4aux,ims_franum  );
/* commit; */
update  api_regpat_imss set status='OK', message='Se proceso con exito', code='3'
where api_regpat_imss.id_transaccion=id_transaccion;
/* commit; */
status:= 'OK';
code:='3';
message:='Se proceso con exito';
end if;
/* commit; */
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
