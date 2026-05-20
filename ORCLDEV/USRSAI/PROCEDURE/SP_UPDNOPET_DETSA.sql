CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_UPDNOPET_DETSA" (   numsol IN NUMBER, idereg IN NUMBER, numpet IN NUMBER,
                                                            aux OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 aux2 NUMBER;
BEGIN
	 aux := 0;
	SELECT COUNT(*) INTO aux
	FROM  detsolact
		WHERE dsa_numsol = numsol
			AND dsa_idereg = idereg;
	IF aux >= 1 THEN
		UPDATE detsolact
		SET dsa_numpet = numpet,
		    dsa_stsreg = 4
		WHERE dsa_numsol = numsol
			AND dsa_idereg = idereg;
	END IF;
	-- Actualiza el estado de una solicitud cuando todos las solicitudes-actor han sido atendidas
	SELECT COUNT(*) INTO aux2
	FROM detsolact
	WHERE dsa_numpet is null AND dsa_numsol = numsol;
	IF aux2 = 0 THEN
		UPDATE encsolact
		SET esa_stssol = 4
		WHERE esa_numsol = numsol;
	END IF;
END ;
/
