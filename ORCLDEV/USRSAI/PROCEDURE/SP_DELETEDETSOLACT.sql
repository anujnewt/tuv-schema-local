CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_DELETEDETSOLACT" (  numsol IN NUMBER,   idereg IN NUMBER,   aux OUT NUMBER )
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
       aux := 0;
		SELECT COUNT(*) INTO aux
		FROM detsolact
		WHERE dsa_numsol = numsol
			AND dsa_idereg = idereg;
	IF aux >= 1 THEN
		DELETE FROM detsolact
		WHERE dsa_numsol = numsol
			AND dsa_idereg = idereg;
	END IF;
END;
/
