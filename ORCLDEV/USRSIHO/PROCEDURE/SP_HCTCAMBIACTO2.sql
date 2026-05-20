CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAMBIACTO2" (pn_a NUMBER, pnKeytva NUMBER, pnHeader NUMBER,
                 Pnkeyplz NUMBER,psKeyDep varchar2,
                 psKeyPue varchar2,pnEjercicio NUMBER,pnCosUni NUMBER,
                 pnNumCdi NUMBER,pnCosUniAnt NUMBER,pnCtvPlz NUMBER,
 pnmonto NUMBER ,pnfolasig NUMBER,   lsSigue OUT VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ws_totcap  holocont.con_numcap %TYPE;
   ws_totdisp holocont.con_numcdi %TYPE;
   ws_numcap  holocont.con_numcap %TYPE;
   ws_ctvplz   NUMBER(10);
   ws_status  varchar2(1);
   wndife     NUMBER (10,2);
   WS_MTO  number (13,2);
   wnmtoejer  NUMBER (10,2);
   lnPresu    hologlpr.glp_presup %TYPE;
   lnEjeci    hologlpr.glp_ejerci %TYPE;
   lnanioo    number(5);
   PASO       varchar2(60);
   emple   NUMBER(10);
BEGIN
	IF pnHeader = 1 THEN		--Lee los Capitulos Vigentes y los Cancela
             lsSigue := 'N';
             IF pnKeytva = 1 THEN
                  UPDATE holococa SET coc_stspag = 'C'
                  WHERE coc_stspag = 'V'
                  AND coc_keyrph is null
                  AND coc_keyplz = pnKeyPlz;
             END IF;
             insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',1,pnKeyPlz);
             SELECT count(*)
             INTO ws_numcap
             FROM holococa
             WHERE coc_keyplz = pnKeyPlz
             and coc_stspag='C';
            BEGIN
                SELECT con_ctvplz
                INTO ws_ctvplz
                FROM holocont
                WHERE con_keyplz = pnKeyPlz;
                EXCEPTION WHEN no_data_found THEN ws_ctvplz := 0;
            END;
            UPDATE holocont
            SET con_stspag='C', con_numcdi = con_numcap - ws_numcap
            WHERE con_keyplz = pnKeyPlz;
            insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',2,ws_numcap);
            insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values('cla',3,pnfolasig);
            UPDATE holoplza
            SET plz_status = 0
            WHERE plz_ctvplz = ws_ctvplz and plz_asig = pnfolasig;
            BEGIN
               SELECT glp_status
               INTO ws_status
               FROM hologlpr
               WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
               AND glp_keypue = TRIM(psKeyPue)
               AND glp_anio   = pnEjercicio;
               EXCEPTION WHEN no_data_found THEN ws_status := '';
            END;
             IF ws_status = 'A' THEN
                UPDATE hologlpr SET glp_ejerci = glp_ejerci - (pnCosUni * pnNumCdi)
                WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
                AND glp_keypue = TRIM(psKeyPue)
                AND glp_anio   = pnEjercicio
                AND glp_status = 'A';
	         lsSigue := 'S';
	     END IF;
             --UPDATE holoplza
             --SET plz_mtoeje = plz_mtoeje - (pnCosUni * pnNumCdi)
             --WHERE plz_ctvplz=ws_ctvplz;
        ELSE
          IF pnHeader = 2 then --Lee los Capitulos Cancelados y los deja Vigentes
 	     IF pnKeytva = 1 THEN
 	        UPDATE holococa
 	          SET coc_stspag = 'V'
 	          WHERE coc_stspag = 'C'
 	            AND coc_keyrph is null
 	            AND coc_keyplz = pnKeyPlz;
     	        ws_totcap := 0;
     	       SELECT COUNT(coc_keycap)
               INTO ws_totcap
               FROM holococa
               WHERE coc_stspag = 'V'
               AND coc_keyrph is null
               AND coc_keyplz = pnKeyPlz;
               UPDATE holocont
               SET con_numcdi = ws_totcap,con_stspag='V'
               WHERE con_keyplz = pnKeyPlz;
             ELSE
                  ws_totcap := 0;
                  BEGIN
                     SELECT con_numcap
                     INTO ws_numcap
                     FROM holocont
                     WHERE con_keyplz = pnKeyPlz;
                     EXCEPTION WHEN no_data_found THEN ws_numcap := 0;
                  END;
                 ws_totdisp := ws_numcap - pn_a;
 	      	 UPDATE holocont
                 SET con_stspag='V', con_numcdi = ws_totdisp
                 WHERE con_keyplz = pnKeyPlz;
             END IF;
              SELECT glp_status
              INTO ws_status
              FROM hologlpr
              WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
              AND glp_keypue = TRIM(psKeyPue)
              AND glp_anio   = pnEjercicio;
              IF ws_status = 'A' THEN
                    UPDATE hologlpr SET glp_ejerci = glp_ejerci + (pnCosUni * pnNumCdi)
                    WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
                    AND glp_keypue = TRIM(psKeyPue)
                    AND glp_anio   = pnEjercicio
                    AND glp_status = 'A';
      	      END IF;
          ELSE
              IF pnHeader = 3 then -----------Cambia Costo Unitario
                 IF pnmonto < pnCosUni THEN
                    lsSigue := 'N';
                 ELSE
                    lsSigue := 'S';
                 END IF;
--insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',5,lsSigue);
                 IF lsSigue = 'S' THEN
                    wndife := pnCosUni - pnCosUniAnt;
                    wnmtoejer := pnNumCdi*wndife;
                    BEGIN
                        SELECT glp_presup,glp_ejerci,glp_anio
                        INTO lnPresu, lnEjeci, lnanioo
                        FROM hologlpr
                        WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
                        AND glp_keypue = psKeyPue
                        AND glp_anio   = pnEjercicio;
                        EXCEPTION WHEN no_data_found THEN lnPresu := 0;
                                                          lnEjeci := 0;
                                                          lnanioo := 0;
                    END;
                 END IF;
                 IF lsSigue = 'S' THEN
                    IF (lnPresu - lnEjeci) < wnmtoejer THEN
                       lsSigue := 'N';
                    ELSE
                       lsSigue := 'S';
                    END IF;
                 END IF;
                 IF lsSigue = 'S' THEN
                     UPDATE holocont
                     SET con_cosuni=pnCosUni
                     WHERE con_keyplz = pnKeyPlz;
                     BEGIN
                        SELECT glp_status
                          INTO ws_status
                          FROM hologlpr
                         WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
                           AND glp_keypue = TRIM(psKeyPue)
                           AND glp_anio   = pnEjercicio;
                        EXCEPTION WHEN no_data_found THEN ws_status := '';
                     END;
 		    IF ws_status = 'A' THEN
 		       UPDATE hologlpr SET glp_ejerci = glp_ejerci + wnmtoejer
 		       WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
 		       AND glp_keypue = TRIM(psKeyPue)
 		       AND glp_anio   = pnEjercicio
 		       AND glp_status = 'A';
 		    END IF;
 		 END IF;
              ELSE
                 IF pnHeader = 4 THEN
		   IF pnmonto < pnCosUni THEN
		      lsSigue := 'N';
		   ELSE
		     lsSigue := 'S';
		   END IF;
                 END IF;
                 IF lsSigue = 'S' THEN
                    wndife :=  pnCosUniAnt - pnCosUni;
                    wnmtoejer := pnNumCdi*wndife;
                    SELECT glp_presup,glp_ejerci,glp_anio
                    INTO lnPresu,lnEjeci,lnanioo
                    FROM hologlpr
                    WHERE glp_keydep = SUBSTR(psKeyDep,1,6)
                    AND glp_keypue = psKeyPue
                    AND glp_anio   = pnEjercicio;
                 END IF;
                 IF lsSigue = 'S' THEN
                    lnEjeci := lnEjeci - wnmtoejer;
                    IF (lnPresu - lnEjeci) < wnmtoejer THEN
                       lsSigue := 'N';
                    ELSE
                       lsSigue := 'S';
                    END IF;
                 END IF;
                 IF lsSigue = 'S' THEN
                     UPDATE holocont
    		     SET con_cosuni=pnCosUni
                     WHERE con_keyplz = pnKeyPlz;
                    BEGIN
                        SELECT glp_status
                        INTO ws_status
                        FROM hologlpr
                        WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
                        AND glp_keypue = TRIM(psKeyPue)
                        AND glp_anio   = pnEjercicio;
                        EXCEPTION WHEN no_data_found THEN ws_status := '';
                    END;
                    IF ws_status = 'A' THEN
                       UPDATE hologlpr SET glp_ejerci = glp_ejerci - wnmtoejer
                       WHERE glp_keydep = TRIM(SUBSTR(psKeyDep,1,6))
                       AND glp_keypue = TRIM(psKeyPue)
                       AND glp_anio   = pnEjercicio
                       AND glp_status = 'A';
                    END IF;
                END IF;
              END IF;
          END IF;
        END IF;
--RETURN lsSigue;
END;
/
