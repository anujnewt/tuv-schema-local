create or replace procedure labprod.respuestasap_actualizarlabora ( id_transaccion varchar, estatus inout varchar, code inout varchar, message inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
band numeric;
band2 numeric;
band3 numeric;
-- emp_keyemp number;
fecha_mov  timestamp(0);
--emp_tipmov varchar(2);
nmcoemp_keyemp numeric;
nmcoemp_keydep varchar(16);
nmcoemp_keypue varchar(16);
nmcoemp_keyims varchar(5);
nmcoemp_keycat varchar(16);
nmcoemp_keycen varchar(16);
nmcoemp_saldia numeric;
nmcoemp_salhor numeric;
nmcoemp_salmes numeric;
nmcoemp_salint numeric;
nmcoemp_salivc numeric;
nmcoemp_salinf numeric;
nmcoemp_intsin numeric;
nmcoemp_infsin numeric;
nmcoemp_keypro numeric;
nmcoemp_jorlab varchar(1);
nmcoemp_unijor numeric;
nmcoemp_ca1aux varchar(10);
nmcoemp_ca2aux varchar(10);
nmcoemp_fecmod timestamp(0);
nmcoemp_hormod varchar(8);
nmcoemp_keyloc varchar(16);
nmcoemp_fecing timestamp(0);
nmcoemp_pering varchar(7);
emp_keyemp numeric;
emp_keydep varchar(16);
emp_keypue varchar(16);
emp_keycen varchar(16);
emp_keyloc varchar(16);
emp_apepat varchar(90);
emp_apemat varchar(90);
emp_nombre varchar(90);
emp_domemp varchar(100);
emp_numext varchar(10);
emp_numint varchar(10);
emp_colemp varchar(100);
emp_cidemp varchar(255);
emp_munemp varchar(6);
emp_entemp varchar(2);
emp_codemp varchar(5);
emp_telemp varchar(60);
emp_regrfc varchar(13);
emp_recurp varchar(18);
emp_regims varchar(12);
emp_cvesex varchar(1);
emp_keyims varchar(5);
emp_rfcims varchar(16);
emp_cvezon numeric;
emp_keypro numeric;
emp_tipemp varchar(6);
emp_tipsal varchar(1);
emp_status numeric;
emp_salhor numeric;
emp_saldia numeric;
emp_salmes numeric;
emp_forpag varchar(2);
emp_ctaban varchar(18);
emp_cvebaj varchar(4);
emp_fecaux timestamp(0);
emp_jorlab varchar(1);
emp_unijor numeric(126);
emp_ca2aux varchar(10);
emp_fecven timestamp(0);
emp_fecpla timestamp(0);
emp_ca1aux varchar(10);
emp_fecha_mov timestamp(0);
emp_fecha_imss timestamp(0);
emp_tipmov varchar(2);
emp_submov varchar(6);
emp_salint numeric;
emp_salivc numeric(12);
emp_salinf numeric(12);
emp_intsin numeric(12);
emp_infsin numeric(12);
emp_keyplz numeric(38);
keyper varchar(7);
bandperiodo numeric;
periodo varchar(7);
periodo2 varchar(7);
periodofin varchar(7);
periodomod varchar(7);
dia numeric;
hora numeric;
periodotray varchar(7);
fechareingreso timestamp(0) := null;
fechaaumento timestamp(0) := null;
bandban numeric;
ws_pro_ca4aux varchar(10);
ws_pro_ca5aux varchar(10);
ws_emp_ca2aux varchar(6);
ws_emp_tipemp varchar(6);
ws_emp_ca4aux varchar(6);
ws_emp_refcon varchar(6);
emp_cveban    varchar(7);
cvebaj varchar(4);
fecmod varchar(20);
hormod varchar(10);
fechatray timestamp(0);
tempmov varchar(2);
tempsubmov varchar(6);
fecing timestamp(0);
--countims number;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select
emp_keyemp,emp_keydep,emp_keypue,emp_keycen,emp_keyloc,emp_apepat,emp_apemat,emp_nombre,emp_domemp,emp_numext,
emp_numint,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,
emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,emp_tipsal,emp_status,emp_salhor,emp_saldia,emp_salmes,
emp_forpag,emp_ctaban,emp_cvebaj,emp_fecaux,emp_jorlab,emp_unijor,emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,
emp_fecha_mov,emp_fecha_imss,emp_tipmov,emp_submov,emp_salint,keyper,emp_fecha_mov fecha_mov,code,
emp_salivc,emp_salinf,emp_intsin,emp_infsin,emp_keyplz
into strict
actualizarlabora.emp_keyemp,actualizarlabora.emp_keydep,actualizarlabora.emp_keypue,actualizarlabora.emp_keycen,actualizarlabora.emp_keyloc,
actualizarlabora.emp_apepat ,actualizarlabora.emp_apemat,actualizarlabora.emp_nombre,actualizarlabora.emp_domemp,actualizarlabora.emp_numext,
actualizarlabora.emp_numint,actualizarlabora.emp_colemp,actualizarlabora.emp_cidemp,actualizarlabora.emp_munemp,actualizarlabora.emp_entemp,
actualizarlabora.emp_codemp,actualizarlabora.emp_telemp,actualizarlabora.emp_regrfc,actualizarlabora.emp_recurp,actualizarlabora.emp_regims,
actualizarlabora.emp_cvesex,actualizarlabora.emp_rfcims,actualizarlabora.emp_cvezon ,actualizarlabora.emp_keypro,actualizarlabora.emp_tipemp,
actualizarlabora.emp_tipsal,actualizarlabora.emp_status,actualizarlabora.emp_salhor,actualizarlabora.emp_saldia,actualizarlabora.emp_salmes,
actualizarlabora.emp_forpag,actualizarlabora.emp_ctaban,actualizarlabora.emp_cvebaj,actualizarlabora.emp_fecaux,actualizarlabora.emp_jorlab,
actualizarlabora.emp_unijor,actualizarlabora.emp_ca2aux,actualizarlabora.emp_fecven ,actualizarlabora.emp_fecpla,actualizarlabora.emp_ca1aux,
actualizarlabora.emp_fecha_mov,actualizarlabora.emp_fecha_imss,actualizarlabora.emp_tipmov,actualizarlabora.emp_submov,
actualizarlabora.emp_salint,actualizarlabora.keyper,fecha_mov,code,
actualizarlabora.emp_salivc, actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin,actualizarlabora.emp_keyplz
from labprod.api_movimientosper where api_movimientosper.id_transaccion = actualizarlabora.id_transaccion and api_movimientosper.code = 'OK';
periodo := keyper;
dia :=  (actualizarlabora.emp_salmes / 30);
hora := (dia / actualizarlabora.emp_unijor);
code :='OK';
--select ims_keyims into actualizarlabora.emp_keyims from labprod.nmloimss where actualizarlabora.emp_rfcims = nmloimss.ims_rfcims;
begin
select ims_keyims into strict actualizarlabora.emp_keyims from labprod.nmloimss where actualizarlabora.emp_rfcims = nmloimss.ims_rfcims;/* dmap converted statement start */
exception  when too_many_rows then
begin
message := concat('REGISTRO PATRONAL DUPLICADO RFC ', actualizarlabora.emp_rfcims) ;/* dmap converted statement end */
estatus:='5';
code :='ERROR';
update labprod.api_movimientosper set estatus =actualizarlabora.estatus,code=actualizarlabora.code,message=actualizarlabora.message
where labprod.api_movimientosper.id_transaccion = actualizarlabora.id_transaccion;
/* commit; */
end;
end;
select count(*) into strict band2 from labprod.nmcoempl where nmcoempl.emp_keyemp=actualizarlabora.emp_keyemp;
begin
select count(*) into strict band3 from labprod.api_movimientosper  where api_movimientosper.id_transaccion = actualizarlabora.id_transaccion and api_movimientosper.estatus='1' and code = 'OK';
exception  when too_many_rows then
begin
update labprod.api_movimientosper set estatus = '2',code='ERROR',message='ID_TRANSACCION DUPLICADO'
where labprod.api_movimientosper.id_transaccion = actualizarlabora.id_transaccion and estatus = '1' and code='OK';
/* commit; */
estatus:='2';
code :='ERROR';
message :='ID_TRANSACCION DUPLICADO';
end;
end;
end;
if code != 'ERROR' then
cvebaj := actualizarlabora.emp_cvebaj;
--modificado ehc
if  actualizarlabora.emp_tipmov = '2' then
actualizarlabora.emp_cvebaj := emp_submov;
actualizarlabora.emp_submov := cvebaj;
update labprod.sccobaja set baj_status = '2'
where baj_keyemp = actualizarlabora.emp_keyemp
and baj_fecbaj =  actualizarlabora.emp_fecha_mov
and baj_status = '1';
end if;
-- termina modificado ehc
--dbms_output.put_line (emp_tipmov || emp_tipmov );
if  emp_tipmov = '2' or emp_tipmov = '36' or emp_tipmov = '35' or emp_tipmov = '6'   then
fechatray :=actualizarlabora.emp_fecha_mov;
else
fechatray :=actualizarlabora.emp_fecha_imss;
end if;
tempmov := emp_tipmov;
if actualizarlabora.emp_tipmov = '6' and actualizarlabora.emp_submov = '15' then
actualizarlabora.emp_tipmov := '1';
actualizarlabora.emp_submov := actualizarlabora.emp_submov;
end if;
if actualizarlabora.emp_tipmov != '36' and  actualizarlabora.emp_tipmov != '35' and actualizarlabora.emp_submov != '44' then
perform dbms_output.put_line('ENTRA PARA INSERTAR EN NMLOTRAY');
begin
call respuestasap_insertatray(
call actualizarlabora.emp_keyemp ,actualizarlabora.fechatray ,actualizarlabora.emp_tipmov ,actualizarlabora.emp_keydep ,actualizarlabora.emp_keypue ,actualizarlabora.emp_keycen ,
call actualizarlabora.emp_keyloc ,actualizarlabora.emp_apepat ,actualizarlabora.emp_apemat ,actualizarlabora.emp_nombre ,actualizarlabora.emp_domemp ,actualizarlabora.emp_numext ,
call actualizarlabora.emp_numint ,actualizarlabora.emp_colemp ,actualizarlabora.emp_cidemp ,actualizarlabora.emp_munemp ,actualizarlabora.emp_entemp ,actualizarlabora.emp_codemp ,
call actualizarlabora.emp_telemp ,actualizarlabora.emp_regrfc ,actualizarlabora.emp_recurp ,actualizarlabora.emp_regims ,actualizarlabora.emp_cvesex ,actualizarlabora.emp_keyims ,
call actualizarlabora.emp_cvezon ,actualizarlabora.emp_keypro ,actualizarlabora.emp_tipemp ,actualizarlabora.emp_tipsal ,actualizarlabora.emp_status ,
call actualizarlabora.emp_salhor ,actualizarlabora.dia ,actualizarlabora.emp_salmes ,actualizarlabora.emp_forpag ,actualizarlabora.emp_ctaban ,actualizarlabora.emp_cvebaj ,
call actualizarlabora.emp_fecaux ,actualizarlabora.emp_jorlab ,actualizarlabora.emp_unijor ,actualizarlabora.emp_ca2aux ,
call actualizarlabora.emp_fecven ,actualizarlabora.emp_fecpla ,actualizarlabora.emp_ca1aux ,actualizarlabora.emp_fecha_imss ,actualizarlabora.emp_submov ,
call actualizarlabora.emp_salint ,actualizarlabora.keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin
);
/* commit; */
exception  when too_many_rows then
begin
estatus:='2';
code :='ERROR';
message := oracle.substr(sqlerrm, 1, 149);
end;
end;
end if;
if  actualizarlabora.emp_tipmov != '1' and actualizarlabora.emp_tipmov != '6' and actualizarlabora.emp_tipmov != '2'  and  band2 != 0  then
select nmcoempl.emp_keyemp,nmcoempl.emp_keydep,nmcoempl.emp_keypue,nmcoempl.emp_keyims,nmcoempl.emp_keypro,
emp_keycen,emp_saldia,emp_salmes,emp_salint,emp_keyloc,emp_jorlab,emp_unijor,emp_fecing,emp_pering
into strict nmcoemp_keyemp,nmcoemp_keydep,nmcoemp_keypue,nmcoemp_keyims,nmcoemp_keypro,
nmcoemp_keycen,nmcoemp_saldia,nmcoemp_salmes,nmcoemp_salint,nmcoemp_keyloc,nmcoemp_jorlab,nmcoemp_unijor,nmcoemp_fecing,nmcoemp_pering
from labprod.nmcoempl where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
if actualizarlabora.emp_keydep != actualizarlabora.nmcoemp_keydep then
call respuestasap_insertatray(
emp_keyemp ,fechatray ,'8',emp_keydep ,emp_keypue ,emp_keycen , emp_keyloc , emp_apepat , emp_apemat , emp_nombre , emp_domemp , emp_numext ,
emp_numint , emp_colemp , emp_cidemp , emp_munemp , emp_entemp , emp_codemp , emp_telemp , emp_regrfc , emp_recurp , emp_regims , emp_cvesex , emp_keyims ,
emp_cvezon ,emp_keypro ,emp_tipemp , emp_tipsal , emp_status ,emp_salhor , round((dia)::numeric,4) , emp_salmes , emp_forpag , emp_ctaban ,emp_cvebaj ,
emp_fecaux ,emp_jorlab , emp_unijor ,emp_ca2aux , emp_fecven ,emp_fecpla , emp_ca1aux , emp_fecha_imss , emp_submov , emp_salint ,keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin
);
/* commit; */
end if;
if  actualizarlabora.emp_keypue != actualizarlabora.nmcoemp_keypue then
call respuestasap_insertatray(
emp_keyemp ,fechatray ,'9' ,emp_keydep ,emp_keypue ,emp_keycen , emp_keyloc , emp_apepat , emp_apemat , emp_nombre , emp_domemp , emp_numext ,
emp_numint , emp_colemp , emp_cidemp , emp_munemp , emp_entemp , emp_codemp , emp_telemp , emp_regrfc , emp_recurp , emp_regims , emp_cvesex , emp_keyims ,
emp_cvezon ,emp_keypro ,emp_tipemp , emp_tipsal , emp_status ,emp_salhor , round((dia)::numeric,4) , emp_salmes , emp_forpag , emp_ctaban ,emp_cvebaj ,
emp_fecaux ,emp_jorlab , emp_unijor ,emp_ca2aux , emp_fecven ,emp_fecpla , emp_ca1aux , emp_fecha_imss , emp_submov , emp_salint ,keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin
);
/* commit; */
end if;
if actualizarlabora.emp_keypro != actualizarlabora.nmcoemp_keypro then
call respuestasap_cambioproceso(actualizarlabora.emp_keypro ,actualizarlabora.emp_keyemp ,actualizarlabora.emp_fecha_mov ,periodo,nmcoemp_keypro, nmcoemp_fecing,nmcoemp_pering);
call respuestasap_insertatray(
emp_keyemp ,fechatray ,'11' ,emp_keydep ,emp_keypue ,emp_keycen , emp_keyloc , emp_apepat , emp_apemat , emp_nombre , emp_domemp , emp_numext ,
emp_numint , emp_colemp , emp_cidemp , emp_munemp , emp_entemp , emp_codemp , emp_telemp , emp_regrfc , emp_recurp , emp_regims , emp_cvesex , emp_keyims ,
emp_cvezon ,emp_keypro ,emp_tipemp , emp_tipsal , emp_status ,emp_salhor , round((dia)::numeric,4) , emp_salmes , emp_forpag , emp_ctaban ,emp_cvebaj ,
emp_fecaux ,emp_jorlab , emp_unijor ,emp_ca2aux , emp_fecven ,emp_fecpla , emp_ca1aux , emp_fecha_imss , emp_submov , emp_salint ,keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin
);
/* commit; */
call respuestasap_insertatray(
emp_keyemp , fechatray-1 ,'20' ,actualizarlabora.nmcoemp_keydep ,nmcoemp_keypue,nmcoemp_keycen , nmcoemp_keyloc , emp_apepat , emp_apemat , emp_nombre , emp_domemp , emp_numext ,
emp_numint , emp_colemp , emp_cidemp , emp_munemp , emp_entemp , emp_codemp , emp_telemp , emp_regrfc , emp_recurp , emp_regims , emp_cvesex ,  call actualizarlabora.nmcoemp_keyims ,
emp_cvezon ,actualizarlabora.nmcoemp_keypro ,emp_tipemp , emp_tipsal , emp_status ,emp_salhor , round((actualizarlabora.nmcoemp_saldia)::numeric,4) ,actualizarlabora.nmcoemp_salmes , emp_forpag , emp_ctaban ,emp_cvebaj ,
emp_fecaux ,actualizarlabora.nmcoemp_jorlab ,  call actualizarlabora.nmcoemp_unijor ,emp_ca2aux , emp_fecven ,emp_fecpla , emp_ca1aux , emp_fecha_imss , emp_submov , nmcoemp_salint ,keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin);
/* commit; */
end if;
if  actualizarlabora.emp_keyims != actualizarlabora.nmcoemp_keyims then
call respuestasap_insertatray(
emp_keyemp ,fechatray ,'3' ,emp_keydep ,emp_keypue ,emp_keycen , emp_keyloc , emp_apepat , emp_apemat , emp_nombre , emp_domemp , emp_numext ,
emp_numint , emp_colemp , emp_cidemp , emp_munemp , emp_entemp , emp_codemp , emp_telemp , emp_regrfc , emp_recurp , emp_regims , emp_cvesex , emp_keyims ,
emp_cvezon ,emp_keypro ,emp_tipemp , emp_tipsal , emp_status ,emp_salhor , round((dia)::numeric,4) , emp_salmes , emp_forpag , emp_ctaban ,emp_cvebaj ,
emp_fecaux ,emp_jorlab , emp_unijor ,emp_ca2aux , emp_fecven ,emp_fecpla , emp_ca1aux , emp_fecha_imss , emp_submov , emp_salint ,keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin
);
/* commit; */
call respuestasap_insertatray(
emp_keyemp , fechatray-1 ,'4' ,actualizarlabora.nmcoemp_keydep ,nmcoemp_keypue,nmcoemp_keycen , nmcoemp_keyloc , emp_apepat , emp_apemat , emp_nombre , emp_domemp , emp_numext ,
emp_numint , emp_colemp , emp_cidemp , emp_munemp , emp_entemp , emp_codemp , emp_telemp , emp_regrfc , emp_recurp , emp_regims , emp_cvesex ,  call actualizarlabora.nmcoemp_keyims ,
emp_cvezon ,actualizarlabora.nmcoemp_keypro ,emp_tipemp , emp_tipsal , emp_status ,emp_salhor , round((actualizarlabora.nmcoemp_saldia)::numeric,4) ,actualizarlabora.nmcoemp_salmes , emp_forpag , emp_ctaban ,emp_cvebaj ,
emp_fecaux ,actualizarlabora.nmcoemp_jorlab ,  call actualizarlabora.nmcoemp_unijor ,emp_ca2aux , emp_fecven ,emp_fecpla , emp_ca1aux , emp_fecha_imss , emp_submov , nmcoemp_salint ,keyper,
call actualizarlabora.emp_salivc,actualizarlabora.emp_salinf,actualizarlabora.emp_intsin,actualizarlabora.emp_infsin);
/* commit; */
end if;
end if;
begin
periodotray := periodo;
periodomod := periodo;
periodofin  := periodo;
if  emp_tipmov != '2' then
actualizarlabora.fecha_mov := null;
periodofin := null;
periodomod := null;
end if;
call respuestasap_clavebanco(actualizarlabora.emp_forpag ,actualizarlabora.emp_cveban);
if band2 = 0 then
insert into labprod.nmcoempl(
emp_keyemp,emp_keydep,emp_keypue,emp_keycen,emp_keyloc,emp_nomemp,
emp_domemp,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,
emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,
emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,
emp_tipsal,emp_status,emp_cobert,
emp_salmes,
emp_forpag,emp_ctaban, emp_cvebaj,emp_fecaux,emp_jorlab,emp_unijor,
emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,
emp_fecing,emp_fecbaj,emp_pering,emp_salint,emp_salivc,emp_salinf,emp_intsin,emp_infsin,emp_peraum,emp_fecrei,
emp_perdep, emp_perpue, emp_perpro,emp_cveban,emp_cvetur,
emp_fecmod,emp_hormod)
select
emp_keyemp,emp_keydep,emp_keypue,emp_keycen ,emp_keyloc ,concat(concat(concat(concat(emp_apepat, '/'),emp_apemat),'/'),emp_nombre) nombre,
concat(concat(concat(concat(emp_domemp, ' '),emp_numext),' '),emp_numint) domicilio,
emp_colemp ,oracle.substr(emp_cidemp,1,20),emp_munemp ,emp_entemp ,
emp_codemp ,emp_telemp ,emp_regrfc ,emp_recurp ,emp_regims ,
emp_cvesex ,actualizarlabora.emp_keyims ,emp_cvezon ,emp_keypro ,emp_tipemp ,
emp_tipsal ,emp_status ,'1',
--emp_salmes ,
0,
emp_forpag ,emp_ctaban ,emp_cvebaj ,emp_fecaux ,emp_jorlab ,emp_unijor ,
emp_ca2aux ,emp_fecven ,emp_fecpla ,emp_ca1aux  ,
actualizarlabora.emp_fecha_mov,actualizarlabora.fecha_mov,periodo,0,0,0,0,0,periodomod,fechareingreso,
periodo, periodo, periodo,actualizarlabora.emp_cveban,0,
to_date(to_char(clock_timestamp(), 'MM/DD/YYYY'), 'MM/DD/YYYY'),
to_char(clock_timestamp(), 'hh24:mi:ss')
from labprod.api_movimientosper where
--api_movimientosper.emp_keyemp = actualizarlabora.emp_keyemp and
api_movimientosper.id_transaccion = actualizarlabora.id_transaccion and code = 'OK';
/* commit; */
update labprod.eocoplza set plz_keyemp = 0 where plz_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
update labprod.eocoplza set plz_keyemp = actualizarlabora.emp_keyemp where plz_keyplz = actualizarlabora.emp_keyplz;
/* commit; */
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('count empleado ', band2)  );/* dmap converted statement end */
if band2  >  0 then
perform dbms_output.put_line('ENTRA PARA MODIFICAR EMPLEADO');
select emp_fecing, emp_pering into strict fecing,periodo2 from labprod.nmcoempl where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
update labprod.nmcoempl  set
nmcoempl.emp_keydep = actualizarlabora.emp_keydep,
nmcoempl.emp_keypue = actualizarlabora.emp_keypue,
nmcoempl.emp_keycen = actualizarlabora.emp_keycen,
nmcoempl.emp_keyloc = actualizarlabora.emp_keyloc,
nmcoempl.emp_nomemp = concat(concat(concat(concat(actualizarlabora.emp_apepat, '/'),actualizarlabora.emp_apemat),'/'),actualizarlabora.emp_nombre),
nmcoempl.emp_domemp = concat(concat(concat(concat(actualizarlabora.emp_domemp, ' '),actualizarlabora.emp_numext),' '),actualizarlabora.emp_numint),
nmcoempl.emp_colemp = actualizarlabora.emp_colemp,
nmcoempl.emp_cidemp = oracle.substr(actualizarlabora.emp_cidemp,1,20),
nmcoempl.emp_munemp = actualizarlabora.emp_munemp,
nmcoempl.emp_entemp = actualizarlabora.emp_entemp,
nmcoempl.emp_codemp = actualizarlabora.emp_codemp,
nmcoempl.emp_telemp = actualizarlabora.emp_telemp,
nmcoempl.emp_regrfc = actualizarlabora.emp_regrfc,
nmcoempl.emp_recurp = actualizarlabora.emp_recurp,
nmcoempl.emp_regims = actualizarlabora.emp_regims,
nmcoempl.emp_cvesex = actualizarlabora.emp_cvesex,
nmcoempl.emp_keyims = actualizarlabora.emp_keyims,
nmcoempl.emp_cvezon = actualizarlabora.emp_cvezon,
nmcoempl.emp_keypro = actualizarlabora.emp_keypro,
nmcoempl.emp_tipemp = actualizarlabora.emp_tipemp,
nmcoempl.emp_tipsal = actualizarlabora.emp_tipsal,
nmcoempl.emp_status = actualizarlabora.emp_status,
nmcoempl.emp_forpag = actualizarlabora.emp_forpag,
nmcoempl.emp_ctaban = actualizarlabora.emp_ctaban,
nmcoempl.emp_cvebaj = actualizarlabora.emp_cvebaj,
nmcoempl.emp_fecaux = actualizarlabora.emp_fecaux,
nmcoempl.emp_jorlab = actualizarlabora.emp_jorlab,
nmcoempl.emp_unijor = actualizarlabora.emp_unijor,
nmcoempl.emp_ca2aux = actualizarlabora.emp_ca2aux,
nmcoempl.emp_fecven = actualizarlabora.emp_fecven,
nmcoempl.emp_fecpla = actualizarlabora.emp_fecpla,
nmcoempl.emp_ca1aux = actualizarlabora.emp_ca1aux,
nmcoempl.emp_cobert = '1',
nmcoempl.emp_fecing = case when nmcoemp_fecing = null then nmcoempl.emp_fecing else nmcoemp_fecing end,
nmcoempl.emp_pering = case when nmcoemp_pering = null then nmcoempl.emp_pering else nmcoemp_pering end,
nmcoempl.emp_perdep = (case when nmcoempl.emp_keydep = actualizarlabora.emp_keydep then nmcoempl.emp_perdep else periodo end),
nmcoempl.emp_perpue = (case when nmcoempl.emp_keypue = actualizarlabora.emp_keypue then nmcoempl.emp_perpue else periodo end),
nmcoempl.emp_perpro = (case when nmcoempl.emp_keypro = actualizarlabora.emp_keypro then nmcoempl.emp_perpro else periodo end),
emp_cveban = actualizarlabora.emp_cveban,
emp_fecmod = clock_timestamp(),
emp_hormod = to_char(clock_timestamp(), 'hh24:mi:ss')
where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
if  emp_tipmov ='1' then
delete from nmlodata where dat_keyemp = actualizarlabora.emp_keyemp and dat_keypar in ('V0','V1');
insert into nmlodata values (actualizarlabora.emp_keyemp,'V0','1');
insert into nmlodata values (actualizarlabora.emp_keyemp,'V1', to_char(clock_timestamp(),'yyyy-mm-dd'));
/* commit; */
end if;
if emp_tipmov = '6' and emp_submov = '44' then
-- select emp_fecing, emp_pering into fecing,periodo from labprod.nmcoempl where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
update labprod.nmcoempl set emp_fecing =  fecing , emp_pering = periodo2,
nmcoempl.emp_fecbaj  = null,
nmcoempl.emp_perbaj  = null,
nmcoempl.emp_cvebaj  = null
where emp_keyemp = actualizarlabora.emp_keyemp;
end if;
if emp_tipmov = '36' then
update labprod.nmcoempl set emp_fecing =  fecing , emp_pering = periodo2
where emp_keyemp = actualizarlabora.emp_keyemp;
end if;
if  emp_tipmov = '2' then
update labprod.eocoplza set eocoplza.plz_keyemp = 0 where eocoplza.plz_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
else
update labprod.eocoplza set eocoplza.plz_keyemp = 0 where eocoplza.plz_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
update labprod.eocoplza set eocoplza.plz_keyemp = actualizarlabora.emp_keyemp where eocoplza.plz_keyplz = actualizarlabora.emp_keyplz;
/* commit; */
end if;
if  tempmov = '6' and emp_submov != '44' then
fechareingreso := emp_fecha_mov;
update labprod.nmcoempl  set
nmcoempl.emp_fecing = actualizarlabora.emp_fecha_mov,
nmcoempl.emp_pering = keyper,
nmcoempl.emp_fecbaj  = null,
nmcoempl.emp_perbaj  = null,
nmcoempl.emp_cvebaj  = null
where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
end if;
if  emp_tipmov = '5' then
fechaaumento := emp_fecha_mov;
periodomod := periodo;
update labprod.nmcoempl  set
nmcoempl.emp_peraum = keyper ,
nmcoempl.emp_fecaum = actualizarlabora.fechaaumento
where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
end if;
if emp_tipmov = '2' then
update labprod.nmcoempl  set
nmcoempl.emp_fecbaj = actualizarlabora.fecha_mov,
nmcoempl.emp_perbaj = actualizarlabora.periodofin
where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
end if;
if  tempmov = '6' and emp_submov = '44' then
select  max(to_char(tra_fecmod, 'DD/MM/YY hh24:mi:ss'))  into strict fecmod from labprod.nmlotray
where tra_keyemp = actualizarlabora.emp_keyemp and nmlotray.tra_tipmov = '2';
delete from labprod.nmlotray where
tra_keyemp = actualizarlabora.emp_keyemp and nmlotray.tra_tipmov = '2' and
fecmod=to_char(nmlotray.tra_fecmod, 'DD/MM/YY hh24:mi:ss');
/* commit; */
update labprod.sccobaja set baj_status = '4'
where baj_keyemp = actualizarlabora.emp_keyemp
and baj_fecbaj =  actualizarlabora.emp_fecha_imss
and baj_status in ( '2','1');
--or baj_status = 1;
/* commit; */
end if;
end if;
select count(*) into strict  bandban from labprod.nmloctas  where actualizarlabora.emp_keypro = cta_keypro and cta_keyemp = actualizarlabora.emp_keyemp;
if  bandban  = 0 then
insert into labprod.nmloctas( cta_keypro,cta_keyemp,cta_ctaban ) values (  call actualizarlabora.emp_keypro,actualizarlabora.emp_keyemp,actualizarlabora.emp_ctaban );
/* commit; */
end if;
if  bandban > 0 then
update labprod.nmloctas set
cta_keypro = actualizarlabora.emp_keypro ,
cta_keyemp = actualizarlabora.emp_keyemp,
cta_ctaban = actualizarlabora.emp_ctaban where actualizarlabora.emp_keypro = cta_keypro and cta_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
end if;
select nmloproc.pro_ca4aux, nmloproc.pro_ca5aux into strict ws_pro_ca4aux, ws_pro_ca5aux from labprod.nmloproc where nmloproc.pro_keypro = actualizarlabora.emp_keypro;
if  nullif(ws_pro_ca4aux::text, '') is null then
ws_pro_ca4aux:= null;
end if;
if  nullif(ws_pro_ca5aux::text, '') is null then
ws_pro_ca5aux:= null;
end if;
call respuestasap_setrefcon(ws_pro_ca4aux,ws_pro_ca5aux,actualizarlabora.emp_ca2aux,actualizarlabora.emp_tipemp,ws_emp_ca4aux , ws_emp_refcon );
update labprod.nmcoempl set nmcoempl.emp_refcon=ws_emp_refcon, nmcoempl.emp_ca4aux = ws_emp_ca4aux where nmcoempl.emp_keyemp = actualizarlabora.emp_keyemp;
/* commit; */
perform dbms_output.put_line(actualizarlabora.id_transaccion);
update labprod.api_movimientosper set estatus = '2', code='OK',message='PROCESADO EN LABORA',fecha_proc = clock_timestamp()
where api_movimientosper.id_transaccion = actualizarlabora.id_transaccion and api_movimientosper.code ='OK';
--and estatus = 1 and code=ok ;
/* commit; */
estatus:='2';
code :='OK';
message :='PROCESADO EN LABORA';
exception when too_many_rows then
--dbms_output.put_line ( id_transaccion duplicado  );
update labprod.api_movimientosper set estatus = '2',code='ERROR',message='ID_TRANSACCION DUPLICADO'
where labprod.api_movimientosper.id_transaccion = actualizarlabora.id_transaccion;
/* commit; */
end;
end if;
exception when no_data_found then
begin
band := 0;
end;
when too_many_rows then
begin
band := 0;
end;end;
$body$
language plpgsql
;
