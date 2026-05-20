create or replace procedure usrsiho."sp_calculo_iva_isr"  (wn_key_pro numeric,wn_key_nom numeric, ws_key_per varchar, ws_key_con varchar, wn_por_cen numeric, ws_con_bas varchar, ws_cod_imp varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tot_bas decimal(16,2);  --suma del importe del concepto base
wn_tot_imp decimal(16,2);  --suma del importe del concepto de impuesto
wn_imp_ort decimal(16,2);  --c??lculo del impuesto a partir del total de la base
wn_dif decimal(16,2);   --diferencia entre el impuesta calculado y la suma del importe del concepto de impuesto.
wn_num_emp numeric(8); --n??mero de empleados a los que se les hara ajuste de 1 centavo
wn_aju_imp decimal(16,2);  --importe del ajuste
begin
/*realiza el c??lculo de iva e isr realizando un ajuste por empleado de tal forma que la sumatoria de iva e isr por empleado
sea igual que el c??lculo de iva e isr realizado con el total de la base */
--obtener la suma del importe del concepto base
select sum(mov_import) into strict wn_tot_bas
from usrsiho.nmwkmovt
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon = ws_con_bas;
--obtener la suma del impirte del concepto de impuesto
select sum(mov_import) into strict wn_tot_imp
from usrsiho.nmwkmovt
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon = ws_key_con;
wn_imp_ort := wn_tot_bas * wn_por_cen / 100;   --calculo del impuesto a partir de la suma del importe del concepto base
wn_dif := wn_tot_imp - wn_imp_ort;  --diferencia entre el impuesto c??lculado y la suma del importe del concepto de impuesto
wn_num_emp := abs(wn_dif * 100);   --n??mero de empleados con ajuste
if wn_dif = 0 then
return;
end if;
if wn_dif < 0 then
wn_aju_imp := 0.01;
else
wn_aju_imp := -0.01;
end if;
insert into usrsiho.tmp_empleados
select mov_keyemp
from usrsiho.nmwkmovt
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon = ws_key_con  limit (wn_num_emp);
--realizar el ajuste
update usrsiho.nmwkmovt set mov_import = mov_import + wn_aju_imp
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon = ws_key_con
and mov_keyemp in (select keyemp from usrsiho.tmp_empleados);
if ws_cod_imp = '01' then
update usrsiho.nmwkmovt set mov_import = mov_import + wn_aju_imp
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon in ('HTP','HPN')
and mov_keyemp in (select keyemp from usrsiho.tmp_empleados);
else
update usrsiho.nmwkmovt set mov_import = mov_import + wn_aju_imp
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon in ('HTD')
and mov_keyemp in (select keyemp from usrsiho.tmp_empleados);
update usrsiho.nmwkmovt set mov_import = mov_import - wn_aju_imp
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon in ('HPN')
and mov_keyemp in (select keyemp from usrsiho.tmp_empleados);
if ws_key_con = 'H24' then
update usrsiho.nmwkmovt set mov_import = mov_import + wn_aju_imp
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
and mov_keynom = wn_key_nom
and mov_keycon in ('H59')
and mov_keyemp in (select keyemp from usrsiho.tmp_empleados);
end if;
end if;
/* commit; */
end;
$body$
language plpgsql
;
