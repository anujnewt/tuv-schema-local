CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAPCOELI" (pnKeyPlz NUMBER,psKeyDep VARCHAR2,
                                psKeyPue VARCHAR2,pnEjercicio NUMBER,
                                pnCosUni NUMBER,pnNumCdi NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
	--Actualizo prestamosR
	UPDATE USRSIHO.holopres
	   SET pre_ejerci = pre_ejerci - (pnCosUni * pnNumCdi)
	 WHERE pre_keydep = TRIM(psKeyDep)
	   AND pre_keypue = TRIM(psKeyPue)
	   AND pre_anio   = pnEjercicio;
	--Elimino el contrato
	DELETE FROM USRSIHO.holocont
	 WHERE con_keyplz = pnKeyPlz;
END;
/
