create or replace procedure labprod.tvautsaf_local_sp_amortizaciones (keyper labprod.nmloamor.amo_keyper%type, keypro labprod.nmloamor.amo_keypro%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_res_pue labprod.amortizaciones.amo_valida%type;
--igneos.i
wn_tot_reg numeric;
wn_cve_emp numeric;
ws_cve_con varchar(3);
wn_ref_ere decimal(16,6);
wn_imp_ort decimal(12,2);
ws_cve_conceptos varchar(100);
ws_cve_cte varchar(5);
wd_fec_mov timestamp(0);
wn_dia_per numeric;
importe varchar(12);
proceso numeric;
refere varchar(2);
foliolabora varchar(30);
tipopago varchar(10);
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
reg record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
wn_res_pue:= null;
wd_fec_mov:= clock_timestamp();
tipopago := ' ';
select trim(both pam_cvesec) into strict ws_cve_cte from labprod.glcopams
where pam_keypar = 'SAFT'
and pam_folfin = 'C';
select pro_diaper into strict wn_dia_per
from labprod.nmloproc
where pro_keypro = keypro;
if wn_dia_per = 7 then
tipopago := 'SEMANA';
elsif wn_dia_per = 10 then
tipopago := 'DECENA';
elsif wn_dia_per = 15 then
tipopago := 'QUINCENA';
end if;/* dmap converted statement start */
for reg in (select amo_keyemp, to_char(amo_keypro,'FM00') amo_keypro, emp_recurp, amo_keycon, amo_keypre, amo_imppag, amo_unipag, to_char(pre_refere,'FM000') pre_refere,
coalesce(oracle.substr(pam_nompar,1,50), ' ') descripcion, amo_ctreve, to_char(amo_numpag,'FM000') amo_numpag, amo_fecpag
from labprod.nmloamor
inner join labprod.nmcoempl on (amo_keyemp = emp_keyemp)
inner join labprod.nmlopres on ( amo_keyemp = pre_keyemp and amo_keycon = pre_keycon and amo_keypre = pre_keypre)
left outer join labprod.glcopams on (pam_keypar = 'AM' and pam_cvesec = amo_tiptra)
where pre_ca2aux = '1'
and amo_imppag > 0
and amo_keyper = keyper
and amo_keypro = keypro
and amo_tiptra = 'C'
and amo_keycon in (select pam_folini from labprod.glcopams
where pam_keypar = (select pam_folini from labprod.glcopams
where pam_cvesec = 'iaasaf'
and pam_keypar = '00')
and pam_folfin =  concat('AMO', ws_cve_cte)
)
) loop
importe := sp_tovarchar2(reg.amo_imppag);/* dmap converted statement end *//* dmap converted statement start */
foliolabora :=  concat(keyper, reg.amo_keypro , reg.amo_keyemp , reg.amo_keycon , reg.amo_numpag , reg.pre_refere) ;/* dmap converted statement end */
begin
select count(*) into strict wn_tot_reg from saf_amca
where "idfoliolabora" = foliolabora;
if wn_tot_reg = 0 then
insert into saf_amca("idfoliolabora", "sesion", "numcliente", "cveempleado", "numnomina", "idprestamo", "montopago",
"interes", "fechasol", "fechaapl", "comentario", "idestatus", "ctrleventos", "nota", "codigo2", "tipopago", "proceso", "periodo")
values ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.amo_keyemp, reg.pre_refere, importe,
reg.amo_unipag, reg.amo_fecpag, wd_fec_mov, reg.descripcion, 15008, reg.amo_ctreve, ' ', reg.amo_keycon, tipopago, reg.amo_keypro, keyper);
end if;
/* commit; */
--exception
--  when others then
--    null;
end;
end loop;end;
$body$
language plpgsql
;
