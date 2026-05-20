CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."TVCDESAF" IS
    TYPE empleado IS RECORD ( keyemp nmcoempl.emp_keyemp%TYPE, keydep nmcoempl.emp_keydep%TYPE, keypue nmcoempl.emp_keypue%TYPE,
                            keypro nmcoempl.emp_keypro%TYPE, status nmcoempl.emp_status%TYPE);
    TYPE periodo IS RECORD ( period glcopams.pam_nompar%TYPE, fecini glcopams.pam_folini%TYPE, fecfin glcopams.pam_folfin%TYPE,
                             diaper INTEGER, cvecal VARCHAR(3));
    TYPE afiliacion IS RECORD (keycon nmlodfij.dfi_keycon%TYPE, porcen nmlodfij.dfi_cantid%TYPE, cuofij nmlodfij.dfi_import%TYPE);
   ---------------------------------
    PROCEDURE Afiliar (recurp IN nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Modifica_Afiliacion ( recurp IN nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Desafiliar ( recurp IN nmcoempl.emp_recurp%TYPE , keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Pagos (recurp IN nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Inserta (recurp IN nmcoempl.emp_recurp%TYPE , monsol IN NUMBER, mondes IN NUMBER, tipact IN NUMBER, cveref IN nmlopres.pre_refere%TYPE,
      unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER);
    PROCEDURE Reestructura (client IN nmlopres.pre_ca2aux%TYPE, recurp IN nmcoempl.emp_recurp%TYPE , cveres IN nmlopres.pre_refere%TYPE, monsol IN NUMBER, mondes IN NUMBER,
      cveref IN nmlopres.pre_refere%TYPE, unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER,
      sdocap IN NUMBER, monadi IN NUMBER, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Elimina_Prestamo ( recurp IN nmcoempl.emp_recurp%TYPE , cveref IN nmlopres.pre_refere%TYPE, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Actualiza_Prestamo ( recurp IN nmcoempl.emp_recurp%TYPE , cveref IN nmlopres.pre_refere%TYPE, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Inserta_Prestamo (recurp IN nmcoempl.emp_recurp%TYPE, totsol in number, impdes in number, totint in number, intdes in number, unisal in number,
                              cvecli in varchar, cveref IN nmlopres.pre_refere%TYPE, keycon IN nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
END TVCDESAF;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."TVCDESAF" IS
/* -- Private Global Variables -------------------------------------------- */
  total NUMBER;
  proceso_actual NUMBER;
  base VARCHAR2(10);
--PROCEDIMIENTO AFILIAR
/* -------------------------------------------------------------------------- */
  PROCEDURE Afiliar (recurp IN nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Afiliar (recurp, cantid, tipact, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Afiliar@RTELECOM(recurp, cantid, tipact, keycon, resultado);
    */
    END IF;
  END Afiliar;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO MODIFICA AFILIACION
/* -------------------------------------------------------------------------- */
  PROCEDURE Modifica_Afiliacion ( recurp IN nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Modifica_Afiliacion (recurp, cantid, tipact, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Modifica_Afiliacion@RTELECOM (recurp, cantid, tipact, keycon, resultado);
    */
    END IF;
  END Modifica_Afiliacion;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO DESAFILIAR
/* -------------------------------------------------------------------------- */
  PROCEDURE Desafiliar ( recurp IN nmcoempl.emp_recurp%TYPE , keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Desafiliar (recurp, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Desafiliar@RTELECOM(recurp, keycon, resultado);
    */
    END IF;
  END Desafiliar;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO PAGOS
/* -------------------------------------------------------------------------- */
  PROCEDURE Pagos(recurp IN nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN nmloconc.con_keycon%TYPE,resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Pagos (recurp, cantid, tipact, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Pagos@RTELECOM (recurp, cantid, tipact, keycon, resultado);
    */
    END IF;
  END Pagos;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO INSERTA
/* -------------------------------------------------------------------------- */
  PROCEDURE Inserta (recurp IN nmcoempl.emp_recurp%TYPE , monsol IN NUMBER, mondes IN NUMBER, tipact IN NUMBER, cveref IN nmlopres.pre_refere%TYPE,
                  unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Inserta (recurp, monsol, mondes, tipact, cveref, unipre, unides, unisal, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Inserta@RTELECOM (recurp, monsol, mondes, tipact, cveref, unipre, unides, unisal, keycon, resultado);
    */
    END IF;
  END Inserta;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO REESTRUCTURA
/* -------------------------------------------------------------------------- */
  PROCEDURE Reestructura (client IN nmlopres.pre_ca2aux%TYPE, recurp IN nmcoempl.emp_recurp%TYPE , cveres IN nmlopres.pre_refere%TYPE, monsol IN NUMBER, mondes IN NUMBER,
                        cveref IN nmlopres.pre_refere%TYPE, unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER,
                        sdocap IN NUMBER, monadi IN NUMBER, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Reestructura (client, recurp, cveres, monsol, mondes, cveref, unipre, unides, unisal, sdocap, monadi, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Reestructura@RTELECOM (client, recurp, cveres, monsol, mondes, cveref, unipre, unides, unisal, sdocap, monadi, keycon, resultado);
    */
    END IF;
  END Reestructura;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO ELIMINA_PRESTAMO
/* -------------------------------------------------------------------------- */
  PROCEDURE Elimina_Prestamo ( recurp IN nmcoempl.emp_recurp%TYPE , cveref IN nmlopres.pre_refere%TYPE, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Elimina_Prestamo (recurp, cveref, keycon, resultado);
    /*
    APSI 231017
    ELSE
     TVCDESAF_LOCAL.Elimina_Prestamo@RTELECOM (recurp, cveref, keycon, resultado);
    */
    END IF;
  END Elimina_Prestamo;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO ACTUALIZA_PRESTAMO
/* -------------------------------------------------------------------------- */
  PROCEDURE Actualiza_Prestamo ( recurp IN nmcoempl.emp_recurp%TYPE , cveref IN nmlopres.pre_refere%TYPE, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Actualiza_Prestamo (recurp, cveref, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Actualiza_Prestamo@RTELECOM (recurp, cveref, keycon, resultado);
    */
    END IF;
  END Actualiza_Prestamo;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO INSERTA_PRESTAMO
/* -------------------------------------------------------------------------- */
PROCEDURE Inserta_Prestamo (recurp IN nmcoempl.emp_recurp%TYPE, totsol in number, impdes in number, totint in number, intdes in number, unisal in number,
                              cvecli in varchar, cveref IN nmlopres.pre_refere%TYPE, keycon IN nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(recurp);
    IF BASE = 'TVNOMINA' THEN
      TVCDESAF_LOCAL.Inserta_Prestamo (recurp, totsol, impdes, totint, intdes, unisal, cvecli, cveref, keycon, resultado);
    /*
    APSI 231017
    ELSE
      TVCDESAF_LOCAL.Inserta_Prestamo@RTELECOM (recurp, totsol, impdes, totint, intdes, unisal, cvecli, cveref, keycon, resultado);
    */
    END IF;
  END Inserta_Prestamo;
/* -------------------------------------------------------------------------- */
END TVCDESAF;
/;
