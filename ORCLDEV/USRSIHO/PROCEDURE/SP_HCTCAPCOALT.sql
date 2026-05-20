CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAPCOALT" (pnKeyTco NUMBER,      psKeyDep VARCHAR2, psKeyPue VARCHAR2,
                                pnCtvPlz NUMBER,     pnKeyEmp NUMBER,  pnNumCap NUMBER,
                                pdFecIni DATE,         pdFecVen DATE,     pnKeyTab NUMBER,
                                psPerTra VARCHAR2,      psIdioma VARCHAR2,  psKeyNac VARCHAR2,
                                pnCosUni NUMBER,psDesPev VARCHAR2, pnKeyTva NUMBER,
                                psKeyTic VARCHAR2,      psDiaPag VARCHAR2, psTmpSal VARCHAR2,
                                psAraEsp VARCHAR2,     psStsFir VARCHAR2,  psStsPlz VARCHAR2,
                                psStsPag VARCHAR2,      pdFecFir DATE,     pdFecCan DATE,
                                pnNumCdi NUMBER,     psDesCap VARCHAR2, pnKeyUsg NUMBER,
                                psNumEje NUMBER,     psScoCap VARCHAR2, psHrsJor VARCHAR2,
                                pdFecCap DATE,         psIdePcc VARCHAR2, pscccont VARCHAR2,
                                pntippag NUMBER,      psPrAnio NUMBER, psobserv VARCHAR2,
                                pscondes VARCHAR2,     psNumLla NUMBER,
--- aedo 12/06/2007 Se agregaron dos parametros mas pscccont VARCHAR2(16),pntippag INTEGER
--- mmq 26/02/2009 Se agrego un parametro mas psPrAnio SMALLINT
--- jcro 05/11/2009 Se agrego un parametro mas psobserv VARCHAR2(80)
--- IG-CONS-0823 Se agrega argumento psNumLla para el almacenamiento del numero de llamados
              lnKeyPlz OUT NUMBER, lnKeyFol OUT NUMBER, lsSigue OUT VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--variables de retorno
--variables de trabajo
   lsMarCco  VARCHAR2(1);
   lsValPres     VARCHAR2(1);
    lnPresu holopres.pre_presup%TYPE;
    lnEjeci holopres.pre_ejerci%TYPE;
    lnAnio holopres.pre_anio%TYPE;
   lnIni     NUMBER(10);
   lnFin     NUMBER(10);
   lnFolEnc	NUMBER(10); --jcro
   err_num		NUMBER(10);
   num_fil number(10);
BEGIN --jcro
   lsSigue := 'S';
   lnFolEnc := 0; --jcro
   err_num := 0; --jcro
    --Checo que exista presupuesto en HOLOPRES
    --Validaciones 1 y 2 exclusivamente
    IF ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 and pnKeyTco <> 519 THEN
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
                SELECT nvl(pre_presup,0),nvl(pre_ejerci,0),pre_anio
                  INTO lnPresu, lnEjeci, lnAnio
                  FROM USRSIHO.holopres
                 WHERE pre_keydep = psKeyDep
                   AND pre_keypue = psKeyPue
                   AND pre_status = 'A';
                EXCEPTION WHEN no_data_found THEN lnPresu := 0;
                                                  lnEjeci := 0;
                                                  lnAnio := 0;
            END;
            IF (lnPresu-lnEjeci) < (pnNumCap*pnCosUni) THEN
               lsSigue := 'N';
            END IF;
        ELSE
           lnAnio:=0;
        END IF;
    ELSE
        lnAnio := 0;
    END IF;
        --Se agrego linea para pasar el aqo MMQ 26-02-09
        --LET lnAnio = psPrAnio;
  --  psNumEje := lnAnio;
   lnKeyFol := 0;
   lnKeyPlz := 0;
    --Si existe presupuesto prosedo a hacer las operaciones
    IF lsSigue = 'S' THEN
       -- Calcula el maximo utilizando el bloqueo de tabla --------------------
-- jcro  SET LOCK MODE TO WAIT;
-- jcro  LOCK TABLE HOLOCONT IN EXCLUSIVE MODE;
--	   SELECT MAX(con_keyfol)
--	   INTO lnKeyFol
--	   FROM holocont
--	   WHERE con_keytco = pnKeyTco;
	   -- Si es el primero se asigna cero
--	   IF lnKeyFol IS NULL THEN
--	      LET lnKeyFol = 0;
--	   END IF;
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
         WHILE lnFolEnc <> 0 -- Si se encuentra el registro ya grabado
         LOOP
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
	   -- Se incrementa el folio
