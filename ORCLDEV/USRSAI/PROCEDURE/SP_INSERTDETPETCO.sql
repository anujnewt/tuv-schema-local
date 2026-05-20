create or replace procedure usrsai."sp_insertdetpetco"  ( numpco numeric, keyemp numeric, nomart varchar, clasif varchar, tabulador numeric, sindicato varchar, siscon varchar, fecgra varchar, nomreal varchar, person varchar, numcap varchar, tabulade numeric, padiftab numeric, totcap numeric, conjunto varchar, nacion varchar, idioma varchar, tipval numeric, tipopago numeric, desclasif varchar, docfis varchar, numllamados numeric, sigid inout numeric) as $body$
--se agrego numllamados como un argumento al final ig-cons-0823
declare
-- pgv moved types start
-- pgv moved types end
cont integer;
begin
sigid := 0;
select count(*) into strict cont from encpetco
where epc_numpco = numpco;
if cont >= 1 then
select coalesce(max(dpc_idereg),0) + 1
into strict sigid
from detpetco
where dpc_numpco = numpco;
--se especificaco la inserci?el campo dpc_numllama ig-cons-0823
insert into detpetco(dpc_numpco, dpc_idereg, dpc_keyemp, dpc_nomart, dpc_clasif, dpc_descla,
dpc_tabulador, dpc_sindicato, dpc_siscon, dpc_fecgra, dpc_nomreal, dpc_person, dpc_numcap,
dpc_tabulade, dpc_padiftab, dpc_totcap, dpc_conjunto, dpc_nacion, dpc_idioma, dpc_tipval,
dpc_tipopago, dpc_stsreg, dpc_docfis, dpc_numllama)
values (numpco, sigid, keyemp, nomart, clasif, desclasif, tabulador, sindicato, siscon, to_timestamp(fecgra,'dd/mm/yyyy'),
nomreal, person, numcap, tabulade, padiftab, totcap, conjunto, nacion, idioma, tipval, tipopago, 1,
docfis, numllamados);
end if;end;
$body$
language plpgsql
;
