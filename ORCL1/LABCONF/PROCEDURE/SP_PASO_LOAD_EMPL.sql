CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_PASO_LOAD_EMPL" (keyemp integer) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
      vs_activo   varchar2(1);
      vs_pering   varchar2(7);
      vn_keyemp   integer;
      vn_existr   integer;
      vg_keyemp   integer;
      vg_keydep   varchar2(16);
      vg_keypue   varchar2(16);
      vg_keycen   varchar2(16);
      vg_keycat   varchar2(16);
      vg_nomemp   varchar2(60);
      vg_nomcor   varchar2(20);
      vg_domemp   varchar2(60);
      vg_colemp   varchar2(40);
      vg_cidemp   varchar2(20);
      vg_pobemp   varchar2(20);
      vg_munemp   varchar2(6);
      vg_entemp   varchar2(2);
      vg_codemp   varchar2(5);
      vg_telemp   varchar2(60);
      vg_regrfc   varchar2(13);
      vg_recurp   varchar2(18);
      vg_regims   varchar2(12);
      vg_reginf   varchar2(12);
      vg_cvesex   varchar2(1);
      vg_keyims   varchar2(5);
      vg_cvezon   smallint;
      vg_keypro   smallint;
      vg_cvetur   smallint;
      vg_tipemp   varchar2(6);
      vg_tipsal   varchar2(1);
      vg_status   smallint;
      vg_salhor   decimal(12,6);
      vg_saldia   decimal(12,6);
      vg_salmes   decimal(12,2);
      vg_salint   decimal(12,6);
      vg_salivc   decimal(12,6);
      vg_salinf   decimal(12,6);
      vg_intsin   decimal(12,6);
      vg_infsin   decimal(12,6);
      vg_varims   decimal(12,6);
      vg_varinf   decimal(12,6);
      vg_anthor   decimal(12,6);
      vg_antdia   decimal(12,6);
      vg_antmes   decimal(12,2);
      vg_antint   decimal(12,6);
      vg_antivc   decimal(12,6);
      vg_antinf   decimal(12,6);
      vg_antits   decimal(12,6);
      vg_antifs   decimal(12,6);
      vg_refcon   varchar2(20);
      vg_cveban   varchar2(7);
      vg_ctaban   varchar2(18);
      vg_forpag   varchar2(2);
      vg_diades   smallint;
      vg_numliq   varchar2(6);
      vg_keyloc   varchar2(16);
      vg_fecing   date;
      vg_fecrei   date;
      vg_fecven   date;
      vg_fecpla   date;
      vg_fecaum   date;
      vg_peraum   varchar2(7);
      vg_fecbaj   date;
      vg_cvebaj   varchar2(4);
      vg_jorlab   varchar2(1);
      vg_unijor   decimal(4,2);
      vg_pering   varchar2(7);
      vg_perbaj   varchar2(7);
      vg_perdep   varchar2(7);
      vg_perpue   varchar2(7);
      vg_percat   varchar2(7);
      vg_perpro   varchar2(7);
      vg_fecaux   date;
      vg_ca1aux   varchar2(10);
      vg_ca2aux   varchar2(10);
      vg_ca3aux   varchar2(10);
      vg_ca4aux   varchar2(10);
      vg_pctbec   decimal(5,2);
      vg_fecmod   date;
      vg_hormod   varchar2(8);
      vg_fecalt   date;
      vg_bajfec   date;
      vg_fecsal   date;
      vg_perpag   varchar2(7);
      vg_inifec   date;
      vg_finfec   date;
      vg_cobert   varchar2(2);
      ws_ca4aux        varchar2(2);
      ws_ca5aux        varchar2(2);
      ws_cveban       varchar2(5);
      pa_keyper       varchar2(10);
BEGIN
BEGIN
     SELECT count(*)
     INTO  vn_existr
     FROM nmcoempl
     WHERE emp_keyemp  = keyemp;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
