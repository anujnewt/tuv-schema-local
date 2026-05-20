CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_AUT_TM_WS_VW" ("ID_SOLICITUD", "LINEA", "RTCRDDSCR", "RTCRD", "CURRCODE", "BUYUNTID", "SECNUM", "STNID", "STNID_ORIG", "DAYCHAR", "DURACION", "1A_TRANSMISION", "AIRDATE", "SOBRECARGO", "PATRON_TRANS", "FECHA_INICIO", "FECHA_FIN", "HORA_INICIO", "HORA_FIN", "ADVID", "MCONTID", "MARCA", "ACCTHDRID", "AGENCIA", "FEC_CAPTURA", "AUX1", "AUX2", "AUX3", "AUX4", "AUX5") AS 
  SELECT D.ID_SOLICITUD,
          D.LINEA,
          E.RTCRDDSCR,
          E.RTCRD,
          '0' AS CURRCODE,
          D.BUYUNTID,
          E.SECNUM,
          CASE
             WHEN (SELECT AM.AGRUPADOR_MULTIPLE
                     FROM XXMOR_CAT_AGRUPADOR_MULT_TAB AM
                    WHERE AM.AGRUPADOR_MULTIPLE = E.AGRUPADOR
                          AND AM.PIVOTE = 'S') = E.AGRUPADOR
             THEN
                (SELECT AM.PREFIJO_CANAL || SUBSTR (D.STNID, 3)
                   FROM XXMOR_CAT_AGRUPADOR_MULT_TAB AM
                  WHERE AM.AGRUPADOR_MULTIPLE = E.AGRUPADOR
                        AND AM.PIVOTE = 'S')
             ELSE
                D.STNID
          END
             STNID,
          D.STNID AS STNID_ORIG,
          '           ' AS DAYCHAR,
          D.DURACION,
          TO_CHAR (SYSDATE, 'YYYY-MM-DD') AS "1A_TRANSMISION",
          TO_CHAR (
             TO_DATE (
                XXMOR_FUNCIONAL_PKG.
                 XXMOR_SOL_FECHAS_FUN (d.id_Solicitud, d.linea, 'F_1A_T'),
                'YYYYMMDD'),
             'YYYY-MM-DD')
             AS AIRDATE,
          D.SOBRECARGO,
          CASE d.sabado + d.domingo
             WHEN 0
             THEN
                   LPAD (lunes, 2, '0')
                || LPAD (MARTES, 2, '0')
                || LPAD (MIERCOLES, 2, '0')
                || LPAD (JUEVES, 2, '0')
                || LPAD (VIERNES, 2, '0')
             --|| LPAD (SABADO, 2, '0')
             --|| LPAD (DOMINGO, 2, '0')
             ELSE
                   LPAD (' ', 10, ' ')
                || LPAD (sabado, 2, '0')
                || LPAD (d.domingo, 2, '0')
          END
             AS PATRON_TRANS,
          XXMOR_FUNCIONAL_PKG.
           XXMOR_FECHA_SIN_ER_FUN (D.FECHA_INICIO, 'AUT_TM')
             AS FECHA_INICIO,
          XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_SIN_ER_FUN (D.FECHA_FIN, 'AUT_TM')
             AS FECHA_FIN,
          D.HORA_INICIO || '0000' AS HORA_INICIO,
          D.HORA_FIN || '0000' AS HORA_FIN,
          E.ADVID,
          E.MCONTID,
          D.MARCA,
          E.ACCTHDRID,
          '              ' AS AGENCIA,
          '              ' AS FEC_CAPTURA,
          TO_CHAR (SYSDATE, 'YYYY-MM-DD') AS AUX1,
          LPAD (' ', 25, ' ') AS AUX2,
          LPAD (' ', 25, ' ') AS AUX3,
          LPAD (' ', 25, ' ') AS AUX4,
          LPAD (' ', 25, ' ') AS AUX5
     FROM XXMOR_SOLICITUDES_DET_TAB D, XXMOR_SOLICITUDES_ENC_TAB E
    WHERE E.ID_SOLICITUD = D.ID_SOLICITUD AND e.id_seg_neg = 1;
