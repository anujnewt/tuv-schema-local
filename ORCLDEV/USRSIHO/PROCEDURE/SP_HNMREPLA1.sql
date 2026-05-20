create or replace procedure usrsiho."sp_hnmrepla1"  (vs_nom_rep varchar, vs_ide_pcc varchar, vn_key_usu numeric) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
-- pgv moved types end
vn_key_nom   usrsiho.nmloperi.per_keynom %type;
vs_num_emi   usrsiho.nmloperi.per_nu4aux %type;
vn_key_pro   usrsiho.nmloperi.per_keypro %type;
vs_key_per   usrsiho.nmloperi.per_keyper %type;
vn_key_emp   usrsiho.nmcoempl.emp_keyemp %type;
vn_emp_ant   usrsiho.nmcoempl.emp_keyemp %type;
vs_nom_emp   usrsiho.nmcoempl.emp_nomemp %type;
vs_reg_rfc   usrsiho.nmcoempl.emp_regrfc %type;
vs_key_con   usrsiho.nmlohism.his_keycon %type;
vs_des_con   usrsiho.nmloconc.con_descon %type;
vs_cod_imp   usrsiho.nmlohism.his_codimp %type;
vn_imp_ort   usrsiho.nmlohism.his_import %type;
vs_key_dep   usrsiho.nmcodeps.dep_keydep %type;
vs_des_dep   usrsiho.nmcodeps.dep_desdep %type;
vn_key_agr   usrsiho.holoagcp.agc_keyagr %type;
vn_key_rph   usrsiho.holofrph.frp_keyrph %type;
vd_fec_act   usrsiho.holofrph.frp_fecact %type;
vn_cos_tot   usrsiho.holohgdp.hgd_costog %type;
vn_cos_tog   usrsiho.holohgdp.hgd_costog %type;
vn_cap_ini   usrsiho.holohgdp.hgd_capini %type;
vn_cap_fin   usrsiho.holohgdp.hgd_capfin %type;
vn_con_per   numeric(5);
vn_con_con   numeric(5);
vn_con_ded   numeric(5);
vn_con_pro   numeric(5);
vd_fec_ini   timestamp(0);
vd_fec_fin   timestamp(0);
vd_fec_pag   timestamp(0);
cuenta     numeric(5);
vs_nom_seg varchar(10);
rec record;
rec2 record;
begin
vn_emp_ant := 0;/* dmap converted statement start */
vs_nom_seg := rtrim(oracle.substr(vs_ide_pcc::text,1,10));/* dmap converted statement end */
-- inicia ciclo principal de lectura
for rec
in (select nmloperi.per_keypro, nmloperi.per_keynom, nmloperi.per_keyper,nmloperi.per_nu4aux,
nmloperi.per_fecini, nmloperi.per_fecfin,nmloperi.per_fecpag,nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
nmcoempl.emp_regrfc, nmlohism.his_keycon,nmloconc.con_descon, nmlohism.his_codimp,
nmlohism.his_keydep, nmcodeps.dep_desdep,sum(nmlohism.his_import) suma
from usrsiho.nmcoempl
join usrsiho.nmlohism on his_keyemp = emp_keyemp
join usrsiho.nmloperi on per_keypro = his_keypro and per_keyper = his_keyper and per_keynom = his_keynom
left join usrsiho.nmcodeps on his_keydep = dep_keydep
join usrsiho.nmloconc on his_keycon = con_keycon
join usrsiho.glwkrang on ran_nomrep = vs_nom_rep and ran_idepcc = vs_ide_pcc and ran_keyusu = vn_key_usu
where per_keypro = ran_keypro
and per_keyper = ran_keyper
and per_keynom = ran_keynom
group by nmloperi.per_keypro, nmloperi.per_keynom, nmloperi.per_keyper, nmloperi.per_nu4aux,
nmloperi.per_fecini, nmloperi.per_fecfin,
nmloperi.per_fecpag,
nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
nmcoempl.emp_regrfc, nmlohism.his_codimp,
nmlohism.his_keycon, nmloconc.con_descon,
nmlohism.his_keydep, nmcodeps.dep_desdep
order by  emp_keyemp) loop
-- comparacion de numeros de empleado
vn_key_pro := rec.per_keypro;
vn_key_nom := rec.per_keynom;
vs_key_per := rec.per_keyper;
vs_num_emi := rec.per_nu4aux;
vd_fec_ini := rec.per_fecini;
vd_fec_fin := rec.per_fecfin;
vd_fec_pag := rec.per_fecpag;
vn_key_emp := rec.emp_keyemp;
vs_nom_emp := rec.emp_nomemp;
vs_reg_rfc := rec.emp_regrfc;
vs_key_con := rec.his_keycon;
vs_des_con := rec.con_descon;
vs_cod_imp := rec.his_codimp;
vs_key_dep := rec.his_keydep;
vs_des_dep := rec.dep_desdep;
vn_imp_ort := rec.suma;
--dbms_output.put_line( vn_key_emp);
if vn_emp_ant <> vn_key_emp then
vn_con_per := 0;
vn_con_ded := 0;
vn_con_pro := 0;
end if;
vn_emp_ant := vn_key_emp;
-- separa por tipo de concepto
if (vs_cod_imp = '01') then
-- verifica si pertenecen a la agrupacion 10
vn_con_con := 0;
begin
select count(*)
into strict vn_con_con
from usrsiho.holoagcp
where agc_keyagr = 10
and agc_keycon = vs_key_con;
exception when no_data_found then vn_con_con := 0;
end;
--dbms_output.put_line( vs_key_con);
--dbms_output.put_line(vn_con_con);
-- selecciona detalle de movimiento
if vn_con_con > 0 then
for rec2
in (select frp_keyrph, frp_fecact,
hgd_costog, hgd_capini,
hgd_capfin, (hgd_numcap*hgd_costog::numeric) cos_tot
from usrsiho.holofrph, usrsiho.holohgdp
where frp_keyrph = hgd_keyrph
and frp_keypro = vn_key_pro
and frp_keyper = vs_key_per
and hgd_keyemp = vn_key_emp) loop
--dbms_output.put_line( 'segundo for');
vn_key_rph := rec2.frp_keyrph;
vd_fec_act := rec2.frp_fecact;
vn_cos_tog := rec2.hgd_costog;
vn_cap_ini := rec2.hgd_capini;
vn_cap_fin := rec2.hgd_capfin;
vn_cos_tot := rec2.cos_tot;
vn_con_per := vn_con_per + 1;
update usrsiho.glwkcrys
set  cry_dec008 = vn_key_pro, cry_dec009 = vn_key_nom, cry_dec010 = vs_num_emi,
cry_chr017 = vs_key_con, cry_chr002 = vs_des_con, cry_chr008 = vs_key_dep,
cry_chr009 = vs_des_dep, cry_dec007 = vn_key_rph, cry_dat001 = vd_fec_act,
cry_dec005 = vn_cos_tog, cry_dec011 = vn_cap_ini, cry_dec012 = vn_cap_fin,
cry_dec004 = vn_cos_tot, cry_dec001 = vn_imp_ort
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu
and cry_dec006 = vn_key_emp
and cry_numsec = vn_con_per;
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount  = 0 then
--dbms_output.put_line (vn_key_pro);
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_dec006, cry_chr012,
cry_chr001, cry_dec008, cry_dec009,
cry_dec010, cry_chr017, cry_chr002,
cry_chr008, cry_chr009, cry_dec007,
cry_dat001, cry_dec005, cry_dec011,
cry_dec012, cry_dec004, cry_dec001,
cry_chr020, cry_dat002, cry_dat003,
cry_dat004, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_per, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vs_key_dep, vs_des_dep, vn_key_rph,
vd_fec_act, vn_cos_tog, vn_cap_ini,
vn_cap_fin, vn_cos_tot, vn_imp_ort,
vs_key_per, vd_fec_ini, vd_fec_fin,
vd_fec_pag, vs_nom_seg);
end if;
end loop;
else
vn_con_per := vn_con_per + 1;
update usrsiho.glwkcrys
set cry_chr017 = vs_key_con, cry_chr002 = vs_des_con, cry_chr008 = vs_key_dep,
cry_chr009 = vs_des_dep, cry_dec001 = vn_imp_ort
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu
and cry_dec006 = vn_key_emp
and cry_numsec = vn_con_per;
get diagnostics cuenta = row_count;
-- dbms_output.put_line(cuenta);
if cuenta  = 0 then
-- dbms_output.put_line('inserta registro');
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_dec006, cry_chr012,
cry_chr001, cry_dec008, cry_dec009,
cry_dec010, cry_chr017, cry_chr002,
cry_chr008, cry_chr009, cry_dec001,
cry_chr020, cry_dat002, cry_dat003,
cry_dat004, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_per, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vs_key_dep, oracle.substr(vs_des_dep,1,20), vn_imp_ort,
vs_key_per, vd_fec_ini, vd_fec_fin,
vd_fec_pag, vs_nom_seg);
end if;
end if;
elsif vs_cod_imp = '02' then
vn_con_ded := vn_con_ded + 1;
update usrsiho.glwkcrys
set cry_chr018 = vs_key_con, cry_chr003 = vs_des_con, cry_dec002 = vn_imp_ort
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu
and cry_dec006 = vn_key_emp
and cry_numsec = vn_con_ded;
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
--  dbms_output.put_line('inserta registro');
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_dec006, cry_chr012,
cry_chr001, cry_dec008, cry_dec009,
cry_dec010, cry_chr018, cry_chr003,
cry_dec002, cry_chr020, cry_dat002,
cry_dat003, cry_dat004, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_ded, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vn_imp_ort, vs_key_per, vd_fec_ini,
vd_fec_fin, vd_fec_pag, vs_nom_seg);
end if;
else
--vn_key_agr := 0;
--select agc_keyagr into vn_key_agr
--  from usrsiho.holoagcp
-- where agc_keyagr = 9
--   and agc_keycon = vs_key_con;
--if sql%rowcount = 0 then
--   continue;
--end if;
vn_key_agr := 0;
select count(*)
into strict vn_key_agr
from usrsiho.holoagcp
where agc_keyagr = 9
and agc_keycon = vs_key_con;
if vn_key_agr > 0 then
vn_con_pro := vn_con_pro + 1;
update usrsiho.glwkcrys
set  cry_chr019 = vs_key_con, cry_chr004 = vs_des_con, cry_dec003 = vn_imp_ort
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu
and cry_dec006 = vn_key_emp
and cry_numsec = vn_con_pro;
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_dec006, cry_chr012,
cry_chr001, cry_dec008, cry_dec009,
cry_dec010, cry_chr019, cry_chr004,
cry_dec003, cry_chr020, cry_dat002,
cry_dat003, cry_dat004, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_pro, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vn_imp_ort, vs_key_per, vd_fec_ini,
vd_fec_fin, vd_fec_pag, vs_nom_seg);
end if;
end if;
end if;
end loop;end;
$body$
language plpgsql
;
