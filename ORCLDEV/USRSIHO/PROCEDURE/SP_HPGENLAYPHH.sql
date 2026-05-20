CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGENLAYPHH" (ws_Dgtos in VARCHAR2,
                             ws_Tpago IN VARCHAR2,ws_Area IN VARCHAR2,
                             wn_Remesa IN INTEGER,ws_fec_ing IN DATE,
                             ws_consec IN VARCHAR2,wn_Proceso INTEGER,
                             ws_fec_pag IN DATE,ws_ConPagExt IN VARCHAR2,
                             ws_Remesa IN VARCHAR2, ws_nomarc out VARCHAR2)
is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- TELEVISA, S.A. DE C.V.
  --
  -- Sistema  : RH-2000
  -- Modulo   : Generaci??e Layout de Remesas (HPGENLAY)
  --
  -- Programa : sp_hpgenlayphh
  --            Asigna y regresa el nombre del Layout utilizando la tabla
  --            holocalen, Deacuerdo a la forma de pago: Banamex y Host to Host
  --
  -- Autor    : Emilio Pulido Rangel.
  -- Fecha    : 27 de Noviembre de 2003.
  -- Modifico : Emilio Pulido Rangel
  -- Comentario : 19-01-2005 Emilio - Se agrego la clave 'ST' que corresponde al archivo normal de layout SANTANDER
  --              14-02-2005 Emilio - Se modifico para recibir el numero de remesa en string y poder preguntar por el
  --              primer caracter y definir parte del nombre del archivo es decir si el primer digito del no. de remesa es:
  --              1 entonces sera 'CH' (Chapultepec), si es 2 entonces sera 'SA' (San Angel) y por ultimo
  --              si es 3 sera 'TE' (Televisoras)
  --  cig         SI ES 6 RADIOPOLIS 'RD'
  --              Tambien se modifico para preguntar ahora por ws_Tpago ('16' ??T') para saber si se concatena o no
  --              la otra parte del archivo (cuando es '16' no se concatena)
  -- AEDO         09/Ene/06 Se modifico BF por BA
   wn_con_sec INTEGER;
   ws_con_sec VARCHAR2(3);
   ws_Cadena VARCHAR2(12);
   ws_Archi VARCHAR2(8);
   ws_SA_CH_TE VARCHAR2(2);
  --SELECT pam_nompar[1,4] || 'H' || LPAD(ws_Area,2,0)
  --  INTO ws_Archi
  --  FROM glcopams
  -- WHERE pam_keypar = 'CCIA'
  --   AND pam_cvesec = (SELECT pro_keycia
  --                       FROM nmloproc
  --                      WHERE pro_keypro = wn_Proceso);
BEGIN
  -- Lineas Nuevas 14-02-05 ----------
  if SUBSTR(ws_Remesa,1,1) = '1' THEN   ---> Chapultepec
     ws_SA_CH_TE := 'CH';
  else
     if SUBSTR(ws_Remesa,1,1) = '2' THEN   ---> San Angel
        ws_SA_CH_TE := 'SA';
     else
        if SUBSTR(ws_Remesa,1,1) = '3' THEN   ---> Televisoras
           ws_SA_CH_TE := 'TE';
        else
           if SUBSTR(ws_Remesa,1,1) ='6' THEN ----> Radiopolis
              ws_SA_CH_TE := 'TL';
           else
              if  SUBSTR(ws_Remesa,1,1) ='4' THEN
                 Ws_SA_CH_TE := 'CF';
              else
                 ws_SA_CH_TE := 'XX';
              end if;
           end if;
        end if;
     end if;
  end if;
  if ws_Dgtos = '16' THEN   -- -> Quiere decir que es BANAMEX
     if SUBSTR(ws_Tpago,1,2) = 'PR' THEN   -- -> QUIERE DECIR QUE BIENE DE RECHAZO
        BEGIN
            SELECT SUBSTR(pam_folini,1,3) || SUBSTR(ws_SA_CH_TE,1,1) || 'R' || LPAD(wn_Proceso,3,0)
              INTO ws_Archi
              FROM USRSIHO.glcopams
             WHERE pam_keypar = 'CCIA'
               AND pam_cvesec = (SELECT pro_keycia
                                   FROM USRSIHO.nmloproc
                                  WHERE pro_keypro = wn_Proceso);
            EXCEPTION WHEN no_data_found THEN ws_Archi := '';
        END;
     else
        BEGIN
            SELECT SUBSTR(pam_folini,1,3) || ws_SA_CH_TE || LPAD(wn_Proceso,3,0)
              INTO ws_Archi
              FROM USRSIHO.glcopams
             WHERE pam_keypar = 'CCIA'
               AND pam_cvesec = (SELECT pro_keycia
                                   FROM USRSIHO.nmloproc
                                  WHERE pro_keypro = wn_Proceso);
            EXCEPTION WHEN no_data_found THEN ws_Archi := '';
        END;
    end if;
  else   -- -> Quiere decir que es BANK BOSTON HOST TO HOST o SANTANDER
    BEGIN
         SELECT SUBSTR(pam_nompar,1,4) || 'H' || ws_SA_CH_TE
           INTO ws_Archi
           FROM USRSIHO.glcopams
          WHERE pam_keypar = 'CCIA'
            AND pam_cvesec = (SELECT pro_keycia
                                FROM nmloproc
                               WHERE pro_keypro = wn_Proceso);
         EXCEPTION WHEN no_data_found THEN ws_Archi := '';
    END;
  END if;
  -- ---------------------- TERMINAN LINEAS NUEVAS
  -- Si no encontramos informacion en la glcopams no hacemos nada
  IF TRIM(ws_Archi) = '' THEN
     ws_Cadena := '';
     ws_nomarc := trim(ws_Cadena);
     return;
  END IF;
  -- 10/01/2005 se cambio 'BK' por 'BF' --CIG
  -- antes Si el tipo de pago prevalece en 'PA' o 'BK' Quiere decir que no es archivo de Rechazo
  -- entonces el concecutivo es asignado de la tabla del calendaria HOLOCALEN
  -- 19-01-2005 Emilio - Se agrego la clave 'ST' que corresponde al archivo normal de layout SANTANDER
  -- 09/Ene/06 AEDO  - Se modifico BF por BA
  IF ws_Tpago = 'PA' or ws_Tpago = 'BA' or ws_Tpago = 'ST' THEN
     if ws_Dgtos = '16' THEN   -- -> Quiere decir que es BANAMEX    linea nuevas 14/02/05
        ws_Cadena := trim(ws_Archi);                         --  linea nuevas 14/02/05
     else   -- -> Quiere decir que es HOST TO HOST o SANTANDER      linea nuevas 14/02/05
        IF nvl(ws_ConPagExt,0) = 0  then
           ws_Cadena := trim(ws_Archi) || trim(ws_Tpago) || trim(ws_consec);
        ELSE   -- Fue Pago Extraordinario y concatenamos los 3 caracteres maximos tecleados por el usuario
           ws_Cadena := trim(ws_Archi) || trim(ws_Tpago) || trim(ws_ConPagExt);
        END IF;
     end if;
     -- Actualizamos el status a 'S' para decir que ya fue Impreso
     UPDATE USRSIHO.holocalen
        SET ale_status = 'S'
      WHERE ale_fecpag = ws_fec_pag
        AND ale_forpag = ws_Tpago;
     ws_nomarc := trim(ws_Cadena);
     return;
  END IF;
  -- ----------------------------- BLOQUEO LA TABLA NFOLREM
  -- Obtenemos el numero consecutivo deacuerdo a la Forma de Pago
  wn_con_sec := 0;
    BEGIN
      SELECT lre_consec
        INTO wn_con_sec
        FROM USRSIHO.nmfolrem
       WHERE SUBSTR(lre_nombre,1,2) = ws_Tpago;
        EXCEPTION WHEN no_data_found THEN wn_con_sec := 0;
    END;
  -- ----------------------------- CHECO QUE EL NUMERO CONSECUTIVO NO ESTE VACIO
  IF wn_con_sec > 0 THEN   -- ---> REALIZAMOS UPDATE
     wn_con_sec := wn_con_sec + 1;
     IF wn_con_sec = 999 THEN
       wn_con_sec := 1;
     END IF;
     -- Concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del Archivo
     ws_con_sec := LPAD(wn_con_sec,3,0);
     if ws_Dgtos = '16' THEN   -- -> Quiere decir que es BANAMEX    linea nuevas 14/02/05
        ws_Cadena := trim(ws_Archi);                        --   linea nuevas 14/02/05
     else                      -- -> Quiere decir que es HOST TO HOST o SANTANDER      linea nuevas 14/02/05
        IF nvl(ws_ConPagExt,0) = 0 then
           ws_Cadena := trim(ws_Archi) || trim(ws_Tpago) || trim(ws_con_sec);
        ELSE   -- Fue Pago Extraordinario y concatenamos los 3 caracteres maximos tecleados por el usuario
           ws_Cadena := trim(ws_Archi) || trim(ws_Tpago) || trim(ws_ConPagExt);
           wn_con_sec := wn_con_sec - 1;
        END IF;
     end if;
     -- Actualizamos el numero consecutivo y el nombre del archivo en la tabla nmfolrem <-----
     UPDATE USRSIHO.nmfolrem SET lre_consec =wn_con_sec, lre_nombre = ws_Tpago
      WHERE SUBSTR(lre_nombre,1,2) = ws_Tpago;
  else   -- ---> REALIZAMOS INSERT
     wn_con_sec := 1;
     -- Concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del Archivo
     ws_con_sec := LPAD(wn_con_sec,3,0);
     if ws_Dgtos = '16' THEN   -- -> Quiere decir que es BANAMEX    linea nuevas 14/02/05
        ws_Cadena := trim(ws_Archi);                        --   linea nuevas 14/02/05
     else                      -- -> Quiere decir que es HOST TO HOST o SANTANDER      linea nuevas 14/02/05
        IF nvl(ws_ConPagExt,0) = 0 then
           ws_Cadena := trim(ws_Archi) || trim(ws_Tpago) || trim(ws_con_sec);
        ELSE  -- Fue Pago Extraordinario y concatenamos los 3 caracteres maximos tecleados por el usuario
           ws_Cadena := trim(ws_Archi) || trim(ws_Tpago) || trim(ws_ConPagExt);
        END IF;
     END if;
     -- Insertamos el registro en la tabla nmfolrem <-----
     INSERT INTO USRSIHO.nmfolrem ( lre_fecha,lre_numrem,lre_consec,lre_nombre )
                    VALUES( ws_fec_ing, wn_Remesa, wn_con_sec, ws_Tpago );
  END IF;
  ws_nomarc := trim(ws_Cadena);
  return;
END;
/
