CREATE OR REPLACE FUNCTION trigger_fct_nmcoempl_sdwu() RETURNS trigger AS $body$
BEGIN
call sp_trig_empl_u(post.emp_keyemp
,post.emp_keydep ,post.emp_keypue ,post.emp_keycen ,post.emp_keycat
,post.emp_nomemp ,post.emp_nomcor ,post.emp_domemp ,post.emp_colemp
,post.emp_cidemp ,post.emp_pobemp ,post.emp_munemp ,post.emp_entemp
,post.emp_codemp ,post.emp_telemp ,post.emp_regrfc ,post.emp_recurp
,post.emp_regims ,post.emp_reginf ,post.emp_cvesex ,post.emp_keyims
,post.emp_cvezon ,post.emp_keypro ,post.emp_cvetur ,post.emp_tipemp
,post.emp_tipsal ,post.emp_status ,post.emp_salhor ,post.emp_saldia
,post.emp_salmes ,post.emp_salint ,post.emp_salivc ,post.emp_salinf
,post.emp_intsin ,post.emp_infsin ,post.emp_varims ,post.emp_varinf
,post.emp_anthor ,post.emp_antdia ,post.emp_antmes ,post.emp_antint
,post.emp_antivc ,post.emp_antinf ,post.emp_antits ,post.emp_antifs
,post.emp_refcon ,post.emp_cveban ,post.emp_ctaban ,post.emp_forpag
,post.emp_diades ,post.emp_numliq ,post.emp_keyloc ,post.emp_fecing
,post.emp_fecrei ,post.emp_fecven ,post.emp_fecpla ,post.emp_fecaum
,post.emp_peraum ,post.emp_fecbaj ,post.emp_cvebaj ,post.emp_jorlab
,post.emp_unijor ,post.emp_pering ,post.emp_perbaj ,post.emp_perdep
,post.emp_perpue ,post.emp_percat ,post.emp_perpro ,post.emp_fecaux
,post.emp_ca1aux ,post.emp_ca2aux ,post.emp_ca3aux ,post.emp_ca4aux
,post.emp_pctbec ,post.emp_fecmod ,post.emp_hormod ,post.emp_fecalt
,post.emp_bajfec ,post.emp_fecsal ,post.emp_perpag ,post.emp_inifec
,post.emp_finfec ,post.emp_cobert ,pre.emp_keyemp ,pre.emp_keydep
,pre.emp_keypue ,pre.emp_keycen ,pre.emp_keycat ,pre.emp_nomemp ,
pre.emp_nomcor ,pre.emp_domemp ,pre.emp_colemp ,pre.emp_cidemp ,pre.emp_pobemp
,pre.emp_munemp ,pre.emp_entemp ,pre.emp_codemp ,pre.emp_telemp ,
pre.emp_regrfc ,pre.emp_recurp ,pre.emp_regims ,pre.emp_reginf ,pre.emp_cvesex
,pre.emp_keyims ,pre.emp_cvezon ,pre.emp_keypro ,pre.emp_cvetur ,
pre.emp_tipemp ,pre.emp_tipsal ,pre.emp_status ,pre.emp_salhor ,pre.emp_saldia
,pre.emp_salmes ,pre.emp_salint ,pre.emp_salivc ,pre.emp_salinf ,
pre.emp_intsin ,pre.emp_infsin ,pre.emp_varims ,pre.emp_varinf ,pre.emp_anthor
,pre.emp_antdia ,pre.emp_antmes ,pre.emp_antint ,pre.emp_antivc ,
pre.emp_antinf ,pre.emp_antits ,pre.emp_antifs ,pre.emp_refcon ,pre.emp_cveban
,pre.emp_ctaban ,pre.emp_forpag ,pre.emp_diades ,pre.emp_numliq ,
pre.emp_keyloc ,pre.emp_fecing ,pre.emp_fecrei ,pre.emp_fecven ,pre.emp_fecpla
,pre.emp_fecaum ,pre.emp_peraum ,pre.emp_fecbaj ,pre.emp_cvebaj ,
pre.emp_jorlab ,pre.emp_unijor ,pre.emp_pering ,pre.emp_perbaj ,pre.emp_perdep
,pre.emp_perpue ,pre.emp_percat ,pre.emp_perpro ,pre.emp_fecaux ,
pre.emp_ca1aux ,pre.emp_ca2aux ,pre.emp_ca3aux ,pre.emp_ca4aux ,pre.emp_pctbec
,pre.emp_fecmod ,pre.emp_hormod ,pre.emp_fecalt ,pre.emp_bajfec ,
pre.emp_fecsal ,pre.emp_perpag ,pre.emp_inifec ,pre.emp_finfec ,pre.emp_cobert
);
RETURN NEW;END;
$body$
LANGUAGE 'plpgsql';
