CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_COM_PASO_EMPL" (noctvo integer) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
      vs_activo varchar2(1);
      vs_pering varchar2(7);
      vn_keyemp integer;
      vn_existr integer;
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
      ve_keyemp   integer;
      ve_keydep   varchar2(16);
      ve_keypue   varchar2(16);
      ve_keycen   varchar2(16);
      ve_keycat   varchar2(16);
      ve_nomemp   varchar2(60);
      ve_nomcor   varchar2(20);
      ve_domemp   varchar2(60);
      ve_colemp   varchar2(40);
      ve_cidemp   varchar2(20);
      ve_pobemp   varchar2(20);
      ve_munemp   varchar2(6);
      ve_entemp   varchar2(2);
      ve_codemp   varchar2(5);
      ve_telemp   varchar2(60);
      ve_regrfc   varchar2(13);
      ve_recurp   varchar2(18);
      ve_regims   varchar2(12);
      ve_reginf   varchar2(12);
      ve_cvesex   varchar2(1);
      ve_keyims   varchar2(5);
      ve_cvezon   smallint;
      ve_keypro   smallint;
      ve_cvetur   smallint;
      ve_tipemp   varchar2(6);
      ve_tipsal   varchar2(1);
      ve_status   smallint;
      ve_salhor   decimal(12,6);
      ve_saldia   decimal(12,6);
      ve_salmes   decimal(12,2);
      ve_salint   decimal(12,6);
      ve_salivc   decimal(12,6);
      ve_salinf   decimal(12,6);
      ve_intsin   decimal(12,6);
      ve_infsin   decimal(12,6);
      ve_varims   decimal(12,6);
      ve_varinf   decimal(12,6);
      ve_anthor   decimal(12,6);
      ve_antdia   decimal(12,6);
      ve_antmes   decimal(12,2);
      ve_antint   decimal(12,6);
      ve_antivc   decimal(12,6);
      ve_antinf   decimal(12,6);
      ve_antits   decimal(12,6);
      ve_antifs   decimal(12,6);
      ve_refcon   varchar2(20);
      ve_cveban   varchar2(7);
      ve_ctaban   varchar2(18);
      ve_forpag   varchar2(2);
      ve_diades   smallint;
      ve_numliq   varchar2(6);
      ve_keyloc   varchar2(16);
      ve_fecing   date;
      ve_fecrei   date;
      ve_fecven   date;
      ve_fecpla   date;
      ve_fecaum   date;
      ve_peraum   varchar2(7);
      ve_fecbaj   date;
      ve_cvebaj   varchar2(4);
      ve_jorlab   varchar2(1);
      ve_unijor   decimal(4,2);
      ve_pering   varchar2(7);
      ve_perbaj   varchar2(7);
      ve_perdep   varchar2(7);
      ve_perpue   varchar2(7);
      ve_percat   varchar2(7);
      ve_perpro   varchar2(7);
      ve_fecaux   date;
      ve_ca1aux   varchar2(10);
      ve_ca2aux   varchar2(10);
      ve_ca3aux   varchar2(10);
      ve_ca4aux   varchar2(10);
      ve_pctbec   decimal(5,2);
      ve_fecmod   date;
      ve_hormod   varchar2(8);
      ve_fecalt   date;
      ve_bajfec   date;
      ve_fecsal   date;
      ve_perpag   varchar2(7);
      ve_inifec   date;
      ve_finfec   date;
      ve_cobert   varchar2(2);
      vc_fecaum   date;
 wd_fec_act          varchar2(10);
 ws_hor_act          varchar2(8);
 ws_nom_rep          varchar2(10);
 ws_ide_pcc          varchar2(15);
 wn_key_usu          INTEGER;
 ws_hor_reg          varchar2(8);
 wn_tot_reg          integer;
 BEGIN
