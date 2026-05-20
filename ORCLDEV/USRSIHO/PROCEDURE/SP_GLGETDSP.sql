CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_GLGETDSP" (ws_key_tab in VARCHAR2,
                                        ws_key_cam in VARCHAR2,
                                        ws_key_men in VARCHAR2, wn_val_dsp out number)
is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  ws_dsp_cam VARCHAR2(1);
  -- DEFINE wn_val_dsp SMALLINT;
CURSOR c_despli  IS
    SELECT rec_despli FROM glcoreca
      WHERE rec_keytab = ws_key_tab
        AND rec_keycam = ws_key_cam
        AND rec_keymen = ws_key_men;
BEGIN
   wn_val_dsp := 0;
    FOR rec IN c_despli LOOP
        ws_dsp_cam := rec.rec_despli;
        IF ws_dsp_cam = 'N' THEN
          wn_val_dsp := 1;
        END IF;
        EXIT;
    END LOOP;
--      BEGIN
--         OPEN c_despli;
--         LOOP
--            FETCH c_despli INTO ws_dsp_cam;
--            IF ws_dsp_cam = 'N' THEN
--                wn_val_dsp := 1;
--            END IF;
--         END LOOP;
--         CLOSE c_despli;
--      END;
END;
/
