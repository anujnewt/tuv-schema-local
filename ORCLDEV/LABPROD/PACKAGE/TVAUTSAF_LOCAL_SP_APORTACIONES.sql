create or replace procedure labprod.tvautsaf_local_sp_aportaciones (keyper labprod.nmloamor.amo_keyper%type, keypro labprod.nmloamor.amo_keypro%type) as $body$
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
select pro_diaper into strict wn_dia_per
from labprod.nmloproc
where pro_keypro = keypro;
if wn_dia_per = 7 then
tipopago := 'SEMANA';
elsif wn_dia_per = 10 then
tipopago := 'DECENA';
elsif wn_dia_per = 15 then
tipopago := 'QUINCENA';
end if;
-- aportaciones caja de ahorro
select trim(both pam_cvesec) into strict ws_cve_cte from labprod.glcopams
where pam_keypar = 'SAFT'
and pam_folfin = 'C';/* dmap converted statement start */
for reg in (select his_keyemp, to_char(his_keypro,'FM00') his_keypro, emp_recurp, his_keycon, his_import, his_fecmov
from labprod.nmlohism
inner join labprod.nmcoempl on (his_keyemp = emp_keyemp)
where his_import > 0
and his_keyper = keyper
and his_keypro = keypro
and his_keycon in (select pam_folini from labprod.glcopams
where pam_keypar = (select pam_folini from labprod.glcopams
where pam_cvesec = 'iaasaf'
and pam_keypar = '00')
and pam_folfin =  concat('APO', ws_cve_cte)
)
) loop
importe := sp_tovarchar2(reg.his_import);/* dmap converted statement end *//* dmap converted statement start */
foliolabora :=  concat(keyper, reg.his_keypro , reg.his_keyemp , reg.his_keycon , importe) ;/* dmap converted statement end */
begin
select count(*) into strict wn_tot_reg from saf_apca
where "idfoliolabora" = foliolabora;
if wn_tot_reg = 0 then
insert into saf_apca("idfoliolabora", "sesion", "numcliente", "cveempleado", "numnomina", "cuenta", "aportacion", "tipomov",
"fechasol", "fechaapl", "idestatus", "nota", "tipopago", "proceso", "periodo")
values ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.his_keyemp, reg.his_keycon, importe, 'AP',
reg.his_fecmov, wd_fec_mov, 15008, ' ', tipopago, reg.his_keypro,keyper);
end if;
/* commit; */
exception
when others then
null;
end;
end loop;
--aportaciones n?mina con causa
select trim(both pam_cvesec)
into strict ws_cve_cte from labprod.glcopams
where pam_keypar = 'SAFT'
and pam_folfin = 'N';/* dmap converted statement start */
for reg in (select his_keyemp, to_char(his_keypro,'FM00') his_keypro, emp_recurp, his_keycon, his_import, his_fecmov
from labprod.nmlohism
inner join labprod.nmcoempl on (his_keyemp = emp_keyemp)
where his_import > 0
and his_keyper = keyper
and his_keypro = keypro
and his_keycon in (select pam_folini from labprod.glcopams
where pam_keypar = (select pam_folini from labprod.glcopams
where pam_cvesec = 'iaasaf'
and pam_keypar = '00')
and pam_folfin =  concat('APO', ws_cve_cte)
)
) loop
importe := sp_tovarchar2(reg.his_import);/* dmap converted statement end *//* dmap converted statement start */
foliolabora :=  concat(keyper, reg.his_keypro , reg.his_keyemp , reg.his_keycon , importe) ;/* dmap converted statement end */
begin
select count(*) into strict wn_tot_reg from saf_apnc
where "idfoliolabora" = foliolabora;
if wn_tot_reg = 0 then
insert into saf_apnc("idfoliolabora", "sesion", "numcliente", "cveempleado", "numnomina", "cuenta", "aportacion", "tipomov",
"fechasol", "fechaapl", "idestatus", "nota", "tipopago","proceso","periodo")
values ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.his_keyemp, reg.his_keycon, importe, 'AP',
reg.his_fecmov, wd_fec_mov, 15008, ' ', tipopago, reg.his_keypro, keyper);
end if;
/* commit; */
exception
when others then
null;
end;
end loop;
--aportaciones fondo de ahorro
select trim(both pam_cvesec) into strict ws_cve_cte from labprod.glcopams
where pam_keypar = 'SAFT'
and pam_folfin = 'F';
for reg in ( select his_keyemp, to_char(his_keypro,'FM00') his_keypro, emp_recurp, mapeo.pam_folini his_keycon, his_import, his_fecmov
from labprod.nmlohism
inner join labprod.nmcoempl on (his_keyemp = emp_keyemp)
inner join (select array_to_string(a,'') from regexp_matches(pam_nompar,'[^,]+', 1, 1, 'g') as foo(a)) mapeo on mapeo.concepto = his_keycon
where his_import > 0
and his_tipplz = 'F'
and his_keyper = keyper
and his_keypro = keypro
and his_keycon in (select array_to_string(a,'') from regexp_matches(pam_nompar,'[^,]+', 1, 1, 'g') as foo(a))
)
loop
importe := sp_tovarchar2(reg.his_import);/* dmap converted statement start */
foliolabora :=  concat(keyper, reg.his_keypro , reg.his_keyemp , reg.his_keycon , importe) ;/* dmap converted statement end */
begin
select count(*) into strict wn_tot_reg from saf_apfa
where "idfoliolabora" = foliolabora;
if wn_tot_reg = 0 then
insert into saf_apfa("idfoliolabora", "sesion", "numcliente", "cveempleado", "numnomina", "cuenta", "aportacion", "tipomov",
"fechasol", "fechaapl", "idestatus", "nota", "tipopago", "proceso", "periodo")
values ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.his_keyemp, reg.his_keycon, importe, 'AP',
reg.his_fecmov, wd_fec_mov, 15008, ' ', tipopago, reg.his_keypro, keyper);
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