wd_fec_act := TO_CHAR(SYSDATE, 'mm/dd/yyyy');
ws_hor_act := TO_CHAR(SYSDATE, 'HH24:MI:SS');
ws_nom_rep := 'emplpaso';
ws_ide_pcc := 'sp_com_paso_emp';
wn_key_usu := noctvo;
ws_hor_reg := TO_CHAR(SYSDATE, 'HH24:MI:SS');
wn_tot_reg := 0;
  INSERT INTO glcoresu (
      res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
      res_horreg, res_totreg, res_status )
    VALUES (
      ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act, ws_hor_act,
      ws_hor_reg, wn_tot_reg, 'P' ) ;
     SELECT count(*)
     INTO  vn_existr
     FROM emplpaso
     WHERE emp_keyemp in (SELECT emp_keyemp
                            FROM  com_orac_sips_empl
                           WHERE  ora_noctvo = noctvo);
SELECT
     emp_keyemp, rtrim(emp_keydep), emp_keypue, rtrim(emp_keycen), rtrim(emp_keycat),
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
     emp_ca2aux, emp_ca3aux, emp_ca4aux, emp_pctbec,
     wd_fec_act, ws_hor_act ,
     emp_fecalt, emp_bajfec, emp_fecsal, emp_perpag,
     emp_inifec, emp_finfec, emp_cobert
	 --TO_CHAR (SYSDATE, 'HH24:MI:SS')
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
FROM com_orac_sips_empl
WHERE ora_noctvo = noctvo;
      UPDATE glcoresu SET res_numreg = vn_existr,
                          res_isaerr = vg_keyemp
        WHERE res_idepro = ws_nom_rep
          AND res_idepcc = ws_ide_pcc
          AND res_keyusu = wn_key_usu
         AND res_fecini = wd_fec_act
          AND res_horreg = ws_hor_reg;
--Determina Tipo Fondo
SELECT pro_ca4aux,pro_ca5aux
  INTO ws_ca4aux,ws_ca5aux
FROM nmloproc
where pro_keypro=vg_keypro;
      If ws_ca4aux = 'S' And ws_ca5aux = 'T' Then
        vg_ca4aux := 'F';
        vg_refcon := '1';
      ElsIf ws_ca4aux = 'N' Then
         vg_ca4aux := 'N';
         vg_refcon := '2';
      ElsIf ws_ca4aux = 'S' And ws_ca5aux = 'C' Then
          If vg_tipemp = '1' Then
         vg_ca4aux := 'F';
         vg_refcon := '1';
          ElsIf vg_tipemp <> '1' Then
                vg_ca4aux := 'N';
                vg_refcon := '2';
          End If;
      ElsIf ws_ca4aux = 'S' And ws_ca5aux = 'S' Then
          If vg_tipemp = '2' Then
	         vg_ca4aux := 'F';
          vg_refcon := '1';
          ElsIf vg_tipemp <> '2' Then
                vg_ca4aux := 'N';
                vg_refcon := '2';
          End If;
      End If;
IF vg_ca2aux ='3'or vg_ca2aux = '4' or
   vg_ca2aux ='5'or vg_ca2aux = '6' or
   vg_ca2aux ='7'
  THEN
               vg_ca4aux := 'N';
               vg_refcon := '2';
END IF;
--Trae datos del maestro
	BEGIN
SELECT
     emp_keyemp, emp_keydep, emp_keypue, emp_keycen, emp_keycat,
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
     emp_inifec, emp_finfec, emp_cobert
