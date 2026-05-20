CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_DELETEDETPETCO" (numpco IN NUMBER, idereg IN NUMBER,cont OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
		SELECT COUNT(*) INTO cont FROM detpetco
		WHERE dpc_idereg = idereg AND dpc_numpco = numpco;
	IF cont >= 1 THEN
		DELETE FROM detpetco
		WHERE dpc_idereg = idereg
			AND dpc_numpco = numpco;
	END IF;
END;
/
