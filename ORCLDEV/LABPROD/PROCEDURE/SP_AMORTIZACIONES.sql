create or replace procedure labprod."sp_amortizaciones"  (keyper nmlohism.his_keyper%type, keypro nmlohism.his_keypro%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_res_pue amortizaciones.amo_valida%type;
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
reg record;
begin
wn_res_pue:= null;
wd_fec_mov:= clock_timestamp();
tipopago := ' ';
select trim(both pam_cvesec) into strict ws_cve_cte from glcopams
where pam_keypar = 'CFIN'
and pam_folfin = 'AMO';
select pro_diaper into strict wn_dia_per
from nmloproc
where pro_keypro = keypro;
if wn_dia_per = 7 then
tipopago := 'SEMANA';
elsif wn_dia_per = 10 then
tipopago := 'DECENA';
elsif wn_dia_per = 15 then
tipopago := 'QUINCENA';
end if;/* dmap converted statement start */
for reg in (select amo_keyemp, to_char(amo_keypro,'FM00') amo_keypro, emp_recurp, amo_keycon, amo_keypre, amo_imppag, to_char(pre_refere,'FM000') pre_refere,
coalesce(oracle.substr(pam_nompar,1,50), ' ') descripcion, amo_ctreve, to_char(amo_numpag,'FM000') amo_numpag
from nmloamor
inner join nmcoempl on (amo_keyemp = emp_keyemp)
inner join nmlopres on ( amo_keyemp = pre_keyemp and amo_keycon = pre_keycon and amo_keypre = pre_keypre)
left outer join glcopams on (pam_keypar = 'AM' and pam_cvesec = amo_tiptra)
where pre_ca2aux = '1'
and amo_imppag > 0
and amo_keyper = keyper
and amo_keypro = keypro
and amo_keycon in (select pam_folini from glcopams
where pam_keypar = (select pam_folini from glcopams
where pam_cvesec = 'iinsaf'
and pam_keypar = '00')
and pam_folfin =  concat('AMO', ws_cve_cte)
)
) loop
importe := sp_tovarchar2(reg.amo_imppag);/* dmap converted statement end *//* dmap converted statement start */
foliolabora :=  concat(keyper, reg.amo_keypro , reg.amo_keyemp , reg.amo_keycon , reg.amo_numpag , reg.pre_refere) ;/* dmap converted statement end */
begin
select count(*) into strict wn_tot_reg from casolpagolabora
where "idfoliolabora" = foliolabora;
if wn_tot_reg = 0 then
insert into casolpagolabora("idfoliolabora", "sesion", "numcliente", "cveempleado", "numnomina", "idprestamo", "montopago",
"interes", "fechasol", "fechaapl", "comentario", "idestatus", "ctrleventos", "nota", "codigo2", "tipopago")
values ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.amo_keyemp, reg.pre_refere, importe,
0, wd_fec_mov, wd_fec_mov, reg.descripcion, 15008, reg.amo_ctreve, ' ', reg.amo_keycon, tipopago);
end if;
/* commit; */
exception
when others then
null;
end;
end loop;end;
$body$
language plpgsql
;
