CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCTPLZALT1" (pnKeyTco NUMBER,	  psKeyDep VARCHAR2,	psKeyPue VARCHAR2,
            pnCtvPlz NUMBER,	  pnKeyEmp NUMBER,	pnNumCap NUMBER,
            pdFecIni DATE,		  pdFecVen DATE,	pnKeyTab NUMBER,
            psPerTra VARCHAR2,	psIdioma VARCHAR2,	psKeyNac VARCHAR2,
            pnCosUni NUMBER,	  psDesPev VARCHAR2,	pnKeyTva NUMBER,
            psKeyTic VARCHAR2,	psDiaPag VARCHAR2,	psTmpSal VARCHAR2,
            psAraEsp VARCHAR2,	psStsFir VARCHAR2,	psStsPlz VARCHAR2,
            psStsPag VARCHAR2,	pdFecFir DATE,		  pdFecCan DATE,
            pnNumCdi NUMBER,	  psDesCap VARCHAR2,	pnKeyUsg NUMBER,
            psNumEje NUMBER,	  psScoCap VARCHAR2,	psHrsJor VARCHAR2,
            pdFecCap DATE, 		  psIdePcc VARCHAR2,	pnCtvAsig NUMBER,
                                            wn_val_ret_01 OUT NUMBER,
                                            wn_val_ret_02 OUT NUMBER,
                                            wv_val_ret_03 OUT VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	--variables de retorno
	lnKeyPlz 	NUMBER(10);
	lnKeyFol 	NUMBER(10);
	lsSigue 	VARCHAR2(1);
	--variables de trabajo
	lsMarCco 	VARCHAR2(1);
	lsValPres 	VARCHAR2(1);
	lnPresu    	USRSIHO.hologlpr.glp_presup %TYPE;
	lnx       	NUMBER(5);
	lnEjeci  	USRSIHO.hologlpr.glp_ejerci %TYPE;
	lnanioo 	number(5);
	lnmtomax 	NUMBER(10);
	lneje  		NUMBER(10);
	lnexcep 	VARCHAR2 (02);
	lnIni 		NUMBER(10);
	lnFin 		NUMBER(10);
	X 			NUMBER(10);
	Y 			NUMBER(10);
	XY 			NUMBER(10);
	A 			NUMBER(10);
	B  			USRSIHO.holoplza.plz_mtoeje %TYPE;
	AB 			NUMBER(10);
	lnFolEnc	NUMBER(10); --jcro
	err_num		NUMBER(10);
  psNumEje_var  NUMBER(10);
   num_fil number(10);
-- ; CURSOR ;
BEGIN --jcro
	lnFolEnc := 0; --jcro
	err_num := 0; --jcro
	---AEDO 14/03/07
	lsSigue := '';
	lnKeyplz := 0;
	lnKeyfol := 0;
	lnanioo := 0;
	-------------------------cig
	--Checo que exista presupuesto en hologlpr
	--Validaciones 1 y 2 exclusivamente
	IF ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519 THEN
	    --insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',1,psKeyDep);
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
                SELECT plz_mtomax,plz_mtoeje,plz_excep
                  INTO lnmtomax, lneje, lnexcep
                  FROM USRSIHO.holoplza
                 WHERE plz_ctvplz = pnCtvPlz
                   AND plz_asig = pnCtvAsig;
                EXCEPTION WHEN no_data_found THEN lnmtomax := 0;
                                                  lneje := 0;
                                                  lnexcep := 0;
            END;
