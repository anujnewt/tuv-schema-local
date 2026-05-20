CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_LLENA_REPORTES" 
(
pANIO  IN NUMBER,
pMES   IN NUMBER,
pTIPO  IN NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
	IF pTIPO = 1  THEN
	   FECXC.Fecxp_Llena_Caratula_Real(pANIO, pMES);
	   FECXC.Fecxp_Llena_Caratula_Ppto(pANIO, pMES);
	END IF;
	IF pTIPO = 2  THEN
	   FECXC.Fecxp_Llena_Forecast ( pANIO, pMES );
	END IF;
	IF pTIPO = 3  THEN
	   FECXC.Fecxp_Llena_Rep_Concil_Erp ( pANIO, pMES );
	   FECXC.Fecxp_Llena_Rep_Concil_Soin ( pANIO, pMES );
	END IF;
	IF pTIPO = 4  THEN
	   FECXC.Fecxp_Llena_Rep_Mcomp_Erp ( pANIO, pMES );
	   FECXC.Fecxp_Llena_Rep_Mcomp_Soin ( pANIO, pMES );
	END IF;
	IF pTIPO = 5  THEN
	   FECXC.Fecxp_Llena_Rep_Ppto_Erp ( pANIO, pMES );
	   FECXC.Fecxp_Llena_Rep_Ppto_Soin ( pANIO, pMES );
	END IF;
	IF pTIPO = 6  THEN
	   FECXC.Fecxp_Llena_Rep_Real_Erp ( pANIO, pMES );
	   FECXC.Fecxp_Llena_Rep_Real_Soin ( pANIO, pMES );
	END IF;
COMMIT;
END Fecxp_Llena_Reportes;
/
