CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_GETSPOTRATE_VW" ("ID_SOLICITUD", "ID_REQUEST", "ID_SEG_NEG", "ID_FZA_VENTAS", "LINEA", "RTCRDDSCR", "RTCRD", "MCONTID", "ADVID", "STNID", "PGMID", "FECHA_1A_TRAN", "HORA_INICIO", "HORA_FIN", "DURACION", "SOBRECARGO", "MARCA", "AGENCIA", "FECHA_CAPTURA", "DIA_SEMANA") AS 
  SELECT E.ID_SOLICITUD,
          E.ID_REQUEST,
          E.ID_SEG_NEG,
          E.ID_FZA_VENTAS,
          D.LINEA,
          E.RTCRDDSCR,
          E.RTCRD,
          E.MCONTID,
          E.ADVID,
          D.STNID,
          D.BUYUNTID AS PGMID,
          TO_CHAR (
             TO_DATE (
                XXMOR_FUNCIONAL_PKG.
                 XXMOR_SOL_FECHAS_FUN (e.ID_SOLICITUD, d.linea, 'F_1A_T'),
                'yyyymmdd'),
             'yyyy-mm-dd')
             AS Fecha_1a_tran,
          D.HORA_INICIO || '0000' AS HORA_INICIO,
          D.HORA_FIN || '0000' AS HORA_FIN,
          D.DURACION,
          TRIM (
             REPLACE (REPLACE (UPPER (D.SOBRECARGO), 'DESC. ', '-'), '%', ''))
             AS SOBRECARGO,
          D.MARCA,
          '' AS agencia,
          TO_CHAR (SYSDATE, 'yyyy-mm-dd') AS fecha_Captura,
          CASE
             WHEN TO_NUMBER (SABADO) > 0 THEN 'S'
             WHEN TO_NUMBER (DOMINGO) > 0 THEN 'D'
             ELSE 'L-V'
          END
             AS DIA_SEMANA
     FROM XXMOR.XXMOR_SOLICITUDES_ENC_TAB E,
          XXMOR.XXMOR_SOLICITUDES_DET_TAB D
    WHERE E.ID_SOLICITUD = D.ID_SOLICITUD AND id_seg_neg = 1
 ;
