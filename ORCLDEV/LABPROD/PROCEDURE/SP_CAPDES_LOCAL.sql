create or replace procedure labprod.dmap_sp_capdes_local  (empleado integer, capacidad inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
-----------------------------------globales
wd_salmes         decimal(14,6);
wi_keypro         integer;
ws_tipemp         varchar(6);
wn_sal_mes        decimal(14,6);
gn_vales_patpaa   decimal(14,6);
gd_topevales      decimal(18,2);
gd_otrasper       decimal(14,6);
gd_excsal         decimal(14,6);
ws_apoemp        varchar(5);--opci
gs_pagoneto      varchar(20);--opcis
--------------------------------------------------
text14            decimal(14,6);
txtpocentaje      decimal(14,6);
txtcuotafija      decimal(14,6);
wd_otrasfracc     decimal(14,6);
wd_fraccioni      decimal(14,6);
-----------------------------------locales
wi_diaper         integer;
ws_ca2aux         decimal(14,6);
ws_keycia         varchar(5);
ws_keyloc         varchar(16);
emp_saldia        decimal(14,6);
srecurp           varchar(20);
wd_impdes         decimal(12,2);
wi_per_mes        integer;
ws_keycon         varchar(8);
wd_impsal         decimal(14,2);
--patpaa
wd_eleuno        decimal(18,6);
wd_eledos        decimal(18,6);
wd_eletre        decimal(18,6);
wd_elecua        decimal(18,6);
i_ban_dera      varchar(10);
wd_salminx5      decimal(18,2);
ws_val_par01     varchar(30);
ws_val_par02     varchar(30);
wd_topepagovales decimal(14,6);
wi_cvezon        integer;
wx_neto_patpaa    decimal(14,6);
ws_pue_nu1aux     varchar(10);
----------------------------------final
vn_por_vale          decimal(14,6);
----------------------------------ispt
wn_sal_bas           decimal(14,6);
wx_dif_sal           decimal(14,6);
wx_por_cen           decimal(14,6);
wx_ispt              decimal(14,6);
wn_ispt           decimal(14,6);
wx_sub_sidio  decimal(14,6);
wx_cuota_fija decimal(14,6);
----------------------------------imss
wn_sal_int     decimal(14,6);
wn_sal_minx3     decimal(14,6);
wn_imp_ramas     decimal(14,6);
wn_imp_rama3     decimal(14,6);
wn_cuota_imss    decimal(14,6);
--------------------------------------cd
wn_otr_percep     decimal(14,6);
wn_otr_per     decimal(14,6);
wd_capasidaddesc  decimal(14,2);
tx_tot_dec        decimal(14,6);
wn_exc_sal       decimal(14,6);
valorcompara      decimal(14,6);
--validaci?n
status   integer;
wn_tot_reg  integer;
capacidad_actual decimal(14,2);
fecing timestamp(0);
dias decimal(14,2);
call_final integer;
q_dfi record;
begin
wd_capasidaddesc := 0;
execute 'ALTER SESSION SET NULLIF(nls_territory::text, '') IS NULLAMERICA ;' ; /* dmap converted statement */
execute 'ALTER SESSION SET NULLIF(nls_language::text, '') IS NULLAMERICAN ;' ; /* dmap converted statement */
execute '/* DUE TO RESTRICTION OF APG, THIS REQUIRES MANUAL VALIDATION. PLEASE VALIDATE. */ SET SESSION DATESTYLE TO ''SQL,DMY'';' ; /* dmap converted statement */
select emp_salmes, emp_keypro, emp_tipemp, pro_diaper, coalesce(sp_todecimal2(cia_ca2aux),0), cia_keycia, emp_keyloc, emp_saldia, emp_recurp, emp_salint, coalesce(oracle.substr(pro_nu3aux, 3, 1), 0), emp_status, emp_fecaux
into strict wd_salmes, wi_keypro, ws_tipemp, wi_diaper, ws_ca2aux, ws_keycia, ws_keyloc, emp_saldia, srecurp, wn_sal_int, i_ban_dera, status, fecing
from labprod.nmcoempl
inner join labprod.nmloproc on (emp_keypro = pro_keypro)
inner join labprod.nmlocias on (pro_keycia = cia_keycia)
where emp_keyemp = empleado;
if status != 1 then
begin
capacidad := 0; /* commit; */ return;
end;
end if;
select count(*) into strict wn_tot_reg from labprod.nmlopres
where pre_keyemp = empleado
and pre_status = '2'
and pre_keycon in ('307','308','309')
and trunc(clock_timestamp()) >= pre_fecini
and trunc(clock_timestamp()) <= pre_fe1aux;
if wn_tot_reg > 0 then
capacidad := 0; return;
end if;
update labprod.tvcapdes set pde_recurp = srecurp where pde_keyemp = empleado;
wn_sal_mes  := wd_salmes;
wi_per_mes := floor(30/wi_diaper);
--opcises
select pam_folini into strict gs_pagoneto from labprod.glcopams
where pam_keypar = (select pam_folini from labprod.glcopams where pam_keypar = '00' and pam_cvesec = 'caprec')
and pam_nompar = 'Pago Neto';
select pam_folini into strict ws_apoemp from labprod.glcopams
where pam_keypar = (select pam_folini from labprod.glcopams where pam_keypar = '00' and pam_cvesec = 'caprec')
and pam_nompar ='Aportacion Empleado';
begin
for q_dfi in (select dfi_perfin,dfi_cantid, dfi_import
from labprod.nmlodfij
inner join labprod.nmcoempl on (dfi_keyemp = emp_keyemp and dfi_keypro = emp_keypro)
where dfi_keyemp = empleado
and dfi_keycon = ws_apoemp
and (nullif(dfi_ca2aux::text, '') is null or dfi_ca2aux = null)
order by  dfi_perfin desc) loop
txtpocentaje := q_dfi.dfi_cantid;
txtcuotafija := q_dfi.dfi_import;
exit;
end loop;
exception when no_data_found then txtpocentaje := 0.0; txtcuotafija := 0.0;
end;
text14 := 0;
if txtpocentaje > 0 then
text14 := 0;
end if;
if txtcuotafija > 0 then
text14 := txtcuotafija * wi_per_mes;
end if;
wd_impdes := 0;
select coalesce(sum(pre_impdes), 0) * wi_per_mes into strict wd_impdes from (
select pre_impdes from labprod.nmlopres, labprod.nmloconc, labprod.glcopams
where pre_keycon = con_keycon
and pre_status in (1, 2)
and pre_keycon not in (select pam_folini from labprod.glcopams where pam_keypar = 'SAFC')
and pre_impsal > 0
and pre_keypro = wi_keypro
and pre_keycon = pam_cvesec
and pam_keypar = 'IFI'
and pre_keyemp = empleado
union all
select sum(pre_ca3aux) pre_impdes
from labprod.nmlopres, labprod.nmloconc, labprod.glcopams
where pre_keycon = con_keycon
and pre_status in (1, 2)
and pre_keycon in (select pam_folini from labprod.glcopams where pam_keypar = 'SAFC')
and pre_impsal > 0
and pre_keypro = wi_keypro
and pre_keycon = pam_cvesec
and pam_keypar = 'IFI'
and pre_keyemp = empleado
and nullif(pre_ca3aux::text, '') is not null
) alias7;
call sp_acum (empleado, wd_impsal);
select coalesce(sum(dfi_import * (case when pro_diaper=15 then  2 when pro_diaper=10 then  3 when pro_diaper=7 then  4 end )),0) into strict wd_otrasfracc
from labprod.nmlodfij, labprod.nmloproc, labprod.nmlocxpr, labprod.glcopams
where dfi_keyemp = empleado
and dfi_keypro = pro_keypro
and dfi_keycon = cxp_keycon
and cxp_keypro = wi_keypro
and cxp_keynom = 1
and cxp_leedfi = 'S'
and cxp_keycon = pam_cvesec
and pam_keypar = 'DFI'
and cxp_keycon not in (select acu_keycon
from labprod.nmloacum, labprod.glcopams
where acu_keyemp = empleado
and acu_keycon = pam_cvesec
and pam_keypar = 'DFI');
select coalesce(sum(dfi_import * (case when pro_diaper=15 then  2 when pro_diaper=10 then  3 when pro_diaper=7 then  4 end )),0) into strict wd_fraccioni
from labprod.nmlodfij, labprod.nmloproc, labprod.nmlocxpr, labprod.glcopams
where dfi_keyemp = empleado
and dfi_keypro = pro_keypro
and dfi_keycon = cxp_keycon
and cxp_keypro = wi_keypro
and cxp_keynom = 1
and cxp_keycon = pam_cvesec
and pam_keypar = 'IFI'
and cxp_keycon <> 'D63';
------------------------------------------------------------------
-->>>>>>>>>>>>>>'calculo el patpaa<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--  call calcula_patpaa(wd_salmes, wi_keypro, ws_tipemp, gd_neto_patpaa, wn_otr_percep)
wx_neto_patpaa := 0;
wd_topepagovales := 0;
if i_ban_dera = 1 then
ws_val_par01 := 0;
ws_val_par02 := 0;
begin--'clave de patpaa con clave 01 de datos adicionales o importe
select coalesce(dat_valpar,0) into strict ws_val_par01 from labprod.nmlodata
where dat_keyemp = empleado and dat_keypar = '01';
exception when no_data_found then ws_val_par01 := 0;
end;
begin--'clave de patpaa con clave 02 de datos adicionales
select coalesce(dat_valpar,0) into strict ws_val_par02 from labprod.nmlodata
where dat_keyemp =  empleado and dat_keypar = '02';
exception when no_data_found then ws_val_par02 := 0;
end;
select trim(both coalesce(pue_nu1aux,0)) into strict ws_pue_nu1aux --'clave de patpaa seg?n puesto de empleado
from labprod.nmcoempl
inner join nmcopues on (emp_keypue = pue_keypue)
where emp_keyemp = empleado;
if wi_keypro = 11 or wi_keypro = 15 then --'tope vales (hasta 5 salarios minimos)
select coalesce(tab_eledos,0) into strict gd_topevales from labprod.nmcoempl, labprod.nmlotabn
where emp_cvezon = tab_eleuno and tab_keytab= '002' and emp_keyemp = empleado;
else
select tab_eledos into strict wd_salminx5 from labprod.nmcoempl, labprod.nmlotabn
where emp_cvezon = tab_eleuno and tab_keytab= '019' and emp_keyemp = empleado;
wd_salminx5 := wd_salminx5 * 5;
gd_topevales := wd_salminx5 * 30.4;
end if;
begin
select tab_eleuno, tab_eledos, tab_eletre, tab_elecua, emp_cvezon  into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua, wi_cvezon
from labprod.nmcoempl, labprod.nmlotabn
where emp_keypro = tab_eleuno
and tab_keytab= '053' and emp_keyemp = empleado and emp_status = 1;
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
if wd_eleuno = 15 then
if wi_cvezon = 1 then
wd_topepagovales := wd_eledos;
end if;
if wi_cvezon = 2 then
wd_topepagovales := wd_eletre;
end if;
else
if ws_tipemp = 1 then
wd_topepagovales := wd_eledos;
end if;
if ws_tipemp = 2 then
wd_topepagovales := wd_eletre;
end if;
end if;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--el c?digo para el c?lculo de patpaa se copio exactamente del c?digo del programa tvcdepre
--el llamado a la funci?n final call final(wx_neto_patpaa, wx_tope_pago_vales, wx_vales_patpaa)
-- se sustituyo por call_final = 0
-- el codigo equivalente de la funcion final en vb se ejecuta al final del bloque
--inicia bloque copiado de vb tvcdepre
wx_neto_patpaa := 0;
if ws_val_par01 = '9' then
call_final := 0;
else
if cast(ws_val_par01 as numeric) > 100 then     --importe en datos adicionales
wx_neto_patpaa := cast(ws_val_par01 as numeric);
if ws_val_par02 = '0' then
call_final := 0;
else
if wi_keypro <> 3 then
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_val_par02 as numeric)
and  tab_keytab= '024';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
else
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_val_par02 as numeric)
and  tab_keytab= '009';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
end if;
call_final := 0;
end if;
else
if wi_keypro = 17 then --intermex
call_final := 0;
else
if ws_val_par01 = '0' then
if ws_pue_nu1aux = '0' then
if ws_val_par02 = '0' then
call_final := 0;
else
if wi_keypro <> 3 then
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_val_par02 as numeric)
and  tab_keytab= '024';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
else
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_val_par02 as numeric)
and  tab_keytab= '009';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
end if;
call_final := 0;  /* aqui */
end if;
else
if wi_keypro <> 3 then
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_pue_nu1aux as numeric)
and  tab_keytab= '024';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
else
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_pue_nu1aux as numeric)
and  tab_keytab= '009';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
end if;
call_final := 0;  /* aqui */
end if;
else
if wi_keypro <> 3 then
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_val_par01 as numeric)
and  tab_keytab= '024';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
else
begin
select tab_eleuno,tab_eledos,tab_eletre,tab_elecua
into strict wd_eleuno, wd_eledos, wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_eleuno = cast(ws_val_par01 as numeric)
and  tab_keytab= '009';
exception when no_data_found then wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
end;
wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
end if;
call_final := 0;
end if;
call_final := 0;
end if;
end if;
end if;
--termina bloque copiado de vb tvcdepre
--	call final(wx_neto_patpaa, wd_topepagovales, wd_valespatpaa)
gd_otrasper := 0;
if (wx_neto_patpaa - wd_topepagovales) > 0 then
wx_neto_patpaa := wx_neto_patpaa - wd_topepagovales;
else
wx_neto_patpaa := 0;
end if;
if wd_salmes < gd_topevales then
if (wi_keypro) >= 28 and (wi_keypro) <= 52 then
begin
select tab_eledos/100 into strict vn_por_vale
from labprod.nmlotabn
where tab_keytab = '032'
and tab_eleuno = wi_keypro;
exception when no_data_found then vn_por_vale := 0;
end;
else
begin
select tab_eletre,tab_elecua into strict wd_eletre, wd_elecua
from labprod.nmlotabn
where tab_keytab = '004'
and tab_eleuno = ws_keycia;
exception when no_data_found then wd_eletre := 0; wd_elecua := 0;
end;
if ws_tipemp = 1 then vn_por_vale := wd_eletre / 100; end if;
if ws_tipemp = 2 then vn_por_vale := wd_elecua / 100; end if;
end if;
gd_otrasper := (emp_saldia * 30) * vn_por_vale;
end if;
--	fin final(wx_neto_patpaa, wd_topepagovales, wd_valespatpaa)
wn_otr_percep := oracle.greatest(gd_otrasper - wd_topepagovales, 0);
else
wx_neto_patpaa := 0;
wn_otr_percep := 0;
end if;
-->>>>>>>>>>>>>>'calculo el ispt<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--   call calcula_ispt(wd_salmes, wn_dif_sal, wn_ispt, ws_ca2aux, ws_keycia, ws_tipemp, wi_keypro)
wn_sal_bas := wd_salmes;
wx_dif_sal := 0;
if (wi_keypro) >= 28 and (wi_keypro) <= 52 then
begin
select tab_eledos into strict wd_eledos from labprod.nmlotabn
where tab_keytab = '030' and tab_eleuno = wi_keypro;
exception when no_data_found then wd_eledos := 0;
end;
else
begin
select tab_eledos into strict wd_eledos from labprod.nmlotabn
where tab_keytab = '014' and tab_eleuno = ws_keycia;
exception when no_data_found then wd_eledos := 0;
end;
end if;
if nullif(wd_eledos::text, '') is not null then
wn_sal_bas := wn_sal_bas + (wn_sal_bas * (wd_eledos / 100));
end if;
begin
select min(tab_eleuno), min(tab_eletre), min(tab_elecua), min(tab_eledos) into strict wd_eleuno, wd_eletre, wd_elecua, wd_eledos
from labprod.nmlotabn
where tab_keytab = 'I10' and tab_eledos > wn_sal_bas  order by  tab_eledos;
exception when no_data_found then wd_eleuno:=0; wd_eletre:=0; wd_elecua:=0; wd_eledos:=0;
end;
if nullif(wd_elecua::text, '') is not null then
wx_por_cen := wd_elecua / 100;
wx_dif_sal := (wn_sal_bas - wd_eleuno) * wx_por_cen;
wx_ispt := wx_dif_sal + wd_eletre;
end if;
begin
select tab_eleuno, tab_eletre, tab_elecua, tab_eledos into strict wd_eleuno, wd_eletre, wd_elecua, wd_eledos
from labprod.nmlotabn
where tab_keytab = 'I11' and tab_eledos > wn_sal_bas   order by  tab_eledos limit 1;
exception when no_data_found then wd_eleuno:=0; wd_eletre:=0; wd_elecua:=0; wd_eledos:=0;
end;
if nullif(wd_elecua::text, '') is not null then
wx_por_cen := wd_elecua / 100;
wx_dif_sal := wx_dif_sal * wx_por_cen + wd_eletre;
wx_sub_sidio := wx_dif_sal * (ws_ca2aux / 100);
end if;
begin
select tab_eleuno, tab_eletre, tab_elecua, tab_eledos into strict wd_eleuno, wd_eletre, wd_elecua, wd_eledos
from labprod.nmlotabn
where tab_keytab = 'I12' and tab_eledos > wn_sal_bas   order by  tab_eledos limit 1;
exception when no_data_found then wd_eleuno:=0; wd_eletre:=0; wd_elecua:=0; wd_eledos:=0;
end;
if nullif(wd_eletre::text, '') is not null then
wx_cuota_fija := wd_eletre;
wx_dif_sal := wx_dif_sal - wx_sub_sidio;
wx_ispt := wx_ispt - wx_sub_sidio - wx_cuota_fija;
end if;
wn_ispt := oracle.greatest(wx_ispt,0);
-->>>>>>>>>>>>>>'calcula el imss<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--   call calcula_imss(vn_key_emp, wn_cuota_imss)
begin
select tab_eledos into strict wd_eledos
from labprod.nmlotabn
where tab_keytab = '002'
and tab_eleuno = 1;
exception when no_data_found then wd_eledos := 0;
end;
wn_sal_minx3 := wd_eledos * 3;
begin
select sum(tab_eletre/100) into strict wd_eletre
from labprod.nmlotabn
where tab_keytab = '005'
and tab_eleuno in (1,4,5,7);
exception when no_data_found then wd_eletre := 0;
end;
wn_imp_ramas := wn_sal_int * wd_eletre;
begin
select sum(tab_eletre/100) into strict wd_eletre
from labprod.nmlotabn
where tab_keytab = '005'
and tab_eleuno in (3);
exception when no_data_found then wd_eletre := 0;
end;
wn_cuota_imss := 0;
dias := fecing - to_timestamp('19000101','YYYYMMDD');
if ws_tipemp = '1' then
if (wd_salmes > 132500 or ( fecing - to_timestamp('19000101','YYYYMMDD') > 37864 )) then
wn_imp_rama3 := oracle.greatest(wn_sal_int - wn_sal_minx3,0) * wd_eletre;
wn_cuota_imss := (wn_imp_ramas + wn_imp_rama3) * 30;
end if;
end if;
--   call valorcapacidaddes(wd_salmes, wi_keypro, ws_keycia, wd_impdes)
wn_otr_per := 0;
begin
select (tab_eledos * 30) into strict wd_eledos
from labprod.nmcoempl, labprod.nmlotabn
where emp_cvezon = tab_eleuno
and tab_keytab= '002'
and emp_keyemp = empleado;
exception when no_data_found then wd_eledos := 0;
end;
wn_exc_sal := wd_eledos;
--'extrae los porcentaje de pips
------------------------------pips---------------------
if (wi_keypro) >= 28 and (wi_keypro) <= 52 then
begin
select tab_eletre into strict wd_eledos from labprod.nmlotabn
where tab_keytab = '030' and tab_eleuno = wi_keypro;
exception when no_data_found then wd_eledos := 0;
end;
else
begin
select tab_eledos into strict wd_eledos from labprod.nmlotabn
where tab_keytab = '003' and tab_eleuno = ws_keycia;
exception when no_data_found then wd_eledos := 0;
end;
end if;
wn_otr_per := wn_otr_per + (wd_salmes * (wd_eledos/ 100));
--'--------------------------------fin pips---------------------
--'----------------------------fomento eficiencia---------------------
if (wi_keypro) >= 28 and (wi_keypro) <= 52 then
begin
select tab_eledos into strict wd_eledos from labprod.nmlotabn
where tab_keytab = '030' and tab_eleuno = wi_keypro;
exception when no_data_found then wd_eledos := 0;
end;
else
begin
select tab_eledos into strict wd_eledos from labprod.nmlotabn
where tab_keytab = '014' and tab_eleuno = ws_keycia;
exception when no_data_found then wd_eledos := 0;
end;
end if;
wn_otr_per := wn_otr_per + (wn_sal_mes * (wd_eledos / 100)) + wx_neto_patpaa + wn_otr_percep; -- wn_otr_percep viene de patpaa
gd_excsal := (wd_salmes + wn_otr_per - wn_exc_sal) * 0.3;
tx_tot_dec := oracle.least(oracle.greatest(gd_excsal - wd_impdes, 0),gd_excsal);
valorcompara := wd_salmes - wd_impdes - wd_impsal - wn_ispt - wn_cuota_imss - wd_otrasfracc - wd_fraccioni - text14;
if tx_tot_dec < valorcompara then
wd_capasidaddesc := tx_tot_dec;
end if;
begin
select pde_capnew into strict capacidad_actual from labprod.tvcapdes where pde_keyemp = empleado;
if wd_capasidaddesc <> capacidad_actual then
update labprod.tvcapdes
set pde_fecant = pde_fecmov, pde_capant = pde_capnew, pde_horant = pde_hormov, pde_hormov = to_char(clock_timestamp(), 'HH:MM'),
pde_fecmov = clock_timestamp(), pde_capnew = wd_capasidaddesc, pde_status = 1
where pde_keyemp = empleado;
end if;
exception
when no_data_found then insert into labprod.tvcapdes values (empleado, srecurp, clock_timestamp(),0,clock_timestamp(),0,0,'00:00',to_char(clock_timestamp(), 'HH:MM'));
end;
capacidad := wd_capasidaddesc;
--capacidad := ws_val_par01;
/* commit; */
end;
$body$
language plpgsql
;
CREATE OR REPLACE PROCEDURE labprod.sp_capdes_local(empleado integer,capacidad numeric) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections__>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_sp_capdes_local(empleado=> %L,capacidad=> %L)' , empleado,capacidad);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE labprod.sp_capdes_local(empleado integer,capacidad numeric) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections@>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_sp_capdes_local(empleado=> %L,capacidad=> %L)' , empleado,capacidad);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
