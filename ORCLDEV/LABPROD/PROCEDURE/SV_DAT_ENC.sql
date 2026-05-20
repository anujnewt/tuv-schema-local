create or replace procedure labprod."sv_dat_enc"  ( num numeric, num_emp inout numeric, nom_emp inout char, nom_jef inout char, pue_jef inout char) as $body$
declare
-- pgv moved types start
-- pgv moved types end
num_jef numeric;
begin
select plz_keyemp,
plz_cverem,
emp_nomemp
into strict num_emp,
num_jef,
nom_emp
from eocoplza,
nmcoempl
where eocoplza.plz_keyemp = nmcoempl.emp_keyemp
and eocoplza.plz_keyemp   = num;
select emp_nomemp,
pue_despue
into strict nom_jef,
pue_jef
from nmcoempl,
nmcopues,
eocoplza
where nmcoempl.emp_keyemp = num_jef
and nmcoempl.emp_keyemp   = eocoplza.plz_keyemp
and nmcopues.pue_keypue   = eocoplza.plz_keypue;end;
$body$
language plpgsql
;
