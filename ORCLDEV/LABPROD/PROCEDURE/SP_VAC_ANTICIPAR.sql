CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_VAC_ANTICIPAR" 
(
  KEYEMP IN NUMBER,
  FECSOL IN DATE,
  FECACT IN DATE,
  NUMANI OUT NUMBER
) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
DIASAL DECIMAL(10,2);
NUMDIA DECIMAL(10,2);
FECING DATE;
FECINI DATE;
FECCAD DATE;
MESES_FECACT DECIMAL(10,2);
MESES_FECSOL DECIMAL(10,2);
CUENTA_PERIODOS INTEGER;
KEYPRO INTEGER;
KEYLOC VARCHAR2(16);
BEGIN
  --Valida si el empleado puede anticipar vacaciones en la fecha de la solicitud.
  --Si no hay d?as disponibles en el periodo de la solicitud, valida si est? a 3 meses de su siguiente periodo vacacional
  --Si no est? dentro dentro de los 3 meses anteriores a su siguiente periodo vacacional, entonces regresa 0 en NUMANI
  BEGIN
    --Busca si existen periodos con dias de saldo disponibles para la solicitud
    SELECT COUNT(*) INTO CUENTA_PERIODOS
      FROM LABPROD.molodiad
      WHERE dia_keyemp = KEYEMP
      AND dia_feccad >= FECACT
      AND dia_fecini <= FECSOL
      AND dia_diasal > 0;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       CUENTA_PERIODOS := 0;
  END;
  IF CUENTA_PERIODOS > 0 THEN
    NUMANI := 0;  --Hay periodos con saldo vigentes. No se puede anticipar vacaciones
  ELSE
    --Busca la fecha de inicio del siguiente periodo vacacional
    BEGIN
      SELECT EMP_FECAUX, EMP_KEYPRO, EMP_KEYLOC
        INTO FECING, KEYPRO, KEYLOC
      FROM LABPROD.NMCOEMPL
      WHERE EMP_KEYEMP = KEYEMP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NUMANI := 0;
        RETURN;
    END;
    FECINI := FN_VAC_FECINIPER(KEYEMP,FECACT,FECING);
    MESES_FECACT := MONTHS_BETWEEN(FECACT,FECINI);
    MESES_FECSOL := MONTHS_BETWEEN(FECSOL,FECINI);
    DBMS_OUTPUT.PUT_LINE('FECINI = '||FECINI);
    DBMS_OUTPUT.PUT_LINE('MESES_FECACT = '||MESES_FECACT);
    DBMS_OUTPUT.PUT_LINE('MESES_FECSOL = '||MESES_FECSOL);
    IF MESES_FECACT >= -3 AND MESES_FECSOL >= -3 THEN
      DBMS_OUTPUT.PUT_LINE('INSERTAR PERIODO');
      LABPROD.SP_VAC_INSERTARPERIODOANT(KEYEMP,FECINI,FECING,KEYPRO,KEYLOC,NUMANI);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Todav?a no puede insertar el periodo');
      NUMANI := 0;  --Todav?a no puede insertar el periodo
    END IF;
  END IF;
END SP_VAC_ANTICIPAR;
/
