create or replace procedure usrsai."sp_updatedetpcanr"  ( numpco numeric, idereg numeric, keyemp numeric, sexo varchar, nomreal varchar, apepat varchar, apemat varchar, regrfc varchar, nomart varchar, cranda varchar, calle varchar, numext varchar, numint varchar, colemp varchar, codpos varchar, munemp varchar, cidemp varchar, nacion varchar, paisres varchar, lugnac varchar, telefono varchar, edad numeric, fecnac varchar, calsind varchar, calmig varchar, clasif varchar, tabulador numeric, sindicato varchar, siscon varchar, fecgra varchar, person varchar, numcap varchar, tabulade numeric, padiftab numeric, totcap numeric, conjunto varchar, idioma varchar, tipval numeric, tipopago numeric, stsreg numeric, recurp varchar, chklst varchar, cont inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
select coalesce(count(*), 0) into strict cont from detpcanr
where dpc_idereg = idereg and dpc_numpco = numpco;
if cont >= 1 then
update detpcanr
set dpc_keyemp = keyemp,
dpc_sexo = sexo,
dpc_nomreal = nomreal,
dpc_apepat = apepat,
dpc_apemat = apemat,
dpc_regrfc = regrfc,
dpc_nomart = nomart,
dpc_cranda = cranda,
dpc_domemp = calle,
dpc_numext = numext,
dpc_numint = numint,
dpc_colemp = colemp,
dpc_codpos = codpos,
dpc_munemp = munemp,
dpc_cidemp = cidemp,
dpc_nacion = nacion,
dpc_paisres = paisres,
dpc_lugnac = lugnac,
dpc_telefono = telefono,
dpc_edad = edad,
dpc_fecnac = to_timestamp(fecnac,'dd/mm/yyyy'),
dpc_calsind = calsind,
dpc_calmig = calmig,
dpc_clasif = clasif,
dpc_tabulador = tabulador,
dpc_sindicato = sindicato,
dpc_siscon = siscon,
dpc_fecgra = to_timestamp(fecgra,'dd/mm/yyyy'),
dpc_person = person,
dpc_numcap = numcap,
dpc_tabulade = tabulade,
dpc_padiftab = padiftab,
dpc_totcap = totcap,
dpc_conjunto = conjunto,
dpc_idioma = idioma,
dpc_tipval = tipval,
dpc_tipopago = tipopago,
dpc_stsreg = stsreg,
dpc_recurp = recurp,
dpc_chklst = chklst
where dpc_idereg = idereg
and dpc_numpco = numpco;
end if;end;
$body$
language plpgsql
;
