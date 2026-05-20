create or replace procedure usrsiho."sp_hnmrepln2"  ( vs_nom_rep varchar, vs_ide_pcc varchar,vn_key_usu numeric, vn_prokey numeric) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
-- pgv moved types end
-- sipros, s. a. de c. v.
--
-- sistema  : rh-2000  c/s
-- modulo   : administracion de remuneraciones (nm)
-- programa : sp_hnmrepln2
--            listado de pagos por proceso
-- autor    : veronica vazquez rodriguez
-- fecha    : 19 de agosto de 1999
-- modifico : jesus nu7ez arciga
-- fecha    : 23 de septiembre de 199
vn_key_nom  usrsiho.nmloperi.per_keynom %type;
vs_key_per  usrsiho.nmloperi.per_keyper %type;
vs_num_emi  usrsiho.nmloperi.per_nu4aux %type;
vn_key_emp  usrsiho.nmcoempl.emp_keyemp %type;
vn_emp_ant  usrsiho.nmcoempl.emp_keyemp %type;
vs_nom_emp  usrsiho.nmcoempl.emp_nomemp %type;
vs_reg_rfc  usrsiho.nmcoempl.emp_regrfc %type;
vs_key_con  usrsiho.nmlohism.his_keycon %type;
vs_des_con  usrsiho.nmloconc.con_descon %type;
vs_cod_imp  usrsiho.nmlohism.his_codimp %type;
vn_imp_ort  usrsiho.nmlohism.his_import %type;
vn_row_ide  usrsiho.nmlohism.his_rowide %type;  -- variable para columna que se agrega en el select principal
vn_key_pro  usrsiho.nmlohism.his_keypro %type;
vn_key_agr  usrsiho.holoagcp.agc_keyagr %type;
vs_vec_001   char(20);
vn_con_001   numeric(5);
vn_con_002   numeric(5);
vn_con_per   numeric(5);
vn_con_ded   numeric(5);
vn_con_pro   numeric(5);
vd_fec_ini   timestamp(0);
vd_fec_fin   timestamp(0);
vd_fec_pag   timestamp(0);
vs_nom_seg varchar(10);
rec record;
rec2 record;
begin
vn_emp_ant := 0;/* dmap converted statement start */
vs_nom_seg := rtrim(oracle.substr(vs_ide_pcc::text,1,10));/* dmap converted statement end */
-- se la columna nmlohism.his_rowide, ya que no agrupara el importe de
-- descuentos de sitatyr y se agrega en el gruop by el campo
-- marzo 2010 - car
for rec
in (select nmloperi.per_keypro, nmloperi.per_keynom,
nmloperi.per_keyper, nmloperi.per_nu4aux,
nmloperi.per_fecini, nmloperi.per_fecfin,
nmloperi.per_fecpag,
nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
nmcoempl.emp_regrfc, nmlohism.his_keycon,
nmloconc.con_descon, nmlohism.his_codimp,
nmlohism.his_rowide,
sum(nmlohism.his_import) suma
from usrsiho.nmcoempl,
usrsiho.nmlohism,
usrsiho.nmloperi,
usrsiho.nmloconc
where per_keypro = his_keypro
and per_keyper = his_keyper
and his_keyemp = emp_keyemp
and his_keycon = con_keycon
and his_keypro = vn_prokey
and per_keyper in (select ran_keyper
from usrsiho.glwkrang
where ran_nomrep = vs_nom_rep
and ran_idepcc = vs_ide_pcc
and ran_keyusu = vn_key_usu)
and his_codimp in ('01','02','03')
group by nmloperi.per_keypro, nmloperi.per_keynom,
nmloperi.per_keyper, nmloperi.per_nu4aux,
nmloperi.per_fecini, nmloperi.per_fecfin,
nmloperi.per_fecpag,
nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
nmcoempl.emp_regrfc, nmlohism.his_codimp,
nmlohism.his_keycon, nmloconc.con_descon,
nmlohism.his_rowide
order by  per_keyper,emp_keyemp) loop
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
vn_row_ide := rec.his_rowide;
vn_imp_ort := rec.suma;
if vn_emp_ant <> vn_key_emp then
vn_con_per := 0;
vn_con_ded := 0;
vn_con_pro := 0;
end if;
vn_con_001 := 0;
vs_vec_001 := '..................';
for rec2
in (select agc_keyagr
from holoagcp
where agc_keycon = vs_key_con) loop
vn_con_001 := rec2.agc_keyagr;/* dmap converted statement start */
if vn_con_001 = 1 then
vs_vec_001 :=  concat('X', oracle.substr(vs_vec_001,2, 19)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 2 then
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 1), 'X' , oracle.substr(vs_vec_001,3,18)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 3 then
--oracle.substr(vs_vec_001,3, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 2), 'X' , oracle.substr(vs_vec_001,4,17)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 4 then
--oracle.substr(vs_vec_001,4, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 3), 'X' , oracle.substr(vs_vec_001,5,16)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 5 then
--oracle.substr(vs_vec_001,5, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 4), 'X' , oracle.substr(vs_vec_001,6,15)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 6 then
--oracle.substr(vs_vec_001,6, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 5), 'X' , oracle.substr(vs_vec_001,7,14)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 7 then
--oracle.substr(vs_vec_001,7, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 6), 'X' , oracle.substr(vs_vec_001,8,13)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 8 then
--oracle.substr(vs_vec_001,8, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 7), 'X' , oracle.substr(vs_vec_001,9,12)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 9 then
--oracle.substr(vs_vec_001,9, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 8), 'X' , oracle.substr(vs_vec_001,10,11)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if vn_con_001 = 10 then
--oracle.substr( vs_vec_001,10, 1) := 'X';
vs_vec_001 := oracle. concat(substr( vs_vec_001,1, 9), 'X' , oracle.substr(vs_vec_001,11,10)) ;/* dmap converted statement end */
end if;
end loop;
vn_emp_ant := vn_key_emp;
if vs_cod_imp = '01' then
vn_con_per := vn_con_per + 1;
update usrsiho.glwkcrys
set cry_chr017 = vs_key_con,
cry_chr002 = vs_des_con,
cry_chr008 = vs_vec_001,
cry_dec001 = vn_imp_ort
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu
and cry_dec006 = vn_key_emp
and cry_numsec = vn_con_per;
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount  = 0 then
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_dec006, cry_chr012,
cry_chr001, cry_dec008, cry_dec009,
cry_dec010, cry_chr017, cry_chr002,
cry_chr008, cry_dec001, cry_chr020,
cry_dat001, cry_dat002, cry_dat003, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_per, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vs_vec_001, vn_imp_ort, vs_key_per,
vd_fec_ini, vd_fec_fin, vd_fec_pag, vs_nom_seg);
end if;
elsif vs_cod_imp = '02' then
vn_con_ded := vn_con_ded + 1;
update usrsiho.glwkcrys
set
cry_chr018 = vs_key_con,
cry_chr003 = vs_des_con,
cry_chr009 = vs_vec_001,
cry_dec002 = vn_imp_ort
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu
and cry_dec006 = vn_key_emp
and cry_numsec = vn_con_ded;
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_dec006, cry_chr012,
cry_chr001, cry_dec008, cry_dec009,
cry_dec010, cry_chr018, cry_chr003,
cry_chr009, cry_dec002, cry_chr020,
cry_dat001, cry_dat002, cry_dat003, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_ded, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vs_vec_001, vn_imp_ort, vs_key_per,
vd_fec_ini, vd_fec_fin, vd_fec_pag, vs_nom_seg);
end if;
else
vn_key_agr := 0;
begin
select agc_keyagr
into strict vn_key_agr
from holoagcp
where agc_keyagr = 9
and agc_keycon = vs_key_con;
exception
when no_data_found then
continue;
end;
vn_con_pro := vn_con_pro + 1;
update usrsiho.glwkcrys
set
cry_chr019 = vs_key_con,
cry_chr004 = vs_des_con,
cry_chr010 = vs_vec_001,
cry_dec003 = vn_imp_ort
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
cry_chr010, cry_dec003, cry_chr020,
cry_dat001, cry_dat002, cry_dat003, cry_chr016)
values (vs_nom_rep, vs_ide_pcc, vn_key_usu,
vn_con_pro, vn_key_emp, vs_reg_rfc,
vs_nom_emp, vn_key_pro, vn_key_nom,
vs_num_emi, vs_key_con, vs_des_con,
vs_vec_001, vn_imp_ort, vs_key_per,
vd_fec_ini, vd_fec_fin, vd_fec_pag, vs_nom_seg);
end if;
end if;
end loop;end;
$body$
language plpgsql
;