BEGIN
SELECT
     trim(emp_keyemp), trim(emp_keydep), trim(emp_keypue), trim(emp_keycen), trim(emp_keycat),
     trim(emp_nomemp), trim(emp_nomcor), trim(emp_domemp), trim(emp_colemp), trim(emp_cidemp),
     trim(emp_pobemp), trim(emp_munemp), trim(emp_entemp), trim(emp_codemp), trim(emp_telemp),
     trim(emp_regrfc), trim(emp_recurp), trim(emp_regims), trim(emp_reginf), trim(emp_cvesex),
     trim(emp_keyims), trim(emp_cvezon), trim(emp_keypro), trim(emp_cvetur), trim(emp_tipemp),
     trim(emp_tipsal), trim(emp_status), trim(emp_salhor), trim(emp_saldia), trim(emp_salmes),
     trim(emp_salint), trim(emp_salivc), trim(emp_salinf), trim(emp_intsin), trim(emp_infsin),
     trim(emp_varims), trim(emp_varinf), trim(emp_anthor), trim(emp_antdia), trim(emp_antmes),
     trim(emp_antint), trim(emp_antivc), trim(emp_antinf), trim(emp_antits), trim(emp_antifs),
     trim(emp_refcon), trim(emp_cveban), trim(emp_ctaban), trim(emp_forpag), trim(emp_diades),
     trim(emp_numliq), trim(emp_keyloc), trim(emp_fecing), trim(emp_fecrei), trim(emp_fecven),
     trim(emp_fecpla), trim(emp_fecaum), trim(emp_peraum), trim(emp_fecbaj), trim(emp_cvebaj),
     trim(emp_jorlab), trim(emp_unijor), trim(emp_pering), trim(emp_perbaj), trim(emp_perdep),
     trim(emp_perpue), trim(emp_percat), trim(emp_perpro), trim(emp_fecaux), trim(emp_ca1aux),
     trim(emp_ca2aux), trim(emp_ca3aux), trim(emp_ca4aux), trim(emp_pctbec), trim(emp_fecmod),
     trim(emp_hormod), trim(emp_fecalt), trim(emp_bajfec), trim(emp_fecsal), trim(emp_perpag),
     trim(emp_inifec), trim(emp_finfec), trim(emp_cobert)
INTO
     vg_keyemp, vg_keydep, vg_keypue, vg_keycen, vg_keycat,
     vg_nomemp, vg_nomcor, vg_domemp, vg_colemp, vg_cidemp,
     vg_pobemp, vg_munemp, vg_entemp, vg_codemp, vg_telemp,
     vg_regrfc, vg_recurp, vg_regims, vg_reginf, vg_cvesex,
     vg_keyims, vg_cvezon, vg_keypro, vg_cvetur, vg_tipemp,
     vg_tipsal, vg_status, vg_salhor, vg_saldia, vg_salmes,
     vg_salint, vg_salivc, vg_salinf, vg_intsin, vg_infsin,
     vg_varims, vg_varinf, vg_anthor, vg_antdia, vg_antmes,
     vg_antint, vg_antivc, vg_antinf, vg_antits, vg_antifs,
     vg_refcon, vg_cveban, vg_ctaban, vg_forpag, vg_diades,
     vg_numliq, vg_keyloc, vg_fecing, vg_fecrei, vg_fecven,
     vg_fecpla, vg_fecaum, vg_peraum, vg_fecbaj, vg_cvebaj,
     vg_jorlab, vg_unijor, vg_pering, vg_perbaj, vg_perdep,
     vg_perpue, vg_percat, vg_perpro, vg_fecaux, vg_ca1aux,
     vg_ca2aux, vg_ca3aux, vg_ca4aux, vg_pctbec, vg_fecmod,
     vg_hormod, vg_fecalt, vg_bajfec, vg_fecsal, vg_perpag,
     vg_inifec, vg_finfec, vg_cobert
