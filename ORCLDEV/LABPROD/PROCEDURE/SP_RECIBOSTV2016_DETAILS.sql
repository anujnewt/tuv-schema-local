CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_RECIBOSTV2016_DETAILS" (
    v_KeyBin IN VARCHAR2 DEFAULT 'nmgrec' ,
    --v_Action IN VARCHAR2 DEFAULT 'DETAILS' ,
    v_IdePro IN VARCHAR2 DEFAULT 'RECNOM2100' ,
    v_IdePcc IN VARCHAR2 DEFAULT 'MIYISHOME' ,
    v_KeyUsu IN NUMBER DEFAULT 990001 ,
    v_FecIni IN DATE DEFAULT '22/12/2016' ,
    v_HorIni IN VARCHAR2 DEFAULT '21:00' ,
    CV_EMPDETAILS OUT SYS_REFCURSOR )
AS
-- PGV moved types end

-- PGV moved types end
  /*
  ?         idePro  (Identificador del proceso, sirve para ir a buscar los par?tros y el resultado)
  ?         idePCC (Nombre de la PC)
  ?         ideUsu (Clave de usuario)
  ?         Fecha de Ejecuci?
  ?         Hora de Ejecuci?
  */
  v_ProHon NUMBER(1,0)  := 0;
  v_KeyPro NUMBER(10,0) := NULL;
  v_KeyNom NUMBER(10,0) := NULL;
  v_KeyPer VARCHAR2(7)  := NULL;
BEGIN
  DECLARE
-- PGV moved types start

