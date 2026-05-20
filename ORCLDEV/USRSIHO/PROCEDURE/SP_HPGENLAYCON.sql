CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGENLAYCON" (ws_Dgtos IN VARCHAR2,
                             ws_Tpago IN VARCHAR2,ws_Area IN VARCHAR2,
                             wn_Remesa IN INTEGER,ws_fec_ing IN DATE, ws_nomarc out VARCHAR2)
is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- TELEVISA, S.A. DE C.V.
  --
  -- Sistema  : RH-2000
  -- Modulo   : Generaci?e Layout de Remesas (HPGENLAY)
  --
  -- Programa : sp_hpgenlaycon
  --            Obtiene el numero consecutivo de la tabla nmfolrem
  --            y asigna y regresa el nombre del Layout deacuerdo a
  --            la forma de pago.
  --
  -- Autor    : Emilio Pulido Rangel.
  -- Fecha    : 30 de Octubre de 2003.
  --
  wn_con_sec INTEGER;
  ws_con_sec VARCHAR2(2);
  ws_Cadena VARCHAR2(8);
 begin
  -- ----------------------------- BLOQUEO LA TABLA NFOLREM
  -- Obtenemos el numero consecutivo deacuerdo a la Forma de Pago
  wn_con_sec := 0;
    BEGIN
      SELECT lre_consec
        INTO wn_con_sec
        FROM USRSIHO.nmfolrem
       WHERE SUBSTR(lre_nombre,1,2) = ws_Dgtos;
       EXCEPTION WHEN no_data_found THEN wn_con_sec := 0;
    END;
  -- ----------------------------- CHECO QUE EL NUMERO CONSECUTIVO NO ESTE VACIO
  IF wn_con_sec > 0 THEN
     wn_con_sec := wn_con_sec + 1;
     IF wn_con_sec = 99 THEN
        wn_con_sec := 1;
     END IF;
     -- Concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del Archivo
     Ws_con_sec := LPAD(wn_con_sec,2,0);
     ws_Cadena := trim(ws_Dgtos) || trim(ws_Tpago) || LPAD(trim(ws_Area),2,0) || trim(ws_con_sec);
     -- Actualizamos el numero consecutivo y el nombre del archivo en la tabla nmfolrem <-----
     UPDATE USRSIHO.nmfolrem SET lre_consec = wn_con_sec, lre_nombre = ws_Cadena
      WHERE SUBSTR(lre_nombre,1,2) = ws_Dgtos;
  ELSE
     wn_con_sec := 1;
     -- Concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del Archivo
     ws_con_sec := LPAD(wn_con_sec,2,0);
     ws_Cadena := trim(ws_Dgtos) || trim(ws_Tpago) || LPAD(trim(ws_Area),2,0) || trim(ws_con_sec);
     -- Insertamos el registro en la tabla nmfolrem <-----
     INSERT INTO USRSIHO.nmfolrem ( lre_fecha,lre_numrem,lre_consec,lre_nombre )
                    VALUES( ws_fec_ing, wn_Remesa, wn_con_sec, ws_Cadena );
  END IF;
  ws_nomarc := ws_Cadena;
 END;
/
