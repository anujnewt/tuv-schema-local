create or replace procedure usrsai."sp_insertdetpcanr"  ( numpco numeric, keyemp numeric, sexo varchar, nomreal varchar, apepat varchar, apemat varchar, regrfc varchar, nomart varchar, cranda numeric, calle varchar, numext varchar, numint varchar, colemp varchar, codpos varchar, munemp varchar, cidemp varchar, nacion varchar, paisres varchar, lugnac varchar, telefono varchar, edad numeric, fecnac varchar, calsind varchar, calmig varchar, clasif varchar, tabulador numeric, sindicato varchar, siscon varchar, fecgra varchar, person varchar, numcap varchar, tabulade numeric, padiftab numeric, totcap numeric, conjunto varchar, idioma varchar, tipval numeric, tipopago numeric, stsreg numeric, recurp varchar, chklst varchar, numllamados numeric, cvenacdad varchar, sigid inout numeric ) as $body$
--se agrega el argumento final numllamados, para guardar el numero de llamados del contrato, y la clave de la nacionalidad(para regimen fiscal) (ig-cons-0823)
declare
-- pgv moved types start
-- pgv moved types end
cont numeric;
begin
sigid := 0;
cont  := 0;
select count(*) into strict cont
from encpcanr
where epc_numpco = numpco;
if cont >= 1 then
select coalesce(max(dpc_idereg),0) + 1 into strict sigid
from detpcanr
where dpc_numpco = numpco;
insert into detpcanr(   dpc_numpco,     dpc_idereg,     dpc_keyemp,     dpc_sexo,       dpc_nomreal,    dpc_apepat,     dpc_apemat,     dpc_regrfc,
dpc_nomart,     dpc_cranda,     dpc_domemp,     dpc_numext,     dpc_numint,     dpc_colemp,     dpc_codpos,     dpc_munemp,
dpc_cidemp,     dpc_nacion,     dpc_paisres,    dpc_lugnac,     dpc_telefono,   dpc_edad,       dpc_fecnac,     dpc_calsind,
dpc_calmig,     dpc_clasif,     dpc_tabulador,  dpc_sindicato,  dpc_siscon,     dpc_fecgra,     dpc_person,     dpc_numcap,
dpc_tabulade,   dpc_padiftab,   dpc_totcap,     dpc_conjunto,   dpc_idioma,     dpc_tipval,     dpc_tipopago,   dpc_stsreg,
dpc_recurp,     dpc_chklst,     dpc_numllama,   dpc_cvenacdad)
values (                 numpco,         sigid,          keyemp,         sexo,           nomreal,        apepat,         apemat,         regrfc,
nomart,         cranda,         calle,          numext,         numint,         colemp,         codpos,         munemp,
cidemp,         nacion,         paisres,        lugnac,         telefono,       edad,           to_timestamp(fecnac,'dd/mm/yyyy'), calsind,
calmig,         clasif,         tabulador,      sindicato,      siscon,         to_timestamp(fecgra,'dd/mm/yyyy'), person, numcap,
tabulade,       padiftab,       totcap,         conjunto,       idioma,         tipval,         tipopago,       stsreg,
recurp,         chklst,         numllamados,    cvenacdad );
--se agrega el campo dpc_numllama a la instruccion insert y se le asigna el valor del argumento numllamado, y la clave de la nacionalidad se asigna el argumento cvenacdad (ig-cons-0823)
end if;end;
$body$
language plpgsql
;
