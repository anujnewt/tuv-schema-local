CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_INSERTENCSOLACT" (  keydep IN VARCHAR2, nomresp IN VARCHAR2, fecgra IN VARCHAR2,
                                                            fecair IN VARCHAR2, observ IN VARCHAR2, keyusu IN VARCHAR2,
                                                            stssol IN NUMBER, obscar IN VARCHAR2, ccdesprov IN VARCHAR2,
                                                            ccprov IN VARCHAR2, sigID OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
      sigID := 0;
      SELECT COALESCE(MAX(esa_numsol), 0) + 1 INTO sigID FROM encsolact;
            INSERT INTO encsolact(esa_numsol, esa_keydep, esa_nomresp, esa_fecsol, esa_fecgra, esa_fecair, esa_observ,esa_keyusu, esa_stssol, esa_obscar, esa_desori, esa_cdcori) VALUES (sigID, keydep, nomresp, SYSDATE, TO_DATE(fecgra,'dd/mm/yyyy'), TO_DATE(fecair,'dd/mm/yyyy'), observ, keyusu, stssol, obscar, ccdesprov, ccprov);
END;
/