INTO
     ve_keyemp, ve_keydep, ve_keypue, ve_keycen, ve_keycat,
     ve_nomemp, ve_nomcor, ve_domemp, ve_colemp, ve_cidemp,
     ve_pobemp, ve_munemp, ve_entemp, ve_codemp, ve_telemp,
     ve_regrfc, ve_recurp, ve_regims, ve_reginf, ve_cvesex,
     ve_keyims, ve_cvezon, ve_keypro, ve_cvetur, ve_tipemp,
     ve_tipsal, ve_status, ve_salhor, ve_saldia, ve_salmes,
     ve_salint, ve_salivc, ve_salinf, ve_intsin, ve_infsin,
     ve_varims, ve_varinf, ve_anthor, ve_antdia, ve_antmes,
     ve_antint, ve_antivc, ve_antinf, ve_antits, ve_antifs,
     ve_refcon, ve_cveban, ve_ctaban, ve_forpag, ve_diades,
     ve_numliq, ve_keyloc, ve_fecing, ve_fecrei, ve_fecven,
     ve_fecpla, ve_fecaum, ve_peraum, ve_fecbaj, ve_cvebaj,
     ve_jorlab, ve_unijor, ve_pering, ve_perbaj, ve_perdep,
     ve_perpue, ve_percat, ve_perpro, ve_fecaux, ve_ca1aux,
     ve_ca2aux, ve_ca3aux, ve_ca4aux, ve_pctbec, ve_fecmod,
     ve_hormod, ve_fecalt, ve_bajfec, ve_fecsal, ve_perpag,
     ve_inifec, ve_finfec, ve_cobert
FROM nmcoempl
WHERE emp_keyemp = vg_keyemp;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
--  AND emp_status = 1 ;
  BEGIN
  SELECT dep_keycen
  INTO   vg_keycen
  FROM   nmcodeps
  WHERE dep_keydep=vg_keydep;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
   vc_fecaum := ve_fecaum;
IF vg_fecaum is not null THEN
   vc_fecaum := vg_fecaum;
