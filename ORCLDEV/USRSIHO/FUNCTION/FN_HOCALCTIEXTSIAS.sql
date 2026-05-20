create or replace  function  usrsiho."fn_hocalctiextsias"  (pi_entrada integer, pi_salida integer, pi_comida integer, pi_capini integer, pi_capfin integer, ps_programa varchar, pl_keyfol integer, pl_keypue varchar, pd_costo decimal, pi_keytco integer, pi_keyemp integer) returns decimal as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- definimos variables para los tipos de jornadas
pc_jornocturna varchar(1);
pc_jordiurna varchar(1);
pc_jormixta varchar(1);
pc_jorx varchar(1);
-- definimos variables de trabajo
li_minent integer;
li_minsal integer;
li_mindif integer;
li_minext integer;
ls_tipojornada varchar(1);
li_numcap integer;
li_pertra integer;
li_tipemp integer;
li_tippro integer;
li_tippro1 integer;
ld_nfactor decimal(13,2);
ld_nminjornada60 decimal(13,2);
ld_nminjornada30 decimal(13,2);
ld_nminjornada15 decimal(13,2);
ld_minjor decimal(13,2);
li_tieext decimal(10,2);
begin
ld_nminjornada60 := 0;
ld_nminjornada30 := 0;
ld_nminjornada15 := 0;
if pi_entrada = 0 then
return 0;
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
else -- salio al d?siguiente de que entro
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
li_numcap := pi_capfin - pi_capini + 1; -- + pf_obtentotcapitulos(pl_keyfol, ps_keyemp, pl_keypue, pd_costo, pi_entrada, pi_salida, pi_comida, pl_foliorph)
-- ---------------------------------------------------
-- leemos el periodo de transmision y tipo de programa
-- ---------------------------------------------------
li_pertra := 0;
li_tippro := 0;
select coalesce(con_pertra,0)
into strict li_pertra
from holocont
where con_keyemp = pi_keyemp
and con_keyfol = pl_keyfol
and con_keytco = pi_keytco;
if li_pertra <> 0 then
li_tippro := 0;
select coalesce(ald_keytpr,0)
into strict li_tippro
from nmloalde
where ald_keydep = trim(both ps_programa);
if li_tippro = 0 then
select ald_pertra,ald_keytpr
into strict li_pertra,li_tippro
from nmloalde
where ald_keydep = trim(both ps_programa);
end if;
else
select ald_pertra,ald_keytpr
into strict li_pertra,li_tippro
from nmloalde
where ald_keydep = trim(both ps_programa);
end if;
-- --------------------------
-- leemos el tipo de empleado
-- --------------------------
li_tipemp := 0;
select oracle.substr(pue_ca4aux,9,1)
into strict li_tipemp
from nmcopues
where pue_keypue = pl_keypue;
-- -----------------------------------------------
-- valuaci?e ld_nfactor y ld_nminjornada60
-- -----------------------------------------------
if li_pertra > 59 or li_numcap > 1 or li_tipemp = 1 then
ld_nfactor := 0;
ld_nminjornada60 := 0;
select hoe_jorcos,hoe_jortie
into strict ld_nfactor,ld_nminjornada60
from holohoex
where hoe_pertra = '60'
and hoe_jornad = ls_tipojornada;
end if;
-- -------------------------------------------
-- valuaci?e ld_nfactor y ld_nminjornada30
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
from holohoex
where hoe_pertra = '30'
and hoe_keytpr = li_tippro1;
end if;
-- -------------------------------------------
-- valuaci?e ld_nfactor y ld_nminjornada15
-- -------------------------------------------
if li_pertra = 15 and li_tipemp <> 1 then
ld_nfactor := 0;
ld_nminjornada15 := 0;
select hoe_jorcos,hoe_jortie
into strict ld_nfactor,ld_nminjornada15
from holohoex
where hoe_pertra = '15';
end if;
-- -------------------------
-- asignaci?e ld_minjor
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
-- evaluaci?e tiempo extra
-- ----------------------------------------
-- obtenemos el numero de horas extras
li_tieext := ((li_minext/60) * 2);
return li_tieext;end;
--dmap converted function completed
$body$
language plpgsql
stable;
