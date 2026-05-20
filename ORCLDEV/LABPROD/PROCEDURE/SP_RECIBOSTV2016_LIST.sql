CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_RECIBOSTV2016_LIST" (
    v_KeyBin IN VARCHAR2 DEFAULT 'nmgrec' ,
    v_IdePro IN VARCHAR2 DEFAULT 'RECNOM2100' ,
    v_IdePcc IN VARCHAR2 DEFAULT 'MIYISHOME' ,
    v_KeyUsu IN NUMBER DEFAULT 990001 ,
    v_FecIni IN DATE DEFAULT '22/12/2016' ,
    v_HorIni IN VARCHAR2 DEFAULT '21:00' ,
    CV_EMPLIST OUT SYS_REFCURSOR )
AS
-- PGV moved types end

-- PGV moved types end
  /*
  ?         idePro  (Identificador del proceso, sirve para ir a buscar los par?metros y el resultado)
  ?         idePCC (Nombre de la PC)
  ?         ideUsu (Clave de usuario)
  ?         Fecha de Ejecuci?n
  ?         Hora de Ejecuci?n
  */
  v_KeyPro NUMBER(10,0) := NULL;
  v_KeyNom NUMBER(10,0) := NULL;
  v_KeyPer VARCHAR2(7)  := NULL;
BEGIN
  DECLARE
-- PGV moved types start

-- PGV moved types start
    v_MissedPams NUMBER;
  --OBTENER PARAMETROS
  BEGIN
    BEGIN
      --Obtener proceso de la glcoargu
      SELECT arg_pvalor
      INTO v_KeyPro
      FROM labprod.glcoargu
      WHERE arg_keycam = 'KEY_PRO'
      AND arg_idepro   = v_IdePro
      AND arg_idepcc   = v_IdePcc
      AND arg_keyusu   = v_KeyUsu
      AND arg_fecini   = v_FecIni
      AND arg_horini   = v_HorIni;
      DBMS_OUTPUT.PUT_LINE('wn_keypro = ' || UTILS.CONVERT_TO_VARCHAR2(v_KEYPRO,4000));
      --Obtener nomina de la glcoargu
      SELECT arg_pvalor
      INTO v_KeyNom
      FROM labprod.glcoargu
      WHERE arg_keycam = 'KEY_NOM'
      AND arg_idepro   = v_IdePro
      AND arg_idepcc   = v_IdePcc
      AND arg_keyusu   = v_KeyUsu
      AND arg_fecini   = v_FecIni
      AND arg_horini   = v_HorIni;
      DBMS_OUTPUT.PUT_LINE('wn_keynom = ' || UTILS.CONVERT_TO_VARCHAR2(v_KeyNom,4000));
      --Obtener periodo de la glcoargu
      SELECT arg_pvalor
      INTO v_KeyPer
      FROM labprod.glcoargu
      WHERE arg_keycam = 'KEY_PER'
      AND arg_idepro   = v_IdePro
      AND arg_idepcc   = v_IdePcc
      AND arg_keyusu   = v_KeyUsu
      AND arg_fecini   = v_FecIni
      AND arg_horini   = v_HorIni;
      DBMS_OUTPUT.PUT_LINE('wn_keyper = ' || v_KeyPer);
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
     v_MissedPams :=1;
     raise_application_error(-20101, 'No se encontraron los parametros');
    END;
      OPEN CV_EMPLIST FOR
      SELECT EMP_KEYEMP ,
      'RN_' || UTILS.CONVERT_TO_VARCHAR2(v_KeyPro,4000) || '_' || v_KeyPer || '_' || UTILS.CONVERT_TO_VARCHAR2(emp_keyemp,4000) || '.PDF' PdfFileName
      FROM labprod.nmloperi
      JOIN labprod.nmlohemp ON ( hem_keypro = per_keypro AND hem_keyper = per_keyper )
      JOIN labprod.nmcoempl ON ( emp_keyemp = hem_keyemp )
      WHERE per_keypro = v_KeyPro AND per_keyper = v_KeyPer
      ORDER BY emp_nomemp ;
  END;
EXCEPTION
WHEN OTHERS THEN
  --utils.handleerror(SQLCODE,SQLERRM);
  RETURN;
END;
/
