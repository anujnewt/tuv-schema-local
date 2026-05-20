CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAPCOALTGLO" (pnKeyTco NUMBER,psKeyDep VARCHAR2,psKeyPue VARCHAR2,
                                pnCtvPlz NUMBER,pnKeyEmp NUMBER,pnNumCap NUMBER,
                                pdFecIni DATE,pdFecVen DATE,pnKeyTab NUMBER,
                                psPerTra VARCHAR2,psIdioma VARCHAR2,psKeyNac VARCHAR2,
                                pnCosUni NUMBER,psDesPev VARCHAR2,pnKeyTva NUMBER,
                                psKeyTic VARCHAR2,psDiaPag VARCHAR2,psTmpSal VARCHAR2,
                                psAraEsp VARCHAR2,psStsFir VARCHAR2,psStsPlz VARCHAR2,
                                psStsPag VARCHAR2,pdFecFir VARCHAR2,pdFecCan VARCHAR2,
                                pnNumCdi NUMBER,psDesCap VARCHAR2,pnKeyUsg NUMBER,
                                psNumEje NUMBER,psScoCap VARCHAR2,psHrsJor VARCHAR2,
                                pdFecCap DATE, pspagouni VARCHAR2, psIdePcc VARCHAR2,
              lnKeyPlz OUT NUMBER,lnKeyFol OUT NUMBER, lsSigue OUT VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--lnKeyPlz,lnKeyFol,lsSigue;
--variables de retorno
--   lnKeyPlz 	NUMBER(10);
--   lnKeyFol 	NUMBER(10);
--   lsSigue 	VARCHAR2(1);
--variables de trabajo
   lsMarCco 	VARCHAR2(1);
   lsValPres 	VARCHAR2(1);
--	DEFINE lnPresu LIKE holopres.pre_presup;
 lnPresu hologlpr.glp_presup%TYPE;
--	DEFINE lnEjeci LIKE holopres.pre_ejerci;
        lnEjeci hologlpr.glp_ejerci%TYPE;
--	DEFINE lnAnio LIKE holopres.pre_anio ;
 lnAnio hologlpr.glp_anio%TYPE ;
   lnIni 	NUMBER(10);
   lnFin 	NUMBER(10);
   conteo number;
   lnFolEnc	NUMBER(10); --jcro
   err_num		NUMBER(10);
   psNumEjeIns Number(10);
