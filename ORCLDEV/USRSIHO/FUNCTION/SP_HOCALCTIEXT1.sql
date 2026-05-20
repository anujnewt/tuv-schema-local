create or replace  function  usrsiho."sp_hocalctiext1"  (pi_entrada numeric, pi_salida numeric, pi_comida numeric, pi_capini numeric, pi_capfin numeric, ps_programa varchar, pl_keyfol numeric, pl_keypue varchar, pd_costo numeric, pi_keytco numeric, pi_keyemp numeric, pd_fecgra timestamp(0)) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- -----------------------------------------------------------------
-- sp_hocalctiext: este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de actores de honorarios
-- para obtener las horas y minutos de tiempo extra en relaci?n a la
-- hora de entrada y salida que se captura en el llamado.
-- devuelve un varchar2 con el importe y el numero de horas y minutos
-- realizado el 26 de octubre de 2016
-- paul henderson marin
-- modifico:                    comentario:				fecha:
-- 					  se genera a partir de 		26/10/2016
--                              sp_hocalctiext para obtener
--					  tanto el importe como las
--					  horas de tiempo extra
-- -----------------------------------------------------------------
-- definimos variables para los tipos de jornadas
pc_jornocturna varchar(1);
pc_jordiurna   varchar(1);
pc_jormixta    varchar(1);
pc_jorx  varchar(1);
-- definimos variables de trabajo
li_minent numeric(10);
li_minsal numeric(10);
li_mindif numeric(10);
li_minext numeric(10);
ls_tipojornada varchar(2);
li_numcap numeric(10);
li_pertra numeric(10);
li_tipemp numeric(10);
li_tippro numeric(10);
li_tippro1 numeric(10);
ld_nfactor decimal(13,2);
ld_nminjornada60 decimal(13,2);
ld_nminjornada30 decimal(13,2);
ld_nminjornada15 decimal(13,2);
ld_minjor decimal(13,2);
li_tieexthrs decimal(10,2);
li_tieextimp decimal(10,2);
ls_tieextmix varchar(20);
--declaramos la variable para el calculo de la edad (jcro)
ld_anios numeric;
ld_menoredad numeric;
ls_nacionalidad varchar(2);
li_codigoanda numeric(10);
li_tieext decimal(10,2);
ls_regrfc varchar(13);
begin
ld_nminjornada60 := 0;
ld_nminjornada30 := 0;
ld_nminjornada15 := 0;
ld_anios := 0;
ld_menoredad := 0;
ls_nacionalidad:= null;
li_codigoanda := 0;
li_tieext := 0;
if pi_entrada = 0  then
return  li_tieext;
end if;
-- aignamos valores a las variables para los tipos de jornada
pc_jornocturna := 'N';
pc_jordiurna := 'D';
pc_jormixta := 'M';
pc_jorx := 'X';
-- obtenemos el minuto de entrada y salida
li_minent := pi_entrada;
li_minsal := pi_salida;
-- ---------------------------------------------------------
-- obtenemos la diferencia entre minutos de entrada y salida
-- ---------------------------------------------------------
li_mindif := 0;
if li_minsal >= li_minent then
li_mindif := li_minsal - li_minent;
else -- salio al d?a siguiente de que entro
li_mindif := 1440 + li_minsal - li_minent;
end if;
-- ---------------------------------------------------------------
-- obtenemos el tipo de jornada deacuerdo a los minutos de entrada
-- ---------------------------------------------------------------
if li_minent >= 0 and li_minent <= 149 then
ls_tipojornada := pc_jornocturna;
end if;
if li_minent >= 150 and li_minent <= 359 then
ls_tipojornada := pc_jorx;
end if;
if li_minent >= 360 and li_minent <= 749 then
ls_tipojornada := pc_jordiurna;
end if;
if li_minent >= 750 and li_minent <= 989 then
ls_tipojornada := pc_jormixta;
end if;
if li_minent >= 990 then
ls_tipojornada := pc_jornocturna;
end if;
-- -----------------------------
-- evaluamos el n?mero de capitulos
-- -----------------------------
li_numcap := pi_capfin - pi_capini + 1;    -- + pf_obtentotcapitulos(pl_keyfol, ps_keyemp, pl_keypue, pd_costo, pi_entrada, pi_salida, pi_comida, pl_foliorph)
-- ---------------------------------------------------
-- leemos el periodo de transmision y tipo de programa
-- ---------------------------------------------------
li_pertra := 0;
li_tippro := 0;
select coalesce(con_pertra,0)
into strict li_pertra
from usrsiho.holocont
where con_keyemp = pi_keyemp
and con_keyfol = pl_keyfol
and con_keytco = pi_keytco;
if li_pertra <> 0 then
li_tippro := 0;
select coalesce(ald_keytpr,0)
into strict li_tippro
from usrsiho.nmloalde
where ald_keydep = trim(both ps_programa);
if li_tippro = 0 then
select ald_pertra,ald_keytpr
into strict li_pertra,li_tippro
from usrsiho.nmloalde
where ald_keydep =  trim(both ps_programa);
end if;
else
select ald_pertra,ald_keytpr
into strict li_pertra,li_tippro
from usrsiho.nmloalde
where ald_keydep =  trim(both ps_programa);
end if;
-- --------------------------
-- leemos el tipo de empleado
-- --------------------------
li_tipemp := 0;
select oracle.substr(pue_ca4aux,9, 1)
into strict li_tipemp
from usrsiho.nmcopues
where pue_keypue = pl_keypue;
-- //inicio cons-0530 mejoras sai juan carlos reyes olivera 07/09/2011
-- -----------------------------------------------------
-- obtenemos los a?os considerados para el menor de edad
-- -----------------------------------------------------
select coalesce(pam_folini,0)
into strict ld_menoredad
from usrsiho.glcopams
where pam_keypar = 'TEME';
-- -----------------------------------------------------
-- obtenemos la nacionalidad del empleado
-- -----------------------------------------------------
select emp_ca3aux
into strict ls_nacionalidad
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
-- -----------------------------------------------------
-- obtenemos el codigo de la anda
-- -----------------------------------------------------
select (pam_folini)::numeric
into strict li_codigoanda
from usrsiho.glcopams
where pam_keypar = 'ACP'
and pam_folfin= 'CODIGO ANDA';/* dmap converted statement start */
-- --------------------------------------------------------------------
-- calculamos la edad del empleado para determinar si es menor de edad
-- --------------------------------------------------------------------
if ls_nacionalidad = '02' then
select ((pd_fecgra - ale_fecnac)/365.25::numeric)
into strict ld_anios
from usrsiho.holoalem
where ale_keyemp= pi_keyemp;/* dmap converted statement end */
else
if li_codigoanda <> pi_keyemp then
select emp_regrfc into strict ls_regrfc
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;/* dmap converted statement start */
if (oracle.substr(ls_regrfc,7,2))::numeric  > 0 and (oracle.substr(ls_regrfc,9,2))::numeric  > 0 and (oracle.substr(ls_regrfc,5,2))::numeric  >= 0 then
if oracle.substr(ls_regrfc,5,2) > oracle.substr(year(clock_timestamp()) + 5, 3,2) then
ld_anios := (pd_fecgra - to_date( concat('19', oracle.substr(ls_regrfc,5,2), '/', oracle.substr(ls_regrfc,7,2), '/', oracle.substr(ls_regrfc,9,2)) ,'yyyy/mm/dd')) /365.25;/* dmap converted statement end *//* dmap converted statement start */
else
ld_anios := (pd_fecgra - to_date( concat('20', oracle.substr(ls_regrfc,5,2), '/', oracle.substr(ls_regrfc,7,2), '/', oracle.substr(ls_regrfc,9,2)) ,'yyyy/mm/dd')) /365.25;/* dmap converted statement end */
end if;
else
ld_anios := 99;
end if;
/*  select case when to_number(oracle.substr(emp_regrfc,7,2)) > 0 and to_number(oracle.substr(emp_regrfc,9,2)) > 0 and to_number(oracle.substr(emp_regrfc,5,2)) >= 0 then
(pd_fecgra - to_date(oracle.substr(emp_regrfc,5,2)||'/'||oracle.substr(emp_regrfc,7,2)||'/'||oracle.substr(emp_regrfc,9,2),'RR/mm/dd')) /365.25
else
99
end
into ld_anios
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;*/
else
ld_anios := 99;
end if;
end if;/* dmap converted statement start */
-- ---------------------------------------------------------------------------------
-- evaluamos y reasignamos el valor del tipo de jornada en caso de ser menor de edad
-- ---------------------------------------------------------------------------------
if ld_anios < ld_menoredad then
ls_tipojornada :=  concat('M', ls_tipojornada) ;/* dmap converted statement end */
end if;
-- //fin cons-0530 mejoras sai juan carlos reyes olivera 07/09/2011
--insert into borra(sec,campo1,campo2,campo3) values(12,'Li_TipEmp',li_tipemp,'');
--insert into borra(sec,campo1,campo2,campo3) values(12,'Pi_Comida',pi_comida,'Despues de validar');
-- -----------------------------------------------
-- valuaci?n de ld_nfactor y ld_nminjornada60
-- -----------------------------------------------
if li_pertra > 59 or li_numcap > 1 or li_tipemp = 1 then
ld_nfactor := 0;
ld_nminjornada60 := 0;
select hoe_jorcos,hoe_jortie
into strict ld_nfactor,ld_nminjornada60
from usrsiho.holohoex
where hoe_pertra = '60'
and hoe_jornad = ls_tipojornada;
end if;
-- -------------------------------------------
-- valuaci?n de ld_nfactor y ld_nminjornada30
-- -------------------------------------------
if li_pertra = 30 and li_tipemp <> 1 then
ld_nfactor := 0;
ld_nminjornada30 := 0;
if li_tippro = 1 then
li_tippro1 := li_tippro;
else
li_tippro1 := 0;
end if;
select hoe_jorcos,hoe_jortie
into strict ld_nfactor,ld_nminjornada30
from usrsiho.holohoex
where hoe_pertra = '30'
and hoe_keytpr = li_tippro1;
end if;
-- -------------------------------------------
-- valuaci?n de ld_nfactor y ld_nminjornada15
-- -------------------------------------------
if li_pertra = 15 and li_tipemp <> 1 then
ld_nfactor := 0;
ld_nminjornada15 := 0;
select hoe_jorcos,hoe_jortie
into strict ld_nfactor,ld_nminjornada15
from usrsiho.holohoex
where hoe_pertra = '15';
end if;
-- -------------------------
-- asignaci?n de ld_minjor
-- -------------------------
ld_minjor := ld_nminjornada60;
if li_pertra = 30 and li_numcap = 1 then
ld_minjor := ld_nminjornada30;
end if;
if li_pertra = 15 then
ld_minjor := ld_nminjornada15;
end if;
if li_tipemp = 1 then
ld_minjor := ld_nminjornada60;
end if;
li_minext := 0;
ld_minjor := ld_minjor + pi_comida;
if li_mindif > ld_minjor then
li_minext := li_mindif - ld_minjor;
end if;
-- si el tipo es 1 (telenovela) el n?mero de capitulos siempre es uno
if li_tippro <> 1 and li_numcap > 1 then
li_numcap := 1;
end if;
-- ----------------------------------------
-- evaluaci?n de tiempo extra
-- ----------------------------------------
-- obtenemos el importe de las horas extras
li_tieextimp := pd_costo * li_numcap * li_minext * 2 / ld_nfactor;
-- obtenemos el numero de horas extras
li_tieexthrs := ((li_minext/60) * 2);/* dmap converted statement start */
ls_tieextmix :=  concat(li_tieextimp, 'H' , li_tieexthrs) ;/* dmap converted statement end */
return ls_tieextmix;
-- ------------------------------------------------------------------------------------------------
end;
--dmap converted function completed
$body$
language plpgsql
stable;
