CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PARA_COPY_VW" ("ID_SOLICITUD", "LINEA", "P_ORDID", "P_ORDLNNUM", "P_ROTID", "P_ADVID", "P_SPTLEN", "P_VERSION", "P_STRDT", "P_EDT", "P_STNID", "P_PLATAFORMA", "P_CUT_IN", "P_MARCA", "P_COPYS_X_FECHA", "P_COPYS_X_ORDEN", "P_MATLOC_CANAL", "P_MATLOC_DEFAULT", "P_MATLOC_NULL", "P_AUX1", "P_AUX2") AS 
  SELECT E.ID_SOLICITUD,
       D.LINEA,
       (SELECT TO_NUMBER(ESTAT_ID_FORANEO)
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  ER.ID_SOLICITUD = E.ID_SOLICITUD
        AND    ER.LINEA        = 0
       )                                             AS P_ORDID,
       TO_NUMBER(R.ESTAT_ID_FORANEO)                 AS P_ORDLNNUM,
       SUBSTR(D.STNID||'*'
              ||(SELECT REVERSE(SUBSTR(REVERSE(TO_CHAR(SER.ESTAT_ID_FORANEO)),
                                     1,6
                                    ))
                 FROM   XXMOR_SOLICITUDES_EST_REP_TAB SER
                 WHERE  SER.ID_SOLICITUD = R.ID_SOLICITUD
                 AND    SER.LINEA        = 0
                )
              ||'*'
              ||TO_CHAR(R.ESTAT_ID_FORANEO, '000')
              ||'*'
              ||TO_CHAR(TRUNC(1000000000 * ABS(DBMS_RANDOM.NORMAL))),
              1,20
             )                                       AS P_ROTID,
       E.ADVID                                       AS P_ADVID,
       TRUNC(D.DURACION)                             AS P_SPTLEN,
       D.VERSION                                     AS P_VERSION,
       TO_CHAR(TO_DATE(D.FECHA_INICIO, 'YYYYMMDD')
                   + DECODE(F.COPYS_X_FECHA,
                            '1', CASE
                                     WHEN LUNES     != 0 THEN 0
                                     WHEN MARTES    != 0 THEN 1
                                     WHEN MIERCOLES != 0 THEN 2
                                     WHEN JUEVES    != 0 THEN 3
                                     WHEN VIERNES   != 0 THEN 4
                                     WHEN SABADO    != 0 THEN 5
                                     WHEN DOMINGO   != 0 THEN 6
                                     ELSE 999
                                 END,
                            0), 'YYYY-MM-DD')        AS P_STRDT,
       TO_CHAR(TO_DATE(D.FECHA_FIN, 'YYYYMMDD')
                   - DECODE(F.COPYS_X_FECHA,
                            '1', CASE
                                     WHEN DOMINGO   != 0 THEN 0
                                     WHEN SABADO    != 0 THEN 1
                                     WHEN VIERNES   != 0 THEN 2
                                     WHEN JUEVES    != 0 THEN 3
                                     WHEN MIERCOLES != 0 THEN 4
                                     WHEN MARTES    != 0 THEN 5
                                     WHEN LUNES     != 0 THEN 6
                                     ELSE 999
                                  END,
                            0), 'YYYY-MM-DD')        AS P_EDT,
       D.STNID                                       AS P_STNID,
       E.PLATAFORMA_CANAL                            AS P_PLATAFORMA,
       DECODE(UPPER(PLATAFORMA_CANAL),'CUTIN', 1, 0) AS P_CUT_IN,
       D.MARCA                                       AS P_MARCA,
       F.COPYS_X_FECHA                               AS P_COPYS_X_FECHA,
       F.COPYS_X_ORDEN                               AS P_COPYS_X_ORDEN,
       DECODE(MATLOC_BUSQUEDA,'FV',F.MATLOC
                                  ,SUBSTR(D.STNID,1,2)
             )                                       AS P_MATLOC_CANAL,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_MATLOC_FUN
                          (E.ID_SOLICITUD, D.LINEA)  AS P_MATLOC_DEFAULT,
       F.MATLOC_NULL                                 AS P_MATLOC_NULL,
       '  '                                          AS P_AUX1,
       '  '                                          AS P_AUX2