--         IF lnexcep = 'O' THEN
		   X := lnmtomax;
           Y := lneje;
           XY := lnmtomax;
           A := pnCosUni;
		   IF XY < A THEN
				lsSigue := 'N';
		   ELSE
				lsSigue := 'S';
		   END IF;
           --  insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',3,lnmtomax);
           --INSERT INTO glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',4,lsSigue);
		   IF lsSigue ='S' THEN
		      SELECT count(glp_presup)
		      INTO lnx
		      FROM USRSIHO.hologlpr
		      WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
		      AND glp_keypue = psKeyPue
		      AND glp_status = 'A';
  			  ---insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',50,lnPresu);
			  IF lnx = 0 THEN
				 lsSigue := 'N';
			  ELSE
				 lsSigue := 'S';
			  END IF;
   			 -- insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',6,lnanioo);
			  IF LsSigue = 'S' THEN
                    BEGIN
                         SELECT glp_presup, glp_ejerci, glp_anio
                         INTO lnPresu, lnEjeci, lnanioo
                         FROM USRSIHO.hologlpr
                         WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
                         AND glp_keypue = psKeyPue
                         AND glp_status = 'A';
                         EXCEPTION WHEN no_data_found THEN lnPresu := 0;
                                                           lnEjeci := 0;
                                                           lnanioo := 0;
                    END;
				 IF (lnPresu-lnEjeci) < (pnNumCap*pnCosUni) THEN
					lsSigue := 'N';
				 ELSE
					lsSigue := 'S';
				 END IF;
			  END IF;
		   END IF;
		ELSE
		   lnanioo := psNumEje;
		END IF;
	ELSE
		lnanioo := psNumEje;
	END IF;
	psNumEje_var := lnanioo;
	lnKeyFol := 0;
	lnKeyPlz := 0;
	--Si existe presupuesto prosedo a hacer las operaciones
	IF lsSigue = 'S' THEN
	   -- Calcula el maximo utilizando el bloqueo de tabla --------------------
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
       SELECT NVL(COUNT(*), 0)
         INTO lnFolEnc
         FROM USRSIHO.HOLOCONT
        WHERE con_keytco = pnKeyTco
          AND con_keyfol = lnKeyFol;
       -- jcro -- Si se encuentra el folio, vuelve a intentarlo hasta que encuentre un
       -- jcro -- folio aceptado por la base de datos.
	   WHILE NOT lnFolEnc = 0  LOOP  -- Si se encuentra el registro ya grabado
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
                INSERT INTO USRSIHO.GLCOPAMS VALUES ('FC',pnKeyTco,'','0','');
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
        INSERT INTO USRSIHO.holocont(con_keyplz, con_keyfol,con_keytco, con_keydep,
                              con_keypue, con_ctvplz,con_keyemp, con_numcap,
                              con_fecoto, con_fecini,con_fecven, con_keytab,
                              con_pertra, con_idioma,con_keynac, con_cosuni,
                              con_despev, con_keytva,con_keytic, con_diapag,
                              con_tmpsal, con_araesp,con_stsfir, con_stsplz,
                              con_stspag, con_fecfir,con_feccan, con_numcdi,
                              con_recfis, con_descap,con_keyusg, con_preano,
                              con_contra, con_hrsjor)
        VALUES(0,lnKeyFol,pnKeyTco, psKeyDep,psKeyPue,pnCtvPlz,
                pnKeyEmp, pnNumCap,pdFecCap,pdFecIni,pdFecVen, pnKeyTab,
                psPerTra, psIdioma,psKeyNac, pnCosUni,psDesPev, pnKeyTva,
                psKeyTic, psDiaPag,psTmpSal, psAraEsp,psStsFir, psStsPlz,
                psStsPag, pdFecFir,pdFecCan, pnNumCdi,'N',psDesCap,
                pnKeyUsg, psNumEje_var,psScoCap,psHrsJor)
        returning con_keyplz into lnKeyPlz ;
	END IF;
    -- Lee el numero de plaza insertado
	  --lnKeyPlz := sp_lee_serial();
	  -- Libera la tabla
	  -- jcro --UNLOCK TABLE HOLOCONT;
	--INSERT INTO glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',20,lnKeyPlz);
	-- END IF;
	IF pnKeyTva = 1 THEN
	   IF lsSigue = 'S' THEN
        FOR rec IN (SELECT cry_dec007, cry_dec008
                    FROM USRSIHO.glwkcrys
                    WHERE cry_nomrep = 'CAP_CTO'
                    AND cry_idepcc = psIdePcc
                    AND cry_keyusu = pnKeyUsg)
              -- 	FOR) LOOP
              LOOP
                  lnIni := rec.cry_dec007;
                  lnFin := rec.cry_dec008;
                  -- lnIni = lnIni To lnFin
                 FOR num_fil IN lnIni .. lnFin LOOP
                    INSERT INTO usrsiho.holococa
                               (coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
                        VALUES (lnKeyPlz,num_fil,1,'V',null,null);
                END LOOP;
              END LOOP;
		-- END FOR rec2IN ; LOOP
	   END IF;
	END IF;
	-- CASE WHEN ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519  THEN
	IF ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519  THEN
		-- CASE WHEN lsSigue = 'S' THEN
		IF lsSigue = 'S' THEN
				--Actualizo el presupuesto ejercido en hologlpr
				UPDATE USRSIHO.hologlpr
				   SET glp_ejerci = glp_ejerci + ( pnNumCap * pnCosUni )
				 WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
				   AND glp_keypue = psKeyPue
				   AND glp_anio   = lnanioo;
							B := 0;
				B := pnNumCap * pnCosUni;
				B := lneje + B;
				UPDATE USRSIHO.holoplza
				SET plz_mtoeje = B
				WHERE plz_ctvplz=pnCtvPlz
				AND plz_asig=pnCtvAsig;
				--   insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',15,B);
				--   insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',12,pnCosUni);
				--   insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',13,pnNumCap);
		END IF;
	END IF;
	-- CASE WHEN ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519  THEN
	IF ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519  THEN
		-- CASE WHEN lsSigue = 'S' THEN
		IF lsSigue = 'S' THEN
			update USRSIHO.holoplza set plz_status=2, plz_keyfol=lnKeyFol, plz_keytco=pnKeyTco ,plz_keyemp=pnKeyEmp, plz_keytab=pnKeyTab
			where plz_ctvplz=pnCtvPlz AND plz_asig =pnCtvAsig;
		END IF;
	END IF;
  --  END IF;
   ------------------------------------------------------------------------
   -- cig--RETURN lnKeyPlz,lnKeyFol,lsSigue;
     --  insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',6,lsSigue);
     --      insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',7,lnKeyplz);
   --  insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',8,lnKeyfol);
   -- RETURN 0,0,lsSigue;
   -- wn_val_ret_01 := 0;
   -- wn_val_ret_02 := 0;
   -- wv_val_ret_03 := lsSigue;
   wn_val_ret_01 := lnKeyPlz;
   wn_val_ret_02 := lnKeyFol;
   wv_val_ret_03 := lsSigue;
END;
/
