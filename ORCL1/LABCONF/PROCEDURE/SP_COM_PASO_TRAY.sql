CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_COM_PASO_TRAY" (noctvo integer) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vt_movuno           integer;
 pe_status           smallint;
 vg_noctvo           integer;
 vg_keyemp           integer;
 vg_fecmov           date;
 vg_tipmov           varchar2(2);
 vg_keydep           varchar2(16);
 vg_keypue           varchar2(16);
 vg_keycat           varchar2(16);
 vg_keycen           varchar2(16);
 vg_saldia           decimal(12,6);
 ve_saldia           decimal(12,6);
 vg_salmes           decimal(12,2);
 ve_salmes           decimal(12,2);
 vg_salint           decimal(12,6);
 ve_salint           decimal(12,6);
 vg_salivc           decimal(12,6);
 ve_salivc           decimal(12,6);
 vg_salinf           decimal(12,6);
 ve_salinf           decimal(12,6);
 vg_intsin           decimal(12,6);
 ve_intsin           decimal(12,6);
 vg_infsin           decimal(12,6);
 ve_infsin           decimal(12,6);
 vg_keyims           varchar2(5);
 ve_keyims           varchar2(5);
 vg_keyper           varchar2(7);
 vg_codloc           varchar2(16);
 ve_codloc           varchar2(16);
 vg_keypla           integer;
 vg_keypro           integer;
 vg_jorlab           varchar2(1);
 vg_unijor           decimal(4,2);
 vg_submov           varchar2(6);
 vg_ca1aux           varchar2(10);
 vg_ca2aux           varchar2(10);
 vg_fecmod           date;
 vg_hormod           varchar2(8);
 vs_activo           varchar2(1);
 vn_existr           integer;
 vg_periodo          integer;
 vg_status           integer;
 vn_cuent1           integer;
 vn_cuent2           integer;
 pa_keyper           varchar2(7);
 wd_fec_act          DATE;
 ws_hor_act          CHAR(8);
 ws_nom_rep          CHAR(10);
 ws_ide_pcc          CHAR(15);
 wn_key_usu          INTEGER;
 ws_hor_reg          CHAR(8);
 wn_tot_reg          integer;
 BEGIN
  -- Inserta registro para monitoreo de resultados                --
wd_fec_act := TO_CHAR (SYSDATE, 'mm/dd/yyyy');
ws_hor_act := TO_CHAR (SYSDATE, 'HH24:MI:SS');
ws_nom_rep := 'traypaso';
ws_ide_pcc := 'sp_com_paso_tra';
wn_key_usu := noctvo;
ws_hor_reg := TO_CHAR (SYSDATE, 'HH24:MI:SS');
wn_tot_reg := 0;
  INSERT INTO glcoresu (
      res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
      res_horreg, res_totreg, res_status )
    VALUES (
      ws_nom_rep, ws_ide_pcc, wn_key_usu, TO_CHAR (SYSDATE, 'mm/dd/yyyy'), ws_hor_act,
      ws_hor_reg, wn_tot_reg, 'P' ) ;
SELECT
    tra_keyemp, tra_fecmov, tra_tipmov, rtrim(tra_keydep),
    tra_keypue, rtrim(tra_keycat), rtrim(tra_keycen), tra_saldia,
    tra_salmes, tra_salint, tra_salivc, tra_salinf,
    tra_intsin, tra_infsin, tra_keyims, tra_keyper,
    tra_codloc, tra_keypla, tra_keypro, tra_jorlab,
    tra_unijor, tra_submov, tra_ca1aux, tra_ca2aux,
    tra_fecmod, tra_hormod
INTO
    vg_keyemp, vg_fecmov, vg_tipmov, vg_keydep,
    vg_keypue, vg_keycat, vg_keycen, vg_saldia,
    vg_salmes, vg_salint, vg_salivc, vg_salinf,
    vg_intsin, vg_infsin, vg_keyims, vg_keyper,
    vg_codloc, vg_keypla, vg_keypro, vg_jorlab,
    vg_unijor, vg_submov, vg_ca1aux, vg_ca2aux,
    vg_fecmod, vg_hormod
