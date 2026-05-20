CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_INSERTENCPETCON" (keydep IN VARCHAR2,   observ IN VARCHAR2, keyusu IN VARCHAR2,
                                                          stspet IN NUMBER,     sigID OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
	sigID := 0;
	SELECT COALESCE(MAX(epc_numpco), 0) + 1 INTO sigID FROM encpetco;
		INSERT INTO encpetco(epc_numpco, epc_keydep, epc_fecpet, epc_observ, epc_keyusu, epc_stspet) VALUES (sigID, keydep, SYSDATE, observ, keyusu, stspet);
END;
/
