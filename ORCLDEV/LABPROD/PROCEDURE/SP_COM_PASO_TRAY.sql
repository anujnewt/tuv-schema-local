create or replace procedure labprod."sp_com_paso_tray"  (noctvo integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vt_movuno           integer;
pe_status           smallint;
vg_noctvo           integer;
vg_keyemp           integer;
vg_fecmov           timestamp(0);
vg_tipmov           varchar(2);
vg_keydep           varchar(16);
vg_keypue           varchar(16);
vg_keycat           varchar(16);
vg_keycen           varchar(16);
vg_saldia           decimal(12,6);
ve_saldia           decimal(12,6);
vg_salmes           decimal(12,2);
ve_salmes           decimal(12,2);
vg_salint           decimal(12,6);
ve_salint           decimal(12,6);
vg_salivc           decimal(12,6);
ve_salivc           decimal(12,6);
vg_salinf           decimal(12,6);
ve_salinf           decimal(12,6);
vg_intsin           decimal(12,6);
ve_intsin           decimal(12,6);
vg_infsin           decimal(12,6);
ve_infsin           decimal(12,6);
vg_keyims           varchar(5);
ve_keyims           varchar(5);
vg_keyper           varchar(7);
vg_codloc           varchar(16);
ve_codloc           varchar(16);
vg_keypla           integer;
vg_keypro           integer;
vg_jorlab           varchar(1);
vg_unijor           decimal(4,2);
vg_submov           varchar(6);
vg_ca1aux           varchar(10);
vg_ca2aux           varchar(10);
vg_fecmod           timestamp(0);
vg_hormod           varchar(8);
vs_activo           varchar(1);
vn_existr           integer;
vg_periodo          integer;
vg_status           integer;
vn_cuent1           integer;
vn_cuent2           integer;
pa_keyper           varchar(7);
wd_fec_act          timestamp(0);
ws_hor_act          char(8);
ws_nom_rep          char(10);
ws_ide_pcc          char(15);
wn_key_usu          integer;
ws_hor_reg          char(8);
wn_tot_reg          integer;
begin
-- inserta registro para monitoreo de resultados                --
wd_fec_act := to_char(clock_timestamp(), 'mm/dd/yyyy');
ws_hor_act := to_char(clock_timestamp(), 'HH24:MI:SS');
ws_nom_rep := 'traypaso';
ws_ide_pcc := 'sp_com_paso_tra';
wn_key_usu := noctvo;
ws_hor_reg := to_char(clock_timestamp(), 'HH24:MI:SS');
wn_tot_reg := 0;
insert into glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, to_char(clock_timestamp(), 'mm/dd/yyyy'), ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P' );/* dmap converted statement start */
select
tra_keyemp, tra_fecmov, tra_tipmov, rtrim(tra_keydep::text),
tra_keypue, rtrim(tra_keycat::text), rtrim(tra_keycen::text), tra_saldia,
tra_salmes, tra_salint, tra_salivc, tra_salinf,
tra_intsin, tra_infsin, tra_keyims, tra_keyper,
tra_codloc, tra_keypla, tra_keypro, tra_jorlab,
tra_unijor, tra_submov, tra_ca1aux, tra_ca2aux,
tra_fecmod, tra_hormod
into strict
vg_keyemp, vg_fecmov, vg_tipmov, vg_keydep,
vg_keypue, vg_keycat, vg_keycen, vg_saldia,
vg_salmes, vg_salint, vg_salivc, vg_salinf,
vg_intsin, vg_infsin, vg_keyims, vg_keyper,
vg_codloc, vg_keypla, vg_keypro, vg_jorlab,
vg_unijor, vg_submov, vg_ca1aux, vg_ca2aux,
vg_fecmod, vg_hormod
from com_orac_sips_tray
where ora_noctvo=noctvo;/* dmap converted statement end */
vn_existr := 0;
vt_movuno := 0;
if vg_tipmov = 1 then
select  count(*)
into strict  vt_movuno
from nmlotray
where tra_keyemp = vg_keyemp
and tra_tipmov = 1;
if vt_movuno > 0 then
vg_tipmov := 6;
end if;
end if;
select  count(*)
into strict  vn_existr
from  traypaso
where  tra_keyemp = vg_keyemp
and  tra_tipmov = vg_tipmov
and  tra_fecmov = vg_fecmov;
update glcoresu set res_numreg = vn_existr,
res_sqlerr = vg_tipmov,
res_isaerr = vg_keyemp
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = to_char(clock_timestamp(), 'mm/dd/yyyy')
and res_horreg = ws_hor_reg;
begin
select distinct emp_status
into strict pe_status
from com_orac_sips_empl
where emp_keyemp=vg_keyemp
and emp_status=2;
exception
when no_data_found then
null;
end;/* dmap converted statement start */
begin
select dep_keycen
into strict   vg_keycen
from   nmcodeps
where dep_keydep= rtrim(vg_keydep::text);/* dmap converted statement end */
exception
when no_data_found then
null;
end;
begin
select min(per_keyper)
into strict   pa_keyper
from nmloperi
where per_keypro=vg_keypro
and per_keynom= 1
and nullif(per_fecact::text, '') is null
and (nullif(per_totemp::text, '') is null or per_totemp=0);
exception
when no_data_found then
null;
end;
vg_keyper := pa_keyper;
vg_keycat := 'SC';
if (vg_tipmov = 2 and  pe_status = 2) or vg_tipmov <> 2 then
if vn_existr = 0  or nullif(vn_existr::text, '') is null  then
if vg_tipmov <> 15 then
insert into  traypaso(tra_keyemp, tra_fecmov, tra_tipmov, tra_keydep,
tra_keypue, tra_keycat, tra_keycen, tra_saldia,
tra_salmes, tra_salint, tra_salivc, tra_salinf,
tra_intsin, tra_infsin, tra_keyims, tra_keyper,
tra_codloc, tra_keypla, tra_keypro, tra_jorlab,
tra_unijor, tra_submov, tra_ca1aux, tra_ca2aux,
tra_fecmod, tra_hormod)
values (vg_keyemp, vg_fecmov, vg_tipmov, vg_keydep,
vg_keypue, vg_keycat, vg_keycen, vg_saldia,
vg_salmes, vg_salint, vg_salivc, vg_salinf,
vg_intsin, vg_infsin, vg_keyims, vg_keyper,
vg_codloc, vg_keypla, vg_keypro, vg_jorlab,
vg_unijor, vg_submov, vg_ca1aux, vg_ca2aux,
vg_fecmod, vg_hormod);
else
vn_cuent1 := 0;
select count(*)
into strict  vn_cuent1
from nmlotray
where tra_keyemp = vg_keyemp
and tra_keyper = pa_keyper
and tra_tipmov = 2;
if  vn_cuent1 > 0  and nullif(pa_keyper::text, '') is not null then
delete from nmlotray
where tra_keyemp=vg_keyemp
and tra_tipmov=2
and tra_keyper = pa_keyper;
end if;
vn_cuent2 := 0;
select count(*)
into strict vn_cuent2
from traypaso
where tra_keyemp = vg_keyemp
and tra_tipmov = 2;
if  vn_cuent2 > 0   then
delete from traypaso
where tra_keyemp=vg_keyemp
and tra_tipmov=2;
end if;
end if;
else
update  traypaso set
tra_keydep = vg_keydep ,
tra_keypue = vg_keypue ,
tra_keycat = vg_keycat ,
tra_keycen = vg_keycen ,
tra_saldia = vg_saldia ,
tra_salmes = vg_salmes ,
tra_salint = vg_salint ,
tra_salivc = vg_salivc ,
tra_salinf = vg_salinf ,
tra_intsin = vg_intsin ,
tra_infsin = vg_infsin ,
tra_keyims = vg_keyims ,
tra_keyper = vg_keyper ,
tra_codloc = vg_codloc ,
tra_keypla = vg_keypla ,
tra_keypro = vg_keypro ,
tra_jorlab = vg_jorlab ,
tra_unijor = vg_unijor ,
tra_submov = vg_submov ,
tra_ca1aux = vg_ca1aux ,
tra_ca2aux = vg_ca2aux ,
tra_fecmod = vg_fecmod ,
tra_hormod = vg_hormod
where tra_keyemp = vg_keyemp
and tra_fecmov = vg_fecmov
and tra_tipmov = vg_tipmov;
end if;
if  vg_tipmov = 4 then
select
emp_keyloc ,
emp_saldia ,
emp_salmes ,
emp_salint ,
emp_salivc ,
emp_salinf ,
emp_intsin ,
emp_infsin ,
emp_keyims
into strict
ve_codloc ,
ve_saldia ,
ve_salmes ,
ve_salint ,
ve_salivc ,
ve_salinf ,
ve_intsin ,
ve_infsin ,
ve_keyims
from nmcoempl
where emp_keyemp = vg_keyemp
and emp_status = 1;
update traypaso
set tra_codloc = ve_codloc ,
tra_saldia = ve_saldia ,
tra_salmes = ve_salmes ,
tra_salint = ve_salint ,
tra_salivc = ve_salivc ,
tra_salinf = ve_salinf ,
tra_intsin = ve_intsin ,
tra_infsin = ve_infsin ,
ora_status = 'S'
where tra_keyemp = vg_keyemp
and tra_tipmov = vg_tipmov
and tra_fecmov = vg_fecmov;
end if;
if vg_tipmov <> 1 or vg_tipmov <> 5 or vg_tipmov <> 6 or vg_tipmov <> 4 then
begin
select
emp_saldia ,
emp_salmes ,
emp_salint ,
emp_salivc ,
emp_salinf ,
emp_intsin ,
emp_infsin
into strict
ve_saldia ,
ve_salmes ,
ve_salint ,
ve_salivc ,
ve_salinf ,
ve_intsin ,
ve_infsin
from nmcoempl
where emp_keyemp = vg_keyemp
and emp_status = 1;
exception
when no_data_found then
null;
end;
begin
select distinct emp_keyloc
into strict ve_codloc
from emplpaso
where emp_keyemp = vg_keyemp;
exception
when no_data_found then
null;
end;
update  traypaso
set tra_codloc = ve_codloc ,
tra_saldia = ve_saldia ,
tra_salmes = ve_salmes ,
tra_salint = ve_salint ,
tra_salivc = ve_salivc ,
tra_salinf = ve_salinf ,
tra_intsin = ve_intsin ,
tra_infsin = ve_infsin ,
ora_status = 'S'
where tra_keyemp = vg_keyemp
and   tra_tipmov = vg_tipmov
and   tra_fecmov = vg_fecmov;
end if;
end if;
if pe_status = 2 and vg_tipmov = 1 then
update traypaso set ora_status = 'D'
where tra_keyemp= vg_keyemp
and tra_tipmov= vg_tipmov
and tra_fecmov = vg_fecmov;
end if;
-- actualiza la tabla de monitoreo indicando la finalizaci?  --
-- del proceso.                                                 --
ws_hor_act := to_char(clock_timestamp(), 'HH24:MI:SS');
update glcoresu set res_numreg = vn_existr,
res_fecfin = to_char(clock_timestamp(), 'mm/dd/yyyy'),
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep
and res_idepcc =  ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = to_char(clock_timestamp(), 'mm/dd/yyyy')
and res_horreg = ws_hor_reg;end;
$body$
language plpgsql
;
