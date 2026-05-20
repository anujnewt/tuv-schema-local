CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAPCOCAM" (pnKeyPlz NUMBER,psKeyDep VARCHAR2,
                                psKeyPue VARCHAR2,pnEjercicio NUMBER,
                                pnCosUni NUMBER,pnNumCdi NUMBER,pnProc NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   lsStatus holopres.pre_status%TYPE;
   lsStatus2 hologlpr.glp_status%TYPE;
   pnEjercicioG NUMBER(5);
BEGIN
		--Lee los Capitulos Vigentes y los Cancela
		  UPDATE USRSIHO.holococa
			  SET coc_stspag = 'C'
		   WHERE coc_stspag = 'V'
		     AND coc_keyrph is null
		     AND coc_keyplz = pnKeyPlz;
   --Actualizamos HOLOPRES o HOLOGLPR lo ejercido por cada Capitulo Vigente
   --dependiendo del proceso
      IF pnProc = 138 THEN
        BEGIN
            SELECT pre_status
             INTO lsStatus
             FROM USRSIHO.holopres
            WHERE pre_keydep = psKeyDep
              AND pre_keypue = TRIM(psKeyPue)
              AND pre_anio   = pnEjercicio;
        END;
		IF lsStatus = 'A' THEN
			UPDATE USRSIHO.holopres
			   SET pre_ejerci = pre_ejerci - (pnCosUni * pnNumCdi)
			 WHERE pre_keydep = psKeyDep
			   AND pre_keypue = TRIM(psKeyPue)
			   AND pre_anio   = pnEjercicio
			   AND pre_status = 'A';
		ELSE
			SELECT MAX(pre_anio)
			  INTO pnEjercicioG
			  FROM USRSIHO.holopres
			 WHERE pre_keydep = psKeyDep
			   AND pre_keypue = TRIM(psKeyPue);
			UPDATE USRSIHO.holopres
			   SET pre_ejerci = pre_ejerci - (pnCosUni * pnNumCdi)
			 WHERE pre_keydep = psKeyDep
			   AND pre_keypue = TRIM(psKeyPue)
			   AND pre_anio   = pnEjercicioG;
		END IF;
      ELSE
            insert into USRSIHO.glwkcrys  (cry_nomrep,cry_chr001,cry_numsec)
                              values ('claud',pnEjercicio,1);
            BEGIN
                SELECT glp_status
                  INTO lsStatus2
                  FROM USRSIHO.hologlpr
                 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
                   AND glp_keypue = TRIM(psKeyPue)
                   AND glp_anio   = pnEjercicio;
                EXCEPTION WHEN no_data_found THEN lsStatus2 := '';
            END;
		IF lsStatus2 = 'A' THEN
			UPDATE USRSIHO.hologlpr
			   SET glp_ejerci = glp_ejerci - (pnCosUni * pnNumCdi)
			 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
			   AND glp_keypue = TRIM(psKeyPue)
			   AND glp_anio   = pnEjercicio
			   AND glp_status = 'A';
		ELSE
            BEGIN
                SELECT MAX(glp_anio)
                  INTO pnEjercicioG
                  FROM USRSIHO.hologlpr
                 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
                   AND glp_keypue = TRIM(psKeyPue);
                EXCEPTION WHEN no_data_found THEN pnEjercicioG := 0;
            END;
			UPDATE USRSIHO.hologlpr
			   SET glp_ejerci = glp_ejerci - (pnCosUni * pnNumCdi)
			 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
			   AND glp_keypue = TRIM(psKeyPue)
			   AND glp_anio   = pnEjercicioG;
		END IF;
        END IF;
		UPDATE USRSIHO.holocont
		   SET con_numcdi = 0
		 WHERE con_keyplz = pnKeyPlz;
END;
/
