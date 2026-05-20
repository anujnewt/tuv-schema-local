create or replace procedure labprod.respuestasap_insertatrayectoria ( id_transaccion varchar, emp_keyemp numeric, fecha_mov timestamp(0), emp_tipmov varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
band numeric;
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
emp_cidemp varchar(20);
emp_munemp varchar(6);
emp_entemp varchar(2);
emp_codemp varchar(5);
emp_telemp varchar(60);
emp_regrfc varchar(13);
emp_recurp varchar(18);
emp_regims varchar(12);
emp_cvesex varchar(1);
emp_keyims varchar(5);
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
emp_fecha_imss timestamp(0);
emp_submov varchar(6);
emp_salint numeric;
keyper varchar(7);
periodo numeric;
keypro numeric;
salint numeric;
dia numeric;
hora numeric;
mes numeric;
unijor numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select count(*) into strict band from labprod.nmlotray
where nmlotray.tra_keyemp = insertatrayectoria.emp_keyemp
and to_timestamp(tra_fecmov,'DD/MM/YY') = to_timestamp(insertatrayectoria.fecha_mov,'DD/MM/YY')
and insertatrayectoria.emp_tipmov =tra_tipmov;
select emp_keypro,emp_salint,emp_salmes,emp_unijor
into strict keypro,salint,mes,unijor
from labprod.api_movimientosper
where api_movimientosper.id_transaccion = insertatrayectoria.id_transaccion;
select min(per_keyper) into strict periodo
from labprod.nmloperi
where nmloperi.per_keypro = insertatrayectoria.keypro
and per_keynom = 1 and nullif(per_fecact::text, '') is null;
exception when too_many_rows then
perform dbms_output.put_line(' EMPLEADO DUPLICADO DENTRO DE NMLOTRAY ' );
end;
dia  :=  (mes / 30);
hora := (dia / unijor);
if band  = 0  then
insert into labprod.nmlotray(
tra_keyemp,tra_fecmov,tra_tipmov,tra_keydep,tra_keypue,
tra_keycat,tra_keycen,tra_saldia,tra_salmes,tra_salint,
tra_salivc,tra_salinf,tra_intsin,tra_infsin,tra_keyims,
tra_keyper,tra_codloc,tra_keypla,tra_keypro,tra_jorlab,
tra_unijor,tra_submov,tra_ca1aux,tra_ca2aux,tra_fecmod,tra_hormod)
select emp_keyemp,emp_fecha_mov,emp_tipmov,emp_keydep,emp_keypue,
0,emp_keycen,(api_movimientosper.emp_salmes/30),emp_salmes,salint,
salint,salint,salint,salint,emp_keyims,
periodo,emp_keyloc,0,emp_keypro,emp_jorlab,
emp_unijor,emp_submov,null,null,clock_timestamp(),to_char(clock_timestamp(), 'hh24:mi:ss')
from labprod.api_movimientosper
where api_movimientosper.emp_keyemp=insertatrayectoria.emp_keyemp and insertatrayectoria.id_transaccion = api_movimientosper.id_transaccion;
/* commit; */
end if;
if  band > 0 then
select
emp_keydep,emp_keypue,emp_keycen,emp_keyloc,
emp_apepat,emp_apemat,emp_nombre,emp_domemp,emp_numext,
emp_numint,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,
emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,
emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,
emp_tipsal,emp_status,emp_salhor,emp_saldia,emp_salmes,
emp_forpag,emp_ctaban,emp_cvebaj,emp_fecaux,emp_jorlab,
emp_unijor,emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,
emp_fecha_imss,emp_submov,emp_salint,keyper
into strict
insertatrayectoria.emp_keydep,insertatrayectoria.emp_keypue,insertatrayectoria.emp_keycen,insertatrayectoria.emp_keyloc
,insertatrayectoria.emp_apepat,insertatrayectoria.emp_apemat,insertatrayectoria.emp_nombre,insertatrayectoria.emp_domemp,insertatrayectoria.emp_numext
,insertatrayectoria.emp_numint,insertatrayectoria.emp_colemp,insertatrayectoria.emp_cidemp,insertatrayectoria.emp_munemp,insertatrayectoria.emp_entemp
,insertatrayectoria.emp_codemp,insertatrayectoria.emp_telemp,insertatrayectoria.emp_regrfc,insertatrayectoria.emp_recurp,insertatrayectoria.emp_regims
,insertatrayectoria.emp_cvesex,insertatrayectoria.emp_keyims,insertatrayectoria.emp_cvezon ,insertatrayectoria.emp_keypro,insertatrayectoria.emp_tipemp
,insertatrayectoria.emp_tipsal,insertatrayectoria.emp_status,insertatrayectoria.emp_salhor,insertatrayectoria.emp_saldia,insertatrayectoria.emp_salmes
,insertatrayectoria.emp_forpag,insertatrayectoria.emp_ctaban,insertatrayectoria.emp_cvebaj,insertatrayectoria.emp_fecaux,insertatrayectoria.emp_jorlab
,insertatrayectoria.emp_unijor,insertatrayectoria.emp_ca2aux,insertatrayectoria.emp_fecven ,insertatrayectoria.emp_fecpla,insertatrayectoria.emp_ca1aux
,insertatrayectoria.emp_fecha_imss,insertatrayectoria.emp_submov
,insertatrayectoria.emp_salint,insertatrayectoria.keyper
from labprod.api_movimientosper
where api_movimientosper.id_transaccion = insertatrayectoria.id_transaccion;
update labprod.nmlotray set
nmlotray.tra_fecmov = insertatrayectoria.fecha_mov,
nmlotray.tra_tipmov = insertatrayectoria.emp_tipmov,
nmlotray.tra_keydep = insertatrayectoria.emp_keydep,
nmlotray.tra_keypue = insertatrayectoria.emp_keyemp,
nmlotray.tra_keycat = 0,
nmlotray.tra_keycen = insertatrayectoria.emp_keycen,
nmlotray.tra_saldia = round((dia )::numeric,4),
nmlotray.tra_salmes = insertatrayectoria.emp_salmes,
nmlotray.tra_salint = salint,
nmlotray.tra_salivc = salint,
nmlotray.tra_salinf = salint,
nmlotray.tra_intsin = salint,
nmlotray.tra_infsin = salint,
nmlotray.tra_keyims = insertatrayectoria.emp_keyims,
nmlotray.tra_keyper = periodo,
nmlotray.tra_codloc = insertatrayectoria.emp_keyloc,
nmlotray.tra_keypla = 0,
nmlotray.tra_keypro = insertatrayectoria.emp_keypro,
nmlotray.tra_jorlab = insertatrayectoria.emp_jorlab,
nmlotray.tra_unijor = insertatrayectoria.emp_unijor,
nmlotray.tra_submov = insertatrayectoria.emp_submov,
nmlotray.tra_ca1aux = insertatrayectoria.emp_ca1aux,
nmlotray.tra_ca2aux = insertatrayectoria.emp_ca2aux,
nmlotray.tra_fecmod = clock_timestamp(),
nmlotray.tra_hormod = to_char(clock_timestamp(), 'hh24:mi:ss')
where nmlotray.tra_keyemp = insertatrayectoria.emp_keyemp
and to_timestamp(tra_fecmov,'DD/MM/YY') = to_timestamp(insertatrayectoria.fecha_mov,'DD/MM/YY')
and insertatrayectoria.emp_tipmov = nmlotray.tra_tipmov;
/* commit; */
end if;end;
$body$
language plpgsql
;
