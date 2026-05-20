CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."ACTUALIZA_SDW" 
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
FOR empl IN ( SELECT * FROM nmcoempl WHERE emp_keyemp IN (SELECT tra_keyemp FROM nmlotray WHERE tra_tipmov = '1' AND tra_fecmov >= '09/23/2011' AND tra_fecmov <= '09/26/2011'))
   LOOP
     sp_trig_empl_i(empl.emp_keyemp ,empl.emp_keydep ,empl.emp_keypue ,empl.emp_keycen ,empl.emp_keycat
    ,empl.emp_nomemp ,empl.emp_nomcor ,empl.emp_domemp ,empl.emp_colemp ,empl.emp_cidemp ,empl.emp_pobemp ,empl.emp_munemp ,empl.emp_entemp
    ,empl.emp_codemp ,empl.emp_telemp ,empl.emp_regrfc ,empl.emp_recurp ,empl.emp_regims ,empl.emp_reginf ,empl.emp_cvesex ,empl.emp_keyims
    ,empl.emp_cvezon ,empl.emp_keypro ,empl.emp_cvetur ,empl.emp_tipemp ,empl.emp_tipsal ,empl.emp_status ,empl.emp_salhor ,empl.emp_saldia
    ,empl.emp_salmes ,empl.emp_salint ,empl.emp_salivc ,empl.emp_salinf ,empl.emp_intsin ,empl.emp_infsin ,empl.emp_varims ,empl.emp_varinf
    ,empl.emp_anthor ,empl.emp_antdia ,empl.emp_antmes ,empl.emp_antint ,empl.emp_antivc ,empl.emp_antinf ,empl.emp_antits ,empl.emp_antifs
    ,empl.emp_refcon ,empl.emp_cveban ,empl.emp_ctaban ,empl.emp_forpag ,empl.emp_diades ,empl.emp_numliq ,empl.emp_keyloc ,empl.emp_fecing
    ,empl.emp_fecrei ,empl.emp_fecven ,empl.emp_fecpla ,empl.emp_fecaum ,empl.emp_peraum ,empl.emp_fecbaj ,empl.emp_cvebaj ,empl.emp_jorlab
    ,empl.emp_unijor ,empl.emp_pering ,empl.emp_perbaj ,empl.emp_perdep ,empl.emp_perpue ,empl.emp_percat ,empl.emp_perpro ,empl.emp_fecaux
    ,empl.emp_ca1aux ,empl.emp_ca2aux ,empl.emp_ca3aux ,empl.emp_ca4aux ,empl.emp_pctbec ,empl.emp_fecmod ,empl.emp_hormod ,empl.emp_fecalt
    ,empl.emp_bajfec ,empl.emp_fecsal ,empl.emp_perpag ,empl.emp_inifec ,empl.emp_finfec ,empl.emp_cobert );
 END LOOP;
 end;
/
