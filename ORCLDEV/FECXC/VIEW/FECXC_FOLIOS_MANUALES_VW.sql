CREATE OR REPLACE FORCE EDITIONABLE VIEW "FECXC"."FECXC_FOLIOS_MANUALES_VW" ("COD_SEC", "F_DEPOSITO", "EMPRESA", "DES_EMPRESA", "REFCLIENTE", "CODBANCOR", "CODFOLIO", "NCHEQUERA", "CONCEPTO", "TIPOCAMBIO", "CODMONEDA", "DESMONEDA", "NOM_BENE", "TIPOCLIENTE", "TIPOPLAN", "CODBANCOE", "NUMCHEQUE", "FORMAPAGO", "IMPORTE", "CUSTOMER_ID", "SEGMENTO1") AS 
  SELECT /*+ USE_NL (A B C D) */
       A.COD_SEC_IMPORTA                 AS COD_SEC,
       A.F_DEPOSITO                      AS F_DEPOSITO,
       A.E_CODIGO                        AS EMPRESA,
       C.DES_EMPRESA                     AS DES_EMPRESA,
       A.REFECLIENTE                     AS REFCLIENTE,
       A.CODBANCOR                       AS CODBANCOR,
       A.CODFOLIO                        AS CODFOLIO,
       A.NCHEQUERA                       AS NCHEQUERA,
       A.CONCEPTO                        AS CONCEPTO,
       A.TIPOCAMBIO                      AS TIPOCAMBIO,
       B.CODMONEDA                       AS CODMONEDA,
       B.DESMONEDA                       AS DESMONEDA,
       A.NOM_BENE                        AS NOM_BENE,
       NVL (A.TIPOCLIENTE,'No definido') AS TIPOCLIENTE,
       NVL (A.TIPOPLAN,'No definido')    AS TIPOPLAN,
       A.CODBANCOE                       AS CODBANCOE,
       A.NUMCHEQUE                       AS NUMCHEQUE,
       A.FORMAPAGO                       AS FORMAPAGO,
       A.IMPORTE                         AS IMPORTE,
       A.CUSTOMER_ID                     AS CUSTOMER_ID,
       D.SEGMENTO1                       AS SEGMENTO1
FROM   FECXC_ENC_IMPGES   A,
       FECXC_MONEDAS      B,
       FECXC_EMPRESAS     C,
       FECXC_DET_IMPGES   D
WHERE  1                  = 1
  AND  A.SECMONEDA        = B.SECMONEDA
  AND  A.E_CODIGO         = C.E_CODIGO
  AND  A.COD_SEC_IMPORTA  = D.COD_SEC_IMPORTA(+)
  AND  A.E_CODIGO         = D.E_CODIGO(+)
UNION
SELECT /*+ USE_NL (A B C D) */
       A.COD_SEC_CLASIFICA          AS COD_SEC,
       A.F_DEPOSITO                      AS F_DEPOSITO,
       A.E_CODIGO                        AS EMPRESA,
       C.DES_EMPRESA                     AS DES_EMPRESA,
       A.REFECLIENTE                     AS REFCLIENTE,
       A.CODBANCOR                       AS CODBANCOR,
       A.CODFOLIO                        AS CODFOLIO,
       A.NCHEQUERA                       AS NCHEQUERA,
       A.CONCEPTO                        AS CONCEPTO,
       A.TIPOCAMBIO                      AS TIPOCAMBIO,
       B.CODMONEDA                       AS CODMONEDA,
       B.DESMONEDA                       AS DESMONEDA,
       A.NOM_BENE                        AS NOM_BENE,
       NVL (A.TIPOCLIENTE,'No definido') AS TIPOCLIENTE,
       NVL (A.TIPOPLAN,'No definido')    AS TIPOPLAN,
       A.CODBANCOE                       AS CODBANCOE,
       A.NUMCHEQUE                       AS NUMCHEQUE,
       A.FORMAPAGO                       AS FORMAPAGO,
       A.IMPORTE                         AS IMPORTE,
       A.CUSTOMER_ID                     AS CUSTOMER_ID,
       D.SEGMENTO1                       AS SEGMENTO1
FROM   FECXC_ENC_CLASIFICADOS A,
       FECXC_MONEDAS          B,
       FECXC_EMPRESAS         C,
       FECXC_DET_CLASIFICADOS D
WHERE  1                   = 1
AND    A.SECMONEDA         = B.SECMONEDA
AND    A.E_CODIGO          = C.E_CODIGO
AND    A.E_CODIGO          = D.E_CODIGO(+)
AND    A.COD_SEC_CLASIFICA = D.COD_SEC_CLASIFICA(+);
