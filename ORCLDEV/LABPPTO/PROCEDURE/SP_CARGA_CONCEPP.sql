CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPPTO"."SP_CARGA_CONCEPP" (iTpoMov in SMALLINT, iTpoCue in SMALLINT) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ws_keycon     SMALLINT;
ws_keydes     VARCHAR2(35);
wn_keytpo     SMALLINT;
wn_tipo       SMALLINT;
wi_tipcue     SMALLINT;
CURSOR cursor1 IS
    SELECT DISTINCT cue_keycue,cue_keydes
		FROM    pplocuen;
BEGIN
  --wn_contreg := 0;
  OPEN cursor1;
	LOOP
      FETCH cursor1 INTO
          ws_keycon, ws_keydes;
		EXIT WHEN cursor1%NOTFOUND;
      /* The original statement block */
      INSERT INTO pplocuen
      (cue_keycue, cue_keytpo, cue_keydes, cue_tipcue)
       VALUES (ws_keycon, iTpoMov, ws_keydes, iTpoCue);
		--wn_contreg := wn_contreg + 1;
	END LOOP;
 CLOSE cursor1;
  --total := wn_contreg;
--return wn_contreg;
END;
/