FROM   XXMOR_FZAS_VTAS_TAB           F,
       XXMOR_SOLICITUDES_ENC_TAB     E,
       XXMOR_SOLICITUDES_DET_TAB     D,
       XXMOR_SOLICITUDES_EST_REP_TAB R
WHERE  E.ID_SOLICITUD                      = D.ID_SOLICITUD
AND    E.ID_FZA_VENTAS                     = F.ID_FZA_VENTAS
AND    E.ID_SOLICITUD                      = R.ID_SOLICITUD
AND    D.ID_SOLICITUD                      = R.ID_SOLICITUD
AND    D.LINEA                             = R.LINEA
--AND    R.ESTAT_ID_FORANEO                  IS NOT NULL --Para que no traiga lineas que an no han sido insertadas en pgm
AND    UPPER(D.VERSION)                    NOT IN ('VER PAUTA', 'SA')
AND    R.ID_SIST                           = 1
--AND    NVL(F.COPYS_X_ORDEN, 0)             = 0 -- SE SUSTITUYO POR LA FUNCION 16MAY2013
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_COPYS_POR_ORDEN_FN
                          (F.ID_FZA_VENTAS,
                           E.ID_SOLICITUD
                          )                = 'N'
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_VALIDA_FUN
                          (D.FECHA_INICIO) = 1
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_VALIDA_FUN
                          (D.FECHA_FIN)    = 1
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_DURACION_VALIDA_FUN
                          (D.DURACION)     = 1
AND    NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_MATLOC_FUN
                          (E.ID_SOLICITUD,
                           D.LINEA),'-0'
                          )               != '-1'
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_COPYS_VERHORARIO_FN
                          (
                           E.ID_SOLICITUD,
                           D.LINEA
                          )                = 'Y'
/*AND    NOT EXISTS                            (   --LINEAS EN LAS QUE CONCOM RESPONDI QUE SU VERSIN NO EXISTE NO SE GENERAN COPYS
                                              SELECT 1
                                              FROM   XXMOR_CONCOM_RPTA_TAB CR
                                              WHERE  CR.ID_SOLICITUD               = D.ID_SOLICITUD
                                              AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                                              AND    INSTR(CR.DETALLE_CONCOM, 'VersionHorario') > 0
                                             )*/
AND    NOT EXISTS                            (   --LINEAS que sigan teniendo error no se generan copys
                                              SELECT 1
                                              FROM   XXMOR_CONCOM_RPTA_TAB CR
                                              WHERE  CR.ID_SOLICITUD               = D.ID_SOLICITUD
                                              AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                                              AND    CR.ESTATUS_ORDUNI             = 10
                                             )
AND    NOT EXISTS                            (   --copys que no se hayan insertado
                                              SELECT 1
                                              FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                              WHERE  ER.ID_SOLICITUD = D.ID_SOLICITUD
                                              AND    ER.LINEA        = D.LINEA
                                              AND    ER.AUX1         IS NOT NULL
                                             )
AND    EXISTS                                (   --Que se haya insertado el encabezado
                                              SELECT 1
                                              FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                              WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                                              AND    ER.LINEA            = 0
                                              AND    ER.ESTAT_ID_FORANEO IS NOT NULL
                                             )
