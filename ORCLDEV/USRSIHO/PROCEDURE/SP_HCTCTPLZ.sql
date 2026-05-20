CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCTPLZ" (wn_key_plz IN NUMBER,
                             wn_key_emp IN NUMBER,
                             wn_key_tco IN NUMBER,
                             ws_key_tic IN  VARCHAR2,
                             ws_dia_pag IN  VARCHAR2,
                             ws_tmp_sal IN  VARCHAR2,
                             ws_des_pev IN  VARCHAR2,
                             ws_ara_esp IN  VARCHAR2,
                             ws_des_cap IN  VARCHAR2,
                             wd_fec_ven IN  DATE,
                             ws_sts_pag IN  VARCHAR2,
                             wd_fec_can IN  DATE,
                             ws_sts_fir IN  VARCHAR2,
                             wd_fec_fir IN  DATE,
                             wn_key_usg IN  NUMBER, wn_key_fol OUT NUMBER  ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
   SELECT NVL(MAX(con_keyfol), 0) + 1
     INTO wn_key_fol
     FROM USRSIHO.holocont
    WHERE con_keytco = wn_key_tco;
   UPDATE USRSIHO.holocont SET
                      con_keyfol = wn_key_fol,con_keyemp = wn_key_emp,con_keytco = wn_key_tco,
                       con_keytic = ws_key_tic,con_diapag = ws_dia_pag,
                       con_tmpsal = ws_tmp_sal,con_despev = ws_des_pev,
                       con_araesp = ws_ara_esp,con_descap = ws_des_cap,
                       con_fecven = wd_fec_ven,con_stspag = ws_sts_pag,
                       con_feccan = wd_fec_can,con_stsfir = ws_sts_fir,
                       con_fecfir = wd_fec_fir,con_keyusg = wn_key_usg,
                       con_stsplz = 2,con_fecoto = TRUNC(SYSDATE)
    WHERE con_keyplz = wn_key_plz;
  -- RETURN wn_key_fol;
END;
/
