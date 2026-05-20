create or replace procedure labprod."sp_trig_empl_u"  ( new_keyemp integer, new_keydep varchar, new_keypue varchar, new_keycen varchar, new_keycat varchar, new_nomemp varchar, new_nomcor varchar, new_domemp varchar, new_colemp varchar, new_cidemp varchar, new_pobemp varchar, new_munemp varchar, new_entemp varchar, new_codemp varchar, new_telemp varchar, new_regrfc varchar, new_recurp varchar, new_regims varchar, new_reginf varchar, new_cvesex varchar, new_keyims varchar, new_cvezon integer, new_keypro integer, new_cvetur integer, new_tipemp varchar, new_tipsal varchar, new_status integer, new_salhor decimal, new_saldia decimal, new_salmes decimal, new_salint decimal, new_salivc decimal, new_salinf decimal, new_intsin decimal, new_infsin decimal, new_varims decimal, new_varinf decimal, new_anthor decimal, new_antdia decimal, new_antmes decimal, new_antint decimal, new_antivc decimal, new_antinf decimal, new_antits decimal, new_antifs decimal, new_refcon varchar, new_cveban varchar, new_ctaban varchar, new_forpag varchar, new_diades integer, new_numliq varchar, new_keyloc varchar, new_fecing timestamp(0), new_fecrei timestamp(0), new_fecven timestamp(0), new_fecpla timestamp(0), new_fecaum timestamp(0), new_peraum varchar, new_fecbaj timestamp(0), new_cvebaj varchar, new_jorlab varchar, new_unijor decimal, new_pering varchar, new_perbaj varchar, new_perdep varchar, new_perpue varchar, new_percat varchar, new_perpro varchar, new_fecaux timestamp(0), new_ca1aux varchar, new_ca2aux varchar, new_ca3aux varchar, new_ca4aux varchar, new_pctbec decimal, new_fecmod timestamp(0), new_hormod varchar, new_fecalt timestamp(0), new_bajfec timestamp(0), new_fecsal timestamp(0), new_perpag varchar, new_inifec timestamp(0), new_finfec timestamp(0), new_cobert varchar, old_keyemp integer, old_keydep varchar, old_keypue varchar, old_keycen varchar, old_keycat varchar, old_nomemp varchar, old_nomcor varchar, old_domemp varchar, old_colemp varchar, old_cidemp varchar, old_pobemp varchar, old_munemp varchar, old_entemp varchar, old_codemp varchar, old_telemp varchar, old_regrfc varchar, old_recurp varchar, old_regims varchar, old_reginf varchar, old_cvesex varchar, old_keyims varchar, old_cvezon integer, old_keypro integer, old_cvetur integer, old_tipemp varchar, old_tipsal varchar, old_status integer, old_salhor decimal, old_saldia decimal, old_salmes decimal, old_salint decimal, old_salivc decimal, old_salinf decimal, old_intsin decimal, old_infsin decimal, old_varims decimal, old_varinf decimal, old_anthor decimal, old_antdia decimal, old_antmes decimal, old_antint decimal, old_antivc decimal, old_antinf decimal, old_antits decimal, old_antifs decimal, old_refcon varchar, old_cveban varchar, old_ctaban varchar, old_forpag varchar, old_diades integer, old_numliq varchar, old_keyloc varchar, old_fecing timestamp(0), old_fecrei timestamp(0), old_fecven timestamp(0), old_fecpla timestamp(0), old_fecaum timestamp(0), old_peraum varchar, old_fecbaj timestamp(0), old_cvebaj varchar, old_jorlab varchar, old_unijor decimal, old_pering varchar, old_perbaj varchar, old_perdep varchar, old_perpue varchar, old_percat varchar, old_perpro varchar, old_fecaux timestamp(0), old_ca1aux varchar, old_ca2aux varchar, old_ca3aux varchar, old_ca4aux varchar, old_pctbec decimal, old_fecmod timestamp(0), old_hormod varchar, old_fecalt timestamp(0), old_bajfec timestamp(0), old_fecsal timestamp(0), old_perpag varchar, old_inifec timestamp(0), old_finfec timestamp(0), old_cobert varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert into nmcoempl_sdw(cmd,old_emp_keyemp,
old_emp_keydep,old_emp_keypue,old_emp_keycen,old_emp_nomemp,old_emp_regrfc,
old_emp_recurp,old_emp_regims,old_emp_keypro,old_emp_status,old_emp_keyloc,
old_emp_fecing,old_emp_fecbaj,old_emp_fecaux,old_emp_ca2aux,new_emp_keyemp,
new_emp_keydep,new_emp_keypue,new_emp_keycen,new_emp_nomemp,new_emp_regrfc,
new_emp_recurp,new_emp_regims,new_emp_keypro,new_emp_status,new_emp_keyloc,
new_emp_fecing,new_emp_fecbaj,new_emp_fecaux,new_emp_ca2aux,orderid1,
orderid2)
values ('update' ,old_keyemp ,old_keydep ,old_keypue
,old_keycen ,old_nomemp ,old_regrfc ,old_recurp ,
old_regims ,old_keypro ,old_status ,old_keyloc ,old_fecing
,old_fecbaj ,old_fecaux ,old_ca2aux ,new_keyemp
,new_keydep ,new_keypue ,new_keycen ,new_nomemp
,new_regrfc ,new_recurp ,new_regims ,new_keypro
,new_status ,new_keyloc ,new_fecing ,new_fecbaj
,new_fecaux ,new_ca2aux , clock_timestamp() ,0);
call sp_sips_orac_empl2 (new_keyemp,new_nomemp,new_cvesex,new_regrfc,new_recurp,new_regims,new_fecing,new_tipemp,new_fecbaj,new_status,
old_nomemp,old_cvesex,old_regrfc,old_recurp,old_regims,old_fecing,old_tipemp,old_fecbaj,old_status,'UP', new_keypro);
--if old_recurp!= new_recurp then
-- grabamos encabezado de la bitacora
--sp_bitacora (9999, 'Trigger', 'SIHO_ORAC', 'CA', 'emp_keyemp','emp_keypro','',new_keyemp,new_keypro,'','Maestro de Empleados');
-- grabamos detalle de la bitacora
--sp_detbitac (9999, 'SIHO_ORAC', 'nmcoempl', 'emp_recurp', old_recurp,new_recurp);
--end if;
end;
$body$
language plpgsql
;
