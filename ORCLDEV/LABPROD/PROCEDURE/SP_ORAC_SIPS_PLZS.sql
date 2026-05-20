CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ORAC_SIPS_PLZS" (noctvo integer) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vg_noctvo    integer;
 vg_keyest    varchar2(3);
 vg_keydep    varchar2(16);
 vg_keypue    varchar2(16);
 vg_keyplz    integer;
 vg_keycat    varchar2(16);
 vg_keyloc    varchar2(16);
 vg_tippla    varchar2(2);
 vg_fecini    date;
 vg_fecfin    date;
 vg_diavig    smallint;
 vg_turnop    smallint;
 vg_keyhor    varchar2(16);
 vg_keyemp    integer;
 vg_cveuoc    integer;
 vg_cverem    integer;
 vg_fecmov    date;
 vg_submov    varchar2(2);
 vg_cosplz    decimal(14,2);
 vg_ca1aux    varchar2(16);
 vg_ca2aux    varchar2(16);
 vg_ca3aux    varchar2(16);
 vg_nu1aux    varchar2(10);
 vg_nu2aux    varchar2(10);
 vg_nu3aux    varchar2(10);
 vg_nu3aux_1   varchar2(16);
 vg_fe1aux    varchar2(10);
 vg_fe2aux    varchar2(10);
 vg_fe3aux    date;
 vg_co1aux    decimal(14,2);
 vg_co2aux    decimal(14,2);
 vg_co3aux    decimal(14,2);
 vg_co4aux    decimal(14,2);
 vg_co5aux    decimal(14,2);
 vg_keysue    varchar2(4);
 vg_sueniv    integer;
 vg_subniv    integer;
 vg_cobert    varchar2(2);
 vg_keypro    smallint;
 vg_keydpl    decimal(16,6);
 vg_fecocu    date;
 vg_salplz    decimal(12,2);
 vg_titula    integer;
 vg_origen    varchar2(2);
 vg_valimp    varchar2(2);
 vg_limocu    date;
 vg_tiptab    varchar2(2);
 vn_existr    integer;
 vs_activo    varchar2(1);
 BEGIN
-- Toma los campos que son de tipo catalogo para verificar que existan --
SELECT plz_keyest, plz_keydep, plz_keypue, plz_keyplz, plz_keycat,
       plz_keyloc, plz_tippla, plz_fecini, plz_fecfin, plz_diavig,
       plz_turnop, plz_keyhor, plz_keyemp, plz_cveuoc, plz_cverem,
       plz_fecmov, plz_submov, plz_cosplz, plz_ca1aux, plz_ca2aux,
       plz_ca3aux, plz_nu1aux, plz_nu2aux, plz_nu3aux, plz_fe1aux,
       plz_fe2aux, plz_fe3aux, plz_co1aux, plz_co2aux, plz_co3aux,
       plz_co4aux, plz_co5aux, plz_keysue, plz_sueniv, plz_subniv,
       plz_cobert, plz_keypro, plz_keydpl, plz_fecocu, plz_salplz,
       plz_titula, plz_origen, plz_valimp, plz_limocu, plz_tiptab
INTO  vg_keyest, vg_keydep, vg_keypue, vg_keyplz, vg_keycat,
      vg_keyloc, vg_tippla, vg_fecini, vg_fecfin, vg_diavig,
      vg_turnop, vg_keyhor, vg_keyemp, vg_cveuoc, vg_cverem,
      vg_fecmov, vg_submov, vg_cosplz, vg_ca1aux, vg_ca2aux,
      vg_ca3aux, vg_nu1aux, vg_nu2aux, vg_nu3aux, vg_fe1aux,
      vg_fe2aux, vg_fe3aux, vg_co1aux, vg_co2aux, vg_co3aux,
      vg_co4aux, vg_co5aux, vg_keysue, vg_sueniv, vg_subniv,
      vg_cobert, vg_keypro, vg_keydpl, vg_fecocu, vg_salplz,
      vg_titula, vg_origen, vg_valimp, vg_limocu, vg_tiptab
  FROM com_orac_sips_plzs
  WHERE ora_noctvo = noctvo;
--Pregunta si existe si la plaza
BEGIN
SELECT count(*)
    INTO vn_existr
    FROM plzapaso
   WHERE plz_keyplz = vg_keyplz;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