-- PGV moved types start
    v_nrCheckSum NUMBER(10,0);
    v_KeyPar     VARCHAR2(6);
    v_keyconSAR  VARCHAR(3);
    v_desconSAR  VARCHAR(50);
    v_desconVales280 VARCHAR(50) := 'VALES DE DESPENSA';
    v_desconVales336 VARCHAR(50) := 'VALES DE FOMENTO CULTURAL';
    BEGIN
    ----------
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET nls_sort = ''BINARY''';
    END;
    -------- Leer Argumentos -----------------------
    BEGIN
      --Obtener proceso de la glcoargu
      SELECT arg_pvalor
      INTO v_KeyPro
      FROM labprod.glcoargu
      WHERE arg_keycam = 'KEY_PRO'
      AND arg_idepro   = v_IdePro
      AND arg_idepcc   = v_IdePcc
      AND arg_keyusu   = v_KeyUsu
      AND arg_fecini   = v_FecIni
      AND arg_horini   = v_HorIni;
      DBMS_OUTPUT.PUT_LINE('wn_keypro = ' || UTILS.CONVERT_TO_VARCHAR2(v_KEYPRO,4000));
      --Obtener nomina de la glcoargu
      SELECT arg_pvalor
      INTO v_KeyNom
      FROM labprod.glcoargu
      WHERE arg_keycam = 'KEY_NOM'
      AND arg_idepro   = v_IdePro
      AND arg_idepcc   = v_IdePcc
      AND arg_keyusu   = v_KeyUsu
      AND arg_fecini   = v_FecIni
      AND arg_horini   = v_HorIni;
      DBMS_OUTPUT.PUT_LINE('wn_keynom = ' || UTILS.CONVERT_TO_VARCHAR2(v_KeyNom,4000));
      --Obtener periodo de la glcoargu
      SELECT arg_pvalor
      INTO v_KeyPer
      FROM labprod.glcoargu
      WHERE arg_keycam = 'KEY_PER'
      AND arg_idepro   = v_IdePro
      AND arg_idepcc   = v_IdePcc
      AND arg_keyusu   = v_KeyUsu
      AND arg_fecini   = v_FecIni
      AND arg_horini   = v_HorIni;
      DBMS_OUTPUT.PUT_LINE('wn_keyper = ' || v_KeyPer);
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
     raise_application_error(-20101, 'No se encontraron los parametros');
    END;
    BEGIN
      DELETE
       FROM labprod.PS_TPW_MSGXCONCS
     WHERE msgs_KEYPRO = v_KeyPro
       AND msgs_KEYPER = v_KeyPer;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('NO HACER NADA');
    END;
    ------------------ Leer Opcis -----------------------
    BEGIN
    ------------------ Clave de OPCIS  ------------------
        BEGIN
          SELECT NVL(RTRIM(pam_folini), ' ')
          INTO v_KeyPar
          FROM labprod.glcopams
          WHERE pam_keypar = '00'
          AND pam_cvesec   = v_KeyBin;
        EXCEPTION
         WHEN NO_DATA_FOUND THEN
         v_KeyPar := '0000';
        END;
        -----------------------------------------------------
        -- PROCESOS DE HONORARIOS
        -----------------------------------------------------
        BEGIN
          SELECT
            CASE pam_folini WHEN 'S' THEN 1 ELSE 0 END
          INTO v_ProHon
          FROM labprod.glcopams
          WHERE pam_keypar = v_KeyPar
          AND pam_cvesec = 'OPCI87'
          AND pam_folini = v_KeyPro;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          v_ProHon := 0;
        END;
        -----------------------------------------------------
        -- 1 HIS_DIAS
        -----------------------------------------------------
        BEGIN
            INSERT INTO labprod.PS_TPW_MSGXCONCS
            (SELECT v_KeyPro, v_KeyPer, CON_KEYCON , 1 FROM LABPROD.NMLOCONC WHERE CON_KEYCON IN ( '001' ));
        END;
        -----------------------------------------------------
        -- 2 TOT_ISR
        -----------------------------------------------------
        BEGIN
          INSERT INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, con_keycon , 2
              FROM labprod.glcopams
              JOIN labprod.nmloconc ON ( con_keycon  = pam_folfin )
              WHERE pam_keypar = v_KeyPar
               AND pam_folini = 'ISR'
             -- AND pam_cvesec   = 'OPCIXX'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            INSERT INTO labprod.PS_TPW_MSGXCONCS
              (SELECT v_KeyPro, v_KeyPer, CON_KEYCON , 2 FROM LABPROD.NMLOCONC WHERE CON_KEYCON IN ( '100','151','183','294','47A' )
              );
        END;
        -----------------------------------------------------
        -- 3 TOT_PER
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, con_keycon , 3
              FROM labprod.glcopams
              JOIN labprod.nmloconc ON ( con_keycon  = pam_folfin )
              WHERE pam_keypar = v_KeyPar
               AND pam_folini = 'PERCEPCIONES'
             -- AND pam_cvesec   = 'OPCIXX'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT INTO labprod.PS_TPW_MSGXCONCS
          (SELECT v_KeyPro, v_KeyPer, CON_KEYCON, 3 FROM LABPROD.NMLOCONC  WHERE CON_KEYCON IN ( '260','273','290' ));
        END;
        -----------------------------------------------------
        -- 4 TOT_DED
        -----------------------------------------------------
        INSERT
        INTO labprod.PS_TPW_MSGXCONCS
          (SELECT v_KeyPro, v_KeyPer, CON_KEYCON, 4 FROM labprod.NMLOCONC
            WHERE CON_KEYCON IN ( '261','274','291','264' ));
        -----------------------------------------------------
        -- 5 IMP_NETO
        -----------------------------------------------------
        INSERT
        INTO labprod.PS_TPW_MSGXCONCS
          (SELECT v_KeyPro, v_KeyPer, CON_KEYCON, 5
            FROM labprod.NMLOCONC
            WHERE CON_KEYCON IN ( '262','275','292','265' )
          );
        -----------------------------------------------------
        -- VER QUE OPCI ES PARA Suma Aportaciones CA
        -- 6 APORTACIONES CA
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, con_keycon, 6
              FROM labprod.glcopams
              JOIN labprod.nmloconc
              ON ( con_keycon  = pam_folfin )
              WHERE pam_keypar = v_KeyPar
               AND PAM_NOMPAR = 'Suma Aportaciones CA'
             -- AND pam_cvesec   = 'OPCIXX'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            ( SELECT v_KeyPro, v_KeyPer, CON_KEYCON , 6 FROM labprod.NMLOCONC WHERE CON_KEYCON IN ( 'D63','23D' ));
        END;
        -----------------------------------------------------
        -- VER QUE OPCI ES PARA Suma Ptmos CA
        -- 7 Prestamos CA
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, con_keycon , 7
              FROM labprod.glcopams
              JOIN labprod.nmloconc ON ( con_keycon  = pam_folfin )
              WHERE pam_keypar = v_KeyPar
               AND PAM_NOMPAR = 'Suma Ptmos CA'
              --AND pam_cvesec   = 'OPCIXX'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT v_KeyPro, v_KeyPer, CON_KEYCON , 7
              FROM labprod.NMLOCONC
              WHERE CON_KEYCON IN ( 'D64','D68','21D','22D' )
            );
        END;
        -----------------------------------------------------
        --VER QUE OPCI ES PARA Suma Fundacion CA
        --8 FUNDACION TV,
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, con_keycon, 8
              FROM labprod.glcopams
              JOIN labprod.nmloconc ON ( con_keycon  = pam_folfin )
              WHERE pam_keypar = v_KeyPar
               AND PAM_NOMPAR = 'Suma Fundacion CA'
              --AND pam_cvesec   = 'OPCIXX'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            ( SELECT v_KeyPro, v_KeyPer, CON_KEYCON , 8 FROM labprod.NMLOCONC WHERE CON_KEYCON IN ( '28D' ));
        END;
        -----------------------------------------------------
        -- Auxiliar (423) Cesantia y Vejez Bimestral
        -- 9 SAR
        -----------------------------------------------------
        BEGIN
          SELECT RTRIM(agp_desagp), RTRIM(agp_keycon)
            INTO v_desconSAR, v_keyconSAR
          FROM labprod.tvconagp
         WHERE agp_numagr = 11;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          v_desconSAR := 'APORTACION SAR: ';
          v_keyconSAR := '423';
        END;
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, con_keycon , 9
              FROM labprod.nmloconc
              WHERE con_keycon = v_keyconSAR
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            ( SELECT v_KeyPro, v_KeyPer, CON_KEYCON , 9 FROM labprod.NMLOCONC WHERE CON_KEYCON IN ( '423' ));
        END;
         -----------------------------------------------------
        -- 280 vales de despensa
        -- 10 vales de despensa
        -----------------------------------------------------
        INSERT
        INTO labprod.PS_TPW_MSGXCONCS
          (SELECT v_KeyPro, v_KeyPer, CON_KEYCON, 10 FROM labprod.NMLOCONC
            WHERE CON_KEYCON IN ( '280' ));
        -----------------------------------------------------
        -- 336 vales de fomento cultural
        -- 11 vales de despensa
        -----------------------------------------------------
        INSERT
        INTO labprod.PS_TPW_MSGXCONCS
          (SELECT v_KeyPro, v_KeyPer, CON_KEYCON, 11 FROM labprod.NMLOCONC
            WHERE CON_KEYCON IN ( '336' ));
        -----------------------------------------------------
            -----------------------------------------------------
        --VER QUE OPCI ES PARA Suma Fundacion CA
        --12 DONATIVO PARA RECONSTRUCCION,
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            VALUES (v_KeyPro, v_KeyPer, 'G09', 12);
        END;
        -----------------------------------------------------
        -- REC ACUMULADO DE ISR
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, pam_folfin, 13
              FROM labprod.glcopams
              WHERE pam_keypar = v_KeyPar
               AND PAM_FOLINI = 'ISR-ACUM'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            VALUES (v_KeyPro, v_KeyPer, 'REC', 13);
        END;
        -----------------------------------------------------
        -- RED ACUMULADO DE PERCEPCIONES
        -----------------------------------------------------
        BEGIN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            (SELECT DISTINCT v_KeyPro, v_KeyPer, pam_folfin, 14
              FROM labprod.glcopams
              WHERE pam_keypar = v_KeyPar
               AND PAM_FOLINI = 'PERCEP-ACUM'
            );
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          INSERT
          INTO labprod.PS_TPW_MSGXCONCS
            VALUES (v_KeyPro, v_KeyPer, 'RED', 14);
        END;
    END;
    COMMIT;
    v_nrCheckSum := 0;
    --INSERT INTO tt_v_selEmpls VALUES (2042703);
    IF v_KeyNom = 25 THEN
        --PARA NOMINA DE AGUINALDO
        OPEN CV_EMPDETAILS FOR
            SELECT
            SUBSTR(RTRIM(cia_descia), 1, 37) RazonSocial ,
            RTRIM(cia_dircia) DireccionCia ,
            per_keypro KeyPro ,
            RTRIM(ims_rfcims) RegPatronal ,
            his_keyemp keyemp ,
            RTRIM(REPLACE(emp_nomemp, '/', ' ')) nomemp ,
            SUBSTR(RTRIM(hem_keydep), 1, 6) keydep ,
            RTRIM(hem_regrfc) rfc ,
            RTRIM(hem_recurp) curp ,
            SUBSTR(RTRIM(hem_keycen), 1, 8) keycen ,
            NVL(hem_fecaux, hem_fecing) Ingreso ,---
            per_keyper Periodo ,
            per_fecpag FechaRecibo ,
            (
              CASE emp_tipsal
              WHEN '0' THEN 'FIJO' WHEN '1' THEN 'VARIABLE'
              WHEN '2' THEN 'MIXTO'
              ELSE 'NO DEFINIDO'
              END) TipoSalImss ,
            hem_regims AfiliacionImss ,
            CASE 0 WHEN 0 THEN hem_saldia ELSE NULL END SalaroDiario ,
            CASE 0 WHEN 0 THEN TOTALES.HIS_DIAS ELSE NULL END DiasTrabajados ,
            emp_keyloc Ubicacion1 ,
            emp_keyloc Ubicacion2 ,
            hem_ctaban CuentaDep ,--nmloctas, NO SE TRAE DE NMLOCTAS
            TOTALES.ACUM_ISR IsrAcum ,
            TOTALES.ACUM_PER PercepAcum ,
            TOTALES.TOT_ISR ,
            TOTALES.TOT_PER ,
            TOTALES.TOT_DED ,
            TOTALES.IMP_NETO ,
            TOTALES.APO_CAHO ,
            TOTALES.PREST_CAHO ,
            TOTALES.IMP_FUND_TV,
            TOTALES.DONATIVO_REC,
            per_keycon ,
            RTRIM(cp.con_descon) per_descon ,
            per_cantid ,
            per_import ,
            ded_keycon ,
            RTRIM(cd.con_descon) ded_descon ,
            ded_cantid ,
            ded_import ,
            Adeudo  ,
            v_desconSAR MessageSAR,
            TOTALES.TOT_SAR ImpMsgSAR,
            SEC_ROW,
            TOTALES.VAL_DESP,
            TOTALES.VAL_FOM_CULT ,
           (TOTALES.IMP_NETO + TOTALES.APO_CAHO + TOTALES.PREST_CAHO + TOTALES.IMP_FUND_TV + TOTALES.DONATIVO_REC) TOT_NET_REC,
           CASE TOTALES.VAL_DESP WHEN 0 THEN NULL ELSE v_desconVales280 END MSGVALDESP,
           CASE TOTALES.VAL_FOM_CULT WHEN 0 THEN NULL ELSE v_desconVales336 END  MSGVALFOMCULT,
           (TOTALES.TOT_DED - TOTALES.APO_CAHO - TOTALES.PREST_CAHO - TOTALES.IMP_FUND_TV - TOTALES.DONATIVO_REC) TOT_DED_REC
          FROM
          (
          SELECT his_keyemp, SEC_ROW,
            MAX(per_keycon) per_keycon,
            CASE WHEN MAX(per_keycon) IS NULL THEN NULL ELSE SUM(per_cantid) END per_cantid,
            CASE WHEN MAX(per_keycon) IS NULL THEN NULL ELSE SUM(per_import) END per_import,
            MAX(ded_keycon) ded_keycon,
            CASE WHEN MAX(ded_keycon) IS NULL THEN NULL ELSE SUM(ded_cantid) END ded_cantid,
            CASE WHEN MAX(ded_keycon) IS NULL THEN NULL ELSE SUM(ded_import) END ded_import,
            SUM(Adeudo) Adeudo
          FROM
            (   --ESTA ES LA DIFERENCIA DEL QUERY ENTRE LA N?INA DE AGUINALDO Y LA NOMINA ORDINARIA
                --EN LA NOMINA DE AGUINALDO CADA CONCEPTO VA EN UNA LINEA POR SEPARADO
            SELECT  his_keyemp,
                ROW_NUMBER() OVER ( PARTITION BY his_keyemp ORDER BY his_keyemp, his_codimp, his_keycon ) SEC_ROW,
                CASE his_codimp WHEN 1 THEN his_keycon ELSE NULL END per_keycon ,
                CASE his_codimp WHEN 1 THEN his_cantid ELSE NULL END per_cantid ,
                CASE his_codimp WHEN 1 THEN his_import ELSE NULL END per_import ,
                CASE his_codimp WHEN 2 THEN his_keycon ELSE NULL END ded_keycon ,
                CASE his_codimp WHEN 2 THEN his_cantid ELSE NULL END ded_cantid ,
                CASE his_codimp WHEN 2 THEN his_import ELSE NULL END ded_import,
                Adeudo
              FROM (
                  SELECT his_keyemp,
                    NVL(RTRIM(CON_CA1AUX), HIS_KEYCON) GROUP_CONC,
                    CASE WHEN MIN(HIS_KEYCON) = '026' THEN '000' ELSE MIN(HIS_KEYCON) END HIS_KEYCON,
                    UTILS.CONVERT_TO_NUMBER(HIS_CODIMP,1,0) HIS_CODIMP,
                    SUM(HIS_CANTID) HIS_CANTID,
                    SUM(HIS_IMPORT) HIS_IMPORT,
                    COUNT(*) HIS_COUNT,
                    SUM(NVL(PRE_IMPSAL, 0)) Adeudo
                  FROM labprod.nmloperi
                  JOIN labprod.nmlohism ON ( his_keypro = per_keypro AND his_keyper  = per_keyper )
                  JOIN labprod.nmloconc ON ( con_keycon = his_keycon )
                  LEFT OUTER JOIN labprod.nmlopres ON (PRE_KEYEMP = HIS_KEYEMP AND PRE_KEYCON = HIS_KEYCON AND PRE_KEYPRE = HIS_ROWIDE)
                  WHERE his_codimp IN ( '01', '02' )
                    AND con_nu1aux = (CASE per_keynom when 1 then '1' else con_nu1aux END ) -- Tipo de recibo 1 paranomina ordinaria
                  AND per_keypro     = v_KeyPro
                  AND per_keyper     = v_KeyPer
                  AND ( v_nrCheckSum = 0 OR ( his_keyemp IN (SELECT KEYEMP FROM labprod.tt_v_selEmpls) ) )
                  --AND HIS_keyemp = 2028171  -- 2043702
                  GROUP BY HIS_KEYEMP, NVL(RTRIM(CON_CA1AUX), HIS_KEYCON), HIS_CODIMP
               ) HISM
             )hism_grps
          GROUP BY his_keyemp, SEC_ROW --, per_keycon, ded_keycon
          ) CONCS
           JOIN labprod.nmloperi ON ( per_keypro = v_KeyPro AND per_keyper = v_KeyPer )
           JOIN labprod.nmcoempl ON ( emp_keyemp = his_keyemp )
           JOIN labprod.nmlohemp ON ( hem_keypro = per_keypro AND hem_keyper = per_keyper AND hem_keyemp = his_keyemp )
           JOIN labprod.nmloproc ON ( pro_keypro = per_keypro )
           JOIN labprod.nmlocias ON ( cia_keycia = pro_keycia )
           JOIN labprod.nmloimss ON ( ims_keyims = hem_keyims )
           LEFT JOIN labprod.nmloconc CP ON ( CP.con_keycon = CONCS.per_keycon )
           LEFT JOIN labprod.nmloconc CD ON ( CD.con_keycon = CONCS.ded_keycon )
           JOIN
              (SELECT hem_keyemp KEYEMP ,
                HISM_PER.ACUM_ISR ,
                HISM_PER.ACUM_PER ,
                HISM_PER.HIS_DIAS ,
                HISM_PER.TOT_ISR ,
                HISM_PER.TOT_PER ,
                HISM_PER.TOT_DED ,
                HISM_PER.IMP_NETO ,
                HISM_PER.APO_CAHO ,
                HISM_PER.PREST_CAHO ,
                HISM_PER.IMP_FUND_TV,
                HISM_PER.TOT_SAR,
                HISM_PER.VAL_DESP,
                HISM_PER.VAL_FOM_CULT,
                HISM_PER.DONATIVO_REC
              FROM labprod.nmloperi PER_TOTS
              JOIN labprod.nmlohemp HEM_TOTS ON ( HEM_TOTS.hem_keypro = PER_TOTS.per_keypro AND HEM_TOTS.hem_keyper  = PER_TOTS.per_keyper )
              LEFT JOIN
                (SELECT his_keyemp ,
                  SUM( CASE msgs_tipocon WHEN 1 THEN his_cantid ELSE 0 END) HIS_DIAS ,
                  SUM( CASE msgs_tipocon WHEN 2 THEN his_import ELSE 0 END) TOT_ISR ,
                  SUM( CASE msgs_tipocon WHEN 3 THEN his_import ELSE 0 END) TOT_PER ,
                  SUM( CASE msgs_tipocon WHEN 4 THEN his_import ELSE 0 END) TOT_DED ,
                  SUM( CASE msgs_tipocon WHEN 5 THEN his_import ELSE 0 END) IMP_NETO ,
                  SUM( CASE msgs_tipocon WHEN 6 THEN his_import ELSE 0 END) APO_CAHO ,
                  SUM( CASE msgs_tipocon WHEN 7 THEN his_import ELSE 0 END) PREST_CAHO ,
                  SUM( CASE msgs_tipocon WHEN 8 THEN his_import ELSE 0 END) IMP_FUND_TV,
                  SUM( CASE msgs_tipocon WHEN 9 THEN his_import ELSE 0 END) TOT_SAR,
                  SUM( CASE msgs_tipocon WHEN 10 THEN his_import ELSE 0 END) VAL_DESP,
                  SUM( CASE msgs_tipocon WHEN 11 THEN his_import ELSE 0 END) VAL_FOM_CULT,
                  SUM( CASE msgs_tipocon WHEN 12 THEN his_import ELSE 0 END) DONATIVO_REC,
                  SUM( CASE msgs_tipocon WHEN 13 THEN his_import ELSE 0 END) ACUM_ISR,
                  SUM( CASE msgs_tipocon WHEN 14 THEN his_import ELSE 0 END) ACUM_PER
                FROM labprod.nmlohism
                JOIN labprod.PS_TPW_MSGXCONCS ON (MSGS_KEYPRO = his_KEYPRO AND MSGS_KEYPER = his_KEYPER AND his_keycon    = msgs_keycon )
                WHERE his_keypro   = v_KeyPro
                AND his_keyper     = v_KeyPer
                AND ( v_nrCheckSum = 0 OR his_keyemp IN (SELECT KEYEMP FROM labprod.tt_v_selEmpls) )
                GROUP BY his_keyemp
                ) HISM_PER ON ( HISM_PER.his_keyemp = HEM_TOTS.hem_keyemp )
            WHERE ( per_keypro                    = v_KeyPro
            AND per_keyper                        = v_KeyPer )
            --AND ( v_nrCheckSum = 0 OR acu_keyemp IN (SELECT KEYEMP FROM tt_v_selEmpls) )
            ) TOTALES ON TOTALES.KEYEMP = his_keyemp
          ORDER BY his_keyemp,SEC_ROW;
    ELSE
        OPEN CV_EMPDETAILS FOR
            SELECT
            SUBSTR(RTRIM(cia_descia), 1, 37) RazonSocial ,
            RTRIM(cia_dircia) DireccionCia ,
            per_keypro KeyPro ,
            RTRIM(ims_rfcims) RegPatronal ,
            his_keyemp keyemp ,
            RTRIM(REPLACE(emp_nomemp, '/', ' ')) nomemp ,
            SUBSTR(RTRIM(hem_keydep), 1, 6) keydep ,
            RTRIM(hem_regrfc) rfc ,
            RTRIM(hem_recurp) curp ,
            SUBSTR(RTRIM(hem_keycen), 1, 8) keycen ,
            NVL(hem_fecaux, hem_fecing) Ingreso ,---
            per_keyper Periodo ,
            per_fecpag FechaRecibo ,
            (
              CASE emp_tipsal
              WHEN '0' THEN 'FIJO' WHEN '1' THEN 'VARIABLE'
              WHEN '2' THEN 'MIXTO'
              ELSE 'NO DEFINIDO'
              END) TipoSalImss ,
            hem_regims AfiliacionImss ,
            CASE 0 WHEN 0 THEN hem_saldia ELSE NULL END SalaroDiario ,
            CASE 0 WHEN 0 THEN TOTALES.HIS_DIAS ELSE NULL END DiasTrabajados ,
            emp_keyloc Ubicacion1 ,
            emp_keyloc Ubicacion2 ,
            hem_ctaban CuentaDep ,--nmloctas, NO SE TRAE DE NMLOCTAS
            TOTALES.ACUM_ISR IsrAcum ,
            TOTALES.ACUM_PER PercepAcum ,
            TOTALES.TOT_ISR ,
            TOTALES.TOT_PER ,
            TOTALES.TOT_DED ,
            TOTALES.IMP_NETO ,
            TOTALES.APO_CAHO ,
            TOTALES.PREST_CAHO ,
            TOTALES.IMP_FUND_TV,
            TOTALES.DONATIVO_REC,
            per_keycon ,
            RTRIM(cp.con_descon) per_descon ,
            per_cantid ,
            per_import ,
            ded_keycon ,
            RTRIM(cd.con_descon) ded_descon ,
            ded_cantid ,
            ded_import ,
            Adeudo  ,
            v_desconSAR MessageSAR,
            TOTALES.TOT_SAR ImpMsgSAR,
            SEC_ROW,
            TOTALES.VAL_DESP,
            TOTALES.VAL_FOM_CULT ,
           (TOTALES.IMP_NETO + TOTALES.APO_CAHO + TOTALES.PREST_CAHO + TOTALES.IMP_FUND_TV + TOTALES.DONATIVO_REC) TOT_NET_REC,
           CASE TOTALES.VAL_DESP WHEN 0 THEN NULL ELSE v_desconVales280 END MSGVALDESP,
           CASE TOTALES.VAL_FOM_CULT WHEN 0 THEN NULL ELSE v_desconVales336 END  MSGVALFOMCULT,
           (TOTALES.TOT_DED - TOTALES.APO_CAHO - TOTALES.PREST_CAHO - TOTALES.IMP_FUND_TV - TOTALES.DONATIVO_REC) TOT_DED_REC
          FROM
          (
          SELECT his_keyemp, SEC_ROW,
            MAX(per_keycon) per_keycon,
            CASE WHEN MAX(per_keycon) IS NULL THEN NULL ELSE SUM(per_cantid) END per_cantid,
            CASE WHEN MAX(per_keycon) IS NULL THEN NULL ELSE SUM(per_import) END per_import,
            MAX(ded_keycon) ded_keycon,
            CASE WHEN MAX(ded_keycon) IS NULL THEN NULL ELSE SUM(ded_cantid) END ded_cantid,
            CASE WHEN MAX(ded_keycon) IS NULL THEN NULL ELSE SUM(ded_import) END ded_import,
            SUM(Adeudo) Adeudo
          FROM
            (
            SELECT  his_keyemp,
                ROW_NUMBER() OVER ( PARTITION BY his_keyemp, his_codimp ORDER BY his_keyemp, his_codimp, his_keycon ) SEC_ROW,
                CASE his_codimp WHEN 1 THEN his_keycon ELSE NULL END per_keycon ,
                CASE his_codimp WHEN 1 THEN his_cantid ELSE NULL END per_cantid ,
                CASE his_codimp WHEN 1 THEN his_import ELSE NULL END per_import ,
                CASE his_codimp WHEN 2 THEN his_keycon ELSE NULL END ded_keycon ,
                CASE his_codimp WHEN 2 THEN his_cantid ELSE NULL END ded_cantid ,
                CASE his_codimp WHEN 2 THEN his_import ELSE NULL END ded_import,
                Adeudo
              FROM (
                  SELECT his_keyemp,
                    NVL(RTRIM(CON_CA1AUX), HIS_KEYCON) GROUP_CONC,
                    MIN(HIS_KEYCON) HIS_KEYCON,
                    UTILS.CONVERT_TO_NUMBER(HIS_CODIMP,1,0) HIS_CODIMP,
                    SUM(HIS_CANTID) HIS_CANTID,
                    SUM(HIS_IMPORT) HIS_IMPORT,
                    COUNT(*) HIS_COUNT,
                    SUM(NVL(PRE_IMPSAL, 0)) Adeudo
                  FROM labprod.nmloperi
                  JOIN labprod.nmlohism ON ( his_keypro = per_keypro AND his_keyper  = per_keyper )
                  JOIN labprod.nmloconc ON ( con_keycon = his_keycon )
                  LEFT OUTER JOIN labprod.nmlopres ON (PRE_KEYEMP = HIS_KEYEMP AND PRE_KEYCON = HIS_KEYCON AND PRE_KEYPRE = HIS_ROWIDE)
                  WHERE his_codimp IN ( '01', '02' )
                    AND con_nu1aux = (CASE per_keynom when 1 then '1' else con_nu1aux END ) -- Tipo de recibo 1 paranomina ordinaria
                  AND per_keypro     = v_KeyPro
                  AND per_keyper     = v_KeyPer
                  AND ( v_nrCheckSum = 0 OR ( his_keyemp IN (SELECT KEYEMP FROM labprod.tt_v_selEmpls) ) )
                  --AND HIS_keyemp = 2028171  -- 2043702
                  GROUP BY HIS_KEYEMP, NVL(RTRIM(CON_CA1AUX), HIS_KEYCON), HIS_CODIMP
               ) HISM
             )hism_grps
          GROUP BY his_keyemp, SEC_ROW --, per_keycon, ded_keycon
          ) CONCS
           JOIN labprod.nmloperi ON ( per_keypro = v_KeyPro AND per_keyper = v_KeyPer )
           JOIN labprod.nmcoempl ON ( emp_keyemp = his_keyemp )
           JOIN labprod.nmlohemp ON ( hem_keypro = per_keypro AND hem_keyper = per_keyper AND hem_keyemp = his_keyemp )
           JOIN labprod.nmloproc ON ( pro_keypro = per_keypro )
           JOIN labprod.nmlocias ON ( cia_keycia = pro_keycia )
           JOIN labprod.nmloimss ON ( ims_keyims = hem_keyims )
           LEFT JOIN labprod.nmloconc CP ON ( CP.con_keycon = CONCS.per_keycon )
           LEFT JOIN labprod.nmloconc CD ON ( CD.con_keycon = CONCS.ded_keycon )
           JOIN
              (SELECT hem_keyemp KEYEMP ,
                ACUMS.ACUM_ISR ,
                ACUMS.ACUM_PER ,
                HISM_PER.HIS_DIAS ,
                HISM_PER.TOT_ISR ,
                HISM_PER.TOT_PER ,
                HISM_PER.TOT_DED ,
                HISM_PER.IMP_NETO ,
                HISM_PER.APO_CAHO ,
                HISM_PER.PREST_CAHO ,
                HISM_PER.IMP_FUND_TV,
                HISM_PER.TOT_SAR,
                HISM_PER.VAL_DESP,
                HISM_PER.VAL_FOM_CULT,
                HISM_PER.DONATIVO_REC
              FROM labprod.nmloperi PER_TOTS
              JOIN labprod.nmlohemp HEM_TOTS ON ( HEM_TOTS.hem_keypro = PER_TOTS.per_keypro AND HEM_TOTS.hem_keyper  = PER_TOTS.per_keyper )
              LEFT JOIN
                (SELECT hem_keyemp ACU_KEYEMP ,
                  SUM( CASE msgs_tipocon
                    WHEN 2 THEN NVL(acu_impuno, 0) + NVL(acu_impdos, 0) + NVL(acu_imptre, 0) + NVL(acu_impcua, 0) + NVL(acu_impcin, 0) + NVL(acu_impsei, 0) + NVL(acu_impsie, 0) + NVL(acu_impoch, 0) + NVL(acu_impnue, 0) + NVL(acu_impdie, 0) + NVL(acu_imponc, 0) + NVL(acu_impdoc, 0)
                    ELSE 0 END) ACUM_ISR ,
                  SUM( CASE msgs_tipocon
                    WHEN 3 THEN NVL(acu_impuno, 0) + NVL(acu_impdos, 0) + NVL(acu_imptre, 0) + NVL(acu_impcua, 0) + NVL(acu_impcin, 0) + NVL(acu_impsei, 0) + NVL(acu_impsie, 0) + NVL(acu_impoch, 0) + NVL(acu_impnue, 0) + NVL(acu_impdie, 0) + NVL(acu_imponc, 0) + NVL(acu_impdoc, 0)
                    ELSE 0 END) ACUM_PER
                FROM labprod.nmloperi
                JOIN labprod.nmlohemp ON ( hem_keypro = per_keypro AND hem_keyper  = per_keyper )
                LEFT JOIN labprod.nmloacum ON ( acu_keyemp = hem_keyemp AND acu_keypro  = hem_keypro AND acu_anioac  = per_anioa1 )
                LEFT JOIN labprod.PS_TPW_MSGXCONCS ON (MSGS_KEYPRO = PER_KEYPRO AND MSGS_KEYPER = PER_KEYPER AND acu_keycon = msgs_keycon )
                WHERE ( per_keypro = v_KeyPro
                AND per_keyper     = v_KeyPer )
                AND ( v_nrCheckSum = 0 OR hem_keyemp IN (SELECT KEYEMP FROM labprod.tt_v_selEmpls) )
                GROUP BY hem_keyemp
                ) ACUMS ON ( ACUMS.acu_keyemp = HEM_TOTS.hem_keyemp )
              LEFT JOIN
                (SELECT his_keyemp ,
                  SUM( CASE msgs_tipocon WHEN 1 THEN his_cantid ELSE 0 END) HIS_DIAS ,
                  SUM( CASE msgs_tipocon WHEN 2 THEN his_import ELSE 0 END) TOT_ISR ,
                  SUM( CASE msgs_tipocon WHEN 3 THEN his_import ELSE 0 END) TOT_PER ,
                  SUM( CASE msgs_tipocon WHEN 4 THEN his_import ELSE 0 END) TOT_DED ,
                  SUM( CASE msgs_tipocon WHEN 5 THEN his_import ELSE 0 END) IMP_NETO ,
                  SUM( CASE msgs_tipocon WHEN 6 THEN his_import ELSE 0 END) APO_CAHO ,
                  SUM( CASE msgs_tipocon WHEN 7 THEN his_import ELSE 0 END) PREST_CAHO ,
                  SUM( CASE msgs_tipocon WHEN 8 THEN his_import ELSE 0 END) IMP_FUND_TV,
                  SUM( CASE msgs_tipocon WHEN 9 THEN his_import ELSE 0 END) TOT_SAR,
                  SUM( CASE msgs_tipocon WHEN 10 THEN his_import ELSE 0 END) VAL_DESP,
                  SUM( CASE msgs_tipocon WHEN 11 THEN his_import ELSE 0 END) VAL_FOM_CULT,
                  SUM( CASE msgs_tipocon WHEN 12 THEN his_import ELSE 0 END) DONATIVO_REC
                FROM labprod.nmlohism
                JOIN labprod.PS_TPW_MSGXCONCS ON (MSGS_KEYPRO = his_KEYPRO AND MSGS_KEYPER = his_KEYPER AND his_keycon    = msgs_keycon )
                WHERE his_keypro   = v_KeyPro
                AND his_keyper     = v_KeyPer
                AND ( v_nrCheckSum = 0 OR his_keyemp IN (SELECT KEYEMP FROM labprod.tt_v_selEmpls) )
                GROUP BY his_keyemp
                ) HISM_PER ON ( HISM_PER.his_keyemp = HEM_TOTS.hem_keyemp )
            WHERE ( per_keypro                    = v_KeyPro
            AND per_keyper                        = v_KeyPer )
            --AND ( v_nrCheckSum = 0 OR acu_keyemp IN (SELECT KEYEMP FROM tt_v_selEmpls) )
            ) TOTALES ON TOTALES.KEYEMP = his_keyemp
          ORDER BY his_keyemp,SEC_ROW;
    END IF;
    END;
 END;
/
