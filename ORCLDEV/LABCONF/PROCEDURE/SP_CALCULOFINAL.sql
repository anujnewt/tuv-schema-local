CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_CALCULOFINAL" (wn_key_pro IN NUMBER, ws_key_per IN varchar, ws_nom_rep IN varchar, ws_fec_ini IN varchar, ws_hor_ini IN varchar)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
Result NUMBER(10) := 1;
BEGIN
  /*INSERTAR CODIGO DE VALIDACI?*/
  DELETE FROM LABCONF.glwkcrys
  WHERE cry_nomrep = ws_nom_rep
    AND cry_numsec = -1
    AND cry_dec006 = wn_key_pro
    AND cry_chr001 = ws_key_per
    AND cry_chr012 = ws_fec_ini
    AND cry_chr023 = ws_hor_ini;
  INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_dec006,cry_chr001,cry_chr002,cry_chr012,cry_chr023,cry_dec007)
   VALUES (ws_nom_rep,-1,wn_key_pro,ws_key_per,'Calculo final', ws_fec_ini,ws_hor_ini,Result);
END;
/