END;
BEGIN
  SELECT cam_activo
    INTO vs_activo
    FROM com_orac_sips_camp
   WHERE cam_tablas='nmloplzs'
     AND cam_campos='plz_keyplz';
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
END;
   IF vn_existr = 0  AND vs_activo = 'S' THEN
         INSERT INTO com_orac_sips_bita
         VALUES (noctvo,'2','com_orac_sips_plzs',
                 'clave de la plaza es incorrecta',
                 TO_CHAR(TRUNC(SYSDATE, 'YYYY')));
   END IF;
  SELECT plz_keyest, plz_keydep, plz_keypue, plz_keyplz, plz_keycat,
         plz_keyloc, plz_tippla, plz_fecini, plz_fecfin, plz_diavig,
         plz_turnop, plz_keyhor, plz_keyemp, plz_cveuoc, plz_cverem,
         plz_fecmov, plz_submov, plz_cosplz, plz_ca1aux, plz_ca2aux,
         plz_ca3aux, plz_nu1aux, plz_nu2aux, plz_nu3aux, plz_fe1aux,
         plz_fe2aux, plz_fe3aux, plz_co1aux, plz_co2aux, plz_co3aux,
         plz_co4aux, plz_co5aux, plz_keysue, plz_sueniv, plz_subniv,
         plz_cobert, plz_keypro, plz_keydpl, plz_fecocu, plz_salplz,
         plz_titula, plz_origen, plz_valimp, plz_limocu, plz_tiptab
  INTO  vg_keyest, vg_keydep, vg_keypue, vg_keyplz, vg_keycat,
        vg_keyloc, vg_tippla, vg_fecini, vg_fecfin, vg_diavig,
        vg_turnop, vg_keyhor, vg_keyemp, vg_cveuoc, vg_cverem,
        vg_fecmov, vg_submov, vg_cosplz, vg_ca1aux, vg_ca2aux,
        vg_ca3aux, vg_nu1aux, vg_nu2aux, vg_nu3aux, vg_fe1aux,
        vg_fe2aux, vg_fe3aux, vg_co1aux, vg_co2aux, vg_co3aux,
        vg_co4aux, vg_co5aux, vg_keysue, vg_sueniv, vg_subniv,
        vg_cobert, vg_keypro, vg_keydpl, vg_fecocu, vg_salplz,
        vg_titula, vg_origen, vg_valimp, vg_limocu, vg_tiptab
  FROM com_orac_sips_plzs
   WHERE ora_noctvo = noctvo;
BEGIN
SELECT pam_cvesec
  INTO vg_nu3aux_1
  FROM glcopams
 WHERE pam_keypar='PC3'
   AND pam_nompar=vg_nu3aux;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  NULL;
END;
   IF vn_existr = 0 THEN
      INSERT INTO plzapaso
                (plz_keyest, plz_keydep, plz_keypue, plz_keyplz, plz_keycat,
                 plz_keyloc, plz_tippla, plz_fecini, plz_fecfin, plz_diavig,
                 plz_turnop, plz_keyhor, plz_keyemp, plz_cveuoc, plz_cverem,
                 plz_fecmov, plz_submov, plz_cosplz, plz_ca1aux, plz_ca2aux,
                 plz_ca3aux, plz_nu1aux, plz_nu2aux, plz_nu3aux, plz_fe1aux,
                 plz_fe2aux, plz_fe3aux, plz_co1aux, plz_co2aux, plz_co3aux,
                 plz_co4aux, plz_co5aux, plz_keysue, plz_sueniv, plz_subniv,
                 plz_cobert, plz_keypro, plz_keydpl, plz_fecocu, plz_salplz,
                 plz_titula, plz_origen, plz_valimp, plz_limocu, plz_tiptab )
          VALUES (vg_keyest, vg_keydep, vg_keypue, vg_keyplz, 'SC',
                  vg_keyloc, vg_tippla, vg_fecini, vg_fecfin, vg_diavig,
                  vg_turnop, vg_keyhor, vg_keyemp, vg_cveuoc, vg_cverem,
                  vg_fecmov, vg_submov, vg_cosplz, vg_ca1aux, vg_ca2aux,
                  vg_ca3aux, vg_nu1aux, vg_nu2aux, vg_nu3aux_1, vg_fe1aux,
                  vg_fe2aux, vg_fe3aux, vg_co1aux, vg_co2aux, vg_co3aux,
                  vg_co4aux, vg_co5aux, vg_keysue, vg_sueniv, vg_subniv,
                  vg_cobert, vg_keypro, vg_keydpl, vg_fecocu, vg_salplz,
                  vg_titula, vg_origen, vg_valimp, vg_limocu, vg_tiptab);
   ELSE
       UPDATE plzapaso set
              plz_keyest = vg_keyest,  plz_keydep = vg_keydep,
              plz_keypue = vg_keypue,  plz_keycat = 'SC',
              plz_keyloc = vg_keyloc,  plz_tippla = vg_tippla,
              plz_fecini = vg_fecini,  plz_fecfin = vg_fecfin,
              plz_diavig = vg_diavig,  plz_turnop = vg_turnop,
              plz_keyhor = vg_keyhor,  plz_keyemp = vg_keyemp,
              plz_cveuoc = vg_cveuoc,  plz_cverem = vg_cverem,
              plz_fecmov = vg_fecmov,  plz_submov = vg_submov,
              plz_cosplz = vg_cosplz,  plz_ca1aux = vg_ca1aux,
              plz_ca2aux = vg_ca2aux,  plz_ca3aux = vg_ca3aux,
              plz_nu1aux = vg_nu1aux,  plz_nu2aux = vg_nu2aux,
              plz_nu3aux = vg_nu3aux_1,  plz_fe1aux = vg_fe1aux,
              plz_fe2aux = vg_fe2aux,  plz_fe3aux = vg_fe3aux,
              plz_co1aux = vg_co1aux,  plz_co2aux = vg_co2aux,
              plz_co3aux = vg_co3aux,  plz_co4aux = vg_co4aux,
              plz_co5aux = vg_co5aux,  plz_keysue = vg_keysue,
              plz_sueniv = vg_sueniv,  plz_subniv = vg_subniv,
              plz_cobert = vg_cobert,  plz_keypro = vg_keypro,
              plz_keydpl = vg_keydpl,  plz_fecocu = vg_fecocu,
              plz_salplz = vg_salplz,  plz_titula = vg_titula,
              plz_origen = vg_origen,  plz_valimp = vg_valimp,
              plz_limocu = vg_limocu,  plz_tiptab = vg_tiptab
        WHERE plz_keyplz = vg_keyplz;
   END IF;
END;
/
