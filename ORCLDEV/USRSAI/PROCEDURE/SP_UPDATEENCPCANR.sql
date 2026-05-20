CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_UPDATEENCPCANR" (   numco IN NUMBER, keydep IN VARCHAR2, observ IN VARCHAR2,
                                                            stspet IN NUMBER,aux OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
            aux := 0;
            SELECT COUNT(*) INTO aux
            FROM encpetco
            WHERE epc_numpco = numco;
            IF aux >= 1 THEN
                        UPDATE encpcanr
                        SET epc_observ = observ,
                                   epc_keydep = keydep,
                                   epc_stspet = stspet
                        WHERE epc_numpco = numco;
            END IF;
END;
/
