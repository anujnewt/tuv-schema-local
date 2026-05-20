create or replace procedure labprod."sp_gen_reg_prestamo"  (wn_key_emp numeric, ws_key_con varchar, ws_ref_ere varchar, wn_imp_ort numeric, wd_fec_ope timestamp(0), ws_ref_amo varchar, ws_ven_num varchar, ws_ven_cod varchar, ws_men_err inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_key_per varchar(7);
ws_tip_ope varchar(1) := '+';
ws_tip_mon varchar(1) := 'M';
wn_tip_cam decimal(11,4) := 1;
ws_tip_reg varchar(1) :='A';
wn_key_pro integer;
ws_sta_tus varchar(1) := '1';
wd_fec_car timestamp(0) := clock_timestamp();
ws_sta_car varchar(1) := 'P';
wn_key_pre decimal(16,6);
begin
ws_men_err:= null;
begin
select emp_keypro into strict wn_key_pro
from    labprod.nmcoempl
where   emp_keyemp = wn_key_emp;
exception
when no_data_found then
begin
ws_men_err := 'EMPLEADO NO EXISTE';
return;
end;
end;
begin
-- busca el periodo correspondiente
select  per_keyper
into strict    ws_key_per
from    labprod.nmloperi
where   per_keypro = wn_key_pro
and     per_fecini <= wd_fec_ope
and     per_fecfin >= wd_fec_ope
and     per_keynom = 1;/* dmap converted statement start */
exception
when no_data_found then
begin
ws_men_err :=  concat('NO EXISTE PERIODO PARA LA FECHA ', wd_fec_ope) ;/* dmap converted statement end */
return;
end;
end;
select nextval('labprod.nmlopres_seq') into strict wn_key_pre;
insert into labprod.ap_sipros(
soi_keyemp,  soi_keycon,  soi_refere,  soi_tipope,
soi_import,  soi_fecope,  soi_tipmon,  soi_tipcam,
soi_tipreg,  soi_keypre,  soi_keypro,  soi_status,
soi_feccar,  soi_stacar,  soi_refamo,  soi_vennum,
soi_vencod
)
values (
wn_key_emp,  ws_key_con,  ws_ref_ere,  ws_tip_ope,
wn_imp_ort,  wd_fec_ope,  ws_tip_mon,  wn_tip_cam,
ws_tip_reg,  wn_key_pre,  wn_key_pro,  ws_sta_tus,
wd_fec_car,  ws_sta_car,  ws_ref_amo,  ws_ven_num,
ws_ven_cod
);
insert into labprod.nmlopres(
pre_keyemp,     pre_keycon,     pre_keypre,     pre_refere,
pre_fecreg,     pre_tippre,     pre_unipre,     pre_imppre,
pre_gastos,     pre_plazop,     pre_unides,     pre_impdes,
pre_porint,     pre_perini,     pre_fecini,     pre_fecaut,
pre_cveaut,     pre_fechab,     pre_uniamo,     pre_impamo,
pre_unisal,     pre_impsal,     pre_uniult,     pre_impult,
pre_numpag,     pre_intpag,     pre_status,     pre_ultact,
pre_refcon,     pre_ctreve,     pre_fe1aux,     pre_fe2aux,
pre_ca1aux,     pre_ca2aux,     pre_ca3aux,     pre_ca4aux,
pre_uniope,     pre_keypro,     pre_impnoa,     pre_pernoa
)
values (
wn_key_emp,     ws_key_con,     wn_key_pre,     ws_ref_ere,
wd_fec_car,     1,              null,           wn_imp_ort,
null,           1,              null,           wn_imp_ort,
0,              ws_key_per,     wd_fec_ope,     wd_fec_ope,
null,           null,           0,              0,
0,              wn_imp_ort,     0,              0,
0,              0,              2,              wd_fec_ope,
null,           ws_ref_amo,     null,           null,
ws_tip_mon,     wn_tip_cam,     null,           null,
null,           wn_key_pro,     0,              null
);
/* commit; */
ws_men_err := 'INSERTADO';/* dmap converted statement start */
exception
when others then ws_men_err :=  concat('ERROR: ', sqlstate, ' : ', sqlerrm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