FROM com_orac_sips_tray
WHERE ora_noctvo=noctvo;
vn_existr := 0 ;
vt_movuno := 0 ;
    IF vg_tipmov = 1 THEN
           SELECT  count(*)
             INTO  vt_movuno
             FROM nmlotray
            WHERE tra_keyemp = vg_keyemp
              AND tra_tipmov = 1;
        IF vt_movuno > 0 THEN
          vg_tipmov := 6 ;
        END IF;
    END IF;
SELECT  count(*)
  INTO  vn_existr
  FROM  traypaso
 WHERE  tra_keyemp = vg_keyemp
   AND  tra_tipmov = vg_tipmov
   AND  tra_fecmov = vg_fecmov;
      UPDATE glcoresu SET res_numreg = vn_existr,
                          res_sqlerr = vg_tipmov,
                          res_isaerr = vg_keyemp
        WHERE res_idepro = ws_nom_rep
          AND res_idepcc = ws_ide_pcc
          AND res_keyusu = wn_key_usu
         AND res_fecini = TO_CHAR (SYSDATE, 'mm/dd/yyyy')
          AND res_horreg = ws_hor_reg;
  BEGIN
  SELECT DISTINCT emp_status
  INTO pe_status
  FROM com_orac_sips_empl
   WHERE emp_keyemp=vg_keyemp
   AND emp_status=2;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN
  SELECT dep_keycen
  INTO   vg_keycen
  FROM   nmcodeps
  WHERE dep_keydep= rtrim(vg_keydep);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN
   SELECT min(per_keyper)
     INTO   pa_keyper
     FROM nmloperi
    WHERE per_keypro=vg_keypro
      AND per_keynom= 1
      AND per_fecact is null
      AND (per_totemp is null OR per_totemp=0);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
vg_keyper := pa_keyper;
vg_keycat := 'SC';
IF (vg_tipmov = 2 and  pe_status = 2) or vg_tipmov <> 2 THEN
IF vn_existr = 0  or vn_existr is null  THEN
  IF vg_tipmov <> 15 THEN
   INSERT INTO  traypaso
      (tra_keyemp, tra_fecmov, tra_tipmov, tra_keydep,
      tra_keypue, tra_keycat, tra_keycen, tra_saldia,
      tra_salmes, tra_salint, tra_salivc, tra_salinf,
      tra_intsin, tra_infsin, tra_keyims, tra_keyper,
      tra_codloc, tra_keypla, tra_keypro, tra_jorlab,
      tra_unijor, tra_submov, tra_ca1aux, tra_ca2aux,
      tra_fecmod, tra_hormod)
   VALUES
      (vg_keyemp, vg_fecmov, vg_tipmov, vg_keydep,
      vg_keypue, vg_keycat, vg_keycen, vg_saldia,
      vg_salmes, vg_salint, vg_salivc, vg_salinf,
      vg_intsin, vg_infsin, vg_keyims, vg_keyper,
      vg_codloc, vg_keypla, vg_keypro, vg_jorlab,
      vg_unijor, vg_submov, vg_ca1aux, vg_ca2aux,
      vg_fecmod, vg_hormod);
  ELSE
   vn_cuent1 := 0;
   SELECT count(*)
     INTO  vn_cuent1
     FROM nmlotray
    WHERE tra_keyemp = vg_keyemp
      AND tra_keyper = pa_keyper
      AND tra_tipmov = 2;
   IF  vn_cuent1 > 0  AND pa_keyper IS NOT NULL then
    DELETE FROM nmlotray
     WHERE tra_keyemp=vg_keyemp
       AND tra_tipmov=2
       AND tra_keyper = pa_keyper;
   END IF;
   vn_cuent2 := 0;
   SELECT count(*)
     INTO vn_cuent2
     FROM traypaso
    WHERE tra_keyemp = vg_keyemp
      AND tra_tipmov = 2;
           IF  vn_cuent2 > 0   then
             DELETE FROM traypaso
               WHERE tra_keyemp=vg_keyemp
                 AND tra_tipmov=2;
           END IF;
  END IF;
