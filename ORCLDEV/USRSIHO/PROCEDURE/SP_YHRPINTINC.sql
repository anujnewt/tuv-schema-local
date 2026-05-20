create or replace procedure usrsiho."sp_yhrpintinc"  ( pd_fecsol timestamp(0), pi_keyusu numeric, pd_fechaact timestamp(0), pl_unifor smallint, pl_transp smallint, pn_keypro smallint, ps_nomrep varchar, ps_idepcc varchar, ps_arefis varchar, vi_valret inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
---sp_yhrpintinc
-- ---------------------------------------------------------------------------------------------------------------
-- ojo la mayoria de los parametros vienen vacios debido a que antes se pedian en pantalla
-- regresara el secuencial del rph y a continuacion los
-- secuenciales de los gdp's.
-- los registros que se generan de esta interfase se podran
-- distinguir por medio del campo holofrph.frp_pertra = 999
--
-- modifico: emilio pulido r. 25.05.06 modifique para ingnorar lo que se estaba
-- almacenando en wn_pertra
-- que se guardaba en frp_pertra. ahora se guarda en li_fpafin el valor que traiga en tmp_cont_exclu.con_fpafin
-- --------------------------------------------------------------------------------------------------------------
li_secrph numeric(10);li_secgdp numeric(10);li_captot numeric(10);li_numcap numeric(10);li_capdis numeric(10);
li_plaza numeric(10);li_empleado numeric(10);li_tipcon numeric(10);li_folio numeric(10);
ld_valor decimal(16,2);ld_costo decimal(16,2);ld_costototal decimal(16,2);
ls_puesto varchar(16);
ls_keycon varchar(4);
li_valsec numeric(10);
li_emptotal numeric(15);
ws_equiva varchar(1);
li_keynom numeric(5);
ls_keydep varchar(16);
ld_fecpag timestamp(0);
ls_tipfol varchar(1);
wn_pertra numeric(10);
ws_nomrep varchar(10);
ws_desnom varchar(60);
ws_descen varchar(60);
pd_tipcam decimal(16,6);
li_emp_exclu numeric(10);
li_emp_exclu1 numeric(10);
li_numregis numeric(10);
ls_descap varchar(200);
li_fpafin numeric(5);
pi_fpagfi numeric(5);
a numeric(10);
ps_programa varchar(20);
pi_keynom smallint;
pd_fechatrab  timestamp(0);
pi_forpag smallint;
ps_tiptra  varchar(20);
pn_tipcam decimal(16,6);
rec record;
rec2 record;
rec3 record;
rec4 record;
rec5 record;
begin
li_secrph     := -1;
li_emptotal   := 0;
ld_costototal := 0;
pd_tipcam     := 0;
li_numregis   := 0;
a  := 0;
pi_fpagfi     := 0;
--delete from borra;
-- ---------------------------------------------------------------------------------
-- incializamos la variable con el nombre del rpt para el listado de rph's generados
-- ---------------------------------------------------------------------------------
ws_nomrep := 'hrpintinc3';
-- -----------------------------------------------------------------------
-- borramos de la glwkcrys la informacion anterior de los rph's generados
-- ----------------------------------------------------------------------
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nomrep
and cry_idepcc = ps_idepcc
and cry_keyusu = pi_keyusu;
-- ignore el 25.05.06
-- -------------------------------
-- asignamos el valor de wn_pertra
-- -------------------------------
-- let wn_pertra = 0;
-- select nvl(max(frp_pertra),0)+1
--   into wn_pertra
--   from holofrph
--  where frp_keypro = pn_keypro --100   --pn_keypro
--    and frp_fecact = today
--    and frp_pertra >= 900;
-- if wn_pertra < 900 then
--    let wn_pertra = 900;
-- end if
--insert into borra values ('FASE 1',0);
-- ----------------------------------------------------------------------------
-- entramos al foreach principal tomando datos de la glwkrang grabados desde vb
-- ----------------------------------------------------------------------------
for rec in (select ran_keynom, ran_keydep,
ran_keycen, ran_keycon,
ran_keypro, ran_keyper,
ran_keycat, ran_keyemp
from usrsiho.glwkrang
where ran_nomrep = ps_nomrep
and ran_idepcc = ps_idepcc
and ran_keyusu = pi_keyusu) loop
pi_keynom := rec.ran_keynom;
ps_programa := rec.ran_keydep;
pd_fechatrab := rec.ran_keycen;
ls_tipfol := rec.ran_keycon;
pi_forpag := rec.ran_keypro;
ps_tiptra := rec.ran_keyper;
pd_tipcam := rec.ran_keycat;
pi_fpagfi := rec.ran_keyemp;
a := a::numeric + 1;
--insert into borra values ('FASE 1 ciclo 1',a);
-- -----------------------------------------------------
-- creamos la tabla temporal con los empleados a excluir
-- -----------------------------------------------------
/*   insert into usrsiho.emp_excluir
select con_keyemp exc_keyemp,count(con_tipcam) exc_numinci
from usrsiho.tmp_cont_exclu
where con_stscon = 'P'
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_forpag = 2
and con_keypro = pn_keypro
and con_arefis = ps_arefis
group by con_keyemp
having count(*) > 1 ;*/
li_secrph     := -1;
li_emptotal   := 0;
ld_costototal := 0;
li_numregis   := 0;
li_empleado := 0;
ld_costo := 0;
ls_puesto:= null;
li_folio := 0;
li_numcap := 0;
ls_keycon:= null;
ls_descap:= null;
-- ----------------------------------------------------------------
-- entramos al segundo foreach tomando datos del froreach principal
-- ----------------------------------------------------------------
-- 25.05.06 agregue con_fpafin en el select y li_fpafin en el into y el order 8 para grabarlo en la holofrph.frp_pertra
for rec2 in (select con_keyemp, con_cosuni,
con_keypue, con_keyfol,
pue_ca5aux, con_tipcam,
coalesce(con_descap,'') descap, coalesce(con_fpafin,0) fpafin,
count(*) suma
from usrsiho.tmp_cont_exclu, usrsiho.nmcopues
where con_keydep = ps_programa
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_tipfol = ls_tipfol
and con_forpag = pi_forpag
and con_tiptra = ps_tiptra
and con_stscon = 'A'
and con_keypue = pue_keypue
and con_tipcam = pd_tipcam
and con_keypro = pn_keypro
and con_arefis = ps_arefis
and con_fpafin = pi_fpagfi  ---aedo forma de pago final
/* and not exists (select exc_keyemp
from usrsiho.emp_excluir
where con_keyemp = exc_keyemp)*/
group by con_keyemp, con_cosuni,con_keypue, con_keyfol,pue_ca5aux, con_tipcam,
coalesce(con_descap,''), coalesce(con_fpafin,0)
) loop
--insert into borra values ('FASE 1 ciclo 2',a);
li_empleado := rec2.con_keyemp;
ld_costo := rec2.con_cosuni;
ls_puesto := rec2.con_keypue;
li_folio := rec2.con_keyfol;
ls_keycon := rec2.pue_ca5aux;
pn_tipcam := rec2.con_tipcam;
ls_descap := rec2.descap;
li_fpafin := rec2.fpafin;
li_numcap := rec2.suma;
a := a::numeric + 1;
-- ---------------------------------
-- si encontramos mas de un registro
-- ---------------------------------
if li_numcap > 0 then
-- ------------------------------------------------------------------
-- si la primera vez li_secrph vale -1 entonces insertamos el header
-- ------------------------------------------------------------------
--insert into borra values ('FASE 1 inserta header?',a);
if li_secrph = -1 then
--insert into borra values ('FASE 1 inserto header',a);
-- ------------------------------------------------------------------
-- definicion de la equivalencia y concepto, dependiendo de la nomina
-- ------------------------------------------------------------------
if pi_keynom = 102 then
ws_equiva := 'I';
else
ws_equiva := 'N';
end if;
ld_valor := ld_costo;
-- -----------------------------------------------
-- insertamos en la holofrph el encabezado del rph
-- -----------------------------------------------
insert into usrsiho.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,
frp_totcos,frp_keyusu,frp_keynom,frp_repeti,
frp_tiptra,frp_fecsol,frp_fectrab,frp_forpag,
frp_pertra,frp_tipfol,frp_unifor,frp_transp,
frp_tipcam,frp_keypro,frp_fecitr,frp_keyare)
values (ps_programa,null,trunc(clock_timestamp()),'0',
ld_valor,pi_keyusu,pi_keynom,ws_equiva  ,
ps_tiptra,pd_fechatrab,pd_fechatrab,pi_forpag,
li_fpafin,ls_tipfol,pl_unifor,pl_transp,
pn_tipcam,pn_keypro,pd_fechatrab,ps_arefis);
-- ---------------------------------
-- lectura del secuencial del rph =>
-- ---------------------------------
--li_secrph := li_secrph + 1;
select max(frp_keyrph) into strict li_secrph from usrsiho.holofrph;
-- return li_secrph with resume;
vi_valret := 1;
--insert into borra values (li_secrph,a);
--else
--insert into borra values ('FASE 1 no inserta header',a);
end if;
-- -----------------
-- capitulos totales
-- -----------------
li_captot := li_numcap;
-- --------------------------------------
-- incrementamos las variables de totales
-- --------------------------------------
ld_valor := ld_costo;
ld_costototal := ld_costototal + ld_valor  * (li_captot);
li_emptotal := li_emptotal + li_empleado;
li_numregis := li_numregis + 1;
-- ---------------------------------
-- aedo  11/08/06 se agrego el siguiente update para guardar el numero del rph en el que se genero el registro
-- ---------------------------------
update usrsiho.tmp_cont_exclu set con_keyrph = li_secrph
where con_keydep = ps_programa
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_tipfol = ls_tipfol
and con_forpag = pi_forpag
and con_tiptra = ps_tiptra
and con_stscon = 'A'
and con_keyemp = li_empleado
and con_tipcam = pd_tipcam
and con_keypro = pn_keypro
and con_arefis = ps_arefis
and con_fpafin = pi_fpagfi;  ---aedo forma de pago final
--insert into borra values ('inserta en hologdpr',a);
-- ---------------------------------
-- insercion de gastos de produccion
-- ---------------------------------
insert into usrsiho.hologdpr(gdp_keydep, gdp_keyrph, gdp_fechag, gdp_keyemp, gdp_keypue, gdp_capini,
gdp_capfin, gdp_numcap, gdp_keycon, gdp_marcon, gdp_marcos, gdp_cosuni,
gdp_keysue, gdp_keytco, gdp_keyfol, gdp_minleg, gdp_minsal, gdp_minext,
gdp_mincom, gdp_keyusu)
values (ps_programa, li_secrph, pd_fechatrab, li_empleado, ls_puesto, 1,
1,li_captot, ls_keycon   ,'S'        ,'S'      ,ld_valor ,
null       , 0,li_folio   ,0          ,0        ,0        ,
0          , pi_keyusu);
-- -----------------------------------
-- lectura del secuencial del  gdp =>
-- -----------------------------------
--     li_secgdp := li_secgdp+ 1;
begin
select max(gdp_keysec )
into strict li_secgdp
from usrsiho.hologdpr;
exception when no_data_found then li_secgdp := 0;
end;
-- return li_secgdp with resume;
vi_valret := 1;
-- -------------------------------------------------------------------------
-- insertamos en la tabla rhdesreciap para las descripciones de los recibos
-- -------------------------------------------------------------------------
if nullif(ls_descap::text, '') is not null then
insert into usrsiho.rhdesreciap(iap_keysec, iap_descap)
values (li_secgdp , ls_descap);
end if;
--insert into borra values (li_secgdp,a);
--insert into borra values ('Termina empleado',a);
end if;
end loop;
-- ----------------------------
-- si el cursor inserto un rph
-- ----------------------------
if li_secrph > -1 then
-- ------------------------------------------------------------------------------------------
-- actualizamos en holofrph el total costo y el total empleado con las sumas de los detalles
-- ------------------------------------------------------------------------------------------
-- ignore el 25.05.06
-- update holofrph
--    set frp_totcos = ld_costototal,
--        frp_totemp = li_emptotal,
--        frp_pertra = wn_pertra
--  where frp_keyrph = li_secrph;
--- agregue el 25.05.06
update usrsiho.holofrph
set frp_totcos = ld_costototal,
frp_totemp = li_emptotal
where frp_keyrph = li_secrph;
-- ---------------------------------------------------------------------------------------------
-- actualizamos en tmp_cont_exclu el con_stscon con  'P' para indicar que este ya fue procesado
-- ---------------------------------------------------------------------------------------------
update usrsiho.tmp_cont_exclu
set con_stscon = 'P',
con_keyusu = pn_keypro,
con_fecmod = pd_fechaact
where con_keydep = ps_programa
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_tipfol = ls_tipfol
and con_forpag = pi_forpag
and con_tiptra = ps_tiptra
and con_stscon = 'A'
and con_tipcam = pd_tipcam
and con_keypro = pn_keypro
and con_arefis = ps_arefis
and con_fpafin = pi_fpagfi  ---aedo forma de pago final
/*  and not exists (select exc_keyemp
from usrsiho.emp_excluir
where con_keyemp = exc_keyemp)*/
;
-- --------------------------------------------------------------------------
-- obtenemos la descripcion de la nomina para efectos del reporte hrpintinc3
-- -------------------------------------------------------------------------
ws_desnom:= null;
ws_descen:= null;
begin
select nom_destip
into strict ws_desnom
from usrsiho.nmlonomi
where nom_keynom = pi_keynom;
exception when no_data_found then ws_desnom:= null;
end;
-- ---------------------------------------------------------------------------------
-- obtenemos la descripcion del centro de costos para efectos del reporte hrpintinc3
-- ---------------------------------------------------------------------------------
begin
select dep_desdep
into strict ws_descen
from usrsiho.nmcodeps
where dep_keydep = ps_programa;
exception when no_data_found then ws_descen:= null;
end;
-- ----------------------------------------------------------------------------
-- grabamos en la glwkcrys la informaci??ara el reporte de rph's generados --
-- ----------------------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_numsec,
cry_dec006,
cry_chr003,
cry_chr012,
cry_chr001,
cry_chr014,
cry_chr018,
cry_chr017,
cry_chr019,
cry_chr015,
cry_dec001,
cry_dec011,
cry_dec007,
cry_dec009,
cry_chr016)
select ws_nomrep,
ps_idepcc,
pi_keyusu,
li_secrph,
pi_keynom,
ws_desnom,
ps_programa,
ws_descen,
pd_fechatrab,
ls_tipfol,
ps_tiptra,
pi_forpag,
a.pam_folini,
pn_tipcam,
ld_costototal,
li_numregis,
li_fpafin,
b.pam_folini
from usrsiho.glcopams a, usrsiho.glcopams b
where a.pam_keypar = 'H10'
and a.pam_cvesec = pi_forpag
and b.pam_keypar = 'H10'
and b.pam_cvesec = li_fpafin;
end if;
end loop;
---insert into borra values ('FASE 2',a);
-- -------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------
-- entramos a la segunda parte de la descarga, procesando ahora los empleados que antes excluimos --
-- -------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------
li_secrph     := -1;
li_emptotal   := 0;
ld_costototal := 0;
pd_tipcam     := 0;
li_numregis   := 0;
-- ----------------------------------------------------------------------------------------
-- entramos al foreach principal tomando el codigo del empleado de la tabla temporal  -----
-- ----------------------------------------------------------------------------------------
for rec3 in (select exc_keyemp
from usrsiho.emp_excluir)
loop
li_emp_exclu := rec3.exc_keyemp;
a := a::numeric + 1;
-- --------------------------------------------------------------
-- entramos al segundo foreach tomando datos de la tmp_cont_exclu
-- --------------------------------------------------------------
for rec4 in (select distinct con_keyemp, con_keynom,
con_keydep, con_fecpag,
con_tipfol, con_forpag,
con_tiptra, con_tipcam,
coalesce(con_fpafin,0) fpafin
from usrsiho.tmp_cont_exclu
where con_keynom = pi_keynom
and con_stscon = 'A'
and con_forpag = 2
and con_fecpag = pd_fechatrab
and con_keyemp = li_emp_exclu
and con_keypro = pn_keypro
and con_arefis = ps_arefis) loop
li_emp_exclu1 := rec4.con_keyemp;
pi_keynom := rec4.con_keynom;
ps_programa := rec4.con_keydep;
pd_fechatrab := rec4.con_fecpag;
ls_tipfol := rec4.con_tipfol;
pi_forpag := rec4.con_forpag;
ps_tiptra := rec4.con_tiptra;
pd_tipcam := rec4.con_tipcam;
pi_fpagfi := rec4.fpafin;
li_secrph     := -1;
li_emptotal   := 0;
ld_costototal := 0;
li_numregis   := 0;
li_empleado := 0;
ld_costo := 0;
ls_puesto:= null;
li_folio := 0;
li_numcap := 0;
ls_keycon:= null;
ls_descap:= null;
a := a::numeric + 1;
-- ------------------------------------------------------------
-- entramos al tercer foreach tomando datos del segundo foreach
-- ------------------------------------------------------------
-- 25.05.06 agregue con_fpafin en el select y li_fpafin en el into y el order 8 para grabarlo en la holofrph.frp_pertra
for rec5 in (select con_keyemp, con_cosuni,
con_keypue, con_keyfol,
pue_ca5aux, con_tipcam,
coalesce(con_descap,'') descap, coalesce(con_fpafin,0) fpafin,
count(*) suma
from usrsiho.tmp_cont_exclu, usrsiho.nmcopues
where con_keydep = ps_programa
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_tipfol = ls_tipfol
and con_forpag = pi_forpag
and con_tiptra = ps_tiptra
and con_stscon = 'A'
and con_keypue = pue_keypue
and con_tipcam = pd_tipcam
and con_keyemp = li_emp_exclu1
and con_keypro = pn_keypro
and con_arefis = ps_arefis
and con_fpafin = pi_fpagfi
group by con_keyemp, con_cosuni,
con_keypue, con_keyfol,
pue_ca5aux, con_tipcam,
coalesce(con_descap,''), coalesce(con_fpafin,0)) loop
li_empleado := rec5.con_keyemp;
ld_costo := rec5.con_cosuni;
ls_puesto := rec5.con_keypue;
li_folio := rec5.con_keyfol;
ls_keycon := rec5.pue_ca5aux;
pn_tipcam := rec5.con_tipcam;
ls_descap := rec5.descap;
li_fpafin := rec5.fpafin;
li_numcap := rec5.suma;
a := a::numeric + 1;
-- ---------------------------------
-- si encontramos mas de un registro
-- ---------------------------------
if li_numcap > 0 then
-- ------------------------------------------------------------------
-- si la primera vez li_secrph vale -1 entonces insertamos el header
-- ------------------------------------------------------------------
if li_secrph = -1 then
-- ------------------------------------------------------------------
-- definicion de la equivalencia y concepto, dependiendo de la nomina
-- ------------------------------------------------------------------
if pi_keynom = 102 then
ws_equiva := 'I';
else
ws_equiva := 'N';
end if;
ld_valor := ld_costo;
-- -----------------------------------------------
-- insertamos en la holofrph el encabezado del rph
-- -----------------------------------------------
--  25.05.06 cambie en el values parametro 13 el null por li_fpafin
insert into usrsiho.holofrph(frp_keydep, frp_keyper, frp_fecact, frp_stsfol,
frp_totcos, frp_keyusu, frp_keynom, frp_repeti,
frp_tiptra, frp_fecsol, frp_fectrab, frp_forpag,
frp_pertra, frp_tipfol, frp_unifor, frp_transp,
frp_tipcam, frp_keypro, frp_fecitr,frp_keyare)
values (ps_programa, null, trunc(clock_timestamp()), '0',
ld_valor, pi_keyusu, pi_keynom, ws_equiva  ,
ps_tiptra, pd_fechatrab, pd_fechatrab, pi_forpag,
li_fpafin, ls_tipfol, pl_unifor, pl_transp,
pn_tipcam, pn_keypro, pd_fechatrab,ps_arefis);
-- ---------------------------------
-- lectura del secuencial del rph =>
-- ---------------------------------
--li_secrph := li_secrph + 1;
select max(frp_keyrph) into strict li_secrph from usrsiho.holofrph;
-- return li_secrph with resume;
vi_valret := 1;
--insert into borra values (li_secrph,a);
end if;
-- -----------------
-- capitulos totales
-- -----------------
li_captot := li_numcap;
-- --------------------------------------
-- incrementamos las variables de totales
-- --------------------------------------
ld_valor := ld_costo;
ld_costototal := ld_costototal + ld_valor  * (li_captot);
li_emptotal := li_emptotal + li_empleado;
li_numregis := li_numregis + 1;
-- ---------------------------------
-- aedo  11/08/06 se agrego el siguiente update para guardar el numero del rph en el que se genero el registro
-- ---------------------------------
update usrsiho.tmp_cont_exclu set con_keyrph = li_secrph
where con_keydep = ps_programa
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_tipfol = ls_tipfol
and con_forpag = pi_forpag
and con_tiptra = ps_tiptra
and con_stscon = 'A'
and con_keyemp = li_empleado
and con_tipcam = pd_tipcam
and con_keypro = pn_keypro
and con_arefis = ps_arefis
and con_fpafin = pi_fpagfi;  ---aedo forma de pago final
-- ---------------------------------
-- insercion de gastos de produccion
-- ---------------------------------
insert into usrsiho.hologdpr(gdp_keydep, gdp_keyrph, gdp_fechag, gdp_keyemp, gdp_keypue, gdp_capini,
gdp_capfin, gdp_numcap, gdp_keycon, gdp_marcon, gdp_marcos, gdp_cosuni,
gdp_keysue, gdp_keytco, gdp_keyfol, gdp_minleg, gdp_minsal, gdp_minext,
gdp_mincom, gdp_keyusu)
values (ps_programa, li_secrph, pd_fechatrab, li_empleado, ls_puesto, 1,
1, li_captot, ls_keycon   ,'S'        ,'S'       , ld_valor ,
null       , 0, li_folio   ,0          ,0        , 0        ,
0          , pi_keyusu);
-- -----------------------------------
-- lectura del secuencial del  gdp =>
-- -----------------------------------
li_secgdp := li_secgdp+ 1;
-- return li_secgdp with resume;
vi_valret := 1;
-- -------------------------------------------------------------------------
-- insertamos en la tabla rhdesreciap para las descripciones de los recibos
-- -------------------------------------------------------------------------
if ls_descap = not null then
insert into usrsiho.rhdesreciap(iap_keysec, iap_descap)
values (li_secgdp , ls_descap);
end if;
------------------------------------------------------------------------------
--insert into borra values (li_secgdp,a);
end if;
end loop;
-- ----------------------------
-- si el cursor inserto un rph
-- ----------------------------
if li_secrph > -1 then
-- ------------------------------------------------------------------------------------------
-- actualizamos en holofrph el total costo y el total empleado con las sumas de los detalles
-- ------------------------------------------------------------------------------------------
-- ignore el 25.05.06
-- update holofrph
--    set frp_totcos = ld_costototal,
--        frp_totemp = li_emptotal,
--        frp_pertra = wn_pertra
--  where frp_keyrph = li_secrph;
-- agregue el 25.05.06
update usrsiho.holofrph
set frp_totcos = ld_costototal,
frp_totemp = li_emptotal
where frp_keyrph = li_secrph;
-- ---------------------------------------------------------------------------------------------
-- actualizamos en tmp_cont_exclu el con_stscon con  'P' para indicar que este ya fue procesado
-- ---------------------------------------------------------------------------------------------
update usrsiho.tmp_cont_exclu
set con_stscon = 'P',
con_keyusu = pn_keypro,
con_fecmod = pd_fechaact
where con_keydep = ps_programa
and con_keynom = pi_keynom
and con_fecpag = pd_fechatrab
and con_tipfol = ls_tipfol
and con_forpag = pi_forpag
and con_tiptra = ps_tiptra
and con_stscon = 'A'
and con_tipcam = pd_tipcam
and con_keyemp = li_emp_exclu1
and con_keypro = pn_keypro
and con_arefis = ps_arefis
and con_fpafin = pi_fpagfi;  ---aedo forma de pago final
-- --------------------------------------------------------------------------
-- obtenemos la descripcion de la nomina para efectos del reporte hrpintinc3
-- -------------------------------------------------------------------------
ws_desnom:= null;
ws_descen:= null;
select nom_destip
into strict ws_desnom
from usrsiho.nmlonomi
where nom_keynom = pi_keynom;
-- ---------------------------------------------------------------------------------
-- obtenemos la descripcion del centro de costos para efectos del reporte hrpintinc3
-- ---------------------------------------------------------------------------------
begin
select dep_desdep
into strict ws_descen
from usrsiho.nmcodeps
where dep_keydep = ps_programa;
exception when no_data_found then ws_descen:= null;
end;
insert into usrsiho.glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_numsec,
cry_dec006,
cry_chr003,
cry_chr012,
cry_chr001,
cry_chr014,
cry_chr018,
cry_chr017,
cry_chr019,
cry_chr015,
cry_dec001,
cry_dec011,
cry_dec007,
cry_dec009,
cry_chr016)
select ws_nomrep,
ps_idepcc,
pi_keyusu,
li_secrph,
pi_keynom,
ws_desnom,
ps_programa,
ws_descen,
pd_fechatrab,
ls_tipfol,
ps_tiptra,
pi_forpag,
a.pam_folini,
pn_tipcam,
ld_costototal,
li_numregis,
li_fpafin,
b.pam_folini
from usrsiho.glcopams a, usrsiho.glcopams b
where a.pam_keypar = 'H10'
and a.pam_cvesec = pi_forpag
and b.pam_keypar = 'H10'
and b.pam_cvesec = li_fpafin;
end if;
end loop;
end loop;
end;
$body$
language plpgsql
;
