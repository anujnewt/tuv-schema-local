CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_CALCULOFINAL" (wn_key_pro IN NUMBER, ws_key_per IN varchar,wn_key_nom IN number, ws_nom_rep IN varchar, ws_fec_ini IN varchar, ws_hor_ini IN varchar)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
Result NUMBER(10) := 1;
BEGIN
  DELETE FROM USRSIHO.glwkcrys
  WHERE cry_nomrep = ws_nom_rep
    AND cry_numsec = -1
    AND cry_dec006 = wn_key_pro
    AND cry_chr001 = ws_key_per
    AND cry_chr012 = ws_fec_ini
    AND cry_chr023 = ws_hor_ini;
  INSERT INTO USRSIHO.glwkcrys (cry_nomrep,cry_numsec,cry_dec006,cry_chr001,cry_chr012,cry_chr023,cry_dec007)
   VALUES (ws_nom_rep,-1,wn_key_pro,ws_key_per,ws_fec_ini,ws_hor_ini,Result);
  IF wn_key_pro = 138 AND (wn_key_nom = 103 OR wn_key_nom= 110) THEN
      USRSIHO.SP_CALCULO_IVA_ISR(
        WN_KEY_PRO => WN_KEY_PRO,
        WN_KEY_NOM => WN_KEY_NOM,
        WS_KEY_PER => WS_KEY_PER,
        WS_KEY_CON => 'H18',
        WN_POR_CEN => 5.34,
        WS_CON_BAS => 'PBI',
        WS_COD_IMP => '01'
      );
      USRSIHO.SP_CALCULO_IVA_ISR(
        WN_KEY_PRO => WN_KEY_PRO,
        WN_KEY_NOM => WN_KEY_NOM,
        WS_KEY_PER => WS_KEY_PER,
        WS_KEY_CON => 'H91',
        WN_POR_CEN => 10.66,
        WS_CON_BAS => 'PBI',
        WS_COD_IMP => '01'
      );
      USRSIHO.SP_CALCULO_IVA_ISR(
        WN_KEY_PRO => WN_KEY_PRO,
        WN_KEY_NOM => WN_KEY_NOM,
        WS_KEY_PER => WS_KEY_PER,
        WS_KEY_CON => 'H23',
        WN_POR_CEN => 10.66,
        WS_CON_BAS => 'PBI',
        WS_COD_IMP => '02'
      );
      USRSIHO.SP_CALCULO_IVA_ISR(
        WN_KEY_PRO => WN_KEY_PRO,
        WN_KEY_NOM => WN_KEY_NOM,
        WS_KEY_PER => WS_KEY_PER,
        WS_KEY_CON => 'H24',
        WN_POR_CEN => 10,
        WS_CON_BAS => 'PBI',
        WS_COD_IMP => '02'
      );
  END IF;
    -- ELJM 30.ENE.2023 OUTSOURCING 2023
    IF wn_key_pro = 100 AND wn_key_nom = 113 THEN
            UPDATE USRSIHO.NMWKMOVT
            SET    MOV_KEYEMP = 195711
            WHERE  MOV_KEYPRO = wn_key_pro
            AND    MOV_KEYPER = WS_KEY_PER
            AND    MOV_KEYNOM = wn_key_nom
            AND    MOV_KEYCON IN ('IVA', 'PBI', 'HPN')
            AND    MOV_KEYEMP = 490195711;
    END IF;
END;
/