-- jcro   LET lnKeyFol = lnKeyFol + 1;
	   ---AEDO 12/06/2007 se agregaron los campos con_cccont, con_tippag al insert
	   ---                y se asignaron los valores de las variables pscccont, pntippag
	   -- Se realiza la inserccion
	   INSERT INTO USRSIHO.holocont( con_keyfol, con_keytco, con_keydep,
	                        con_keypue, con_ctvplz, con_keyemp, con_numcap,
	                        con_fecoto, con_fecini, con_fecven, con_keytab,
	                        con_pertra, con_idioma, con_keynac, con_cosuni,
	                        con_despev, con_keytva, con_keytic, con_diapag,
	                        con_tmpsal, con_araesp, con_stsfir, con_stsplz,
	                        con_stspag, con_fecfir, con_feccan, con_numcdi,
	                        con_recfis, con_descap, con_keyusg, con_preano,
	                        con_contra, con_hrsjor, con_cccont, con_tippag,
                                con_observ, con_descan)
	   VALUES(      lnKeyFol, pnKeyTco, psKeyDep, psKeyPue, pnCtvPlz,
	          pnKeyEmp, pnNumCap, pdFecCap, pdFecIni, pdFecVen, pnKeyTab,
	          psPerTra, psIdioma, psKeyNac, pnCosUni, psDesPev, pnKeyTva,
	          psKeyTic, psDiaPag, psTmpSal, psAraEsp, psStsFir, psStsPlz,
	          psStsPag, pdFecFir, pdFecCan, pnNumCdi,      'N', psDesCap,
	          pnKeyUsg, lnAnio, psScoCap, psHrsJor, pscccont, pntippag,
                  psobserv, pscondes)
        returning con_keyplz into lnKeyPlz;
-- psNumEje se cambio lnAnio
	   -- Lee el numero de folio insertado
         --lnKeyPlz := sp_lee_serial(); -- jcro
--         SELECT MAX(con_keyplz)
--           INTO   lnKeyPlz
--           FROM   usrsiho.holocont;
	   -- Libera la tabla
-- jcro   UNLOCK TABLE HOLOCONT;
        IF pnKeyTva = 1 THEN
            FOR rec IN (SELECT cry_dec007,cry_dec008
                      FROM usrsiho.glwkcrys
                     WHERE cry_nomrep='CAP_CTO'
                       AND cry_idepcc=psIdePcc
                       AND cry_keyusu=pnKeyUsg
                ) LOOP
                 lnIni := rec.cry_dec007;
                 lnFin := rec.cry_dec008;
                 FOR num_fil IN lnIni .. lnFin LOOP
                    INSERT INTO usrsiho.holococa
                               (coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
                        VALUES (lnKeyPlz,num_fil,1,'V',null,null);
                END LOOP;
            END LOOP;
        ELSE
            --El tipo de Validacion 3 corresponde a MULTIACTIVIDAD
            IF pnKeyTva = 3 THEN
                FOR rec3 IN (SELECT cry_dec007,cry_dec008
                          FROM usrsiho.glwkcrys
                         WHERE cry_nomrep='CAP_CTO'
                           AND cry_idepcc=psIdePcc
                           AND cry_keyusu=pnKeyUsg) LOOP
                        lnIni := rec3.cry_dec007;
                        lnFin := rec3.cry_dec008;
                        INSERT INTO usrsiho.holocoac(coa_keyplz,coa_keypue,coa_cosuni)
                             VALUES (lnKeyPlz,lnIni,lnFin);
                END LOOP;
            --IG-CONS-0823
            --Se agrega para el tipo de validacion 4 (Llamados)
            ELSE
              IF  pnKeyTva = 4 THEN
                FOR num_fil IN 1 ..psNumLla LOOP
                  --Inserta en el detalle de contratos
                  INSERT INTO usrsiho.holococa
                               (coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
                        VALUES (lnKeyPlz,pnNumCap,num_fil,'V',null,null);
                END LOOP;
              END IF;
            --Termina Se agrega para el tipo de validacion 4 (Llamados)
            END IF;
        END IF;
      -- CASE WHEN ( pnKeyTva = 1 OR pnKeyTva = 2 ) AND pnKeyTco <> 2 AND pnKeyTco <> 3 AND pnKeyTco <> 519  THEN
        -- CASE WHEN pnKeyTva IN (1, 2) AND pnKeyTco NOT IN (2, 3, 519)  THEN
        IF (pnKeyTva = 1 OR pnKeyTva = 2)  AND pnKeyTco NOT IN (2, 3, 519) THEN
            -- IF pnKeyTco NOT IN (2, 3, 519)  THEN
                -- CASE WHEN lsValPres = 'S' THEN
                IF lsValPres = 'S' THEN
                    --Actualizo el presupuesto ejercido en HOLOPRES
                    UPDATE usrsiho.holopres
                       SET pre_ejerci = pre_ejerci + ( pnNumCap * pnCosUni )
                     WHERE pre_keydep = psKeyDep
                       AND pre_keypue = psKeyPue
                       AND pre_anio   = lnAnio;
                END IF;
                -- END CASE;
        -- END IF;
        -- END CASE;
        END IF;
    END IF;
   ------------------------------------------------------------------------
  -- RETURN lnKeyPlz,lnKeyFol,lsSigue;
END;
/