FROM emplpaso
WHERE emp_keyemp = keyemp;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
-- Actualiza paso o inserta
 IF vn_existr = 0  and vg_keyemp is not null THEN
    INSERT INTO nmcoempl
    (emp_keyemp, emp_keydep, emp_keypue, emp_keycen, emp_keycat,
     emp_nomemp, emp_nomcor, emp_domemp, emp_colemp, emp_cidemp,
     emp_pobemp, emp_munemp, emp_entemp, emp_codemp, emp_telemp,
     emp_regrfc, emp_recurp, emp_regims, emp_reginf, emp_cvesex,
     emp_keyims, emp_cvezon, emp_keypro, emp_cvetur, emp_tipemp,
     emp_tipsal, emp_status, emp_salhor, emp_saldia, emp_salmes,
     emp_salint, emp_salivc, emp_salinf, emp_intsin, emp_infsin,
     emp_varims, emp_varinf, emp_anthor, emp_antdia, emp_antmes,
     emp_antint, emp_antivc, emp_antinf, emp_antits, emp_antifs,
     emp_refcon, emp_cveban, emp_ctaban, emp_forpag, emp_diades,
     emp_numliq, emp_keyloc, emp_fecing, emp_fecrei, emp_fecven,
     emp_fecpla, emp_fecaum, emp_peraum, emp_fecbaj, emp_cvebaj,
     emp_jorlab, emp_unijor, emp_pering, emp_perbaj, emp_perdep,
     emp_perpue, emp_percat, emp_perpro, emp_fecaux, emp_ca1aux,
     emp_ca2aux, emp_ca3aux, emp_ca4aux, emp_pctbec, emp_fecmod,
     emp_hormod, emp_fecalt, emp_bajfec, emp_fecsal, emp_perpag,
     emp_inifec, emp_finfec, emp_cobert)
   VALUES(
     vg_keyemp, vg_keydep, vg_keypue, vg_keycen, vg_keycat,
     vg_nomemp, vg_nomcor, vg_domemp, vg_colemp, vg_cidemp,
     vg_pobemp, vg_munemp, vg_entemp, vg_codemp, vg_telemp,
     vg_regrfc, vg_recurp, vg_regims, vg_reginf, vg_cvesex,
     vg_keyims, vg_cvezon, vg_keypro, vg_cvetur, vg_tipemp,
     vg_tipsal, vg_status, vg_salhor, vg_saldia, vg_salmes,
     vg_salint, vg_salivc, vg_salinf, vg_intsin, vg_infsin,
     vg_varims, vg_varinf, vg_anthor, vg_antdia, vg_antmes,
     vg_antint, vg_antivc, vg_antinf, vg_antits, vg_antifs,
     vg_refcon, vg_cveban, vg_ctaban, vg_forpag, vg_diades,
     vg_numliq, vg_keyloc, vg_fecing, vg_fecrei, vg_fecven,
     vg_fecpla, vg_fecaum, vg_peraum, vg_fecbaj, vg_cvebaj,
     vg_jorlab, vg_unijor, vg_pering, vg_perbaj, vg_perdep,
     vg_perpue, vg_percat, vg_perpro, vg_fecaux, vg_ca1aux,
     vg_ca2aux, vg_ca3aux, vg_ca4aux, vg_pctbec, vg_fecmod,
     vg_hormod, vg_fecalt, vg_bajfec, vg_fecsal, vg_perpag,
     vg_inifec, vg_finfec, vg_cobert);
 ELSE
  UPDATE nmcoempl set
     emp_keydep  =  vg_keydep  ,
     emp_keypue  =  vg_keypue  , emp_keycen  =  vg_keycen  ,
     emp_keycat  =  vg_keycat  , emp_nomemp  =  vg_nomemp  ,
     emp_nomcor  =  vg_nomcor  , emp_domemp  =  vg_domemp  ,
     emp_colemp  =  vg_colemp  , emp_cidemp  =  vg_cidemp  ,
     emp_pobemp  =  vg_pobemp  , emp_munemp  =  vg_munemp  ,
     emp_entemp  =  vg_entemp  , emp_codemp  =  vg_codemp  ,
     emp_telemp  =  vg_telemp  , emp_regrfc  =  vg_regrfc  ,
     emp_recurp  =  vg_recurp  , emp_regims  =  vg_regims  ,
     emp_reginf  =  vg_reginf  , emp_cvesex  =  vg_cvesex  ,
     emp_keyims  =  vg_keyims  , emp_cvezon  =  vg_cvezon  ,
     emp_keypro  =  vg_keypro  , emp_cvetur  =  vg_cvetur  ,
     emp_tipemp  =  vg_tipemp  , emp_tipsal  =  vg_tipsal  ,
     emp_status  =  vg_status  , emp_salhor  =  vg_salhor  ,
     emp_saldia  =  vg_saldia  , emp_salmes  =  vg_salmes  ,
     emp_salint  =  vg_salint  , emp_salivc  =  vg_salivc  ,
     emp_salinf  =  vg_salinf  , emp_intsin  =  vg_intsin  ,
     emp_infsin  =  vg_infsin  , emp_varims  =  vg_varims  ,
     emp_varinf  =  vg_varinf  , emp_anthor  =  vg_anthor  ,
     emp_antdia  =  vg_antdia  , emp_antmes  =  vg_antmes  ,
     emp_antint  =  vg_antint  , emp_antivc  =  vg_antivc  ,
     emp_antinf  =  vg_antinf  , emp_antits  =  vg_antits  ,
     emp_antifs  =  vg_antifs  , emp_refcon  =  vg_refcon  ,
     emp_cveban  =  vg_cveban  , emp_ctaban  =  vg_ctaban  ,
     emp_forpag  =  vg_forpag  , emp_diades  =  vg_diades  ,
     emp_numliq  =  vg_numliq  , emp_keyloc  =  vg_keyloc  ,
     emp_fecing  =  vg_fecing  , emp_fecrei  =  vg_fecrei  ,
     emp_fecven  =  vg_fecven  , emp_fecpla  =  vg_fecpla  ,
     emp_fecaum  =  vg_fecaum  , emp_peraum  =  vg_peraum  ,
     emp_fecbaj  =  vg_fecbaj  , emp_cvebaj  =  vg_cvebaj  ,
     emp_jorlab  =  vg_jorlab  , emp_unijor  =  vg_unijor  ,
     emp_pering  =  vg_pering  , emp_perbaj  =  vg_perbaj  ,
     emp_perdep  =  vg_perdep  , emp_perpue  =  vg_perpue  ,
     emp_percat  =  vg_percat  , emp_perpro  =  vg_perpro  ,
     emp_fecaux  =  vg_fecaux  , emp_ca1aux  =  vg_ca1aux  ,
     emp_ca2aux  =  vg_ca2aux  , emp_ca3aux  =  vg_ca3aux  ,
     emp_ca4aux  =  vg_ca4aux  , emp_pctbec  =  vg_pctbec  ,
     emp_fecmod  =  vg_fecmod  , emp_hormod  =  vg_hormod  ,
     emp_fecalt  =  vg_fecalt  , emp_bajfec  =  vg_bajfec  ,
     emp_fecsal  =  vg_fecsal  , emp_perpag  =  vg_perpag  ,
     emp_inifec  =  vg_inifec  , emp_finfec  =  vg_finfec  ,
     emp_cobert  =  vg_cobert
   WHERE emp_keyemp=vg_keyemp;
END IF;
vn_existr := 0;
ws_cveban := substr(vg_cveban,1,3);
BEGIN
SElECT count(*)
  INTO vn_existr
 FROM  nmloctas
where cta_keyemp=vg_keyemp
  and cta_keypro=vg_keypro;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
   IF vn_existr = 0 THEN
      INSERT INTO nmloctas
      SELECT trim(emp_keypro),trim(emp_keyemp), trim(emp_ctaban)
       FROM  emplpaso
       WHERE emp_keyemp=keyemp;
    ELSE
       UPDATE nmloctas set cta_ctaban=vg_ctaban,
                           cta_keypro=vg_keypro
       WHERE  cta_keyemp = keyemp
         AND  cta_keypro = vg_keypro;
   END IF;
END;
/