UNION                      -- Agrega los registros de los copys x orden
SELECT E.ID_SOLICITUD,
       D.LINEA,
       (SELECT TO_NUMBER(ESTAT_ID_FORANEO)
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  ER.ID_SOLICITUD = E.ID_SOLICITUD
        AND    ER.LINEA        = 0
       )                                             AS P_ORDID,
       TO_NUMBER(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_NUMLINE_FUN
                                    (D.ID_SOLICITUD,
                                     D.LINEA
                                    )
                )                                    AS P_ORDLNNUM,
       --R.ESTAT_ID_FORANEO AS ID_FORANEO_LINEA,  -->20121130 Octavio llam a para ver que valor ponian aqui en estos casos, => 0
       SUBSTR(DECODE(E.ID_FZA_VENTAS, 7,          --Es de nacional
                                        'MULTI0*'
                                        ||(SELECT REVERSE(SUBSTR(REVERSE(TO_CHAR(R.ESTAT_ID_FORANEO)),
                                                                 1,6)
                                                                )
                                           FROM   XXMOR_SOLICITUDES_EST_REP_TAB SER
                                           WHERE  SER.ID_SOLICITUD = R.ID_SOLICITUD
                                           AND    SER.LINEA        = 0
                                          )
                                        ||'*'
                                        --|| '000' -- TO_CHAR (R.ESTAT_ID_FORANEO, '000') MISMO CASO DE LA LLAMADA
                                        --Se quita el 000 por un query mas dinmico que no sobreescriba versiones
                                        ||XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_NUMLINE_FUN(D.ID_SOLICITUD, TO_NUMBER(D.LINEA))
                                        ||'*'
                                        ||TO_CHAR(TRUNC(1000000000 * ABS(DBMS_RANDOM.NORMAL))),
                                        D.STNID||'*'
                                        ||(SELECT REVERSE(SUBSTR(REVERSE(TO_CHAR(ER.ESTAT_ID_FORANEO)),
                                                                 1,6)
                                                                 )
                                           FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                           WHERE  ER.ID_SOLICITUD = R.ID_SOLICITUD
                                           AND    ER.LINEA        = 0
                                          )
                                        ||'*'
                                        --||'000'                --Se quita el 000 por un query mas dinmico que no sobreescriba versiones
                                        ||XXMOR_FUNCIONAL_PKG.XXMOR_NUMLINE_FUN
                                                             (D.ID_SOLICITUD, TO_NUMBER(D.LINEA))
                                        ||'*'
                                        ||TO_CHAR(TRUNC(1000000000 * ABS(DBMS_RANDOM.NORMAL)))),
              1, 20)                                          AS P_ROTID,
       E.ADVID                                                AS P_ADVID,
       TRUNC(D.DURACION)                                      AS P_SPTLEN,
       D.VERSION                                              AS P_VERSION,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN
                          (E.ID_SOLICITUD, NULL, 'FI_COPY')   AS P_STRDT,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN
                          (E.ID_SOLICITUD, NULL, 'FF_COPY')   AS P_EDT,
       DECODE (UPPER (PLATAFORMA_CANAL), 'TVSA', '', D.STNID) AS P_STNID, --Estaba el agrupador 11-07-2012
       E.PLATAFORMA_CANAL                                     AS P_PLATAFORMA,
       DECODE(UPPER(PLATAFORMA_CANAL), 'CUTIN', 1, 0)         AS P_CUT_IN,
       D.MARCA                                                AS P_MARCA,
       F.COPYS_X_FECHA                                        AS P_COPYS_X_FECHA,
       F.COPYS_X_ORDEN                                        AS P_COPYS_X_ORDEN,
       DECODE(MATLOC_BUSQUEDA, 'FV', F.MATLOC
                                   , SUBSTR (STNID, 1, 2))    AS P_MATLOC_CANAL,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_MATLOC_FUN
                          (E.ID_SOLICITUD, D.LINEA)           AS P_MATLOC_DEFAULT,
       F.MATLOC_NULL                                          AS P_MATLOC_NULL,
       '  '                                                   AS AUX1,
       '  '                                                   AS AUX2
FROM   XXMOR_FZAS_VTAS_TAB           F,
       XXMOR_SOLICITUDES_ENC_TAB     E,
       XXMOR_SOLICITUDES_DET_TAB     D,
       XXMOR_SOLICITUDES_EST_REP_TAB R
