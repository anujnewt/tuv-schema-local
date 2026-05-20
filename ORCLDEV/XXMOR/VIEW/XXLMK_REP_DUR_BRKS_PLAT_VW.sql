CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXLMK_REP_DUR_BRKS_PLAT_VW" ("ID_AJUSTE_BREAKS", "ID_CANAL", "NUM_BREAK", "DES_CAN_PSP", "IND_NIVEL", "DES_NIVEL", "NUM_BREK_NOM_TIME", "NUM_VENTA", "NUM_CAPACIDAD_INI", "VENTA_PLAT", "NUM_AJUSTE", "DES_VENTA", "DES_CAPACIDAD_INI", "DES_VENTA_PLAT", "DES_AJUSTE", "PLAT", "MIN_BRK_TIME", "NUM_DURACION", "DES_DURACION", "CAPACIDAD_PLAT", "DES_CAPACIDAD_PLAT", "ID_GRUPO") AS 
  SELECT
    ID_AJUSTE_BREAKS,
    ID_CANAL,
    NUM_BREAK,
    DES_CAN_PSP,
    IND_NIVEL,
    DECODE(IND_NIVEL, 1, 'Network', 2, 'Nacional', 3, 'Regional', 4, 'Nacional', '') AS DES_NIVEL,
    NUM_BREK_NOM_TIME,
    NUM_VENTA,
    NUM_CAPACIDAD_INI,
    VENTA_PLAT,
    NUM_AJUSTE,
    TO_CHAR(TO_DATE(NUM_VENTA, 'sssss'), 'hh24:mi:ss')         AS DES_VENTA,
    TO_CHAR(TO_DATE(NUM_CAPACIDAD_INI, 'sssss'), 'hh24:mi:ss') AS DES_CAPACIDAD_INI,
    TO_CHAR(TO_DATE(VENTA_PLAT, 'sssss'), 'hh24:mi:ss')        AS DES_VENTA_PLAT,
    CASE
        WHEN NUM_AJUSTE < 0
        THEN NUM_AJUSTE||''
        ELSE TO_CHAR(TO_DATE(NUM_AJUSTE, 'sssss'), 'hh24:mi:ss')
    END AS DES_AJUSTE,
    PLAT,
    MIN_BRK_TIME,
    XXMOR.XXLMK_ORDLMK_PKG.XXLMK_CAN_DUR_EXEPT_CONF_FUN(ID_AJUSTE_BREAKS, ID_GRUPO, NUM_BREAK_BASE)
    AS DURACION,
    XXMOR.XXLMK_ORDLMK_PKG.XXLMK_CAN_DUR_EXEPT_FMT_FUN(ID_AJUSTE_BREAKS, ID_GRUPO, NUM_BREAK_BASE)
    AS DES_DURACION,
    CAPACIDAD_PLAT,
    TO_CHAR(TO_DATE(NVL(CAPACIDAD_PLAT, 0), 'sssss'), 'hh24:mi:ss') AS DES_CAPACIDAD_PLAT,
    ID_GRUPO