BEGIN --jcro
   lsSigue := 'S';
   lnFolEnc := 0; --jcro
   err_num := 0; --jcro
    psNumEjeIns := psNumEje;
	--Checo que exista presupuesto en HOLOGLPR ANTES HOLOPRES
	--Validaciones 1 y 2 exclusivamente
	IF ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519 THEN
		BEGIN
            SELECT ald_marcco
              INTO lsMarCco
              FROM USRSIHO.nmloalde
             WHERE ald_keydep = psKeyDep;
            EXCEPTION WHEN no_data_found THEN lsMarCco := '';
         END;
		IF lsMarCco IS NULL THEN
			lsValPres := 'S';
		ELSE
			IF lsMarCco = 'N' THEN
				lsValPres := 'S';
			ELSE
				lsValPres := 'N';
			END IF;
		END IF;
		IF lsValPres = 'S' THEN
            BEGIN
                SELECT nvl(glp_presup,0),nvl(glp_ejerci,0),glp_anio
                  INTO lnPresu, lnEjeci, lnAnio
                  FROM USRSIHO.hologlpr
                 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
                   AND glp_keypue = psKeyPue
                   AND glp_status = 'A';
                EXCEPTION WHEN no_data_found THEN lnPresu  := 0;
                                                  lnEjeci := 0;
                                                  lnAnio := '';
            END;
			IF (lnPresu-lnEjeci) < (pnNumCap*pnCosUni) THEN
			   lsSigue := 'N';
			END IF;
		ELSE
		   lnAnio:=psNumEje;
		END IF;
	ELSE
		lnAnio := psNumEje;
	END IF;
	--psNumEje := lnAnio; original
   psNumEjeIns := lnAnio;
   lnKeyFol := 0;
   lnKeyPlz := 0;
	--Si existe presupuesto prosedo a hacer las operaciones
	IF lsSigue = 'S' THEN
	   -- Calcula el maximo utilizando el bloqueo de tabla --------------------
	   -- jcro --SET LOCK MODE TO WAIT;
	   -- jcro --LOCK TABLE HOLOCONT IN EXCLUSIVE MODE;
	   -- jcro --SELECT MAX(con_keyfol)
	   -- jcro --INTO lnKeyFol
	   -- jcro --FROM holocont
	   -- jcro --WHERE con_keytco = pnKeyTco;
	   -- Si es el primero se asigna cero
	   -- jcro --IF lnKeyFol IS NULL THEN
	   -- jcro --   LET lnKeyFol = 0;
	   -- jcro --END IF;
	   -- Se incrementa el folio
	   -- jcro --LET lnKeyFol = lnKeyFol + 1;
         -- jcro -- Busca el numero de folio
         BEGIN
             SELECT to_number(pam_folini)
               INTO lnKeyFol
               FROM USRSIHO.GLCOPAMS
              WHERE pam_cvesec = pnKeyTco
                AND pam_keypar = 'FC';
            EXCEPTION WHEN no_data_found THEN lnKeyFol := 0;
         END;
         -- jcro -- Si no encuentra el numero de folio toma el valor de 0
         -- jcro -- y lo inserta en la tabla de folios
	   IF lnKeyFol IS NULL THEN
	      lnKeyFol := 0;
            INSERT INTO USRSIHO.GLCOPAMS
            VALUES ('FC',pnKeyTco,'','0','');
         ELSE
         -- jcro -- Si lo encuentra le incrementa 1 y lo actualiza en la tabla de folios
            lnKeyFol := lnKeyFol + 1;
            UPDATE USRSIHO.GLCOPAMS
               SET pam_folini = lnKeyFol
             WHERE pam_cvesec = pnKeyTco
               AND pam_keypar = 'FC';
	   END IF;
         -- jcro -- Busca si se encuentra en la tabla el folio obtenido
         SELECT NVL(COUNT(*),0)
           INTO lnFolEnc
           FROM USRSIHO.HOLOCONT
          WHERE con_keytco = pnKeyTco
            AND con_keyfol = lnKeyFol;
         -- jcro -- Si se encuentra el folio, vuelve a intentarlo hasta que encuentre un
         -- jcro -- folio aceptado por la base de datos.
         WHILE NOT lnFolEnc = 0 LOOP  -- Si se encuentra el registro ya grabado
            BEGIN
                SELECT to_number(pam_folini)
                  INTO lnKeyFol
                  FROM USRSIHO.GLCOPAMS
                 WHERE pam_cvesec = pnKeyTco
                   AND pam_keypar = 'FC';
                EXCEPTION WHEN no_data_found THEN lnKeyFol := 0;
            END;
	       IF lnKeyFol IS NULL THEN
	          lnKeyFol := 0;
                INSERT INTO USRSIHO.GLCOPAMS
                VALUES ('FC',pnKeyTco,'','0','');
             ELSE
                lnKeyFol := lnKeyFol + 1;
                UPDATE USRSIHO.GLCOPAMS
                   SET pam_folini = lnKeyFol
                 WHERE pam_cvesec = pnKeyTco
                   AND pam_keypar = 'FC';
	       END IF;
             SELECT NVL(COUNT(*),0)
               INTO lnFolEnc
               FROM USRSIHO.HOLOCONT
              WHERE con_keytco = pnKeyTco
                AND con_keyfol = lnKeyFol;
         END LOOP;
	   -- Se realiza la inserccion
