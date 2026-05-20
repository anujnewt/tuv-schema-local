CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_BITACORA" (wn_key_usu IN NUMBER, ws_log_usu IN VARCHAR2,
                                         ws_ide_pcc IN VARCHAR2,   ws_tip_mov IN VARCHAR2,
                                         ws_key_001 IN VARCHAR2,   ws_key_002 IN VARCHAR2,
                                         ws_key_003 IN VARCHAR2,   ws_val_001 IN VARCHAR2,
                                         ws_val_002 IN VARCHAR2,   ws_val_003 IN VARCHAR2,
                                         ws_des_men IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    --ws_fec_mov DATE     := sp_glgetfec;
    ws_fec_mov CHAR(10) := TO_CHAR(SYSDATE, 'dd/mm/yyyy');
    ws_hor_mov VARCHAR2(8)  := sp_glgethor;
    ws_ide_bit VARCHAR2(10) := '_BITACORA_';
BEGIN
    DELETE FROM glwkcrys
      WHERE cry_nomrep = ws_ide_bit AND
            cry_idepcc = ws_ide_pcc AND
            cry_keyusu = wn_key_usu;
    INSERT INTO glwkcrys
              (cry_nomrep, cry_idepcc, cry_keyusu, cry_dat001, cry_chr012)
      VALUES  (ws_ide_bit, ws_ide_pcc, wn_key_usu, ws_fec_mov, ws_hor_mov);
    INSERT INTO glcobita
             (bit_keyusu, bit_logusu, bit_idepcc, bit_fecmov, bit_hormov,
              bit_tipmov, bit_key001, bit_key002, bit_key003, bit_val001,
              bit_val002, bit_val003, bit_desmen)
      VALUES (wn_key_usu, ws_log_usu, ws_ide_pcc, ws_fec_mov, ws_hor_mov,
              ws_tip_mov, ws_key_001, ws_key_002, ws_key_003, ws_val_001,
              ws_val_002, ws_val_003, ws_des_men);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        sp_glGenErr ('BITACORA', ws_ide_pcc, wn_key_usu, ws_hor_mov,
                     SQLCODE, 0, SUBSTR (SQLERRM, 1, 60));
END;
/
