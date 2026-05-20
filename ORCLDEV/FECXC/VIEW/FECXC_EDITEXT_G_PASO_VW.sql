CREATE OR REPLACE FORCE EDITIONABLE VIEW "FECXC"."FECXC_EDITEXT_G_PASO_VW" ("DIVISION_DESC", "COBRANZA_DIA", "COBRANZA_MES", "PRESUP_MES", "VARIACION_MES", "PERC_MES", "COBRANZA_ALAFECHA", "PRESUP_ALAFECHA", "VARIACION_ALAFECHA", "PERC_ALAFECHA", "COBRANZA_ANTERIOR", "VARIACION_ANTERIOR", "PERC_ANTERIOR") AS 
  SELECT DIVISION_DESC,
            SUM (COBRANZA_DIA) COBRANZA_DIA,
            SUM (COBRANZA_MES) COBRANZA_MES,
            SUM (PRESUP_MES) PRESUP_MES,
            SUM (VARIACION_MES) VARIACION_MES,
              CASE
                         WHEN SUM(PRESUP_MES) = 0 THEN 0
                         ELSE
                       ((SUM (cobranza_mes) - SUM (presup_mes)) / SUM (presup_mes) )* 100
                      END
            PERC_MES,
            SUM (COBRANZA_ALAFECHA) COBRANZA_ALAFECHA,
            SUM (PRESUP_ALAFECHA) PRESUP_ALAFECHA,
            SUM (VARIACION_ALAFECHA) VARIACION_ALAFECHA,
              CASE
                 WHEN SUM(PRESUP_ALAFECHA) = 0
                 THEN
                    0
                 ELSE
                   ((SUM (cobranza_alafecha) - SUM (presup_alafecha)) / SUM (presup_alafecha)) * 100
              END
            PERC_ALAFECHA,
            SUM (COBRANZA_ANTERIOR) COBRANZA_ANTERIOR,
            SUM (VARIACION_ANTERIOR) VARIACION_ANTERIOR,
              CASE
                 WHEN SUM(COBRANZA_ANTERIOR) = 0
                 THEN
                    0
                 ELSE
                   ((SUM (cobranza_alafecha) - SUM (cobranza_anterior)) / SUM (cobranza_anterior)) *100
              END
            PERC_ANTERIOR
       FROM (  SELECT DISTINCT
                      DIVISION_DESC,
                      COBRANZA_DIA,
                      COBRANZA_MES,
                      PRESUP_MES,
                      (COBRANZA_MES - PRESUP_MES) VARIACION_MES,
                      COBRANZA_ALAFECHA,
                      PRESUP_ALAFECHA,
                      (COBRANZA_ALAFECHA - PRESUP_ALAFECHA) VARIACION_ALAFECHA,
                      COBRANZA_ANTERIOR,
                      (COBRANZA_ALAFECHA - COBRANZA_ANTERIOR) VARIACION_ANTERIOR
                  FROM FECXC.FECXC_EDITEXT_DET_REP
                WHERE DIVISION IN
                         (SELECT COD_SEC_LIN
                            FROM FECXC.FECXC_DET_CATALOGOS
                           WHERE TIPO_CAT = 'DIVISION' AND REP_EDIT_EXT = 1)
             ORDER BY DIVISION_DESC)
                GROUP BY CUBE (DIVISION_DESC)
   ORDER BY DIVISION_DESC ;
