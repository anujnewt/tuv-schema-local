CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_CONS_EMPL" (pw_keyemp IN NMCOEMPL.EMP_KEYEMP%TYPE,
                               pw_nomemp OUT VARCHAR2,
                               pw_appemp OUT VARCHAR2,
                               pw_apmemp OUT VARCHAR2,
                               pw_status OUT VARCHAR2,
                               pw_despue OUT VARCHAR2,
                               pw_descia OUT VARCHAR2,
                               pw_desdep OUT VARCHAR2,
                               pw_pol_cc OUT VARCHAR2,
                               pw_error OUT VARCHAR2)IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
lw_nomemp    DATOSGENERALES.GEN_NOMEMP%TYPE;
lw_apepat    DATOSGENERALES.GEN_APEPAT%TYPE;
lw_apemat    DATOSGENERALES.GEN_APEMAT%TYPE;
BEGIN
--   --extraemos el nombre del empleado de la tabla DATOSGENERALES
--   BEGIN
--      SELECT  gen_nomemp,
--              gen_apepat,
--              gen_apemat
--      INTO    lw_nomemp,
--              lw_apepat,
--              lw_apemat
--      FROM    DATOSGENERALES
--      WHERE   gen_keyemp    = pw_keyemp
--      AND     ROWNUM = 1;
--   EXCEPTION
--      WHEN NO_DATA_FOUND THEN
--         pw_error := 'NO EXISTE EL NUMERO DEL EMPLEADO [' || pw_keyemp || '] EN DATOS GENERALES';
--      WHEN OTHERS THEN
--         IF SQLCODE = -54 THEN
--            pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION DE DATOSGENERALES';
--         ELSE
--            pw_error := 'ERROR: '||SQLERRM;
--         END IF;
--      RETURN;
--   END;
--   pw_nomemp := lw_apepat || '/' || lw_apemat || '/' || lw_nomemp;
   --SE EXTRAEN LOS DATOS GENERALES DEL EMPLEADO
   BEGIN
      SELECT REPLACE(em.emp_nomemp, '/', '-'),
             em.emp_status,
             pu.pue_despue,
             ci.cia_descia,
             dp.dep_desdep,
             --INICIA MOD 24-07-2017
             SUBSTR(dp.dep_refcon,15,8)
             --TERMINA MOD 24-07-2017
      INTO   lw_nomemp,
             pw_status,
             pw_despue,
             pw_descia,
             pw_desdep,
             --INICIA MOD 24-07-2017
             pw_pol_cc
             --TERMINA MOD 24-07-2017
      FROM   LABPROD.nmcoempl em,
             LABPROD.nmcopues pu,
             LABPROD.nmloproc pr,
             LABPROD.nmlocias ci,
             LABPROD.nmcodeps dp
      WHERE emp_keyemp    = pw_keyemp
      AND   em.emp_keypue = pu.pue_keypue
      AND   em.emp_keypro = pr.pro_keypro
      AND   pr.pro_keycia = ci.cia_keycia
      AND   em.emp_keydep = dp.dep_keydep;
      pw_appemp := SUBSTR(lw_nomemp,1,INSTR(lw_nomemp,'-') - 1);
      lw_nomemp := SUBSTR(lw_nomemp,INSTR(lw_nomemp,'-') + 1);
      pw_apmemp := SUBSTR(lw_nomemp,1,INSTR(lw_nomemp,'-') - 1);
      lw_nomemp := SUBSTR(lw_nomemp,INSTR(lw_nomemp,'-') + 1);
      pw_nomemp :=  lw_nomemp;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         pw_error := 'NO EXISTE EL NUMERO DEL EMPLEADO [' || pw_keyemp || '] CON NOMBRE [' || pw_nomemp || ']';
      WHEN OTHERS THEN
         IF SQLCODE = -54 THEN
            pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION';
         ELSE
            pw_error := 'ERROR: '||SQLERRM;
         END IF;
      RETURN;
   END;
   ----se extrae el centro de costos
   --INICIA MOD 24-07-2017
--   BEGIN
--      SELECT tv.pol_cc
--      INTO   pw_pol_cc
--      FROM   LABPROD.tvwkpoli tv
--      WHERE  tv.pol_keyemp = pw_keyemp
--      AND    tv.pol_fecmov = (
--                              SELECT MAX(pol_fecmov)
--                              FROM   LABPROD.tvwkpoli tv
--                              WHERE  tv.pol_keyemp = pw_keyemp
--                              AND    tv.pol_cc <> '00000000')
--      AND    tv.pol_cc <> '00000000'
--      AND ROWNUM = 1;
--   EXCEPTION
--      WHEN NO_DATA_FOUND THEN
--         pw_error := 'NO EXISTE NUMERO DE EMPLEADO [' || pw_keyemp || '], SI ERES COLABORADOR DE TELEVISA TALENTO, FAVOR DE CAPTURAR LOS DATOS.';
--      WHEN OTHERS THEN
--         IF SQLCODE = -54 THEN
--            pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION';
--         ELSE
--            pw_error := 'ERROR: '||SQLERRM;
--         END IF;
--      RETURN;
--   END;
--EXCEPTION
--   WHEN NO_DATA_FOUND THEN
--      pw_error := 'NO EXISTE NUMERO DE EMPLEADO [' || pw_keyemp || '], SI ERES COLABORADOR DE TELEVISA TALENTO, FAVOR DE CAPTURAR LOS DATOS.';
--   WHEN OTHERS THEN
--      IF SQLCODE = -54 THEN
--         pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION';
--      ELSE
--         pw_error := 'ERROR: '||SQLERRM;
--      END IF;
--   RETURN;
   --TERMINA MOD 17-07-2017
END;
/
