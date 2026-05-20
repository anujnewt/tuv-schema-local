CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPCMCAP" (wn_keyfol NUMBER,wn_gdpsec NUMBER,
                                        wn_keytco NUMBER,wn_keyplz NUMBER,
                                        ws_stspag CHAR,wn_capini NUMBER,
                                        wn_capfin NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   wn_iter NUMBER(10);wn_numsec NUMBER(10);wn_keyrph NUMBER(10);
BEGIN
   FOR wn_iter in wn_capini .. wn_capfin loop
      -- Lectura del secuencial
      SELECT MAX(coc_numsec)
      INTO wn_numsec
      FROM usrsiho.holococa,usrsiho.holocont
      WHERE coc_keyplz = con_keyplz
        AND con_keyfol = wn_keyfol
        AND con_keytco = wn_keytco
        AND coc_keycap = wn_iter;
      IF wn_numsec IS NULL THEN
         wn_numsec := 0;
      END IF;
      wn_numsec := wn_numsec + 1;
      BEGIN
          SELECT gdp_keyrph
          INTO wn_keyrph
          FROM usrsiho.hologdpr
          WHERE gdp_keysec = wn_gdpsec;
          EXCEPTION WHEN no_data_found THEN wn_keyrph := 0;
      END;
      -- Inserccion de capitulos
      INSERT INTO usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
      VALUES (wn_keyplz,wn_iter,wn_numsec,ws_stspag,wn_keyrph,wn_gdpsec);
   END LOOP;
END;
/
