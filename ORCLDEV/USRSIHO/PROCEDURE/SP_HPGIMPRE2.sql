CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGIMPRE2" (ws_nomrep IN VARCHAR2,ws_idepcc IN VARCHAR2,wn_keyusu IN NUMBER,wn_keynom IN NUMBER,
                             in_keyapr IN VARCHAR2,wn_numemi IN NUMBER,wn_maxmin IN NUMBER,wn_keypro IN NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  ws_desapr VARCHAR2(40);
  ws_desnom VARCHAR2(40);
  wd_fecpag DATE;
  wn_recibo NUMBER(10);
  wn_import NUMBER(16,2);
  wn_corte  NUMBER(5);
  wn_keyemp NUMBER(10);
  ws_nomemp VARCHAR2(60);
  ws_keyapr VARCHAR(20);
BEGIN
  --LECTURA DE REGISTROS
  FOR rec IN (SELECT pam_cvesec,pam_nompar,nom_destip,rec_keyrec,rec_fecpag,rec_import,emp_keyemp,emp_nomemp
  FROM usrsiho.glcopams,usrsiho.nmlonomi,usrsiho.holoreci,usrsiho.nmcoempl
  WHERE pam_keypar='H2'
  AND rtrim(rec_keyapr)=rtrim(pam_cvesec)
  AND rec_keynom=nom_keynom
  AND rec_keyemp=emp_keyemp
  AND rec_keynom=wn_keynom
  AND rec_numemi=wn_numemi
  AND rec_keypro=wn_keypro) LOOP
    --DEFINICION DEL CORTE
    ws_keyapr := rec.pam_cvesec;
    ws_desapr := rec.pam_nompar;
    ws_desnom := rec.nom_destip;
    wn_recibo := rec.rec_keyrec;
    wd_fecpag := rec.rec_fecpag;
    wn_import := rec.rec_import;
    wn_keyemp := rec.emp_keyemp;
    ws_nomemp := rec.emp_nomemp;
    IF wn_import>wn_maxmin THEN
      wn_corte:=1;
    ELSE
      wn_corte:=2;
    END IF;
    --INSERCCION DE REGISTROS DE PASO
    INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_dec006,cry_chr004,cry_chr018,
    cry_chr003,cry_dat001,cry_dec008,cry_dec007,cry_dec001,cry_dec009,
    cry_dec010,cry_chr001)
    VALUES(ws_nomrep ,ws_idepcc ,wn_keyusu ,wn_keynom ,ws_desnom,ws_keyapr ,
    ws_desapr ,wd_fecpag ,wn_numemi ,wn_recibo ,wn_import ,wn_corte ,
    wn_keyemp ,ws_nomemp);
  END LOOP;
END;
/
