CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_VERS_VIRT_AUX_VW" ("ID_REQUEST", "ID_SOLICITUD", "ID_SEG_NEG", "LINEA", "ID_FZA_VENTAS", "ADVID", "EXTCPYNUM", "NOMANCLEN", "ACTANCLEN", "ANCSTRDT", "ANCEDT", "USRCHR", "SPTCHR", "PRDID1", "VIDSRC", "AUDSRC", "BRND", "AUTOID", "PROACTDAY", "ACTDAY", "PROPGMID", "PROSTN", "AUX01", "AUX02", "AUX03", "AUX04", "AUX05") AS 
  SELECT E.ID_REQUEST,
          E.ID_SOLICITUD,
          E.ID_SEG_NEG,
          D.LINEA,
          E.ID_FZA_VENTAS,
          E.ADVID,
          D.VERSION AS EXTCPYNUM,                --Identificador de la Versin
          D.DURACION AS NOMANCLEN,              --Duracin Nominal en Segundos
          TO_NUMBER (D.duracion) * 1000 AS ACTANCLEN, --Duracin actual en milisegundos
          /*(SELECT TO_CHAR (
                     MIN (TO_DATE (fecha_inicio, 'yyyy-mm-dd'))
                     - TO_CHAR (MIN (TO_DATE (fecha_inicio, 'yyyy-mm-dd')),
                                'D')
                     + 2,
                     'YYYY-MM-DD')
             FROM xxmor_solicitudes_det_tab det
            WHERE det.id_solicitud = e.id_solicitud
                  --AND DET.LINEA_ESTATUS NOT IN (46, 36)
                  )
             AS */ ----------- Primer intento de fecha
       /*  (   SELECT DECODE(TO_CHAR(MIN(TO_DATE(fecha_inicio,'YYYY-MM-DD')) ,'D'),'1'
              ,TO_CHAR((MIN(TO_DATE(fecha_inicio,'YYYY-MM-DD'))
                        - TO_CHAR(MIN(TO_DATE(fecha_inicio,'YYYY-MM-DD')),'D')
                       ) - 5
                       ,'YYYY-MM-DD'
                      )
              ,TO_CHAR((MIN(TO_DATE(fecha_inicio,'YYYY-MM-DD'))
                        - TO_CHAR(MIN(TO_DATE(fecha_inicio,'YYYY-MM-DD')),'D')
                       ) + 2
                       ,'YYYY-MM-DD'
                      )
             ) LUNES_ANT
        FROM   xxmor_solicitudes_det_tab det
        WHERE  det.id_solicitud = e.id_solicitud  )   */
         to_char(sysdate,'yyyy-mm-dd')  ANCSTRDT, -- Fecha de inicio de la version: El lunes anterior a la primer transmisin.
          TO_CHAR (TO_NUMBER (TO_CHAR (SYSDATE, 'yyyy')) + 1) || '-01-31'
             AS ANCEDT,                                            --Fecha Fin
          d.USR_CHR AS USRCHR,                           --User Characteristic
          d.SPOT_CHR AS SPTCHR,                          --Spot Characteristic
          '00PT' AS PRDID1,                        --Tipo de Producto  -- E.PRDID
          'VR' AS VIDSRC,                         --Fuente del video (Virtual)
          'VR' AS AUDSRC,                          --Fuente del Audio (Virtual)
          d.MARCA AS BRND,                                --Marca del producto
          FV.MATLOC AS AUTOID, --Automation Id solo para Provincia (TN, JC,NL)
          '0000000' AS PROACTDAY, --Das en que se puede transmitir la Versin
          '1111111' AS ACTDAY,    --Das en que se puede transmitir la Versin
          '  ' AS Propgmid,
          '  ' AS Prostn,
          '12345678901234567890  ' AS AUX01,                     -- auxiliar 1
          '12345678901234567890  ' AS AUX02,                     -- auxiliar 2
          '12345678901234567890  ' AS AUX03,                     -- auxiliar 3
          '12345678901234567890  ' AS AUX04,                     -- auxiliar 4
          '12345678901234567890  ' AS AUX05                      -- auxiliar 5
     FROM XXMOR_SOLICITUDES_ENC_TAB E,
              XXMOR_SOLICITUDES_DET_TAB D,
              XXMOR_FZAS_VTAS_TAB FV
    WHERE E.ID_SOLICITUD = D.ID_SOLICITUD
    AND E.ID_FZA_VENTAS = FV.ID_FZA_VENTAS
    AND FV.MERCADOTECNIA = 1
    AND E.ID_SEG_NEG = 1
 ;
