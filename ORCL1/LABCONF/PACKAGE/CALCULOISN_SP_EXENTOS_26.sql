create or replace procedure labconf.calculoisn_sp_exentos_26 (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tope decimal(12,2);
wn_tot_emp numeric(6);
wn_tot_imp decimal(12,2);
wn_imp_dif decimal(12,2);
wn_tot_bas decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--exento del estado de sonora
--se reparte entre todos los empleados
wn_tope := wn_uma * 6 * 30.4;
select count(*) into strict wn_tot_emp
from labconf.nmlohemp
where hem_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per
and hem_ca1aux in (select pam_cvesec from labconf.glcopams where pam_keypar  ='IEST' and pam_folini = '26');
if wn_tot_emp  >= 1 and wn_tot_emp <= 5 then
insert into labconf.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,mov_keyben,mov_comfam)
select mov_keyemp,'S08',wn_key_nom,mov_keydep,mov_keypue,0, wn_uma * 30.4,mov_fecmov,mov_keyper,mov_keypro,'ISE','03','N0',0,mov_ca1aux,'',0,0,0,0,0
from labconf.nmwkmovt
where mov_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and mov_ca1aux in (select pam_cvesec from labconf.glcopams where pam_keypar  ='IEST' and pam_folini = '26')
and mov_keycon = 'B26';
end if;
if wn_tot_emp > 5 and wn_tot_emp <= 20 then
select sum(mov_import) into strict wn_tot_bas
from labconf.nmwkmovt
where mov_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and mov_ca1aux in (select pam_cvesec from labconf.glcopams where pam_keypar  ='IEST' and pam_folini = '26')
and mov_keycon = 'B26';
insert into labconf.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,mov_keyben,mov_comfam)
select mov_keyemp,'S08',wn_key_nom,mov_keydep,mov_keypue,0,(mov_import / wn_tot_bas) * wn_tope,mov_fecmov,mov_keyper,mov_keypro,'ISE','03','N0',0,mov_ca1aux,'',0,0,0,0,0
from labconf.nmwkmovt
where mov_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and mov_ca1aux in (select pam_cvesec from labconf.glcopams where pam_keypar  ='IEST' and pam_folini = '26')
and mov_keycon = 'B26';
--al dividir el exento entre el numero de empleados, es posible que la sumatoria entre los registros de movimientos
--y el exento calculado tenga diferencias de centavos.
--por esa realiza un ajuste con la diferencia sumando un centavo a los primeros empleados
select sum(mov_import) into strict wn_tot_imp
from labconf.nmwkmovt
where mov_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and mov_keycon = 'S08';
wn_imp_dif := wn_tope - wn_tot_imp;
update labconf.nmwkmovt
set mov_import = mov_import + 0.01
where mov_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and mov_keycon = 'S08'  * 100 limit (wn_imp_dif);
/* commit; */
end if;end;
$body$
language plpgsql
;