WHERE  E.ID_SOLICITUD                      = D.ID_SOLICITUD
AND    E.ID_FZA_VENTAS                     = F.ID_FZA_VENTAS
AND    E.ID_SOLICITUD                      = R.ID_SOLICITUD
AND    D.ID_SOLICITUD                      = R.ID_SOLICITUD
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_VALIDA_FUN
                          (D.FECHA_INICIO) = 1
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_VALIDA_FUN
                          (D.FECHA_FIN)    = 1
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_DURACION_VALIDA_FUN
                          (D.DURACION)     = 1
AND    NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_MATLOC_FUN
                          (E.ID_SOLICITUD,
                           D.LINEA),'-0') != '-1'
AND    D.LINEA                             = R.LINEA
AND    R.ESTAT_ID_FORANEO                  IS NOT NULL --PAra que no traiga lineas que an no han sido insertadas en pgm
AND    UPPER (D.VERSION)                   NOT IN ('VER PAUTA', 'SA') --AND UPPER (D.VERSION) != 'VER PAUTA'
AND    R.ID_SIST                           = 1
--AND    NVL(F.COPYS_X_ORDEN, 0) = 1 -- SE SUSTITUYO POR LA FUNCION 16MAY2013
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_COPYS_POR_ORDEN_FN
                          (F.ID_FZA_VENTAS,
                           E.ID_SOLICITUD) = 'Y'
AND    XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_COPYS_VERHORARIO_FN
                          (
                           E.ID_SOLICITUD,
                           D.LINEA
                          )                = 'Y'
/*AND    NOT EXISTS                            (   --LINEAS EN LAS QUE CONCOM RESPONDI QUE SU VERSIN NO EXISTE NO SE GENERAN COPYS
                                              SELECT 1
                                              FROM   XXMOR_CONCOM_RPTA_TAB CR
                                              WHERE  CR.ID_SOLICITUD               = D.ID_SOLICITUD
                                              AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                                              AND    INSTR(CR.DETALLE_CONCOM, 'VersionHorario') > 0
                                             )*/
AND    EXISTS                                (   --copys que no se hayan insertado
                                              SELECT 1
                                              FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                              WHERE  ER.ID_SOLICITUD = D.ID_SOLICITUD
                                              AND    ER.LINEA        = D.LINEA
                                              AND    ER.AUX1         IS NULL
                                             )
AND    NOT EXISTS                            (   -- Valida que si el Copy ya fue insertado, no se inserte
                                              SELECT 1
                                              FROM   XXMOR_SOLICITUDES_DET_TAB     SD,
                                                     XXMOR_SOLICITUDES_EST_REP_TAB ER
                                              WHERE  SD.ID_SOLICITUD = ER.ID_SOLICITUD
                                              AND    SD.LINEA        = ER.LINEA
                                              AND    SD.VERSION      = D.VERSION
                                              AND    SD.STNID        = D.STNID
                                              AND    ER.ID_SOLICITUD = E.ID_SOLICITUD
                                              AND    ER.AUX1         IS NOT NULL
                                              )
AND EXISTS                                   (   -- Que se haya insertado el encabezado
                                              SELECT 1
                                              FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                              WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                                              AND    ER.LINEA            = 0
                                              AND    ER.ESTAT_ID_FORANEO IS NOT NULL
                                             )
AND D.LINEA                                IN ( -- Las lineas que esten bien, agrupadas por canal y version
                                               SELECT MIN(D2.LINEA)
                                               FROM   XXMOR_SOLICITUDES_DET_TAB D2
                                               WHERE  D2.ID_SOLICITUD = D.ID_SOLICITUD
                                               AND    D2.LINEA        NOT IN (SELECT DISTINCT TO_NUMBER(R.NUMLINEA_CONCOM)
                                                                              FROM   XXMOR_CONCOM_RPTA_TAB R
                                                                              WHERE  R.ID_SOLICITUD    = D2.ID_SOLICITUD
                                                                              AND    R.NUMLINEA_CONCOM IS NOT NULL
                                                                              AND    R.ESTATUS_ORDUNI  = '10'
                                                                              AND    R.ID_SEG_NEG      = 1
                                                                             )
                                               GROUP BY D2.VERSION, D2.STNID
                                              );