FROM
    (
        SELECT
            ABV.ID_AJUSTE_BREAKS,
            ABV.ID_CANAL,
            ABV.NUM_BREAK,
            CL.DES_CAN_PSP,
            CL.IND_NIVEL,
            DURS.BREAK_TIME,
            ABV.NUM_BREK_NOM_TIME,
            ABV.NUM_CAPACIDAD_INI,
            ABV.NUM_VENTA,
            ABV.NUM_AJUSTE,
            DURS.VENTA_PLAT,
            'Izzi' AS PLAT,
            DURS.MIN_BRK_TIME,
            NVL(ADC.NUM_DUR_CONF, NVL(GC.NUM_DURACION, 0)) AS NUM_DURACION,
            DURS.CAPACIDAD_PLAT,
            GC.ID_GRUPO,
            ABV.NUM_BREAK_BASE
        FROM
            XXMOR.XXLMK_AJUS_BRKS_VALS_TAB ABV
        JOIN
            XXMOR.XXLMK_GRUP_CAN_NIV_TAB GCN
        ON
            ABV.ID_CANAL = GCN.ID_CANAL
        JOIN
            XXMOR.XXLMK_GRUPOS_CANALES_TAB GC
        ON
            GCN.ID_GRUPO = GC.ID_GRUPO
        JOIN
            XXMOR.XXLMK_CANALES_LMK_TAB CL
        ON
            ABV.ID_CANAL = CL.ID_CANAL
        LEFT JOIN
            XXMOR.XXLMK_AJUS_DUR_CONF_GRP_TAB ADC
        ON
            ABV.ID_AJUSTE_BREAKS = ADC.ID_AJUSTE_BREAKS
        AND ADC.ID_GRUPO = GC.ID_GRUPO
        AND ADC.NUM_BREAK_TIME = ABV.NUM_BREAK_BASE
        JOIN
            (
                SELECT
                    GCN.ID_GRUPO,
                    ABV.NUM_BREAK_BASE AS BREAK_TIME,
                    ABV.ID_AJUSTE_BREAKS,
                    SUM(ABV.NUM_VENTA)         AS VENTA_PLAT,
                    MIN(ABV.NUM_BREK_NOM_TIME) AS MIN_BRK_TIME,
                    SUM(ABV.NUM_CAPACIDAD_INI) AS CAPACIDAD_PLAT
                FROM
                    XXMOR.XXLMK_AJUS_BRKS_VALS_TAB ABV
                JOIN
                    XXMOR.XXLMK_GRUP_CAN_NIV_TAB GCN
                ON
                    ABV.ID_CANAL = GCN.ID_CANAL
                JOIN
                    XXMOR.XXLMK_CANALES_LMK_TAB CL
                ON
                    ABV.ID_CANAL = CL.ID_CANAL
                WHERE
                    CL.IND_NIVEL IN (1,
                                     2,
                                     3)
                GROUP BY
                    GCN.ID_GRUPO,
                    ABV.ID_AJUSTE_BREAKS,
                    ABV.NUM_BREAK_BASE) DURS
        ON
            ABV.ID_AJUSTE_BREAKS = DURS.ID_AJUSTE_BREAKS
        AND GCN.ID_GRUPO = DURS.ID_GRUPO
        AND ABV.NUM_BREAK_BASE = DURS.BREAK_TIME
        WHERE
            CL.IND_NIVEL IN (1,
                             2,
                             3)
        UNION
        SELECT
            ABV.ID_AJUSTE_BREAKS,
            ABV.ID_CANAL,
            ABV.NUM_BREAK,
            CL.DES_CAN_PSP,
            CL.IND_NIVEL,
            DURS.BREAK_TIME,
            ABV.NUM_BREK_NOM_TIME,
            ABV.NUM_CAPACIDAD_INI,
            ABV.NUM_VENTA,
            ABV.NUM_AJUSTE,
            DURS.VENTA_PLAT,
            'Sky' AS PLAT,
            DURS.MIN_BRK_TIME,
            NVL(ADC.NUM_DUR_CONF, NVL(GC.NUM_DURACION, 0)) AS NUM_DURACION,
            DURS.CAPACIDAD_PLAT,
            GC.ID_GRUPO,
            ABV.NUM_BREAK_BASE
        FROM
            XXMOR.XXLMK_AJUS_BRKS_VALS_TAB ABV
        JOIN
            XXMOR.XXLMK_GRUP_CAN_NIV_TAB GCN
        ON
            ABV.ID_CANAL = GCN.ID_CANAL
        JOIN
            XXMOR.XXLMK_GRUPOS_CANALES_TAB GC
        ON
            GCN.ID_GRUPO = GC.ID_GRUPO
        JOIN
            XXMOR.XXLMK_CANALES_LMK_TAB CL
        ON
            ABV.ID_CANAL = CL.ID_CANAL
        LEFT JOIN
            XXMOR.XXLMK_AJUS_DUR_CONF_GRP_TAB ADC
        ON
            ABV.ID_AJUSTE_BREAKS = ADC.ID_AJUSTE_BREAKS
        AND ADC.ID_GRUPO = GC.ID_GRUPO
        AND ADC.NUM_BREAK_TIME = ABV.NUM_BREAK_BASE
        JOIN
            (
                SELECT
                    GCN.ID_GRUPO,
                    NUM_BREAK_BASE AS BREAK_TIME,
                    ABV.ID_AJUSTE_BREAKS,
                    SUM(ABV.NUM_VENTA)         AS VENTA_PLAT,
                    MIN(ABV.NUM_BREK_NOM_TIME) AS MIN_BRK_TIME,
                    SUM(ABV.NUM_CAPACIDAD_INI) AS CAPACIDAD_PLAT
                FROM
                    XXMOR.XXLMK_AJUS_BRKS_VALS_TAB ABV
                JOIN
                    XXMOR.XXLMK_GRUP_CAN_NIV_TAB GCN
                ON
                    ABV.ID_CANAL = GCN.ID_CANAL
                JOIN
                    XXMOR.XXLMK_CANALES_LMK_TAB CL
                ON
                    ABV.ID_CANAL = CL.ID_CANAL
                WHERE
                    CL.IND_NIVEL IN (1,
                                     4)
                GROUP BY
                    GCN.ID_GRUPO,
                    ABV.ID_AJUSTE_BREAKS,
                    ABV.NUM_BREAK_BASE) DURS
        ON
            ABV.ID_AJUSTE_BREAKS = DURS.ID_AJUSTE_BREAKS
        AND GCN.ID_GRUPO = DURS.ID_GRUPO
        AND ABV.NUM_BREAK_BASE = DURS.BREAK_TIME
        WHERE
            CL.IND_NIVEL IN (1,
                             4) )
ORDER BY
    ID_AJUSTE_BREAKS,
    ID_GRUPO,
    BREAK_TIME,
    PLAT,
    NUM_BREK_NOM_TIME,
    IND_NIVEL;
