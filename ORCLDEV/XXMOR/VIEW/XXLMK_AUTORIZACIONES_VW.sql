CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXLMK_AUTORIZACIONES_VW" ("ID_ORDHDR", "ID_SEG_NEG", "ID_ARCHIVO", "IND_PROC_X_LIN", "IND_GARANTIZADO", "CVE_ADVID", "CVE_MCONTID", "CVE_MCONT_CUTIN", "DES_EMAIL", "DES_REF_FOLIO", "CVE_AGYESTNUM", "CVE_ACCTHDRID", "DES_RTCRD", "DES_RTCRD_CUTIN", "DES_COMENT", "DES_SECNUM", "DES_PLAT_CANAL", "ID_PRDDES", "NUM_TOTAL_SPTS", "CAN_TOT_SIN_DESC", "CAN_TOT_CON_DESC", "DES_TIP_FACTUR", "CAN_DESC", "DES_TARGET", "CVE_MODULO", "NUM_ORD_AGEN", "DES_TARG_AFIN", "DES_TIPO_SERV", "IND_KIDS", "IND_FAV_LO_MEJOR", "NUM_GRPS_TOTALES", "NUM_EJECUCION", "DES_TIPO_ORDEN", "DES_VERSION_FICH", "FEC_CREACION", "CVE_CREADO_POR", "FEC_ACTUALIZACION", "CVE_ACTUALIZADO_POR", "CAN_INVERSION_TOTAL", "IND_TIPO_ORDEN", "IND_ESTATUS", "DES_AGRUPADOR", "ID_FZA_VENTAS", "AUTH_TM", "AUTH_CC", "AUTH_URG", "AUTH_OPLG", "NOM_ARCHIVO_SOL", "REPR_SPOTS", "AUTH_EXT") AS 
  SELECT
    ALL_ORDS.ID_ORDHDR,
    ALL_ORDS.ID_SEG_NEG,
    ALL_ORDS.ID_ARCHIVO,
    ALL_ORDS.IND_PROC_X_LIN,
    ALL_ORDS.IND_GARANTIZADO,
    ALL_ORDS.CVE_ADVID,
    ALL_ORDS.CVE_MCONTID,
    ALL_ORDS.CVE_MCONT_CUTIN,
    ALL_ORDS.DES_EMAIL,
    ALL_ORDS.DES_REF_FOLIO,
    ALL_ORDS.CVE_AGYESTNUM,
    ALL_ORDS.CVE_ACCTHDRID,
    ALL_ORDS.DES_RTCRD,
    ALL_ORDS.DES_RTCRD_CUTIN,
    ALL_ORDS.DES_COMENT,
    ALL_ORDS.DES_SECNUM,
    ALL_ORDS.DES_PLAT_CANAL,
    ALL_ORDS.ID_PRDDES,
    ALL_ORDS.NUM_TOTAL_SPTS,
    ALL_ORDS.CAN_TOT_SIN_DESC,
    ALL_ORDS.CAN_TOT_CON_DESC,
    ALL_ORDS.DES_TIP_FACTUR,
    ALL_ORDS.CAN_DESC,
    ALL_ORDS.DES_TARGET,
    ALL_ORDS.CVE_MODULO,
    ALL_ORDS.NUM_ORD_AGEN,
    ALL_ORDS.DES_TARG_AFIN,
    ALL_ORDS.DES_TIPO_SERV,
    ALL_ORDS.IND_KIDS,
    ALL_ORDS.IND_FAV_LO_MEJOR,
    ALL_ORDS.NUM_GRPS_TOTALES,
    ALL_ORDS.NUM_EJECUCION,
    ALL_ORDS.DES_TIPO_ORDEN,
    ALL_ORDS.DES_VERSION_FICH,
    ALL_ORDS.FEC_CREACION,
    ALL_ORDS.CVE_CREADO_POR,
    ALL_ORDS.FEC_ACTUALIZACION,
    ALL_ORDS.CVE_ACTUALIZADO_POR,
    ALL_ORDS.CAN_INVERSION_TOTAL,
    ALL_ORDS.IND_TIPO_ORDEN,
    ALL_ORDS.IND_ESTATUS,
    ALL_ORDS.DES_AGRUPADOR,
    ALL_ORDS.ID_FZA_VENTAS,
    ALL_ORDS.AUTH_TM,
    ALL_ORDS.AUTH_CC,
    ALL_ORDS.AUTH_URG,
    ALL_ORDS.AUTH_OPLG,
    ALL_ORDS.NOM_ARCHIVO_SOL,
    ALL_ORDS.REPR_SPOTS,
    ALL_ORDS.AUTH_EXT
