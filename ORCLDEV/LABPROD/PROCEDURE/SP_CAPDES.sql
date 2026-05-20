CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_CAPDES" (empleado IN INTEGER, capacidad OUT NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-----------------------------------globales
 total NUMBER;
 base VARCHAR2(10);
BEGIN
    BASE := LABPROD.FN_BASEDATOS_EMP(empleado);
    SP_CAPDES_LOCAL (empleado, capacidad);
    /*
    APSI
    231009 Cambio para TU
    IF BASE = 'TVNOMINA' THEN
      SP_CAPDES_LOCAL (empleado, capacidad);
    ELSE
      SP_CAPDES_LOCAL@RTELECOM (empleado, capacidad);
    END IF;
    */
END;
/