END IF;
-- Actualiza paso o inserta
 IF vn_existr = 0 THEN
    INSERT INTO emplpaso
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
     vg_nomemp, ve_nomcor, vg_domemp, vg_colemp, vg_cidemp,
     vg_pobemp, vg_munemp, vg_entemp, vg_codemp, vg_telemp,
     vg_regrfc, vg_recurp, vg_regims, vg_reginf, vg_cvesex,
     vg_keyims, vg_cvezon, vg_keypro, vg_cvetur, vg_tipemp,
     vg_tipsal, vg_status, ve_salhor, ve_saldia, vg_salmes,
     ve_salint, ve_salivc, ve_salinf, ve_intsin, ve_infsin,
     ve_varims, ve_varinf, ve_anthor, ve_antdia, ve_antmes,
     ve_antint, ve_antivc, ve_antinf, ve_antits, ve_antifs,
     vg_refcon, vg_cveban, vg_ctaban, vg_forpag, ve_diades,
     ve_numliq, vg_keyloc, vg_fecing, vg_fecrei, vg_fecven,
     vg_fecpla, vc_fecaum, ve_peraum, vg_fecbaj, vg_cvebaj,
     vg_jorlab, vg_unijor, ve_pering, vg_perbaj, ve_perdep,
     ve_perpue, ve_percat, ve_perpro, vg_fecaux, vg_ca1aux,
     vg_ca2aux, vg_ca3aux, vg_ca4aux, ve_pctbec, vg_fecmod,
     vg_hormod, vg_fecalt, vg_bajfec, ve_fecsal, ve_perpag,
     ve_inifec, ve_finfec, vg_cobert);
 ELSE
  UPDATE emplpaso set
     emp_keydep  =  vg_keydep  ,
     emp_keypue  =  vg_keypue  , emp_keycen  =  vg_keycen  ,
     emp_keycat  =  vg_keycat  , emp_nomemp  =  vg_nomemp  ,
     emp_nomcor  =  ve_nomcor  , emp_domemp  =  vg_domemp  ,
     emp_colemp  =  vg_colemp  , emp_cidemp  =  vg_cidemp  ,
     emp_pobemp  =  vg_pobemp  , emp_munemp  =  vg_munemp  ,
     emp_entemp  =  vg_entemp  , emp_codemp  =  vg_codemp  ,
     emp_telemp  =  vg_telemp  , emp_regrfc  =  vg_regrfc  ,
     emp_recurp  =  vg_recurp  , emp_regims  =  vg_regims  ,
     emp_reginf  =  vg_reginf  , emp_cvesex  =  vg_cvesex  ,
     emp_keyims  =  vg_keyims  , emp_cvezon  =  vg_cvezon  ,
     emp_keypro  =  vg_keypro  , emp_cvetur  =  vg_cvetur  ,
     emp_tipemp  =  vg_tipemp  , emp_tipsal  =  vg_tipsal  ,
     emp_status  =  vg_status  , emp_salhor  =  ve_salhor  ,
     emp_saldia  =  ve_saldia  , emp_salmes  =  vg_salmes  ,
     emp_salint  =  ve_salint  , emp_salivc  =  ve_salivc  ,
     emp_salinf  =  ve_salinf  , emp_intsin  =  ve_intsin  ,
     emp_infsin  =  ve_infsin  , emp_varims  =  ve_varims  ,
     emp_varinf  =  ve_varinf  , emp_anthor  =  ve_anthor  ,
     emp_antdia  =  ve_antdia  , emp_antmes  =  ve_antmes  ,
     emp_antint  =  ve_antint  , emp_antivc  =  ve_antivc  ,
     emp_antinf  =  ve_antinf  , emp_antits  =  ve_antits  ,
     emp_antifs  =  ve_antifs  , emp_refcon  =  vg_refcon  ,
     emp_cveban  =  vg_cveban  , emp_ctaban  =  vg_ctaban  ,
     emp_forpag  =  vg_forpag  , emp_diades  =  ve_diades  ,
     emp_numliq  =  ve_numliq  , emp_keyloc  =  vg_keyloc  ,
     emp_fecing  =  vg_fecing  , emp_fecrei  =  vg_fecrei  ,
     emp_fecven  =  vg_fecven  , emp_fecpla  =  vg_fecpla  ,
     emp_fecaum  =  vc_fecaum  , emp_peraum  =  ve_peraum  ,
     emp_fecbaj  =  vg_fecbaj  , emp_cvebaj  =  vg_cvebaj  ,
     emp_jorlab  =  vg_jorlab  , emp_unijor  =  vg_unijor  ,
     emp_pering  =  ve_pering  , emp_perbaj  =  vg_perbaj  ,
     emp_perdep  =  ve_perdep  , emp_perpue  =  ve_perpue  ,
     emp_percat  =  ve_percat  , emp_perpro  =  ve_perpro  ,
     emp_fecaux  =  vg_fecaux  , emp_ca1aux  =  vg_ca1aux  ,
     emp_ca2aux  =  vg_ca2aux  , emp_ca3aux  =  vg_ca3aux  ,
     emp_ca4aux  =  vg_ca4aux  , emp_pctbec  =  ve_pctbec  ,
     emp_fecmod  =  vg_fecmod  , emp_hormod  =  vg_hormod  ,
     emp_fecalt  =  vg_fecalt  , emp_bajfec  =  vg_bajfec  ,
     emp_fecsal  =  ve_fecsal  , emp_perpag  =  ve_perpag  ,
     emp_inifec  =  ve_inifec  , emp_finfec  =  ve_finfec  ,
     emp_cobert  =  vg_cobert
   WHERE emp_keyemp=vg_keyemp;
END IF;
IF vg_status = 1 THEN
DELETE FROM traypaso
WHERE       tra_keyemp=vg_keyemp
  AND       tra_tipmov=2;
END IF;
  -- Actualiza la tabbaa deemnitoreo indicandoola finalizacion    --
  -- del proceso.                                                 --
ws_hor_act := TO_CHAR(SYSDATE, 'HH24:MI:SS');
  UPDATE glcoresu SET res_numreg = vn_existr,
                      res_fecfin = wd_fec_act,
                      res_horfin = ws_hor_act,
                      res_status = 'T'
    WHERE res_idepro = ws_nom_rep
      AND res_idepcc = ws_ide_pcc
      AND res_keyusu = wn_key_usu
      AND res_fecini = wd_fec_act
      AND res_horreg = ws_hor_reg;
END;
/
