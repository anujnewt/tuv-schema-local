create or replace procedure labprod."sp_trig_empl_i"  ( new_keyemp integer, new_keydep varchar, new_keypue varchar, new_keycen varchar, new_keycat varchar, new_nomemp varchar, new_nomcor varchar, new_domemp varchar, new_colemp varchar, new_cidemp varchar, new_pobemp varchar, new_munemp varchar, new_entemp varchar, new_codemp varchar, new_telemp varchar, new_regrfc varchar, new_recurp varchar, new_regims varchar, new_reginf varchar, new_cvesex varchar, new_keyims varchar, new_cvezon integer, new_keypro integer, new_cvetur integer, new_tipemp varchar, new_tipsal varchar, new_status integer, new_salhor decimal, new_saldia decimal, new_salmes decimal, new_salint decimal, new_salivc decimal, new_salinf decimal, new_intsin decimal, new_infsin decimal, new_varims decimal, new_varinf decimal, new_anthor decimal, new_antdia decimal, new_antmes decimal, new_antint decimal, new_antivc decimal, new_antinf decimal, new_antits decimal, new_antifs decimal, new_refcon varchar, new_cveban varchar, new_ctaban varchar, new_forpag varchar, new_diades integer, new_numliq varchar, new_keyloc varchar, new_fecing timestamp(0), new_fecrei timestamp(0), new_fecven timestamp(0), new_fecpla timestamp(0), new_fecaum timestamp(0), new_peraum varchar, new_fecbaj timestamp(0), new_cvebaj varchar, new_jorlab varchar, new_unijor decimal, new_pering varchar, new_perbaj varchar, new_perdep varchar, new_perpue varchar, new_percat varchar, new_perpro varchar, new_fecaux timestamp(0), new_ca1aux varchar, new_ca2aux varchar, new_ca3aux varchar, new_ca4aux varchar, new_pctbec decimal, new_fecmod timestamp(0), new_hormod varchar, new_fecalt timestamp(0), new_bajfec timestamp(0), new_fecsal timestamp(0), new_perpag varchar, new_inifec timestamp(0), new_finfec timestamp(0), new_cobert varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert into nmcoempl_sdw(cmd,new_emp_keyemp,new_emp_keydep,new_emp_keypue,new_emp_keycen,new_emp_nomemp,new_emp_regrfc,new_emp_recurp,
new_emp_regims,new_emp_keypro,new_emp_status,new_emp_keyloc, new_emp_fecing,new_emp_fecbaj,new_emp_fecaux,new_emp_ca2aux,orderid1,orderid2)
values ('insert' ,new_keyemp ,new_keydep ,new_keypue ,new_keycen ,new_nomemp ,new_regrfc ,new_recurp
,new_regims ,new_keypro ,new_status ,new_keyloc ,new_fecing ,new_fecbaj ,new_fecaux ,new_ca2aux,clock_timestamp() ,0 );
-- igneos.i (se agrega proceso)
call sp_sips_orac_empl2 (new_keyemp,new_nomemp,new_cvesex,new_regrfc,new_recurp,new_regims,new_fecing,new_tipemp,
'','','','','','','','','','','','IN', new_keypro);end;
$body$
language plpgsql
;
