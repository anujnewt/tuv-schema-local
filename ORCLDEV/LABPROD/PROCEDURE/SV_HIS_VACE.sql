create or replace procedure labprod."sv_his_vace"  ( num integer, his_vace inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open his_vace for select vac_keyemp, emp_nomemp, sum(vac_salper) from nmcocvac, nmcoempl where nmcoempl.emp_keyemp = nmcocvac.vac_keyemp and nmcocvac.vac_keyemp = num and nmcocvac.vac_status = 'V' group by emp_nomemp, vac_keyemp;end;
$body$
language plpgsql
;