ELSE
   UPDATE  traypaso SET
   tra_keydep = vg_keydep ,
   tra_keypue = vg_keypue ,
   tra_keycat = vg_keycat ,
   tra_keycen = vg_keycen ,
   tra_saldia = vg_saldia ,
   tra_salmes = vg_salmes ,
   tra_salint = vg_salint ,
   tra_salivc = vg_salivc ,
   tra_salinf = vg_salinf ,
   tra_intsin = vg_intsin ,
   tra_infsin = vg_infsin ,
   tra_keyims = vg_keyims ,
   tra_keyper = vg_keyper ,
   tra_codloc = vg_codloc ,
   tra_keypla = vg_keypla ,
   tra_keypro = vg_keypro ,
   tra_jorlab = vg_jorlab ,
   tra_unijor = vg_unijor ,
   tra_submov = vg_submov ,
   tra_ca1aux = vg_ca1aux ,
   tra_ca2aux = vg_ca2aux ,
   tra_fecmod = vg_fecmod ,
   tra_hormod = vg_hormod
   WHERE tra_keyemp = vg_keyemp
     AND tra_fecmov = vg_fecmov
     AND tra_tipmov = vg_tipmov;
END IF;
    IF  vg_tipmov = 4 THEN
      SELECT
             emp_keyloc ,
             emp_saldia ,
             emp_salmes ,
             emp_salint ,
             emp_salivc ,
             emp_salinf ,
             emp_intsin ,
             emp_infsin ,
             emp_keyims
        INTO
             ve_codloc ,
             ve_saldia ,
             ve_salmes ,
             ve_salint ,
             ve_salivc ,
             ve_salinf ,
             ve_intsin ,
             ve_infsin ,
             ve_keyims
        FROM nmcoempl
       WHERE emp_keyemp = vg_keyemp
         AND emp_status = 1;
      UPDATE traypaso
         SET tra_codloc = ve_codloc ,
             tra_saldia = ve_saldia ,
             tra_salmes = ve_salmes ,
             tra_salint = ve_salint ,
             tra_salivc = ve_salivc ,
             tra_salinf = ve_salinf ,
             tra_intsin = ve_intsin ,
             tra_infsin = ve_infsin ,
             ora_status = 'S'
       WHERE tra_keyemp = vg_keyemp
         AND tra_tipmov = vg_tipmov
         AND tra_fecmov = vg_fecmov;
    END IF;
 IF vg_tipmov <> 1 or vg_tipmov <> 5 or vg_tipmov <> 6 or vg_tipmov <> 4 THEN
BEGIN
   SELECT
     emp_saldia ,
     emp_salmes ,
     emp_salint ,
     emp_salivc ,
     emp_salinf ,
     emp_intsin ,
     emp_infsin
   INTO
     ve_saldia ,
     ve_salmes ,
     ve_salint ,
     ve_salivc ,
     ve_salinf ,
     ve_intsin ,
     ve_infsin
     FROM nmcoempl
     WHERE emp_keyemp = vg_keyemp
       and emp_status = 1;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN
      SELECT emp_keyloc
        INTO ve_codloc
        FROM emplpaso
       WHERE emp_keyemp = vg_keyemp;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
  END;
UPDATE  traypaso
 SET tra_codloc = ve_codloc ,
     tra_saldia = ve_saldia ,
     tra_salmes = ve_salmes ,
     tra_salint = ve_salint ,
     tra_salivc = ve_salivc ,
     tra_salinf = ve_salinf ,
     tra_intsin = ve_intsin ,
     tra_infsin = ve_infsin ,
     ora_status = 'S'
   WHERE tra_keyemp = vg_keyemp
   AND   tra_tipmov = vg_tipmov
   AND   tra_fecmov = vg_fecmov;
END IF;
END IF;
IF pe_status = 2 and vg_tipmov = 1 then
   update traypaso set ora_status = 'D'
    where tra_keyemp= vg_keyemp
      and tra_tipmov= vg_tipmov
      and tra_fecmov = vg_fecmov;
END IF;
  -- Actualiza la tabla de monitoreo indicando la finalizaci�  --
  -- del proceso.                                                 --
  ws_hor_act := TO_CHAR (SYSDATE, 'HH24:MI:SS');
  UPDATE glcoresu SET res_numreg = vn_existr,
                      res_fecfin = TO_CHAR (SYSDATE, 'mm/dd/yyyy'),
                      res_horfin = ws_hor_act,
                      res_status = 'T'
    WHERE res_idepro = ws_nom_rep
      AND res_idepcc =  ws_ide_pcc
      AND res_keyusu = wn_key_usu
      AND res_fecini = TO_CHAR (SYSDATE, 'mm/dd/yyyy')
      AND res_horreg = ws_hor_reg;
END;
/
