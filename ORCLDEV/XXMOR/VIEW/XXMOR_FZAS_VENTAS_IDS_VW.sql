CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_FZAS_VENTAS_IDS_VW" ("ID_SEG_NEG", "ID_FZA_VENTAS", "IDENT_FZA_VENTAS", "REGION", "AGRUPADOR", "CLIENTE", "SUFIJO", "SPTCHR", "USRCHR", "INCLUSION") AS 
  SELECT A.ID_SEG_NEG,
       A.ID_FZA_VENTAS,
       FV.IDENT_FZA_VENTAS,
       A.REGION,
       B.AGRUPADOR,
       C.CLIENTE,
       D.SUFIJO,
       SPTCHR,
       USRCHR,
       E.INCLUSION
FROM   (SELECT ID_SEG_NEG,
               ID_FZA_VENTAS,
               IDENT_FZA_TIPO,
               IDENT_FZA_VAL AS REGION
        FROM   XXMOR_FZAS_VTAS_IDENT_TAB
        WHERE  IDENT_FZA_TIPO = 'P'              --and IDENT_FZA_VAL = 'DF'
       ) A
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               IDENT_FZA_TIPO,
                               IDENT_FZA_VAL AS AGRUPADOR
                        FROM XXMOR_FZAS_VTAS_IDENT_TAB
                        WHERE IDENT_FZA_TIPO = 'G' --and IDENT_FZA_VAL is null
                       ) B
       ON  A.ID_SEG_NEG    = B.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = B.ID_FZA_VENTAS
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               IDENT_FZA_TIPO,
                               IDENT_FZA_VAL AS CLIENTE
                        FROM XXMOR_FZAS_VTAS_IDENT_TAB
                        WHERE IDENT_FZA_TIPO = 'A' --and IDENT_FZA_VAL is  null
                       ) C
       ON  A.ID_SEG_NEG    = C.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = C.ID_FZA_VENTAS
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               IDENT_FZA_TIPO,
                               IDENT_FZA_VAL AS SUFIJO
                        FROM XXMOR_FZAS_VTAS_IDENT_TAB
                        WHERE IDENT_FZA_TIPO = 'S' --and IDENT_FZA_VAL = 'CO'
                       ) D
       ON  A.ID_SEG_NEG    = D.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = D.ID_FZA_VENTAS
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               SPTCHR,
                               USRCHR,
                               INCLUSION
                        FROM XXMOR_CONF_TIPO_SRV_TAB
                        WHERE INCLUSION = 1
                       ) E
       ON  A.ID_SEG_NEG    = E.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = E.ID_FZA_VENTAS
       INNER JOIN XXMOR_FZAS_VTAS_TAB FV
       ON  A.ID_SEG_NEG    = FV.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = FV.ID_FZA_VENTAS
       AND FV.ACTIVA       = '1'
WHERE  INCLUSION IS NOT NULL
UNION
SELECT A.ID_SEG_NEG,
       A.ID_FZA_VENTAS,
       FV.IDENT_FZA_VENTAS,
       A.REGION,
       B.AGRUPADOR,
       C.CLIENTE,
       D.SUFIJO,
       SPTCHR,
       USRCHR,
       E.INCLUSION
FROM   (SELECT ID_SEG_NEG,
               ID_FZA_VENTAS,
               IDENT_FZA_TIPO,
               IDENT_FZA_VAL AS REGION
        FROM XXMOR_FZAS_VTAS_IDENT_TAB
        WHERE IDENT_FZA_TIPO = 'P'              --and IDENT_FZA_VAL = 'DF'
       ) A
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               IDENT_FZA_TIPO,
                               IDENT_FZA_VAL AS AGRUPADOR
                        FROM XXMOR_FZAS_VTAS_IDENT_TAB
                        WHERE IDENT_FZA_TIPO = 'G' --and IDENT_FZA_VAL is null
                       ) B
       ON  A.ID_SEG_NEG    = B.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = B.ID_FZA_VENTAS
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               IDENT_FZA_TIPO,
                               IDENT_FZA_VAL AS CLIENTE
                        FROM   XXMOR_FZAS_VTAS_IDENT_TAB
                        WHERE  IDENT_FZA_TIPO = 'A' --and IDENT_FZA_VAL is  null
                       ) C
       ON  A.ID_SEG_NEG    = C.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = C.ID_FZA_VENTAS
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               IDENT_FZA_TIPO,
                               IDENT_FZA_VAL AS SUFIJO
                        FROM XXMOR_FZAS_VTAS_IDENT_TAB
                        WHERE IDENT_FZA_TIPO = 'S' --and IDENT_FZA_VAL = 'CO'
                       ) D
       ON  A.ID_SEG_NEG    = D.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = D.ID_FZA_VENTAS
       LEFT OUTER JOIN (SELECT ID_SEG_NEG,
                               ID_FZA_VENTAS,
                               SPTCHR,
                               USRCHR,
                               INCLUSION
                        FROM XXMOR_CONF_TIPO_SRV_TAB
                        WHERE INCLUSION = 0
                       ) E
       ON  A.ID_SEG_NEG    = E.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = E.ID_FZA_VENTAS
       INNER JOIN XXMOR_FZAS_VTAS_TAB FV
       ON  A.ID_SEG_NEG    = FV.ID_SEG_NEG
       AND A.ID_FZA_VENTAS = FV.ID_FZA_VENTAS
       AND FV.ACTIVA       = '1'
WHERE  INCLUSION IS NOT NULL;
