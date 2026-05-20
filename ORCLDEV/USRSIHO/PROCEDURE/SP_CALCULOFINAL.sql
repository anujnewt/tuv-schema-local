create or replace procedure usrsiho."sp_calculofinal"  (wn_key_pro numeric, ws_key_per varchar,wn_key_nom numeric, ws_nom_rep varchar, ws_fec_ini varchar, ws_hor_ini varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
result numeric(10) := 1;
begin
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_numsec = -1
and cry_dec006 = wn_key_pro
and cry_chr001 = ws_key_per
and cry_chr012 = ws_fec_ini
and cry_chr023 = ws_hor_ini;
insert into usrsiho.glwkcrys(cry_nomrep,cry_numsec,cry_dec006,cry_chr001,cry_chr012,cry_chr023,cry_dec007)
values (ws_nom_rep,-1,wn_key_pro,ws_key_per,ws_fec_ini,ws_hor_ini,result);
if wn_key_pro = 138 and (wn_key_nom = 103 or wn_key_nom= 110) then
call usrsiho.sp_calculo_iva_isr (
wn_key_pro => wn_key_pro,
wn_key_nom => wn_key_nom,
ws_key_per => ws_key_per,
ws_key_con => 'H18',
wn_por_cen => 5.34,
ws_con_bas => 'PBI',
ws_cod_imp => '01'
);
call usrsiho.sp_calculo_iva_isr (
wn_key_pro => wn_key_pro,
wn_key_nom => wn_key_nom,
ws_key_per => ws_key_per,
ws_key_con => 'H91',
wn_por_cen => 10.66,
ws_con_bas => 'PBI',
ws_cod_imp => '01'
);
call usrsiho.sp_calculo_iva_isr (
wn_key_pro => wn_key_pro,
wn_key_nom => wn_key_nom,
ws_key_per => ws_key_per,
ws_key_con => 'H23',
wn_por_cen => 10.66,
ws_con_bas => 'PBI',
ws_cod_imp => '02'
);
call usrsiho.sp_calculo_iva_isr (
wn_key_pro => wn_key_pro,
wn_key_nom => wn_key_nom,
ws_key_per => ws_key_per,
ws_key_con => 'H24',
wn_por_cen => 10,
ws_con_bas => 'PBI',
ws_cod_imp => '02'
);
end if;
-- eljm 30.ene.2023 outsourcing 2023
if wn_key_pro = 100 and wn_key_nom = 113 then
update usrsiho.nmwkmovt
set    mov_keyemp = 195711
where  mov_keypro = wn_key_pro
and    mov_keyper = ws_key_per
and    mov_keynom = wn_key_nom
and    mov_keycon in ('IVA', 'PBI', 'HPN')
and    mov_keyemp = 490195711;
end if;end;
$body$
language plpgsql
;
