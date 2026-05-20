CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABCONF"."CALCULOISN" AS
  PROCEDURE SP_CALCULOISN(ws_nom_rep IN VARCHAR2);
  FUNCTION IMPORTEISN(ws_key_ent IN VARCHAR2,wn_base IN NUMBER, wn_por_cen IN NUMBER,wn_por_adi IN NUMBER, ws_key_tab IN VARCHAR2,wn_cuo_fij IN NUMBER, wn_tot_emp IN NUMBER) RETURN NUMBER;
  FUNCTION IMPORTEADI(ws_key_ent IN VARCHAR2,wn_base IN NUMBER, wn_por_cen IN NUMBER,wn_por_adi IN NUMBER, ws_key_tab IN VARCHAR2, wn_imp_isn IN NUMBER) RETURN NUMBER;
  FUNCTION PORCENTAJE(ws_key_ent IN VARCHAR2,wn_por_cen IN NUMBER,ws_key_tab IN VARCHAR2,wn_base IN NUMBER) RETURN NUMBER;
  FUNCTION PORCENTAJE_ADICIONAL(ws_key_ent IN VARCHAR2,wn_por_adi IN NUMBER,ws_key_tab IN VARCHAR2,wn_base IN NUMBER, ws_key_cia IN VARCHAR2, wn_anio IN INT) RETURN NUMBER;
  FUNCTION CUOTAFIJA(ws_key_ent IN VARCHAR2,wn_por_adi IN NUMBER,ws_key_tab IN VARCHAR2,wn_base IN NUMBER) RETURN NUMBER;
