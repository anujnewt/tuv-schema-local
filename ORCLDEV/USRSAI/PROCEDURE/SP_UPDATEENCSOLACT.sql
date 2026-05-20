CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_UPDATEENCSOLACT" (numsol IN NUMBER,keydep IN VARCHAR2, nomresp IN VARCHAR2,
                                    fecgra IN VARCHAR2, fecair IN VARCHAR2, observ IN VARCHAR2,
                                    stssol IN NUMBER, obscar IN VARCHAR2, aux OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
      aux := 0;
      SELECT COUNT(*) INTO aux
      FROM encsolact
      WHERE esa_numsol = numsol;
      IF aux >= 1 THEN
            UPDATE encsolact
            SET esa_keydep = keydep,
                  esa_observ = observ,
                  esa_fecgra = TO_DATE(fecgra,'dd/mm/yyyy'),
                  esa_fecair = TO_DATE(fecair,'dd/mm/yyyy'),
                  esa_stssol = stssol,
                  esa_nomresp = nomresp,
                  esa_obscar = obscar
            WHERE esa_numsol = numsol;
      END IF;
END;
/
