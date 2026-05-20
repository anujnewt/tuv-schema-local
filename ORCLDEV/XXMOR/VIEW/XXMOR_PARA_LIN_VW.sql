CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PARA_LIN_VW" ("ID_SOLICITUD", "LINEA", "P_ORDID", "P_ORDLNNUM", "P_ORDLNID", "P_STNID", "P_SPOTCHR", "P_USRCHR", "P_SECNUM", "P_STRDT", "P_EDT", "P_BUYUNTID", "P_STRTIM", "P_ETIM", "P_SPTLEN", "P_SPTPAT", "P_RT", "P_BKDT", "P_USRFL11", "P_LNSPTORD", "P_LNVALORD", "P_PRDID1", "P_BRND", "P_CMT", "P_MEDNUM", "P_MEDCUTNUM", "P_DSCR_RTADJUST", "P_AUX1", "P_AUX2", "P_AUX3", "P_USRFL19", "P_USRFL20") AS 
  SELECT
    E.ID_SOLICITUD,
    D.LINEA,
    (
        SELECT
            ER.ESTAT_ID_FORANEO
        FROM
            XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE
            ER.ID_SOLICITUD = D.ID_SOLICITUD
        AND ER.LINEA = 0
        AND ER.ID_SIST = 1 )    P_ORDID,
    ER.ESTAT_ID_FORANEO      AS P_ORDLNNUM,
    ER.AUX2                     P_ORDLNID,
    D.STNID                  AS P_STNID,
    D.SPOT_CHR               AS P_SPOTCHR,
    CASE
        WHEN SUBSTR(E.MCONTID, INSTR(E.MCONTID, '.') - 2, 2) IN
            (
                SELECT
                    VALOR_PARAMETRO
                FROM
                    XXMOR.XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE
                    NOMBRE_PARAMETRO = 'Prefijo_UsrChr' )
        AND TRIM(D.USR_CHR) IS NULL
        THEN 'M'
        WHEN SUBSTR(E.MCONTID, INSTR(E.MCONTID, '.') - 2, 2) IN
            (
                SELECT
                    VALOR_PARAMETRO
                FROM
                    XXMOR.XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE
                    NOMBRE_PARAMETRO = 'Prefijo_UsrChr' )
        AND TRIM(D.USR_CHR) IS NOT NULL
        THEN TRIM(D.USR_CHR)
        WHEN SUBSTR(E.MCONTID, INSTR(E.MCONTID, '.') - 2, 2) NOT IN
            (
                SELECT
                    VALOR_PARAMETRO
                FROM
                    XXMOR.XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE
                    NOMBRE_PARAMETRO = 'Prefijo_UsrChr' )
        AND TRIM(D.USR_CHR) IS NOT NULL
        THEN TRIM(D.USR_CHR)
    END AS P_USRCHR,
    CASE
        WHEN NVL(E.GARANTIZADO, 0) = 1
        THEN '0'
        WHEN SUBSTR(E.COMENTARIOS, 1, 1) = '('
        AND SUBSTR(E.COMENTARIOS, 5, 1) = ')'
        AND SUBSTR(E.COMENTARIOS, 3, 1) = ','
        THEN SUBSTR(E.COMENTARIOS, 2, 1)
        WHEN SUBSTR(E.MCONTID, INSTR (E.MCONTID, '.') - 2, 2) IN
            (
                SELECT
                    VALOR_PARAMETRO
                FROM
                    XXMOR.XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE
                    NOMBRE_PARAMETRO = 'Prefijo_UsrChr' )
        THEN '7'
        ELSE E.SECNUM
    END                                                          AS P_SECNUM,
    TO_CHAR(TO_DATE(D.FECHA_INICIO, 'YYYY-MM-DD'), 'YYYY-MM-DD') AS P_STRDT,
    TO_CHAR(TO_DATE(D.FECHA_FIN, 'YYYY-MM-DD'), 'YYYY-MM-DD')    AS P_EDT,
    TRIM(D.BUYUNTID)                                             AS P_BUYUNTID,
    D.HORA_INICIO||'0000'                                        AS P_STRTIM,
    D.HORA_FIN||'0000'                                           AS P_ETIM,
    ABS(D.DURACION)                                              AS P_SPTLEN,
    DECODE(TO_NUMBER(D.LUNES), 0, '  ', LPAD(D.LUNES, 2, '0'))|| DECODE(TO_NUMBER(D.MARTES), 0,
    '  ', LPAD(D.MARTES, 2, '0'))|| DECODE(TO_NUMBER(D.MIERCOLES), 0, '  ', LPAD(D.MIERCOLES, 2,
    '0'))|| DECODE(TO_NUMBER(D.JUEVES), 0, '  ', LPAD(D.JUEVES, 2, '0'))|| DECODE(TO_NUMBER
    (D.VIERNES), 0, '  ', LPAD(D.VIERNES, 2, '0'))|| DECODE(TO_NUMBER(D.SABADO), 0, '  ', LPAD
    (D.SABADO, 2, '0'))|| DECODE(TO_NUMBER(D.DOMINGO), 0, '  ', LPAD(D.DOMINGO, 2, '0')) AS
                                               P_SPTPAT,
    ABS(TRUNC((D.TARIFASP_SIN_DESC) * 100)) AS P_RT,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD')          AS P_BKDT,
    CASE
        WHEN (
                SELECT
                    1
                FROM
                    XXMOR_CONCOM_RPTA_TAB CR
                WHERE
                    CR.ID_SOLICITUD = D.ID_SOLICITUD
                AND CR.NUMLINEA_CONCOM = D.LINEA
                AND CR.ACCION_CONCOM = 'AUTORIZACION'
                AND CR.CAMPO_CONCOM IN 'TARIFA_MANUAL'
                AND CR.ESTATUS_ORDUNI = 20 ) > 0
        THEN 1
        WHEN (
                SELECT
                    COUNT (1)
                FROM
                    XXMOR_CAT_AGRUPADOR_MULT_TAB A
                WHERE
                    A.AGRUPADOR_MULTIPLE = E.AGRUPADOR
                AND A.AGRUPADOR_MULTIPLE = 'CABSKY' ) > 0
        AND XXMOR_FUNCIONAL_PKG.XXMOR_RTCRD_CA_FUN(E.ID_SOLICITUD) > 0
        THEN 1
        ELSE 0
    END                                          AS P_USRFL11,
    D.SPOTS                                      AS P_LNSPTORD,
    NVL(ROUND(D.TOT_LINEA_SIN_DESC * 100, 0), 0) AS P_LNVALORD,
    SUBSTR(E.PRDID_DESC, 1, 4)                   AS P_PRDID1,
    D.MARCA                                      AS P_BRND,
    D.OBSERVACIONES                              AS P_CMT,
    D.BN                                         AS P_MEDNUM,
    D.P                                          AS P_MEDCUTNUM,
    D.SOBRECARGO                                 AS P_DSCR_RTADJUST,
    NVL2(D.LINEA_HNA, 1, NULL)                   AS P_AUX1,
    SUBSTR(D.TIPO_SERVICIO,1,20)                 AS P_AUX2,
    '      '                                     AS P_AUX3,
    -- INCIO OMW - Cambio manejo de Paquetes, 23-ABR-2015
    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_VALOR_PAQUETES_FN ( 'USRFL19', NVL(UPPER(D.DES_PLATAFORMA),
    'SIN VALOR') ) AS P_USRFL19,
    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_VALOR_PAQUETES_FN ( 'USRFL20', NVL(UPPER(D.DES_PLATAFORMA),
    'SIN VALOR') ) AS P_USRFL20
    -- FIN OMW - Cambio manejo de Paquetes, 23-ABR-2015
