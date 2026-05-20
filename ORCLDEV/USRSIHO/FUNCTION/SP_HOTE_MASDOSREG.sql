create or replace  function  usrsiho."sp_hote_masdosreg"  (pi_num_id numeric, pi_keyemp numeric, pi_serial numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- -----------------------------------------------------------------
-- creo: 			comentario:								fecha:
-- juan carlos reyes olivera	sp_hote_masdosreg: este stored procedure se utiliza para saber		29 de junio de 2011
--				si un actor tiene mas de dos registros con diferente contrato
-- 				esto paea saber si se le debe de calcular el tiempo extra solo
-- 				a un registro y no duplicar el pago de esta oncidencia.
-- 				devuelve un entero si al registro se debe o no calcular te
--
-- modifico:			comentario:								fecha:
--
--
-- -----------------------------------------------------------------
li_num_reg numeric(10);
li_serial numeric(10);
li_resultado numeric(10);
li_keypue numeric(10);
begin
li_serial := 0;
li_num_reg := 0;
li_resultado := 1;
li_keypue := 0;
select det_keypue
into strict li_keypue
from usrsiho.holodettra
where det_serial = pi_serial;
select coalesce(count(*),1)
into strict li_num_reg
from usrsiho.holodettra, usrsiho.nmloalde
where det_keydep = ald_keydep and
det_num_id = pi_num_id and
det_keyemp = pi_keyemp and
det_keypue = li_keypue and
nullif(det_keyfol::text, '') is not null and
det_stsreg = 'V' and
det_inanda = 'N' and
ald_keytpr <> 1;
if li_num_reg > 1 then
select min(det_serial)
into strict li_serial
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_keyemp = pi_keyemp and
nullif(det_keyfol::text, '') is not null and
det_stsreg = 'V' and
det_inanda = 'N';
if li_serial = pi_serial then
li_resultado := 1;
else
li_resultado := 0;
end if;
end if;
return li_resultado;end;
--dmap converted function completed
$body$
language plpgsql
stable;