END CALCULOISN;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABCONF"."CALCULOISN" AS
  PROCEDURE SP_PARAMETROS(ws_nom_rep IN VARCHAR2,ws_key_per OUT VARCHAR2, wn_anio OUT INT, wn_mes OUT INT,wn_key_nom OUT SMALLINT);
  PROCEDURE SP_AVANCE(ws_nom_rep IN VARCHAR2, ws_sta_tus IN VARCHAR2, wn_num_reg IN INT, wn_tot_reg IN INT, ws_men_saj IN VARCHAR2);
  PROCEDURE SP_HISTORICOEMP(ws_nom_rep IN VARCHAR2, ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT);
  PROCEDURE SP_LIMPIARMOV(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2);
  PROCEDURE SP_ACUMULADOS(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_INCIDENCIAS(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_BASES(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_CARGARISN(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_PRORRATEO(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_CAMPECHE(wn_base IN NUMBER,ws_key_tab IN VARCHAR2,wn_por_adi IN NUMBER, wn_por_cen OUT NUMBER,wn_imp_isn OUT NUMBER, wn_imp_adi OUT NUMBER);
  PROCEDURE SP_SINALOA(wn_base IN NUMBER,ws_key_tab IN VARCHAR2,wn_por_adi IN NUMBER, wn_por_cen OUT NUMBER,wn_imp_isn OUT NUMBER, wn_imp_adi OUT NUMBER);
  FUNCTION ISN_CHIHUAHUA(wn_base IN NUMBER,wn_por_cen IN NUMBER, wn_por_adi IN NUMBER, ws_key_tab IN VARCHAR2, wn_tot_emp IN NUMBER) RETURN NUMBER;
  FUNCTION FECHA_MOV(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2) RETURN DATE;
  FUNCTION VALORUMA RETURN NUMBER;
  PROCEDURE SP_EXENTOS(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_01(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_03(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_11(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_08(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_13(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_16(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_17(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_21(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_22(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_25(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_26(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_28(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT);
  PROCEDURE SP_EXENTOS_VALES(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, ws_key_ent IN VARCHAR,wn_tope IN NUMBER, wn_limite IN NUMBER);
  wn_uma NUMBER(18,6);
  PROCEDURE SP_CALCULOISN(ws_nom_rep IN VARCHAR2) AS
    ws_key_per VARCHAR2(7);
    wn_anio INT;
    wn_mes INT;
    wn_key_nom SMALLINT;
    wn_tot_reg INT;
    wn_num_reg INT;
    err_num NUMBER;
    err_msg VARCHAR2(2000);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('ws_nom_rep = '||ws_nom_rep);
    wn_tot_reg := 9;
    SP_AVANCE(ws_nom_rep, 'P', 0, wn_tot_reg,'Iniciando C¿¿lculo ISN');
    SP_PARAMETROS(ws_nom_rep,ws_key_per,wn_anio,wn_mes,wn_key_nom);
    DBMS_OUTPUT.PUT_LINE('ws_key_per = '||ws_key_per);
    DBMS_OUTPUT.PUT_LINE('wn_anio = '||wn_anio);
    DBMS_OUTPUT.PUT_LINE('wn_mes = '||wn_mes);
    DBMS_OUTPUT.PUT_LINE('wn_key_nom = '||wn_key_nom);
    wn_uma := VALORUMA;
    DBMS_OUTPUT.PUT_LINE('wn_uma = '||wn_uma);
    wn_num_reg := 1;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Generando hist¿¿rico de empleados');
    SP_HISTORICOEMP(ws_nom_rep,ws_key_per, wn_anio, wn_mes);
    wn_num_reg := 2;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Limpiando movimientos de n¿¿mina');
    SP_LIMPIARMOV(ws_nom_rep,ws_key_per);
    wn_num_reg := 3;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Generando acumulados');
    SP_ACUMULADOS(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    --Se calculan las bases antes de exentos porque hay conceptos que se proratean en funci¿¿n de la base.
    SP_BASES(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    wn_num_reg := 4;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Cargando Incidencias');
    SP_INCIDENCIAS(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    wn_num_reg := 5;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Calculando Exentos');
    SP_EXENTOS(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    wn_num_reg := 6;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Generando bases de c¿¿lculo');
    SP_BASES(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    wn_num_reg := 7;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Ejecutando el c¿¿lculo de ISN');
    SP_CARGARISN(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    wn_num_reg := 8;
    SP_AVANCE(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Calculando prorrateo');
    SP_PRORRATEO(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_AVANCE(ws_nom_rep, 'T', wn_tot_reg, wn_tot_reg,'C¿¿lculo Terminado');
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        err_num := SQLCODE;
        err_msg := err_num||SUBSTR(SQLERRM, 1, 1500)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        SP_AVANCE(ws_nom_rep, 'E', wn_num_reg, wn_tot_reg,err_msg);
      END;
  END SP_CALCULOISN;
  PROCEDURE SP_PARAMETROS(ws_nom_rep IN VARCHAR2, ws_key_per OUT VARCHAR2, wn_anio OUT INT, wn_mes OUT INT,
                          wn_key_nom OUT SMALLINT) AS
  BEGIN
    SELECT arg_pvalor INTO ws_key_per
    FROM LABCONF.glcoargu
    WHERE arg_idepro = ws_nom_rep
      AND arg_keycam = 'KEY_PER';
    SELECT TO_NUMBER(arg_pvalor) INTO wn_anio
    FROM LABCONF.glcoargu
    WHERE arg_idepro = ws_nom_rep
      AND arg_keycam = 'ANIO';
    SELECT TO_NUMBER(arg_pvalor) INTO wn_mes
    FROM LABCONF.glcoargu
    WHERE arg_idepro = ws_nom_rep
      AND arg_keycam = 'MES';
    SELECT TO_NUMBER(pam_folini) INTO wn_key_nom
    FROM LABCONF.glcopams
    WHERE pam_keypar = (SELECT pam_folini FROM LABCONF.glcopams WHERE pam_keypar = '00' AND pam_cvesec = 'calisn')
      AND pam_cvesec = 'OPCI01';
  END;
  PROCEDURE SP_HISTORICOEMP(ws_nom_rep IN VARCHAR2, ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT) AS
    wd_fec_fin DATE;
  BEGIN
    SELECT per_fecfin INTO wd_fec_fin
    FROM LABCONF.nmloperi
    WHERE per_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND per_keyper = ws_key_per
    AND ROWNUM = 1;
    DELETE FROM LABCONF.NMLOHEMP
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.GLWKRANG WHERE ran_nomrep = ws_nom_rep)
      AND hem_keyper = ws_key_per;
    INSERT INTO LABCONF.NMLOHEMP (hem_keypro,hem_keyper,hem_keyemp,hem_keydep,hem_ca1aux,hem_diades,hem_keypue,hem_keycen,hem_tipemp,hem_keyloc,hem_keyims,hem_fecaum,hem_salmes)
    SELECT DISTINCT hem_keypro, ws_key_per,hem_keyemp,hem_keydep,hem_ca1aux,LABCONF.EDADXFECHA(hem_regrfc,wd_fec_fin),emp_keypue,emp_keycen,emp_tipemp,emp_keyloc,emp_keyims,emp_fecaum,emp_salmes
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloperi ON hem_keypro = per_keypro and hem_keyper = per_keyper
    INNER JOIN LABCONF.nmlohism ON his_keypro = hem_keypro AND his_keyper = hem_keyper AND his_keyemp = hem_keyemp AND his_keycon IN ('311','268','C25','658','627','281','334')  --Este join es para evitar que se inserten registros sin movimientos
    LEFT JOIN LABCONF.nmcoempl ON hem_keyemp = emp_keyemp
    WHERE per_keypro in (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND per_anioa1 = wn_anio
    AND per_nummes = wn_mes
    AND per_keynom IN (1,3,6,14,15,16,20,23,25,26,30,32,38,62,31);
    COMMIT;
  END;
  PROCEDURE SP_LIMPIARMOV(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2) AS
  BEGIN
    DELETE FROM LABCONF.nmwkmovt
    WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per;
    COMMIT;
  END;
  PROCEDURE  SP_ACUMULADOS(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wd_fec_mov DATE;
  BEGIN
    wd_fec_mov := FECHA_MOV(ws_nom_rep, ws_key_per);
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp,  --mov_keyemp
           his_keycon,  --mov_keycon
           wn_key_nom,   --mov_keynom
           hem_keydep,  --mov_keydep
           NULL, --mov_keypue
           0, --mov_cantid
           SUM(his_import),  --mov_import
           wd_fec_mov,   --mov_fecmov
           ws_key_per,   --mov_keyper
           hem_keypro,   --mov_keypro
           'ACU',  --mov_keyfor
           '03',   --mov_codimp
           'NO',   --mov_codacu
           0,      --mov_rowide
           hem_ca1aux,   --mov_ca1aux
           NULL, --mov_ca2aux
           0,  --mov_uniope
           0,  --mov_keyplz
           0,  --mov_tipplz
           0,  --mov_keyben
           0   --mov_comfam
    FROM LABCONF.nmloperi
    INNER JOIN LABCONF.nmlohemp ON hem_keypro = per_keypro AND hem_keyper = per_keyper
    INNER JOIN LABCONF.nmlohism ON hem_keyemp = his_keyemp AND per_keypro = his_keypro AND per_keyper = his_keyper
    WHERE per_anioa1 = TO_CHAR(wn_anio)
      AND per_nummes = wn_mes
      AND per_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND per_keynom IN (1,3,6,14,15,16,20,23,25,26,30,32,38,62,31)
      AND his_keycon IN (SELECT DISTINCT con_keycon FROM LABCONF.IsnConf WHERE con_anio = wn_anio)
      AND his_codacu <> 'NO'
    GROUP BY hem_keyemp,  --mov_keyemp
           his_keycon,  --mov_keycon
           hem_keydep,  --mov_keydep
           hem_keypro,   --mov_keypro
           hem_ca1aux; --mov_ca2aux
    COMMIT;
  END;
  PROCEDURE  SP_INCIDENCIAS(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wd_fec_mov DATE;
  BEGIN
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp,  --mov_keyemp
           inc_keycon,  --mov_keycon
           wn_key_nom,   --mov_keynom
           MIN(hem_keydep) keep(dense_rank first order by hem_ca1aux),  --mov_keydep
           NULL, --mov_keypue
           0, --mov_cantid
           inc_import,  --mov_import
           wd_fec_mov,   --mov_fecmov
           hem_keyper,   --mov_keyper
           hem_keypro,   --mov_keypro
           'INC',  --mov_keyfor
           '03',   --mov_codimp
           'NO',   --mov_codacu
           inc_keyinc,      --mov_rowide
           MIN(hem_ca1aux),   --mov_ca1aux
           NULL, --mov_ca2aux
           0,  --mov_uniope
           0,  --mov_keyplz
           0,  --mov_tipplz
           0,  --mov_keyben
           0   --mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmcoinci ON hem_keyemp = inc_keyemp AND hem_keypro = inc_keypro AND hem_keyper = inc_keyper AND inc_keycon = 'S07'
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND hem_keyper = ws_key_per
      AND hem_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar = 'IEST' AND pam_folini IN ('15','03'))
    GROUP BY hem_keyemp,inc_keycon,inc_import,hem_keyper,hem_keypro,inc_keyinc;
    COMMIT;
  END;
  PROCEDURE SP_BASES(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
  BEGIN
    DELETE FROM LABCONF.nmwkmovt
    WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_keyfor = 'IBAS';
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp mov_keyemp,
           CASE WHEN hem_diades < ent_limeda THEN Cpto.con_keycon ELSE 'S01' END mov_keycon,
           wn_key_nom mov_keynom,
           hem_keydep mov_keydep,
           null mov_keypue,
           0 mov_cantid,
           sum(case when con_tipcon = 1 then mov_import else mov_import * -1 end) mov_import,
           per_fecpag mov_fecmov,
           ws_key_per mov_keyper,
           hem_keypro mov_keypro,
           'IBAS' mov_keyfor,
           '03' mov_codimp,
           'NO' mov_codacu,
           0 mov_rowide,
           hem_ca1aux mov_ca1aux,
           null mov_ca2aux,
           0 mov_uniope,
           0 mov_keyplz,
           0 mov_tipplz,
           0 mov_keyben,
           0 mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloperi ON per_keypro = hem_keypro AND per_keyper = hem_keyper
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp AND hem_keydep = mov_keydep AND hem_ca1aux = mov_ca1aux
    INNER JOIN LABCONF.glcopams IEST ON IEST.pam_keypar = 'IEST' AND IEST.pam_cvesec = hem_ca1aux
    INNER JOIN LABCONF.IsnConf Conf ON con_keyent = IEST.pam_folini AND Conf.con_keycon = mov_keycon AND Conf.con_tipcon IN (1,2) AND Conf.con_anio = wn_anio
    INNER JOIN LABCONF.IsnEntidades ON ent_keyent = IEST.pam_folini AND ent_anio = wn_anio
    LEFT JOIN LABCONF.nmloconc Cpto ON Cpto.con_keyfor = 'IBAS' AND Cpto.con_ca1aux = IEST.pam_folini
    WHERE hem_keypro  IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND hem_keyper = ws_key_per
    GROUP BY hem_keyemp,hem_keypro,per_fecpag,hem_keydep,hem_ca1aux,Cpto.con_keycon,hem_diades,ent_limeda;
    COMMIT;
  END;
  PROCEDURE SP_CARGARISN(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
  BEGIN
    DELETE FROM LABCONF.IsnTotales
    WHERE isn_keycia IN (SELECT pro_keycia
                         FROM LABCONF.glwkrang
                         INNER JOIN LABCONF.nmloproc ON pro_keypro = ran_keypro
                         WHERE ran_nomrep = ws_nom_rep)
      AND isn_anio = wn_anio
      AND isn_mes = wn_mes;
    INSERT INTO LABCONF.IsnTotales (isn_keycia,isn_keyent,isn_anio,isn_mes,isn_keyper,isn_porcen,isn_poradi,isn_keytab,isn_cuofij,isn_base,isn_totreg,isn_totemp,isn_impisn,isn_impadi)
    SELECT pro_keycia isn_keycia,IEST.pam_folini isn_keyent,wn_anio isn_anio,wn_mes isn_mes,hem_keyper isn_keyper,
      ent_porcen isn_porcen,ent_poradi ist_poradi,ent_keytab isn_keytab,0 isn_cuofij,
      SUM(mov_import) ISN_BASE,COUNT(*) ISN_TOTREG,COUNT(DISTINCT hem_keyemp) ISN_TOTEMP,
      0 isn_impisn,0 isn_impadi
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloproc ON hem_keypro = pro_keypro
    INNER JOIN LABCONF.glcopams IEST ON IEST.pam_keypar = 'IEST' AND pam_cvesec = hem_ca1aux
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp AND hem_ca1aux = mov_ca1aux
    INNER JOIN LABCONF.nmloconc  ON mov_keycon = con_keycon AND con_keyfor IN ('IBAS')
    INNER JOIN LABCONF.IsnEntidades ON ent_keyent = IEST.pam_folini AND ent_anio = wn_anio
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND hem_keyper = ws_key_per
      group by pro_keycia,IEST.pam_folini,wn_anio,wn_mes,hem_keyper,ent_porcen,ent_poradi,ent_keytab,0,0
    ORDER BY ISN_KEYCIA,ISN_KEYENT;
    UPDATE IsnTotales
    SET isn_porcen = LABCONF.CALCULOISN.PORCENTAJE(isn_keyent, isn_porcen,isn_keytab,isn_base),
        isn_poradi = LABCONF.CALCULOISN.PORCENTAJE_ADICIONAL(isn_keyent, isn_poradi,isn_keytab,isn_base,isn_keycia, wn_anio),
        isn_cuofij = LABCONF.CALCULOISN.CUOTAFIJA(isn_keyent, isn_porcen,isn_keytab,isn_base)
    WHERE isn_keycia IN (SELECT pro_keycia
                         FROM LABCONF.glwkrang
                         INNER JOIN LABCONF.nmloproc ON pro_keypro = ran_keypro
                         WHERE ran_nomrep = ws_nom_rep)
      AND isn_anio = wn_anio
      AND isn_mes = wn_mes;
    UPDATE IsnTotales
    SET isn_impisn = LABCONF.CALCULOISN.IMPORTEISN(isn_keyent,isn_base, isn_porcen, isn_poradi, isn_keytab,isn_cuofij, isn_totreg)
    WHERE isn_keycia IN (SELECT pro_keycia
                         FROM LABCONF.glwkrang
                         INNER JOIN LABCONF.nmloproc ON pro_keypro = ran_keypro
                         WHERE ran_nomrep = ws_nom_rep)
      AND isn_anio = wn_anio
      AND isn_mes = wn_mes;
    UPDATE IsnTotales
    SET isn_impadi = LABCONF.CALCULOISN.IMPORTEADI(isn_keyent,isn_base, isn_porcen, isn_poradi, isn_keytab, isn_impisn)
    WHERE isn_keycia IN (SELECT pro_keycia
                         FROM LABCONF.glwkrang
                         INNER JOIN LABCONF.nmloproc ON pro_keypro = ran_keypro
                         WHERE ran_nomrep = ws_nom_rep)
      AND isn_anio = wn_anio
      AND isn_mes = wn_mes;
    COMMIT;
  END;
  PROCEDURE SP_PRORRATEO(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
  BEGIN
    INSERT INTO LABCONF.nmwkmovt (MOV_KEYEMP,MOV_KEYCON,MOV_KEYNOM,MOV_KEYDEP,MOV_KEYPUE,MOV_CANTID,MOV_IMPORT,MOV_FECMOV,MOV_KEYPER,MOV_KEYPRO,MOV_KEYFOR,MOV_CODIMP,MOV_CODACU,MOV_ROWIDE,MOV_CA1AUX,MOV_CA2AUX,MOV_UNIOPE,MOV_KEYPLZ,MOV_TIPPLZ,MOV_KEYBEN,MOV_COMFAM)
    SELECT MOV_KEYEMP,CON_ISN.con_keycon MOV_KEYCON,MOV_KEYNOM,MOV_KEYDEP,MOV_KEYPUE,0 MOV_CANTID,
      ROUND(mov_import * isn_impisn / isn_base,2)  MOV_IMPORT,MOV_FECMOV,MOV_KEYPER,MOV_KEYPRO,'ISN',MOV_CODIMP,'ME',MOV_ROWIDE,MOV_CA1AUX,MOV_CA2AUX,MOV_UNIOPE,MOV_KEYPLZ,MOV_TIPPLZ,MOV_KEYBEN,MOV_COMFAM
    FROM LABCONF.nmwkmovt
      INNER JOIN LABCONF.nmloconc CON_BAS ON mov_keycon = CON_BAS.con_keycon AND CON_BAS.con_keyfor = 'IBAS'
      INNER JOIN LABCONF.nmloconc CON_ISN ON CON_ISN.con_keyfor = 'ISN' AND CON_ISN.con_ca1aux = CON_BAS.con_ca1aux
      INNER JOIN LABCONF.nmloproc ON mov_keypro = pro_keypro
      INNER JOIN LABCONF.IsnTotales ON isn_keycia = pro_keycia AND isn_keyent = CON_BAS.con_ca1aux AND isn_keyper = mov_keyper
    WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND isn_base > 0;
    COMMIT;
  END;
  FUNCTION IMPORTEISN(ws_key_ent IN VARCHAR2,wn_base IN NUMBER, wn_por_cen IN NUMBER,wn_por_adi IN NUMBER, ws_key_tab IN VARCHAR2,wn_cuo_fij IN NUMBER, wn_tot_emp IN NUMBER) RETURN NUMBER IS
    wn_imp_isn NUMBER(12,2);
    wn_imp_adi NUMBER(12,2);
    wn_pct_loc NUMBER(12,2);  --Porcentaje para los estados en que el porcentaje depende de la base
  BEGIN
    DBMS_OUTPUT.PUT_LINE('IMPORTEISN ws_key_ent = '||ws_key_ent||' wn_por_cen = '||wn_por_cen||' wn_por_adi = '||wn_por_adi);
    CASE ws_key_ent
      WHEN '04' THEN  --CAMPECHE
        BEGIN
          SP_CAMPECHE(wn_base,ws_key_tab,wn_por_adi, wn_pct_loc,wn_imp_isn, wn_imp_adi );
        END;
      /*WHEN '08' THEN  --CHIHUAHUA
        BEGIN
          wn_imp_isn := ISN_CHIHUAHUA(wn_base,wn_por_cen, wn_por_adi, ws_key_tab, wn_tot_emp);
        END;*/
      WHEN '25' THEN  --SINALOA
        BEGIN
          SP_SINALOA(wn_base,ws_key_tab,wn_por_adi, wn_pct_loc,wn_imp_isn, wn_imp_adi );
        END;
      ELSE
        BEGIN
          wn_imp_isn := wn_base * wn_por_cen / 100;
          wn_imp_adi := LABCONF.CALCULOISN.IMPORTEADI(ws_key_ent,wn_base, wn_por_cen, wn_por_adi, ws_key_tab, wn_imp_isn);
          wn_imp_isn := wn_imp_isn + wn_imp_adi;
        END;
    END CASE;
    RETURN wn_imp_isn;
  END;
  --IMPORTEISN utiliza la funci¿¿n IMPORTEADI
  --No se debe utilizar la funci¿¿n IMPORTEADI en la misma setencia que la funci¿¿n IMPORTEISN.
  FUNCTION IMPORTEADI(ws_key_ent IN VARCHAR2,wn_base IN NUMBER, wn_por_cen IN NUMBER,wn_por_adi IN NUMBER, ws_key_tab IN VARCHAR2, wn_imp_isn IN NUMBER) RETURN NUMBER IS
    wn_imp_adi NUMBER(12,2);
  BEGIN
    wn_imp_adi := wn_base * wn_por_cen / 100;
    wn_imp_adi := wn_imp_adi * wn_por_adi / 100;
    RETURN wn_imp_adi;
  END;
  PROCEDURE SP_AVANCE(ws_nom_rep IN VARCHAR2, ws_sta_tus IN VARCHAR2, wn_num_reg IN INT, wn_tot_reg IN INT, ws_men_saj IN VARCHAR2) AS
  BEGIN
    UPDATE LABCONF.glcoresu SET res_status = ws_sta_tus,res_numreg = wn_num_reg,res_totreg = wn_tot_reg, res_deserr=ws_men_saj
	  WHERE res_idepro = ws_nom_rep;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(ws_men_saj);
  END;
  FUNCTION FECHA_MOV(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2) RETURN DATE IS
    wd_fec_mov DATE;
  BEGIN
    SELECT per_fecfin INTO wd_fec_mov
    FROM LABCONF.nmloperi
    WHERE per_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND per_keyper = ws_key_per
      AND ROWNUM = 1;
    RETURN wd_fec_mov;
  END;
  FUNCTION ISN_CHIHUAHUA(wn_base IN NUMBER,wn_por_cen IN NUMBER, wn_por_adi IN NUMBER, ws_key_tab IN VARCHAR2, wn_tot_emp IN NUMBER) RETURN NUMBER IS
    wn_isn NUMBER(12,2);
    wn_adi NUMBER(12,2);
    wn_por_est NUMBER(12,2);
    wn_estimulo NUMBER(12,2);
  BEGIN
    wn_isn := (wn_base * wn_por_cen / 100);
    wn_adi := (wn_isn * wn_por_adi / 100);
    CASE WHEN wn_tot_emp <= 10 THEN wn_por_est := 0.2;
         WHEN wn_tot_emp > 10 AND wn_tot_emp <= 30 THEN wn_por_est := 0.1;
         WHEN wn_tot_emp > 30 AND wn_tot_emp <= 50 THEN wn_por_est := 0.05;
         ELSE wn_por_est := 0;
    END CASE;
    wn_estimulo := wn_isn * wn_por_est;
    wn_isn := wn_isn + wn_adi - wn_estimulo;
    RETURN wn_isn;
  END;
  FUNCTION PORCENTAJE(ws_key_ent IN VARCHAR2,wn_por_cen IN NUMBER,ws_key_tab IN VARCHAR2,wn_base IN NUMBER) RETURN NUMBER IS
    wn_result NUMBER(8,2);
  BEGIN
    wn_result := wn_por_cen;
    IF ws_key_tab IS NOT NULL THEN
      SELECT tab_elecua INTO wn_result
      FROM LABCONF.nmlotabn
      WHERE tab_keytab = ws_key_tab
      AND tab_eleuno <= wn_base
      AND tab_eledos >= wn_base;
    END IF;
    RETURN wn_result;
  END;
  FUNCTION CUOTAFIJA(ws_key_ent IN VARCHAR2,wn_por_adi IN NUMBER,ws_key_tab IN VARCHAR2,wn_base IN NUMBER) RETURN NUMBER IS
    wn_result NUMBER(8,2);
  BEGIN
    wn_result := 0;
    IF ws_key_tab IS NOT NULL THEN
      SELECT tab_eletre INTO wn_result
      FROM LABCONF.nmlotabn
      WHERE tab_keytab = ws_key_tab
      AND tab_eleuno <= wn_base
      AND tab_eledos >= wn_base;
    END IF;
    RETURN wn_result;
  END;
  FUNCTION PORCENTAJE_ADICIONAL(ws_key_ent IN VARCHAR2,wn_por_adi IN NUMBER,ws_key_tab IN VARCHAR2,wn_base IN NUMBER, ws_key_cia IN VARCHAR2, wn_anio IN INT) RETURN NUMBER IS
    wn_result NUMBER(8,2);
  BEGIN
    CASE
      WHEN ws_key_ent = '12' THEN   --GUERRERO
        SELECT CASE WHEN pam_folini IS NULL THEN ENT_PORADI ELSE NVL(LABCONF.SAFE_TO_NUMBER(pam_folini),0) END INTO wn_result
        FROM LABCONF.ISNENTIDADES
        LEFT JOIN LABCONF.GLCOPAMS ON PAM_KEYPAR = 'IS12' AND PAM_CVESEC = ws_key_cia
        WHERE ent_keyent = '12'
          AND ent_anio = wn_anio;
      WHEN ws_key_tab IS NOT NULL  AND ws_key_ent = '13' THEN  --HIDALGO
        SELECT tab_elecua INTO wn_result
        FROM LABCONF.nmlotabn
        WHERE tab_keytab = ws_key_tab
        AND tab_eleuno <= wn_base
        AND tab_eledos >= wn_base;
      WHEN ws_key_ent = '26' THEN   --SONORA
        SELECT CASE WHEN pam_folini IS NULL THEN ENT_PORADI ELSE NVL(LABCONF.SAFE_TO_NUMBER(pam_folini),0) END INTO wn_result
        FROM LABCONF.ISNENTIDADES
        LEFT JOIN LABCONF.GLCOPAMS ON PAM_KEYPAR = 'IS26' AND PAM_CVESEC = ws_key_cia
        WHERE ent_keyent = '26'
          AND ent_anio = wn_anio;
      WHEN ws_key_ent = '30' THEN   --VERACRUZ
        SELECT CASE WHEN pam_folini IS NULL THEN ENT_PORADI ELSE NVL(LABCONF.SAFE_TO_NUMBER(pam_folini),0) END INTO wn_result
        FROM LABCONF.ISNENTIDADES
        LEFT JOIN LABCONF.GLCOPAMS ON PAM_KEYPAR = 'IS30' AND PAM_CVESEC = ws_key_cia
        WHERE ent_keyent = '30'
          AND ent_anio = wn_anio;
      WHEN ws_key_ent = '32' THEN   --ZACATECAS
        SELECT CASE WHEN pam_folini IS NULL THEN ENT_PORADI ELSE NVL(LABCONF.SAFE_TO_NUMBER(pam_folini),0) END INTO wn_result
        FROM LABCONF.ISNENTIDADES
        LEFT JOIN LABCONF.GLCOPAMS ON PAM_KEYPAR = 'IS32' AND PAM_CVESEC = ws_key_cia
        WHERE ent_keyent = '32'
          AND ent_anio = wn_anio;
      ELSE
        wn_result := wn_por_adi;
    END CASE;
    RETURN wn_result;
  END;
  FUNCTION VALORUMA RETURN NUMBER IS
    wn_valor NUMBER(18,6);
  BEGIN
    SELECT tab_eledos INTO wn_valor
    FROM LABCONF.nmlotabn
    WHERE tab_keytab = '002'
    AND tab_eleuno = 1;
    RETURN wn_valor;
    EXCEPTION WHEN OTHERS THEN
      RETURN 0;
  END;
  PROCEDURE SP_EXENTOS(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
  BEGIN
    SP_EXENTOS_01(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_03(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_08(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_11(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_13(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_16(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_17(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_21(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_22(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_25(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_26(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
    SP_EXENTOS_28(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
  END;
  PROCEDURE SP_EXENTOS_01(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE AGUASCALIENTES
    --EXENTOS PARA MAYORES DE 60   S01
  INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp mov_keyemp,
           'S01' mov_keycon,
           wn_key_nom mov_keynom,
           hem_keydep mov_keydep,
           null mov_keypue,
           0 mov_cantid,
           sum(case when con_tipcon = 1 then mov_import else mov_import * -1 end) * 0.5 mov_import,
           TO_DATE('31/01/2020','DD/MM/YYYY') mov_fecmov,
           ws_key_per mov_keyper,
           hem_keypro mov_keypro,
           'ISNE' mov_keyfor,
           '03' mov_codimp,
           'NO' mov_codacu,
           0 mov_rowide,
           hem_ca1aux mov_ca1aux,
           null mov_ca2aux,
           0 mov_uniope,
           0 mov_keyplz,
           0 mov_tipplz,
           0 mov_keyben,
           0 mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp AND hem_keydep = mov_keydep AND hem_ca1aux = mov_ca1aux
    INNER JOIN LABCONF.glcopams IEST ON IEST.pam_keypar = 'IEST' AND IEST.pam_cvesec = hem_ca1aux
    INNER JOIN LABCONF.IsnConf Conf ON con_keyent = IEST.pam_folini AND Conf.con_keycon = mov_keycon AND Conf.con_tipcon IN (1,2) AND Conf.con_anio = wn_anio
    INNER JOIN LABCONF.IsnEntidades ON ent_keyent = IEST.pam_folini AND ent_anio = wn_anio
    LEFT JOIN LABCONF.nmloconc Cpto ON Cpto.con_keyfor = 'IBAS' AND Cpto.con_ca1aux = IEST.pam_folini
    WHERE hem_keypro  IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND hem_keyper = ws_key_per
      AND hem_diades >= 60
      AND IEST.PAM_FOLINI = '01'
    GROUP BY hem_keyemp,hem_keypro,hem_keydep,hem_ca1aux,Cpto.con_keycon,hem_diades,ent_limeda;
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); EL EXCENDENTE GRAVA
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '01',wn_tope, wn_tope) ;
  END;
  PROCEDURE SP_EXENTOS_03(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE BAJA CALIFORNIA SUR
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); EL EXCENDENTE GRAVA
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '03',wn_tope, wn_tope) ;
  END;
  PROCEDURE SP_EXENTOS_08(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE CHIHUAHUA
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); EL EXCENDENTE GRAVA
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '08',wn_tope, 0) ;
  END;
  PROCEDURE SP_EXENTOS_11(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE GUANAJUATO
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); SI REBASA GRAVA TODO
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '11',wn_tope, wn_tope) ;
  END;
  PROCEDURE SP_EXENTOS_13(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE HIDALGO
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); SI REBASA GRAVA TODO
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '13',wn_tope, 0) ;
  END;
  PROCEDURE SP_EXENTOS_16(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE MICHOACAN
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); SI REBASA GRAVA TODO
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '16',wn_tope, 0) ;
  END;
  PROCEDURE SP_EXENTOS_17(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE MORELOS
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 30% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); SI REBASA GRAVA TODO
    wn_tope := wn_uma * 30 * 0.3;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '17',wn_tope, 0) ;
  END;
  PROCEDURE SP_EXENTOS_21(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE PUEBLA
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); EL EXCENDENTE GRAVA
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '21',wn_tope, wn_tope) ;
  END;
  PROCEDURE SP_EXENTOS_22(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
    wn_tot_emp NUMBER(6,0);
    wn_tot_imp NUMBER(12,2);
    wn_imp_dif NUMBER(12,2);
    wn_tot_bas NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE QUERETARO
    --EXENTOS VALES DE DESPENSA S02
    --HASTA EL 40% DEL UMA ELEVADA AL MES  (86.88*30=2606.40*40%=1042.56)SON EXENTOS (281+284+334); EL EXCENDENTE GRAVA
    wn_tope := wn_uma * 30 * 0.4;
    SP_EXENTOS_VALES(ws_nom_rep,ws_key_per, '22',wn_tope, wn_tope) ;
    --EXENTO DEL ESTADO DE QUERETARO
    --Se reparte entre todos los empleados
    wn_tope := wn_uma * 8 * 30.4;
    SELECT COUNT(*) INTO wn_tot_emp
    FROM LABCONF.nmlohemp
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND hem_keyper = ws_key_per
    AND hem_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '22');
    SELECT SUM(mov_import) INTO wn_tot_bas
    FROM LABCONF.nmwkmovt
    WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND mov_keyper = ws_key_per
    AND mov_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '22')
    AND mov_keycon = 'B22';
    IF wn_tot_bas > 0 then
      INSERT INTO LABCONF.nmwkmovt (MOV_KEYEMP,MOV_KEYCON,MOV_KEYNOM,MOV_KEYDEP,MOV_KEYPUE,MOV_CANTID,MOV_IMPORT,MOV_FECMOV,MOV_KEYPER,MOV_KEYPRO,MOV_KEYFOR,MOV_CODIMP,MOV_CODACU,MOV_ROWIDE,MOV_CA1AUX,MOV_CA2AUX,MOV_UNIOPE,MOV_KEYPLZ,MOV_TIPPLZ,MOV_KEYBEN,MOV_COMFAM)
      SELECT mov_keyemp,'S03',wn_key_nom,mov_keydep,mov_keypue,0,(mov_import / wn_tot_bas) * wn_tope,mov_fecmov,mov_keyper,mov_keypro,'ISE','03','N0',0,mov_ca1aux,'',0,0,0,0,0
      FROM LABCONF.nmwkmovt
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '22')
      AND mov_keycon = 'B22';
      --AL DIVIDIR EL EXENTO ENTRE EL NUMERO DE EMPLEADOS, ES POSIBLE QUE LA SUMATORIA ENTRE LOS REGISTROS DE MOVIMIENTOS
      --Y EL EXENTO CALCULADO TENGA DIFERENCIAS DE CENTAVOS.
      --POR ESA REALIZA UN AJUSTE CON LA DIFERENCIA SUMANDO UN CENTAVO A LOS PRIMEROS EMPLEADOS
      SELECT SUM(mov_import) INTO wn_tot_imp
      FROM LABCONF.nmwkmovt
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_keycon = 'S03';
      wn_imp_dif := wn_tope - wn_tot_imp;
      UPDATE LABCONF.nmwkmovt
      SET mov_import = mov_import + 0.01
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_keycon = 'S03'
      AND ROWNUM <= wn_imp_dif * 100;
    END IF;
    COMMIT;
  END;
  PROCEDURE SP_EXENTOS_25(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE SINALOA
    --EXENTOS AGUINALDO S04
    --30 UMAS (86.88*30=2,606.4)
    --025 AGUINALDO
    --603 PROPROCION DE AGUINALDO FINIQ
    --645 ADEUDO AGUINALDO
    wn_tope := wn_uma * 30;
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp,  --mov_keyemp
           'S04',  --mov_keycon
           per_keynom,   --mov_keynom
           hem_keydep,  --mov_keydep
           NULL, --mov_keypue
           0, --mov_cantid
           CASE WHEN wn_tope > SUM(mov_import) THEN SUM(mov_import) ELSE wn_tope END,  --mov_import
           per_fecfin,   --mov_fecmov
           hem_keyper,   --mov_keyper
           hem_keypro,   --mov_keypro
           'ISNE',  --mov_keyfor
           '03',   --mov_codimp
           'NO',   --mov_codacu
           0,      --mov_rowide
           hem_ca1aux,   --mov_ca1aux
           NULL, --mov_ca2aux
           0,  --mov_uniope
           0,  --mov_keyplz
           0,  --mov_tipplz
           0,  --mov_keyben
           0   --mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloperi ON hem_keypro = per_keypro AND hem_keyper = per_keyper
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp
                               AND mov_keycon IN ('025','603','645')
    INNER JOIN LABCONF.glcopams IEST ON pam_keypar = 'IEST' AND pam_cvesec = hem_ca1aux AND pam_folini = '25'
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND hem_keyper = ws_key_per
    GROUP BY hem_keyemp,'S04',per_keynom,hem_keydep,null,0,wn_tope,per_fecfin,hem_keyper,hem_keypro,'ISNE','03','NO',
    0,hem_ca1aux;
  END;
  PROCEDURE SP_EXENTOS_26(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
    wn_tot_emp NUMBER(6,0);
    wn_tot_imp NUMBER(12,2);
    wn_imp_dif NUMBER(12,2);
    wn_tot_bas NUMBER(12,2);
  BEGIN
    --EXENTO DEL ESTADO DE SONORA
    --Se reparte entre todos los empleados
    wn_tope := wn_uma * 6 * 30.4;
    SELECT COUNT(*) INTO wn_tot_emp
    FROM LABCONF.nmlohemp
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND hem_keyper = ws_key_per
    AND hem_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '26');
    IF wn_tot_emp  >= 1 AND wn_tot_emp <= 5 THEN
      INSERT INTO LABCONF.nmwkmovt (MOV_KEYEMP,MOV_KEYCON,MOV_KEYNOM,MOV_KEYDEP,MOV_KEYPUE,MOV_CANTID,MOV_IMPORT,MOV_FECMOV,MOV_KEYPER,MOV_KEYPRO,MOV_KEYFOR,MOV_CODIMP,MOV_CODACU,MOV_ROWIDE,MOV_CA1AUX,MOV_CA2AUX,MOV_UNIOPE,MOV_KEYPLZ,MOV_TIPPLZ,MOV_KEYBEN,MOV_COMFAM)
        SELECT mov_keyemp,'S08',wn_key_nom,mov_keydep,mov_keypue,0, wn_uma * 30.4,mov_fecmov,mov_keyper,mov_keypro,'ISE','03','N0',0,mov_ca1aux,'',0,0,0,0,0
        FROM LABCONF.nmwkmovt
        WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
        AND mov_keyper = ws_key_per
        AND mov_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '26')
        AND mov_keycon = 'B26';
    END IF;
    IF wn_tot_emp > 5 AND wn_tot_emp <= 20 THEN
      SELECT SUM(mov_import) INTO wn_tot_bas
      FROM LABCONF.nmwkmovt
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '26')
      AND mov_keycon = 'B26';
      INSERT INTO LABCONF.nmwkmovt (MOV_KEYEMP,MOV_KEYCON,MOV_KEYNOM,MOV_KEYDEP,MOV_KEYPUE,MOV_CANTID,MOV_IMPORT,MOV_FECMOV,MOV_KEYPER,MOV_KEYPRO,MOV_KEYFOR,MOV_CODIMP,MOV_CODACU,MOV_ROWIDE,MOV_CA1AUX,MOV_CA2AUX,MOV_UNIOPE,MOV_KEYPLZ,MOV_TIPPLZ,MOV_KEYBEN,MOV_COMFAM)
      SELECT mov_keyemp,'S08',wn_key_nom,mov_keydep,mov_keypue,0,(mov_import / wn_tot_bas) * wn_tope,mov_fecmov,mov_keyper,mov_keypro,'ISE','03','N0',0,mov_ca1aux,'',0,0,0,0,0
      FROM LABCONF.nmwkmovt
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_ca1aux IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar  ='IEST' AND pam_folini = '26')
      AND mov_keycon = 'B26';
      --AL DIVIDIR EL EXENTO ENTRE EL NUMERO DE EMPLEADOS, ES POSIBLE QUE LA SUMATORIA ENTRE LOS REGISTROS DE MOVIMIENTOS
      --Y EL EXENTO CALCULADO TENGA DIFERENCIAS DE CENTAVOS.
      --POR ESA REALIZA UN AJUSTE CON LA DIFERENCIA SUMANDO UN CENTAVO A LOS PRIMEROS EMPLEADOS
      SELECT SUM(mov_import) INTO wn_tot_imp
      FROM LABCONF.nmwkmovt
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_keycon = 'S08';
      wn_imp_dif := wn_tope - wn_tot_imp;
      UPDATE LABCONF.nmwkmovt
      SET mov_import = mov_import + 0.01
      WHERE mov_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
      AND mov_keyper = ws_key_per
      AND mov_keycon = 'S08'
      AND ROWNUM <= wn_imp_dif * 100;
      COMMIT;
    END IF;
  END;
  PROCEDURE SP_EXENTOS_28(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, wn_anio IN INT, wn_mes IN INT, wn_key_nom IN SMALLINT) AS
    wn_tope NUMBER(12,2);
  BEGIN
    --EXENTOS PARA EL ESTADO DE TAMAULIPAS
    --EXENTOS PTU S05
    --15 UMAS (86.88*15=1,303.20)
    --027 REPARTO DE UTILIDADES
    wn_tope := wn_uma * 15;
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp,  --mov_keyemp
           'S05',  --mov_keycon
           per_keynom,   --mov_keynom
           hem_keydep,  --mov_keydep
           NULL, --mov_keypue
           0, --mov_cantid
           CASE WHEN wn_tope > SUM(mov_import) THEN SUM(mov_import) ELSE wn_tope END,  --mov_import
           per_fecfin,   --mov_fecmov
           hem_keyper,   --mov_keyper
           hem_keypro,   --mov_keypro
           'ISNE',  --mov_keyfor
           '03',   --mov_codimp
           'NO',   --mov_codacu
           0,      --mov_rowide
           hem_ca1aux,   --mov_ca1aux
           NULL, --mov_ca2aux
           0,  --mov_uniope
           0,  --mov_keyplz
           0,  --mov_tipplz
           0,  --mov_keyben
           0   --mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloperi ON hem_keypro = per_keypro AND hem_keyper = per_keyper
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp
                               AND mov_keycon IN ('027') AND hem_ca1aux = mov_ca1aux AND hem_keydep = mov_keydep
    INNER JOIN LABCONF.glcopams IEST ON pam_keypar = 'IEST' AND pam_cvesec = hem_ca1aux AND pam_folini = '28'
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND hem_keyper = ws_key_per
    GROUP BY hem_keyemp,'S05',per_keynom,hem_keydep,null,0,wn_tope,per_fecfin,hem_keyper,hem_keypro,'ISNE','03','NO',
    0,hem_ca1aux;
    --EXENTOS INDEMNIZACI¿¿N S06
    --INDEMNIZACIONES Y PRIMAS DE ANTIG¿¿EDAD SON EXENTAS HASTA 90 UMAS POR A¿¿O TRABAJADO (601+602+606+682+685).
    --(UMA*A¿¿OS DE SERVICIOS*90). FRACCI¿¿N DE MAS DE 6 MESES SE CONSIDERA UN A¿¿O, EL EXCEDENTE GRAVA
    --601 INDEMNIZACION
    --602 INDEMNIZACION 20 DIAS
    --606 PRIMA DE ANTIG¿¿EDAD FINIQUITOS
    --682 INDEMNIZACION REESTRUCTURA
    --685 INDEMNIZACION 20 DIAS REESTRUCTURA
    wn_tope := wn_uma * 15;
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp,  --mov_keyemp
           'S06',  --mov_keycon
           per_keynom,   --mov_keynom
           hem_keydep,  --mov_keydep
           NULL, --mov_keypue
           0, --mov_cantid
           LABCONF.EXENTO_INDEMNIZACION(hem_fecaux,hem_fecing,SUM(mov_import),wn_uma),  --mov_import
           per_fecfin,   --mov_fecmov
           hem_keyper,   --mov_keyper
           hem_keypro,   --mov_keypro
           'ISNE',  --mov_keyfor
           '03',   --mov_codimp
           'NO',   --mov_codacu
           0,      --mov_rowide
           hem_ca1aux,   --mov_ca1aux
           NULL, --mov_ca2aux
           0,  --mov_uniope
           0,  --mov_keyplz
           0,  --mov_tipplz
           0,  --mov_keyben
           0   --mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloperi ON hem_keypro = per_keypro AND hem_keyper = per_keyper
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp
                               AND mov_keycon IN ('601','602','606','682','685')
    INNER JOIN LABCONF.glcopams IEST ON pam_keypar = 'IEST' AND pam_cvesec = hem_ca1aux AND pam_folini = '28'
    --INNER JOIN LABCONF.nmcoempl ON hem_keyemp = emp_keyemp
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND hem_keyper = ws_key_per
    GROUP BY hem_keyemp,'S06',per_keynom,hem_keydep,null,0,hem_fecaux,hem_fecing,per_fecfin,hem_keyper,hem_keypro,'ISNE','03','NO',
    0,hem_ca1aux;
  END;
  PROCEDURE SP_EXENTOS_VALES(ws_nom_rep IN VARCHAR2,ws_key_per IN VARCHAR2, ws_key_ent IN VARCHAR,wn_tope IN NUMBER, wn_limite IN NUMBER) AS
  BEGIN
    --CONCEPTO S02 EXENTO DE VALES DE DESPENSA
    INSERT INTO LABCONF.nmwkmovt (mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
    mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
    mov_keyben,mov_comfam)
    SELECT hem_keyemp,  --mov_keyemp
           'S02',  --mov_keycon
           per_keynom,   --mov_keynom
           hem_keydep,  --mov_keydep
           NULL, --mov_keypue
           0, --mov_cantid
           CASE WHEN wn_tope > SUM(mov_import) THEN SUM(mov_import) ELSE wn_limite END,  --mov_import
           per_fecfin,   --mov_fecmov
           hem_keyper,   --mov_keyper
           hem_keypro,   --mov_keypro
           'ISNE',  --mov_keyfor
           '03',   --mov_codimp
           'NO',   --mov_codacu
           0,      --mov_rowide
           hem_ca1aux,   --mov_ca1aux
           NULL, --mov_ca2aux
           0,  --mov_uniope
           0,  --mov_keyplz
           0,  --mov_tipplz
           0,  --mov_keyben
           0   --mov_comfam
    FROM LABCONF.nmlohemp
    INNER JOIN LABCONF.nmloperi ON hem_keypro = per_keypro AND hem_keyper = per_keyper
    INNER JOIN LABCONF.nmwkmovt ON hem_keypro = mov_keypro AND hem_keyper = mov_keyper AND hem_keyemp = mov_keyemp
                               AND mov_keycon IN ('281','284','334')
    INNER JOIN LABCONF.glcopams IEST ON pam_keypar = 'IEST' AND pam_cvesec = hem_ca1aux AND pam_folini = ws_key_ent
    WHERE hem_keypro IN (SELECT ran_keypro FROM LABCONF.glwkrang WHERE ran_nomrep = ws_nom_rep)
    AND hem_keyper = ws_key_per
    GROUP BY hem_keyemp,'S02',per_keynom,hem_keydep,null,0,wn_tope,wn_limite,per_fecfin,hem_keyper,hem_keypro,'ISNE','03','NO',
    0,hem_ca1aux;
    COMMIT;
  END;
  PROCEDURE SP_CAMPECHE(wn_base IN NUMBER,ws_key_tab IN VARCHAR2,wn_por_adi IN NUMBER, wn_por_cen OUT NUMBER,wn_imp_isn OUT NUMBER, wn_imp_adi OUT NUMBER) AS
    wn_isn NUMBER(12,2);
    wn_adi NUMBER(12,2);
    wn_lim_inf NUMBER(18,6);
    wn_cuo_fij NUMBER(18,6);
    wn_por_est NUMBER(12,2);
    wn_estimulo NUMBER(12,2);
  BEGIN
    SELECT tab_eleuno,tab_eletre,tab_elecua INTO wn_lim_inf,wn_cuo_fij,wn_por_cen
      FROM LABCONF.nmlotabn
      WHERE tab_keytab = ws_key_tab
      AND tab_eleuno <= wn_base
      AND tab_eledos >= wn_base;
    wn_isn := ((wn_base - wn_lim_inf) * wn_por_cen / 100);
    wn_isn := wn_isn + wn_cuo_fij;
    wn_imp_adi := wn_isn * wn_por_adi / 100;
    wn_imp_isn := wn_isn + wn_imp_adi;
  END;
  PROCEDURE SP_SINALOA(wn_base IN NUMBER,ws_key_tab IN VARCHAR2,wn_por_adi IN NUMBER, wn_por_cen OUT NUMBER,wn_imp_isn OUT NUMBER, wn_imp_adi OUT NUMBER) AS
    wn_isn NUMBER(12,2);
    wn_adi NUMBER(12,2);
    wn_lim_inf NUMBER(18,6);
    wn_cuo_fij NUMBER(18,6);
    wn_por_est NUMBER(12,2);
    wn_estimulo NUMBER(12,2);
  BEGIN
    SELECT tab_eleuno,tab_eletre,tab_elecua INTO wn_lim_inf,wn_cuo_fij,wn_por_cen
      FROM LABCONF.nmlotabn
      WHERE tab_keytab = ws_key_tab
      AND tab_eleuno <= wn_base
      AND tab_eledos >= wn_base;
    wn_isn := ((wn_base - wn_lim_inf) * wn_por_cen / 100);
    wn_isn := wn_isn + wn_cuo_fij;
    wn_imp_adi := wn_isn * wn_por_adi / 100;
    wn_imp_isn := wn_isn + wn_imp_adi;
  END;
END CALCULOISN;
/;
