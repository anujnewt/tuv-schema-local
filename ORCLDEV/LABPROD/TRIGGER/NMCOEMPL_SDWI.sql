CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."NMCOEMPL_SDWI" after insert on LABPROD.nmcoempl
    referencing new as post
    for each row 
    BEGIN

        sp_trig_empl_i(:post.emp_keyemp ,:post.emp_keydep ,:post.emp_keypue ,:post.emp_keycen ,:post.emp_keycat 
    ,:post.emp_nomemp ,:post.emp_nomcor ,:post.emp_domemp ,:post.emp_colemp ,:post.emp_cidemp ,:post.emp_pobemp ,:post.emp_munemp ,:post.emp_entemp 
    ,:post.emp_codemp ,:post.emp_telemp ,:post.emp_regrfc ,:post.emp_recurp ,:post.emp_regims ,:post.emp_reginf ,:post.emp_cvesex ,:post.emp_keyims 
    ,:post.emp_cvezon ,:post.emp_keypro ,:post.emp_cvetur ,:post.emp_tipemp ,:post.emp_tipsal ,:post.emp_status ,:post.emp_salhor ,:post.emp_saldia 
    ,:post.emp_salmes ,:post.emp_salint ,:post.emp_salivc ,:post.emp_salinf ,:post.emp_intsin ,:post.emp_infsin ,:post.emp_varims ,:post.emp_varinf 
    ,:post.emp_anthor ,:post.emp_antdia ,:post.emp_antmes ,:post.emp_antint ,:post.emp_antivc ,:post.emp_antinf ,:post.emp_antits ,:post.emp_antifs 
    ,:post.emp_refcon ,:post.emp_cveban ,:post.emp_ctaban ,:post.emp_forpag ,:post.emp_diades ,:post.emp_numliq ,:post.emp_keyloc ,:post.emp_fecing 
    ,:post.emp_fecrei ,:post.emp_fecven ,:post.emp_fecpla ,:post.emp_fecaum ,:post.emp_peraum ,:post.emp_fecbaj ,:post.emp_cvebaj ,:post.emp_jorlab 
    ,:post.emp_unijor ,:post.emp_pering ,:post.emp_perbaj ,:post.emp_perdep ,:post.emp_perpue ,:post.emp_percat ,:post.emp_perpro ,:post.emp_fecaux 
    ,:post.emp_ca1aux ,:post.emp_ca2aux ,:post.emp_ca3aux ,:post.emp_ca4aux ,:post.emp_pctbec ,:post.emp_fecmod ,:post.emp_hormod ,:post.emp_fecalt 
    ,:post.emp_bajfec ,:post.emp_fecsal ,:post.emp_perpag ,:post.emp_inifec ,:post.emp_finfec ,:post.emp_cobert );        
    END;



/
ALTER TRIGGER "LABPROD"."NMCOEMPL_SDWI" ENABLE;
