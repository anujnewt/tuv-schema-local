CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_DELETEPCTMP" (numpet IN NUMBER, aux OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
     aux := 0;
      --Cuenta registros
	SELECT COUNT(*) INTO aux
	FROM  detpetco
		WHERE dpc_numpco = numpet;
	--Encabezado
		DELETE FROM encpetco
		WHERE epc_numpco = numpet;
      --Detalle
		DELETE FROM detpetco
		WHERE dpc_numpco = numpet;
END;
/