FROM
    (
        SELECT
            O.ID_ORDHDR,
            O.ID_SEG_NEG,
            O.ID_ARCHIVO,
            O.IND_PROC_X_LIN,
            O.IND_GARANTIZADO,
            O.CVE_ADVID,
            O.CVE_MCONTID,
            O.CVE_MCONT_CUTIN,
            O.DES_EMAIL,
            O.DES_REF_FOLIO,
            O.CVE_AGYESTNUM,
            O.CVE_ACCTHDRID,
            O.DES_RTCRD,
            O.DES_RTCRD_CUTIN,
            O.DES_COMENT,
            O.DES_SECNUM,
            O.DES_PLAT_CANAL,
            O.ID_PRDDES,
            O.NUM_TOTAL_SPTS,
            O.CAN_TOT_SIN_DESC,
            O.CAN_TOT_CON_DESC,
            O.DES_TIP_FACTUR,
            O.CAN_DESC,
            O.DES_TARGET,
            O.CVE_MODULO,
            O.NUM_ORD_AGEN,
            O.DES_TARG_AFIN,
            O.DES_TIPO_SERV,
            O.IND_KIDS,
            O.IND_FAV_LO_MEJOR,
            O.NUM_GRPS_TOTALES,
            O.NUM_EJECUCION,
            O.DES_TIPO_ORDEN,
            O.DES_VERSION_FICH,
            O.FEC_CREACION,
            O.CVE_CREADO_POR,
            O.FEC_ACTUALIZACION,
            O.CVE_ACTUALIZADO_POR,
            O.CAN_INVERSION_TOTAL,
            O.IND_TIPO_ORDEN,
            O.IND_ESTATUS,
            O.DES_AGRUPADOR,
            O.ID_FZA_VENTAS,
            NVL(TM.AUTH, 0)   AS AUTH_TM,
            0 AS AUTH_CC,
            NVL(URG.AUTH, 0)  AS AUTH_URG,
            NVL(OPLG.AUTH, 0) AS AUTH_OPLG,
            A.NOM_ARCHIVO_SOL,
            CASE
                WHEN O.IND_ESTATUS = 8
                OR  O.IND_ESTATUS = 9.5
                OR  O.IND_ESTATUS = 20
                THEN 2
                WHEN NVL(REPR.AUTH, 0) = 1
                OR  O.IND_ESTATUS = 9.7
                THEN 1
                ELSE 0
            END                           AS REPR_SPOTS,
            NVL(EXT.AUTH, 0) AS AUTH_EXT
        FROM
            XXMOR.XXLMK_ORDHDR_TAB O
        JOIN
            XXMOR.XXLMK_ARCHIVOS_SOL_TAB A
        ON
            O.ID_ARCHIVO = A.ID_ARCHIVO_SOL
        LEFT JOIN
            (
                SELECT
                    A.ID_ORDEN,
                    1 AS AUTH
                FROM
                    XXMOR.XXLMK_AUTORIZACIONES_TAB A
                WHERE
                    A.IND_TIPO_AUT = 'TM'
                AND A.IND_ESTATUS = 1
                GROUP BY
                    ID_ORDEN) TM
        ON
            O.ID_ORDHDR = TM.ID_ORDEN
        LEFT JOIN
            (
                SELECT
                    A.ID_ORDEN,
                    1 AS AUTH
                FROM
                    XXMOR.XXLMK_AUTORIZACIONES_TAB A
                WHERE
                    A.IND_TIPO_AUT = 'URG'
                AND A.IND_ESTATUS = 1
                GROUP BY
                    ID_ORDEN) URG
        ON
            O.ID_ORDHDR = URG.ID_ORDEN
        LEFT JOIN
            (
                SELECT
                    A.ID_ORDEN,
                    1 AS AUTH
                FROM
                    XXMOR.XXLMK_AUTORIZACIONES_TAB A
                WHERE
                    A.IND_TIPO_AUT = 'OPLG'
                AND A.IND_ESTATUS = 1
                GROUP BY
                    ID_ORDEN) OPLG
        ON
            O.ID_ORDHDR = OPLG.ID_ORDEN
        LEFT JOIN
            (
                SELECT
                    A.ID_ORDEN,
                    1 AS AUTH
                FROM
                    XXMOR.XXLMK_AUTORIZACIONES_TAB A
                WHERE
                    A.IND_TIPO_AUT = 'EXT'
                AND A.IND_ESTATUS = 1
                GROUP BY
                    ID_ORDEN) EXT
        ON
            O.ID_ORDHDR = EXT.ID_ORDEN
        LEFT JOIN
            (
                SELECT
                    OL.ID_ORDHDR,
                    1 AS AUTH
                FROM
                    XXMOR.XXLMK_LINEAS_SPOTS_TAB LS
                JOIN
                    XXMOR.XXLMK_ORDLN_TAB OL
                ON
                    LS.ID_LINEA = OL.ID_LINEA
                WHERE
                    LS.IND_ESTATUS = 6
                GROUP BY
                    ID_ORDHDR) REPR
        ON
            O.ID_ORDHDR = REPR.ID_ORDHDR) ALL_ORDS
WHERE
    ALL_ORDS.AUTH_TM != 0 -- Autoriaciones Tarifa Manual
OR  ALL_ORDS.AUTH_CC != 0 -- Autoriaciones Tarifa Manual
OR  ALL_ORDS.AUTH_URG != 0 -- Autorizaciones Urgentes
OR  ALL_ORDS.AUTH_OPLG != 0 -- Autorizaciones Open Log
OR  ALL_ORDS.AUTH_EXT != 0 -- Autorizaciones Extemporaneas
OR  ALL_ORDS.REPR_SPOTS != 0 -- Reprocesos
OR  ALL_ORDS.IND_ESTATUS = 3 -- Con autorizaciones
OR  ALL_ORDS.IND_ESTATUS = 9.7 -- Error al colocar spots
OR  ALL_ORDS.IND_ESTATUS = 8 -- Reprocesando
;