FROM
    XXMOR_SOLICITUDES_DET_TAB D,
    XXMOR_SOLICITUDES_ENC_TAB E,
    XXMOR_SOLICITUDES_ORIG_ENC_TAB EO,
    XXMOR_FZAS_VTAS_TAB F,
    XXMOR_SOLICITUDES_EST_REP_TAB ER,
    (
        SELECT DISTINCT
            ID_SOLICITUD,
            NUMLINEA_CONCOM
        FROM
            XXMOR_CONCOM_RPTA_TAB
        WHERE
            NUMLINEA_CONCOM IS NOT NULL
        MINUS
        SELECT DISTINCT
            ID_SOLICITUD,
            NUMLINEA_CONCOM
        FROM
            XXMOR_CONCOM_RPTA_TAB
        WHERE
            ESTATUS_ORDUNI = '10' ) CR
WHERE
    ER.LINEA != 0
AND ER.ESTAT_ID_FORANEO IS NULL
AND E.ID_SOLICITUD = D.ID_SOLICITUD
AND E.ID_FZA_VENTAS = F.ID_FZA_VENTAS
AND E.ID_REQUEST = EO.ID_REQUEST
AND D.ID_SOLICITUD = CR.ID_SOLICITUD
AND D.LINEA = CR.NUMLINEA_CONCOM
AND D.ID_SOLICITUD = ER.ID_SOLICITUD(+)
AND D.LINEA = ER.LINEA(+)
AND ER.AUX2 IS NOT NULL
AND ER.ID_SIST(+) = 1
AND F.ID_SEG_NEG = 1
AND
    CASE
        WHEN XXMOR_FUNCIONAL_PKG.XXMOR_ES_SOL_AGR_MULT_FUN (E.ID_SOLICITUD) = 1
        AND DIVISION_MONTOS = 1
        THEN 1
        WHEN XXMOR_FUNCIONAL_PKG.XXMOR_ES_SOL_AGR_MULT_FUN (E.ID_SOLICITUD) = 0
        THEN 1
        ELSE 0
    END = 1
AND E.ID_SOLICITUD =
    (--PARA QUE NO SE INSERTEN LAS LINEAS, CUYO ENCABEZADO NO HA SIDO INSERTADO
        SELECT
            ER.ID_SOLICITUD
        FROM
            XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE
            ER.ID_SOLICITUD = E.ID_SOLICITUD
        AND ER.LINEA = 0
        AND ER.ESTAT_ID_FORANEO IS NOT NULL )
ORDER BY
    D.ID_SOLICITUD,
    TO_NUMBER(D.LINEA) ASC;