--   insert into glwkcrys  (cry_nomrep,cry_chr001,cry_numsec)
--   values ('clau',psNumEje,5);
--con_keyplz
	   INSERT INTO USRSIHO.holocont( con_keyfol,con_keytco, con_keydep,
	                        con_keypue, con_ctvplz,con_keyemp, con_numcap,
	                        con_fecoto, con_fecini,con_fecven, con_keytab,
	                        con_pertra, con_idioma,con_keynac, con_cosuni,
	                        con_despev, con_keytva,con_keytic, con_diapag,
	                        con_tmpsal, con_araesp,con_stsfir, con_stsplz,
	                        con_stspag, con_fecfir,con_feccan, con_numcdi,
	                        con_recfis, con_descap,con_keyusg, con_preano,
	                        con_contra, con_hrsjor,con_regrfc)
	    VALUES(lnKeyFol,pnKeyTco, psKeyDep,psKeyPue,pnCtvPlz,
	          pnKeyEmp, pnNumCap,pdFecCap,pdFecIni,pdFecVen, pnKeyTab,
	          psPerTra, psIdioma,psKeyNac, pnCosUni,psDesPev, pnKeyTva,
	          psKeyTic, psDiaPag,psTmpSal, psAraEsp,psStsFir, psStsPlz,
	          psStsPag, TO_DATE(pdFecFir,'MM/DD/YYYY'),TO_DATE(pdFecCan,'MM/DD/YYYY'), pnNumCdi,'N',psDesCap,
	          pnKeyUsg, psNumEjeIns,psScoCap,psHrsJor,pspagouni)
	          returning con_keyplz into lnKeyPlz;
	   -- Lee el numero de folio insertado
	   --lnKeyPlz := sp_lee_serial();
	   --SELECT max(con_keyplz)+1 into lnKeyPlz from holocont;
	   -- Libera la tabla
	   -- jcro --UNLOCK TABLE HOLOCONT;
		IF pnKeyTva = 1 THEN
			FOR rec IN (SELECT cry_dec007, cry_dec008
			          FROM USRSIHO.glwkcrys
			         WHERE cry_nomrep = 'CAP_CTO'
			           AND cry_idepcc = psIdePcc
			           AND cry_keyusu = pnKeyUsg
				) LOOP
                 lnIni := rec.cry_dec007;
                 lnFin := rec.cry_dec008;
                 FOR conteo in lnIni .. lnFin LOOP
                        INSERT INTO USRSIHO.holococa
                                   (coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
                            VALUES (lnKeyPlz,conteo,1,'V',null,null);
                END LOOP;
			END LOOP;
		ELSE
			--El tipo de Validacion 3 corresponde a MULTIACTIVIDAD
			IF pnKeyTva = 3 THEN
				FOR rec3 IN (SELECT cry_dec007,cry_dec008
				          FROM USRSIHO.glwkcrys
				         WHERE cry_nomrep='CAP_CTO'
				           AND cry_idepcc=psIdePcc
				           AND cry_keyusu=pnKeyUsg) LOOP
						lnIni := rec3.cry_dec007;
						lnFin := rec3.cry_dec008;
						INSERT INTO USRSIHO.holocoac(coa_keyplz,coa_keypue,coa_cosuni)
						     VALUES (lnKeyPlz,lnIni,lnFin);
				END LOOP;
			END IF;
		END IF;
		IF ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519 THEN
			IF  lsValPres = 'S' THEN
				--Actualizo el presupuesto ejercido antes HOLOPRES ahora hologlpr --cig--
				UPDATE USRSIHO.hologlpr
				   SET glp_ejerci = glp_ejerci + ( pnNumCap * pnCosUni )
				 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
				   AND glp_keypue = psKeyPue
				   AND glp_anio   = lnAnio;
			END IF;
		END IF;
   END IF;
   ------------------------------------------------------------------------
  -- RETURN lnKeyPlz,lnKeyFol,lsSigue;
END;
/
