CREATE OR REPLACE EDITIONABLE PACKAGE "FECXC"."FECXC_FOLIOS_MANUALES_PKG" as
/*===============================================================
FILE NAME : fecxc_folios_manuales_pkg.pks
NOMBRE DEL M?DULO     : FECXC
CREATED DATE          : 01-Ene-2013
AUTHOR(S)             : Jesus Argumedo
SHORT DESCRIPTION     : Este paquete contiene procedimientos y funciones
                        necesarias para la generaci?n del reporte soporte folios manuales
                        COBRANZA FILIALES,RECLA DE INGRESO, OTROS
PROCEDURES CONTAINS   :
                      fecxc_fill_folmanuales_pr
                      FECXC_FILL_FOLMANUALES_FN
                      FECXC_GET_SUBCLASIF_FN
RELATED DOCUMENTS   : An?lisis y dise?o funcional
=============================================================== */
--Procedure Recla de Ingreso
procedure FECXC_FILL_FOLMANUALES_PR (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    );
--Procedure Cobranza Filiales
procedure FECXC_FILL_FOLMANUALES2_PR (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     pistmesinicial       in varchar2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                     );
--Procedure Otros
procedure FECXC_FILL_FOLMANUALES3_PR (
                                     pistsegmento         in varchar2,
                                     PISTMONEDA           IN VARCHAR2,
                                     PISTANIO             IN VARCHAR2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    );
--Procedure Traspasos
procedure FECXC_FILL_FOLMANUALES4_PR (
                                     pistsegmento         in varchar2,
                                     PISTMONEDA           IN VARCHAR2,
                                     PISTANIO             IN VARCHAR2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    );
--Funcion Cobranza Filiales y Otros
function FECXC_FILL_FOLMANUALES_FN (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     PISTANIO             IN VARCHAR2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )
RETURN VARCHAR2;
--Funcion Traspasos
function FECXC_FILL_FOLMANUALES2_FN (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     PISTANIO             IN VARCHAR2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )
RETURN VARCHAR2;
--Funcion Recla de Ingreso
function FECXC_FILL_FOLMANUALES3_FN (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     PISTANIO             IN VARCHAR2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )
RETURN VARCHAR2;
function FECXC_GET_SUBCLASIF_FN (
                                  PIINFOLIO    number
                                 )
RETURN VARCHAR2;
FUNCTION FECXC_GET_SUBCLASIF_IVA_FN (
                                      PIINFOLIO_MANUAL    NUMBER,
                                      pistsegmento         in varchar2
                                    )
RETURN NUMBER;
FUNCTION FECXC_GET_SUBCLASIF_IVA_INT_FN (
                                      PIINFOLIO_MANUAL    NUMBER,
                                      pistsegmento         in varchar2
                                    )
RETURN NUMBER;
FUNCTION FECXC_GET_SUBCLASIF_BASE_FN (
                                      PIINFOLIO_MANUAL    NUMBER,
                                      pistsegmento         in varchar2
                                    )
RETURN NUMBER;
FUNCTION FECXC_GET_SUBCLASIF_BASE_4_FN (
                                      PIINFOLIO_MANUAL    NUMBER,
                                      pistsegmento         in varchar2
                                    )
RETURN NUMBER;
FUNCTION FECXC_GET_SUBCLASIF_OTROS_FN (
                                      PIINFOLIO_MANUAL    NUMBER,
                                      pistsegmento         in varchar2
                                    )
RETURN NUMBER;
FUNCTION FECXC_GET_SUBCLASIF_OTROS_2_FN (
                                      PIINFOLIO_MANUAL    NUMBER,
                                      pistsegmento         in varchar2
                                    )
RETURN NUMBER;
END;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "FECXC"."FECXC_FOLIOS_MANUALES_PKG" AS
  procedure fecxc_fill_folmanuales_pr (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    ) is
      PRAGMA AUTONOMOUS_TRANSACTION;
      linE_codigo            NUMBER;
      lincod_sec_clasifica   NUMBER;
      lin_importe            NUMBER;
      life_f_deposito        DATE;
      list_nom_bene          VARCHAR2(150);
      licont                 NUMBER := 0;
  CURSOR CURFOLIOREAL IS
      SELECT DISTINCT TRIM(substr(a.concepto,0,instr(a.concepto, ' '))) as folio_real
            FROM FECXC_FOLIOS_MANUALES_VW A,FECXC_DET_CATALOGOS B
              WHERE 1=1--A.EMPRESA = 3868
              AND B.COD_SEC_LIN = a.SEGMENTO1
              AND B.TIPO_CAT = 'SEGMENTO'
              AND A.CODFOLIO < 0
              AND B.COD_VALOR = pistsegmento --argumel
              AND a.CONCEPTO like '%RECLA%INGRESO%'
              AND CODMONEDA = pistmoneda
              AND TO_CHAR(a.F_DEPOSITO,'MM') between pistmesinicial and pistmesfinal
              AND TO_CHAR(A.F_DEPOSITO,'YYYY') = PISTANIO
              AND FECXC_DIVXPERIODO_PKG.ISNUMERIC_FN(NVL(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')),'DUMMY')) = 1;
              --AND TRIM(substr(A.concepto,0,instr(A.concepto, ' '))) NOT IN(33403454,33627798)
              --AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) NOT IN (SELECT NUM_FOLIO_REAL FROM FECXC_FMANUAL_OUT_TAB);
  BEGIN
    BEGIN
  IF PINREGISTRO = 1
  THEN
    DELETE FECXC_FMANUAL_OUT_TAB;
    COMMIT;
  END IF;
     FOR I IN CURFOLIOREAL
    LOOP
      LINE_CODIGO := NULL;
      LINCOD_SEC_CLASIFICA := NULL;
      LIN_IMPORTE := NULL;
      LIFE_F_DEPOSITO := NULL;
      LIST_NOM_BENE := NULL;
     licont := licont+100;
       BEGIN
              SELECT A.E_CODIGO,
                     A.COD_SEC_CLASIFICA,
                     A.IMPORTE,
                     A.F_DEPOSITO ,
                     A.NOM_BENE
              INTO linE_codigo,
                   lincod_sec_clasifica,
                   lin_importe,
                   life_f_deposito,
                   list_nom_bene
              FROM FECXC_ENC_CLASIFICADOS A
              WHERE CODFOLIO = I.FOLIO_REAL;
        EXCEPTION WHEN NO_DATA_FOUND
        THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_FILL_FOLMANUALES_PR Folio: '||I.FOLIO_REAL);
        END;
--      AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) NOT IN (SELECT NUM_FOLIO_REAL FROM FECXC_FMANUAL_OUT_TAB);
      INSERT INTO FECXC_FMANUAL_OUT_TAB (
                  NUM_ECODIGO,
                  COD_SEC_CLASIFICA,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                SELECT A.E_CODIGO,
                       COD_SEC_CLASIFICA,
                       licont,
                       I.folio_real,
                       life_f_deposito,
                       NULL,
                       CASE WHEN COD_SUBCLASIF = 'BASE' THEN IMPORTE  END,
                       CASE WHEN COD_SUBCLASIF IN ('OTROS','INTERCAMBI','INTERIVA','OTROSING') THEN IMPORTE  END,
                       CASE WHEN COD_SUBCLASIF = 'IVA' THEN IMPORTE  END,
                       list_nom_bene,
                       --N_LINEA_CLAS,
                       lin_importe,
                       D.DESC_VALOR,
                       SYSDATE
                FROM FECXC_DET_CLASIFICADOS A,
                     FECXC_DET_CLASFECXC B,
                     FECXC_ENC_CLASFECXC C,
                     FECXC_DET_CATALOGOS D
                    WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                    AND A.COD_SEC_DET       = B.COD_SEC_DET
                    AND A.COD_SEC_CATCLAS   = C.COD_SEC_CATCLAS
                    AND A.SEGMENTO1         = D.COD_SEC_LIN(+)
                    AND E_CODIGO            =LINE_CODIGO
                    AND COD_SEC_CLASIFICA   =LINCOD_SEC_CLASIFICA
                    AND LINCOD_SEC_CLASIFICA NOT IN (SELECT COD_SEC_CLASIFICA FROM FECXC_FMANUAL_OUT_TAB);
/*******************************************************************************/
               licont := licont+1;
          INSERT INTO FECXC_FMANUAL_OUT_TAB (
                  NUM_ECODIGO,
                  COD_SEC_CLASIFICA,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                  SELECT A.EMPRESA,
                         A.COD_SEC,
                         LICONT,
                         SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')),
                         A.F_DEPOSITO,
                         A.codfolio,
                         FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_BASE_FN(A.CODFOLIO,pistsegmento),
                         FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_OTROS_FN(A.CODFOLIO,pistsegmento),
                         FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_IVA_FN(A.CODFOLIO,pistsegmento),
                         A.NOM_BENE,
                         lin_importe,
                         B.DESC_VALOR,
                         SYSDATE
                  FROM FECXC_FOLIOS_MANUALES_VW A,FECXC_DET_CATALOGOS B
                  where 1=1--A.EMPRESA = 3868
                  and B.COD_SEC_LIN = a.SEGMENTO1
                  and B.TIPO_CAT = 'SEGMENTO'
                  AND A.CODFOLIO < 0
                  and B.COD_VALOR = pistsegmento
                  and a.CONCEPTO like '%RECLA%INGRESO%'
                  and CODMONEDA = pistmoneda
                  and TO_CHAR(a.F_DEPOSITO,'MM') between pistmesinicial and pistmesfinal
                  AND TO_CHAR(A.F_DEPOSITO,'YYYY') = PISTANIO
                  and trim(SUBSTR(a.CONCEPTO,0,INSTR(a.CONCEPTO, ' '))) = I.folio_real
                  AND fecxc_divxperiodo_pkg.isnumeric_fn(nvl(substr(A.concepto,0,instr(A.concepto, ' ')),'DUMMY')) = 1;
    END LOOP;
    COMMIT;
    EXCEPTION
    WHEN OTHERS
    THEN
      dbms_output.put_line('Error: '||sqlerrm);
    ROLLBACK;
    END;
  END fecxc_fill_folmanuales_pr;
function fecxc_fill_folmanuales_fn (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )
return varchar2
is
    lstposterrbuf       varchar2(2000);
    lstPostRetcode      VARCHAR2(30);
  BEGIN
   FECXC_FILL_FOLMANUALES2_PR (
                                          pistsegmento,
                                          pistmoneda,
                                          pistanio,
                                          pistmesinicial,
                                          PISTMESFINAL,
                                          PINREGISTRO
                              );
  FECXC_FILL_FOLMANUALES3_PR (
                                         pistsegmento   ,
                                         pistmoneda,
                                         PISTANIO ,
                                         PISTMESINICIAL ,
                                         PISTMESFINAL ,
                                         PINREGISTRO
                             );
   -- RETURN NVL(lstPostErrbuf, 'OK');
   RETURN TO_CHAR(PINREGISTRO);
EXCEPTION
    WHEN OTHERS
    THEN
        return 'Error: ' || sqlerrm;
END fecxc_fill_folmanuales_fn;
---------------------------------------------------
function FECXC_FILL_FOLMANUALES2_FN (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )
return varchar2
is
    lstposterrbuf       varchar2(2000);
    lstPostRetcode      VARCHAR2(30);
  BEGIN
FECXC_FILL_FOLMANUALES4_PR (
                                         pistsegmento   ,
                                         pistmoneda,
                                         PISTANIO ,
                                         PISTMESINICIAL ,
                                         PISTMESFINAL ,
                                         PINREGISTRO
                             );
   -- RETURN NVL(lstPostErrbuf, 'OK');
   RETURN TO_CHAR(PINREGISTRO);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'Error: ' || sqlerrm;
END FECXC_FILL_FOLMANUALES2_FN;
---------------------------------------------------
--------------------------------------------------
function fecxc_fill_folmanuales3_fn (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )
return varchar2
is
    lstposterrbuf       varchar2(2000);
    lstPostRetcode      VARCHAR2(30);
  BEGIN
    FECXC_FILL_FOLMANUALES_PR (
                                            pistsegmento,
                                            pistmoneda,
                                            pistanio,
                                            PISTMESINICIAL,
                                            PISTMESFINAL,
                                            PINREGISTRO
                              );
   -- RETURN NVL(lstPostErrbuf, 'OK');
   RETURN TO_CHAR(PINREGISTRO);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'Error: ' || sqlerrm;
END fecxc_fill_folmanuales3_fn;
-------------------------------------------------
  procedure FECXC_FILL_FOLMANUALES2_PR (
                                         pistsegmento         in varchar2,
                                         pistmoneda           in varchar2,
                                         pistanio             in varchar2,
                                         pistmesinicial       in varchar2,
                                         PISTMESFINAL         IN VARCHAR2,
                                         PINREGISTRO          NUMBER
                                       ) is
      PRAGMA AUTONOMOUS_TRANSACTION;
      linE_codigo            NUMBER;
      lincod_sec_clasifica   NUMBER;
      lin_importe            NUMBER;
      life_f_deposito        DATE;
      list_nom_bene          VARCHAR2(150);
      licont                 NUMBER := 0;
  CURSOR CURFOLIOREAL IS
      SELECT DISTINCT TRIM(substr(a.concepto,0,instr(a.concepto, ' '))) as folio_real
            FROM FECXC_FOLIOS_MANUALES_VW A,FECXC_DET_CATALOGOS B
              WHERE 1=1--A.EMPRESA = 3868
              AND B.COD_SEC_LIN = a.SEGMENTO1
              AND B.TIPO_CAT = 'SEGMENTO'
              AND A.CODFOLIO < 0
              AND B.COD_VALOR = pistsegmento --argumel
              AND a.CONCEPTO like '%COB FILIALES%'
              AND CODMONEDA = pistmoneda
              AND TO_CHAR(a.F_DEPOSITO,'MM') between pistmesinicial and pistmesfinal
              AND TO_CHAR(A.F_DEPOSITO,'YYYY') = PISTANIO
              AND FECXC_DIVXPERIODO_PKG.ISNUMERIC_FN(NVL(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')),'DUMMY')) = 1;
              --AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) NOT IN (SELECT NUM_FOLIO_REAL FROM FECXC_FMANUAL_OUT2_TAB);
  BEGIN
  IF PINREGISTRO = 1
  THEN
    DELETE FECXC_FMANUAL_OUT2_TAB;
    COMMIT;
  END IF;
     FOR I IN CURFOLIOREAL
    LOOP
      LINE_CODIGO := NULL;
      LINCOD_SEC_CLASIFICA := NULL;
      LIN_IMPORTE := NULL;
      LIFE_F_DEPOSITO := NULL;
      LIST_NOM_BENE := NULL;
     LICONT := LICONT+1;
      BEGIN
            SELECT A.E_CODIGO,
                   A.COD_SEC_CLASIFICA,
                   A.IMPORTE,
                   A.F_DEPOSITO ,
                   A.NOM_BENE
            INTO linE_codigo,
                 lincod_sec_clasifica,
                 lin_importe,
                 life_f_deposito,
                 list_nom_bene
            FROM FECXC_ENC_CLASIFICADOS A
            WHERE CODFOLIO =I.FOLIO_REAL;
     EXCEPTION WHEN NO_DATA_FOUND
      THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_FILL_FOLMANUALES2_PR Folio: '||I.FOLIO_REAL);
      END;
      INSERT INTO FECXC_FMANUAL_OUT2_TAB (
                  NUM_ECODIGO,
                  COD_SEC_CLASIFICA,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                SELECT A.E_CODIGO,
                       COD_SEC_CLASIFICA,
                       licont,
                       I.folio_real,
                       life_f_deposito,
                       NULL,
                       CASE WHEN COD_SUBCLASIF = 'BASE' THEN IMPORTE  END,
                       CASE WHEN COD_SUBCLASIF IN ('OTROS','INTERCAMBI','INTERIVA','OTROSING') THEN IMPORTE  END,
                       CASE WHEN COD_SUBCLASIF = 'IVA' THEN IMPORTE  END,
                       list_nom_bene,
                       lin_importe,
                       D.DESC_VALOR,
                       SYSDATE
                  FROM FECXC_DET_CLASIFICADOS A,
                     FECXC_DET_CLASFECXC B,
                     FECXC_ENC_CLASFECXC C,
                     FECXC_DET_CATALOGOS D
                    WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
AND A.COD_SEC_DET       = B.COD_SEC_DET
AND A.COD_SEC_CATCLAS   = C.COD_SEC_CATCLAS
AND A.SEGMENTO1         = D.COD_SEC_LIN(+)
AND E_CODIGO            =linE_codigo
AND COD_SEC_CLASIFICA   =LINCOD_SEC_CLASIFICA;
/*******************************************************************************/
          INSERT INTO FECXC_FMANUAL_OUT2_TAB (
                  NUM_ECODIGO,
                  COD_SEC_CLASIFICA,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                  SELECT A.EMPRESA,
                         A.COD_SEC,
                         LICONT,
                         trim(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))),
                         A.F_DEPOSITO,
                         A.CODFOLIO,
                          FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_BASE_FN(A.CODFOLIO,pistsegmento),
                          FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_OTROS_FN(A.CODFOLIO,pistsegmento),
                          FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_IVA_FN(A.CODFOLIO,pistsegmento),
                         A.nom_bene,
                         (  SELECT SUM(nvl(X.IMPORTE,0)) IMPORTE
                            FROM FECXC_FOLIOS_MANUALES_VW X
                            WHERE X.CODFOLIO = TO_NUMBER(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')))
                            and X.CODFOLIO > 0
                            GROUP BY X.CODFOLIO
                         )AS IMPORTE_FOLIO_REAL,
                         B.DESC_VALOR,
                         SYSDATE
                  FROM FECXC_FOLIOS_MANUALES_VW A,FECXC_DET_CATALOGOS B
                  where 1=1--A.EMPRESA = 3868
                  and B.COD_SEC_LIN = a.SEGMENTO1
                  and B.TIPO_CAT = 'SEGMENTO'
                  AND A.CODFOLIO < 0
                  and B.COD_VALOR = pistsegmento
                  and a.CONCEPTO like '%COB FILIALES%'
                  --AND B.DESC_VALOR = ''
                  and CODMONEDA = pistmoneda
                  and TO_CHAR(a.F_DEPOSITO,'MM') between pistmesinicial and pistmesfinal
                  AND TO_CHAR(A.F_DEPOSITO,'YYYY') = PISTANIO
                  AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) = I.FOLIO_REAL
                  AND FECXC_DIVXPERIODO_PKG.ISNUMERIC_FN(NVL(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')),'DUMMY')) = 1;
                  --AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) NOT IN (SELECT NUM_FOLIO_REAL FROM FECXC_FMANUAL_OUT2_TAB);
    END LOOP;
  COMMIT;
    EXCEPTION
    WHEN OTHERS
    THEN
        --postErrbuf  :=  SQLERRM;
        --postRetcode :=  SQLCODE;
        dbms_output.put_line('Error:'||TO_CHAR(SQLCODE));
        dbms_output.put_line(sqlerrm);
        ROLLBACK;
  END FECXC_FILL_FOLMANUALES2_PR;
  procedure FECXC_FILL_FOLMANUALES3_PR (
                                     pistsegmento         in varchar2,
                                     PISTMONEDA           IN VARCHAR2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    )IS
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
IF PINREGISTRO = 1
  THEN
    DELETE FECXC_FMANUAL_OUT3_TAB;
    COMMIT;
  END IF;
 INSERT INTO FECXC_FMANUAL_OUT3_TAB (
                  COD_SEC_CLASIFICA,
                  NUM_ECODIGO,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                    SELECT  DISTINCT A.COD_SEC_CLASIFICA,
                            E.E_CODIGO ,
                            0,
                            0,
                            E.F_DEPOSITO,
                           E.CODFOLIO ,
                            E.IMPORTE,
                            FECXC_GET_SUBCLASIF_OTROS_2_FN(E.CODFOLIO,pistsegmento),
                            FECXC_GET_SUBCLASIF_IVA_INT_FN(E.CODFOLIO,pistsegmento),
                           E.NOM_BENE,
                           0,
                           D.DESC_VALOR,
                           SYSDATE
                    FROM FECXC_DET_CLASIFICADOS A,
                         FECXC_DET_CLASFECXC B,
                         FECXC_DET_CATALOGOS D,
                         FECXC_ENC_CLASIFICADOS E,
                         FECXC_MONEDAS F
                    WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                      AND E.COD_SEC_CLASIFICA = A.COD_SEC_CLASIFICA
                      AND   E.SECMONEDA = F.SECMONEDA
                      AND A.COD_SEC_DET = B.COD_SEC_DET
                      AND D.TIPO_CAT = 'SEGMENTO'
                      AND D.COD_SEC_LIN = A.SEGMENTO1
                      and D.COD_VALOR = pistsegmento
                      AND F.CODMONEDA = pistmoneda
                      AND TO_CHAR(E.F_DEPOSITO,'MM') BETWEEN pistmesinicial AND PISTMESFINAL
                      AND TO_CHAR(E.F_DEPOSITO,'YYYY') = PISTANIO
                      AND B.COD_SUBCLASIF IN('INTERCAMBI','INTERIVA','OTROS','OTROSING','IVA');
COMMIT;
EXCEPTION
    WHEN OTHERS
    THEN
        --postErrbuf  :=  SQLERRM;
        --postRetcode :=  SQLCODE;
        dbms_output.put_line('Error:'||TO_CHAR(SQLCODE));
        dbms_output.put_line(sqlerrm);
        ROLLBACK;
END FECXC_FILL_FOLMANUALES3_PR;
PROCEDURE FECXC_FILL_FOLMANUALES4_PR (
                                     pistsegmento         in varchar2,
                                     pistmoneda           in varchar2,
                                     pistanio             in varchar2,
                                     PISTMESINICIAL       IN VARCHAR2,
                                     PISTMESFINAL         IN VARCHAR2,
                                     PINREGISTRO          NUMBER
                                    ) is
      PRAGMA AUTONOMOUS_TRANSACTION;
      linE_codigo            NUMBER;
      lincod_sec_clasifica   NUMBER;
      lin_importe            NUMBER;
      life_f_deposito        DATE;
      list_nom_bene          VARCHAR2(150);
      licont                 NUMBER := 0;
  CURSOR CURFOLIOREAL IS
      SELECT DISTINCT TRIM(substr(a.concepto,0,instr(a.concepto, ' '))) as folio_real
            FROM FECXC_FOLIOS_MANUALES_VW A,FECXC_DET_CATALOGOS B
              WHERE 1=1--A.EMPRESA = 3868
              AND B.COD_SEC_LIN = a.SEGMENTO1
              AND B.TIPO_CAT = 'SEGMENTO'
              AND A.CODFOLIO < 0
              AND B.COD_VALOR = pistsegmento --argumel
              AND a.CONCEPTO like '%TRAS%'
              AND CODMONEDA = pistmoneda
              AND TO_CHAR(a.F_DEPOSITO,'MM') between pistmesinicial and pistmesfinal
              AND TO_CHAR(A.F_DEPOSITO,'YYYY') = PISTANIO
              AND FECXC_DIVXPERIODO_PKG.ISNUMERIC_FN(NVL(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')),'DUMMY')) = 1;
              --AND TRIM(substr(A.concepto,0,instr(A.concepto, ' '))) NOT IN(33403454,33627798)
              --AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) NOT IN (SELECT NUM_FOLIO_REAL FROM FECXC_FMANUAL_OUT_TAB);
  BEGIN
    BEGIN
  IF PINREGISTRO = 1
  THEN
    DELETE FECXC_FMANUAL_OUT4_TAB;
    COMMIT;
  END IF;
     FOR I IN CURFOLIOREAL
    LOOP
      LINE_CODIGO := NULL;
      LINCOD_SEC_CLASIFICA := NULL;
      LIN_IMPORTE := NULL;
      LIFE_F_DEPOSITO := NULL;
      LIST_NOM_BENE := NULL;
     licont := licont+100;
       BEGIN
              SELECT A.E_CODIGO,
                     A.COD_SEC_CLASIFICA,
                     A.IMPORTE,
                     A.F_DEPOSITO ,
                     A.NOM_BENE
              INTO linE_codigo,
                   lincod_sec_clasifica,
                   lin_importe,
                   life_f_deposito,
                   list_nom_bene
              FROM FECXC_ENC_CLASIFICADOS A
              WHERE CODFOLIO = I.FOLIO_REAL;
        EXCEPTION WHEN NO_DATA_FOUND
        THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_FILL_FOLMANUALES4_PR Folio: '||I.FOLIO_REAL);
        END;
--      AND TRIM(SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' '))) NOT IN (SELECT NUM_FOLIO_REAL FROM FECXC_FMANUAL_OUT_TAB);
      INSERT INTO FECXC_FMANUAL_OUT4_TAB (
                  NUM_ECODIGO,
                  COD_SEC_CLASIFICA,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                SELECT A.E_CODIGO,
                       COD_SEC_CLASIFICA,
                       licont,
                       I.folio_real,
                       life_f_deposito,
                       NULL,
                       CASE WHEN COD_SUBCLASIF IN ('BASE','TRASPASO') THEN IMPORTE  END,
                       CASE WHEN COD_SUBCLASIF IN ('OTROS','INTERCAMBI','INTERIVA','OTROSING') THEN IMPORTE  END,
                       CASE WHEN COD_SUBCLASIF = 'IVA' THEN IMPORTE  END,
                       list_nom_bene,
                       --N_LINEA_CLAS,
                       lin_importe,
                       D.DESC_VALOR,
                       SYSDATE
                FROM FECXC_DET_CLASIFICADOS A,
                     FECXC_DET_CLASFECXC B,
                     FECXC_ENC_CLASFECXC C,
                     FECXC_DET_CATALOGOS D
                    WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                    AND A.COD_SEC_DET       = B.COD_SEC_DET
                    AND A.COD_SEC_CATCLAS   = C.COD_SEC_CATCLAS
                    AND A.SEGMENTO1         = D.COD_SEC_LIN(+)
                    AND E_CODIGO            =LINE_CODIGO
                    AND COD_SEC_CLASIFICA   =LINCOD_SEC_CLASIFICA
                    AND LINCOD_SEC_CLASIFICA NOT IN (SELECT COD_SEC_CLASIFICA FROM FECXC_FMANUAL_OUT4_TAB);
/*******************************************************************************/
               LICONT := LICONT+1;
          INSERT INTO FECXC_FMANUAL_OUT4_TAB (
                  NUM_ECODIGO,
                  COD_SEC_CLASIFICA,
                  ID_ORDEN,
                  NUM_FOLIO_REAL,
                  FEC_F_INGRESO,
                  NUM_FOLIO_MANUAL,
                  NUM_MONTO_FOLIO,
                  NUM_OTROS,
                  NUM_IVA,
                  NOM_CLIENTE,
                  NUM_IMP_FOLIO_REAL,
                  DES_SEGMENTO,
                  FEC_CREATION_DATE)
                  SELECT A.EMPRESA,
                         A.COD_SEC,
                         LICONT,
                         SUBSTR(A.CONCEPTO,0,INSTR(A.CONCEPTO, ' ')),
                         A.F_DEPOSITO,
                         A.CODFOLIO,
                         FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_BASE_4_FN(A.CODFOLIO,pistsegmento),
                         FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_OTROS_FN(A.CODFOLIO,pistsegmento),
                         FECXC_FOLIOS_MANUALES_PKG.FECXC_GET_SUBCLASIF_IVA_FN(A.CODFOLIO,pistsegmento),
                         A.NOM_BENE,
                         lin_importe,
                         B.DESC_VALOR,
                         SYSDATE
                  FROM FECXC_FOLIOS_MANUALES_VW A,FECXC_DET_CATALOGOS B
                  where 1=1--A.EMPRESA = 3868
                  and B.COD_SEC_LIN = a.SEGMENTO1
                  and B.TIPO_CAT = 'SEGMENTO'
                  AND A.CODFOLIO < 0
                  and B.COD_VALOR = pistsegmento
                  and a.CONCEPTO like '%TRAS%'
                  and CODMONEDA = pistmoneda
                  and TO_CHAR(a.F_DEPOSITO,'MM') between pistmesinicial and pistmesfinal
                  AND TO_CHAR(A.F_DEPOSITO,'YYYY') = PISTANIO
                  and trim(SUBSTR(a.CONCEPTO,0,INSTR(a.CONCEPTO, ' '))) = I.folio_real
                  AND fecxc_divxperiodo_pkg.isnumeric_fn(nvl(substr(A.concepto,0,instr(A.concepto, ' ')),'DUMMY')) = 1;
    END LOOP;
    COMMIT;
    EXCEPTION
    WHEN OTHERS
    THEN
      dbms_output.put_line('Error: '||sqlerrm);
    ROLLBACK;
    END;
  END fecxc_fill_folmanuales4_pr;
  FUNCTION fecxc_get_subclasif_fn (
                                    piinFolio    NUMBER
                                  )
RETURN VARCHAR2
IS
                  list_subclasif          VARCHAR2(150);
                  lin_cod_sec_clasifica   NUMBER;
                  lin_ecodigo             NUMBER;
 BEGIN
            BEGIN
                         SELECT A.COD_SEC_CLASIFICA,
                                A.E_CODIGO
                                INTO lin_cod_sec_clasifica,
                                     lin_ecodigo
                         FROM FECXC_ENC_CLASIFICADOS A
                         WHERE CODFOLIO =piinFolio;
                        SELECT COD_SUBCLASIF INTO list_subclasif
                        FROM FECXC_DET_CLASIFICADOS A,
                             FECXC_DET_CLASFECXC B,
                             FECXC_ENC_CLASFECXC C,
                             FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET = B.COD_SEC_DET
                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO = lin_ecodigo
                        AND COD_SEC_CLASIFICA = lin_cod_sec_clasifica;
       EXCEPTION WHEN NO_DATA_FOUND
                      THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_GET_SUBCLASIF_FN Folio; '||piinFolio);
                      END;
                       RETURN   list_subclasif;
end fecxc_get_subclasif_fn;
function FECXC_GET_SUBCLASIF_IVA_FN (
                                  PIINFOLIO_MANUAL    NUMBER,
                                  PISTSEGMENTO VARCHAR2
                                 )
return number
IS
LIN_IMPORTE NUMBER := 0;
LIN_COD_SEC NUMBER;
LIN_EMPRESA NUMBER;
begin
            BEGIN
                      SELECT distinct A.COD_SEC,
                             A.EMPRESA
                             INTO LIN_COD_SEC,
                                  LIN_EMPRESA
                      FROM FECXC_FOLIOS_MANUALES_VW A
                      WHERE CODFOLIO = PIINFOLIO_MANUAL;
                SELECT B.IMPORTE INTO LIN_IMPORTE
                FROM(
                      SELECT SUM(NVL(IMPORTE,0)) as IMPORTE
                      FROM
                          FECXC_DET_CLASIFICADOS A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_CLASIFICA = LIN_COD_SEC
                        AND COD_SUBCLASIF = 'IVA'
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                  UNION
                      SELECT SUM(NVL(IMPORTE,0))as IMPORTE
                        FROM
                          FECXC_DET_IMPGES A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_IMPORTA   = LIN_COD_SEC
                        AND COD_SUBCLASIF     = 'IVA'
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                )B;
        EXCEPTION WHEN NO_DATA_FOUND
                      THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_GET_SUBCLASIF_IVA_FN Folio: '||PIINFOLIO_MANUAL);
                      END;
RETURN NVL(LIN_IMPORTE,0);
END FECXC_GET_SUBCLASIF_IVA_FN;
function FECXC_GET_SUBCLASIF_IVA_INT_FN (
                                  PIINFOLIO_MANUAL    NUMBER,
                                  PISTSEGMENTO VARCHAR2
                                 )
return number
IS
LIN_IMPORTE NUMBER := 0;
LIN_COD_SEC NUMBER;
LIN_EMPRESA NUMBER;
begin
            BEGIN
                      SELECT distinct A.COD_SEC,
                             A.EMPRESA
                             INTO LIN_COD_SEC,
                                  LIN_EMPRESA
                      FROM FECXC_FOLIOS_MANUALES_VW A
                      WHERE CODFOLIO = PIINFOLIO_MANUAL;
                SELECT B.IMPORTE INTO LIN_IMPORTE
                FROM(
                      SELECT SUM(NVL(IMPORTE,0)) as IMPORTE
                      FROM
                          FECXC_DET_CLASIFICADOS A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_CLASIFICA = LIN_COD_SEC
                        AND COD_SUBCLASIF IN ('IVA','INTERIVA')
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                  UNION
                      SELECT SUM(NVL(IMPORTE,0))as IMPORTE
                        FROM
                          FECXC_DET_IMPGES A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_IMPORTA   = LIN_COD_SEC
                        AND COD_SUBCLASIF     IN ('IVA','INTERIVA')
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                )B;
        EXCEPTION WHEN NO_DATA_FOUND
                      THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_GET_SUBCLASIF_IVA_FN Folio: '||PIINFOLIO_MANUAL);
                      END;
RETURN NVL(LIN_IMPORTE,0);
END FECXC_GET_SUBCLASIF_IVA_INT_FN;
FUNCTION FECXC_GET_SUBCLASIF_BASE_FN (
                                  PIINFOLIO_MANUAL NUMBER,
                                  pistsegmento VARCHAR2
                                 )
return number
IS
LIN_IMPORTE NUMBER := 0;
LIN_COD_SEC NUMBER;
LIN_EMPRESA NUMBER;
BEGIN
           BEGIN
                      SELECT distinct A.COD_SEC,
                             A.EMPRESA
                             INTO LIN_COD_SEC,
                                  LIN_EMPRESA
                      FROM FECXC_FOLIOS_MANUALES_VW A
                      WHERE CODFOLIO = PIINFOLIO_MANUAL;
          EXCEPTION WHEN NO_DATA_FOUND
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM||' No existe informacion para este registro FECXC_GET_SUBCLASIF_BASE_FN 1 Folio: '||PIINFOLIO_MANUAL);
            WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM||' Arrojo mas de un folio FECXC_GET_SUBCLASIF_BASE_FN 1 Folio: '||PIINFOLIO_MANUAL);
            END;
           BEGIN
                SELECT B.IMPORTE INTO LIN_IMPORTE
                FROM(
                      SELECT SUM(NVL(IMPORTE,0)) as IMPORTE
                      FROM
                          FECXC_DET_CLASIFICADOS A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_CLASIFICA = LIN_COD_SEC
                        AND COD_SUBCLASIF     = 'BASE'
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                        UNION
                      SELECT SUM(NVL(IMPORTE,0))as IMPORTE
                        FROM
                          FECXC_DET_IMPGES A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_IMPORTA   = LIN_COD_SEC
                        AND COD_SUBCLASIF     = 'BASE'
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                )B;
      EXCEPTION WHEN NO_DATA_FOUND
              THEN DBMS_OUTPUT.PUT_LINE(SQLERRM||' No existe informacion para este registro FECXC_GET_SUBCLASIF_BASE_FN 2 Folio: '||PIINFOLIO_MANUAL);
              END;
RETURN NVL(LIN_IMPORTE,0);
END FECXC_GET_SUBCLASIF_BASE_FN;
FUNCTION FECXC_GET_SUBCLASIF_BASE_4_FN (
                                  PIINFOLIO_MANUAL NUMBER,
                                  pistsegmento VARCHAR2
                                 )
return number
IS
LIN_IMPORTE NUMBER := 0;
LIN_COD_SEC NUMBER;
LIN_EMPRESA NUMBER;
BEGIN
           BEGIN
                      SELECT distinct A.COD_SEC,
                             A.EMPRESA
                             INTO LIN_COD_SEC,
                                  LIN_EMPRESA
                      FROM FECXC_FOLIOS_MANUALES_VW A
                      WHERE CODFOLIO = PIINFOLIO_MANUAL;
          EXCEPTION WHEN NO_DATA_FOUND
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM||' No existe informacion para este registro FECXC_GET_SUBCLASIF_BASE_FN 1 Folio: '||PIINFOLIO_MANUAL);
            WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM||' Arrojo mas de un folio FECXC_GET_SUBCLASIF_BASE_FN 1 Folio: '||PIINFOLIO_MANUAL);
            END;
           BEGIN
                SELECT B.IMPORTE INTO LIN_IMPORTE
                FROM(
                      SELECT SUM(NVL(IMPORTE,0)) as IMPORTE
                      FROM
                          FECXC_DET_CLASIFICADOS A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_CLASIFICA = LIN_COD_SEC
                        AND COD_SUBCLASIF     IN ('BASE','TRASPASO')
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                        UNION
                      SELECT SUM(NVL(IMPORTE,0))as IMPORTE
                        FROM
                          FECXC_DET_IMPGES A,
                          FECXC_DET_CLASFECXC B,
                          FECXC_ENC_CLASFECXC C
                          --FECXC_DET_CATALOGOS D
                        WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                        AND A.COD_SEC_DET   = B.COD_SEC_DET
                          --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                        AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                        AND E_CODIGO          = LIN_EMPRESA
                        AND COD_SEC_IMPORTA   = LIN_COD_SEC
                        AND COD_SUBCLASIF     = 'TRASPASO'
                        AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                      GROUP BY cod_subclasif
                )B;
      EXCEPTION WHEN NO_DATA_FOUND
              THEN DBMS_OUTPUT.PUT_LINE(SQLERRM||' No existe informacion para este registro FECXC_GET_SUBCLASIF_BASE_FN 2 Folio: '||PIINFOLIO_MANUAL);
              END;
RETURN NVL(LIN_IMPORTE,0);
END FECXC_GET_SUBCLASIF_BASE_4_FN;
function FECXC_GET_SUBCLASIF_OTROS_FN (
                                  PIINFOLIO_MANUAL    number,
                                  PISTSEGMENTO  VARCHAR2
                                 )
return number
IS
LIN_IMPORTE NUMBER := 0;
LIN_COD_SEC NUMBER;
LIN_EMPRESA NUMBER;
BEGIN
          BEGIN
                      SELECT distinct A.COD_SEC,
                             A.EMPRESA
                             INTO LIN_COD_SEC,
                                  LIN_EMPRESA
                      FROM FECXC_FOLIOS_MANUALES_VW A
                      WHERE CODFOLIO = PIINFOLIO_MANUAL;
                      SELECT SUM(B.IMPORTE) INTO LIN_IMPORTE
                      FROM(
                                SELECT SUM(NVL(IMPORTE,0)) as IMPORTE
                                FROM
                                    FECXC_DET_CLASIFICADOS A,
                                    FECXC_DET_CLASFECXC B,
                                    FECXC_ENC_CLASFECXC C
                                    --FECXC_DET_CATALOGOS D
                                  WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                                  AND A.COD_SEC_DET   = B.COD_SEC_DET
                                    --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                                  AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                                  AND E_CODIGO          = LIN_EMPRESA
                                  AND COD_SEC_CLASIFICA = LIN_COD_SEC
                                  AND COD_SUBCLASIF     IN ('OTROS','INTERCAMBI','INTERIVA','OTROSING')
                                  AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                                GROUP BY cod_subclasif
                                  UNION
                                SELECT SUM(NVL(IMPORTE,0))as IMPORTE
                                  FROM
                                    FECXC_DET_IMPGES A,
                                    FECXC_DET_CLASFECXC B,
                                    FECXC_ENC_CLASFECXC C
                                    --FECXC_DET_CATALOGOS D
                                  WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                                  AND A.COD_SEC_DET   = B.COD_SEC_DET
                                    --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                                  AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                                  AND E_CODIGO          = LIN_EMPRESA
                                  AND COD_SEC_IMPORTA   = LIN_COD_SEC
                                  AND COD_SUBCLASIF     IN ('OTROS','INTERCAMBI','INTERIVA','OTROSING')
                                  AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                                GROUP BY cod_subclasif
                            )B;
         EXCEPTION WHEN NO_DATA_FOUND
                  THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_GET_SUBCLASIF_OTROS_FN Folio: '||PIINFOLIO_MANUAL);
        END;
RETURN NVL(LIN_IMPORTE,0);
END FECXC_GET_SUBCLASIF_OTROS_FN;
function FECXC_GET_SUBCLASIF_OTROS_2_FN (
                                  PIINFOLIO_MANUAL    number,
                                  PISTSEGMENTO  VARCHAR2
                                 )
return number
IS
LIN_IMPORTE NUMBER := 0;
LIN_COD_SEC NUMBER;
LIN_EMPRESA NUMBER;
BEGIN
          BEGIN
                      SELECT distinct A.COD_SEC,
                             A.EMPRESA
                             INTO LIN_COD_SEC,
                                  LIN_EMPRESA
                      FROM FECXC_FOLIOS_MANUALES_VW A
                      WHERE CODFOLIO = PIINFOLIO_MANUAL;
                      SELECT SUM(B.IMPORTE) INTO LIN_IMPORTE
                      FROM(
                                SELECT SUM(NVL(IMPORTE,0)) as IMPORTE
                                FROM
                                    FECXC_DET_CLASIFICADOS A,
                                    FECXC_DET_CLASFECXC B,
                                    FECXC_ENC_CLASFECXC C
                                    --FECXC_DET_CATALOGOS D
                                  WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                                  AND A.COD_SEC_DET   = B.COD_SEC_DET
                                    --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                                  AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                                  AND E_CODIGO          = LIN_EMPRESA
                                  AND COD_SEC_CLASIFICA = LIN_COD_SEC
                                  AND COD_SUBCLASIF     IN ('OTROS','INTERCAMBI','OTROSING')
                                  AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                                GROUP BY cod_subclasif
                                  UNION
                                SELECT SUM(NVL(IMPORTE,0))as IMPORTE
                                  FROM
                                    FECXC_DET_IMPGES A,
                                    FECXC_DET_CLASFECXC B,
                                    FECXC_ENC_CLASFECXC C
                                    --FECXC_DET_CATALOGOS D
                                  WHERE A.COD_SEC_CATCLAS = B.COD_SEC_CATCLAS
                                  AND A.COD_SEC_DET   = B.COD_SEC_DET
                                    --                        AND  A.SEGMENTO1 = D.COD_SEC_LIN(+)
                                  AND A.COD_SEC_CATCLAS = C.COD_SEC_CATCLAS
                                  AND E_CODIGO          = LIN_EMPRESA
                                  AND COD_SEC_IMPORTA   = LIN_COD_SEC
                                  AND COD_SUBCLASIF     IN ('OTROS','INTERCAMBI','OTROSING')
                                  AND A.SEGMENTO1 = (SELECT COD_SEC_LIN FROM FECXC_DET_CATALOGOS WHERE COD_VALOR = pistsegmento AND TIPO_CAT='SEGMENTO')
                                GROUP BY cod_subclasif
                            )B;
         EXCEPTION WHEN NO_DATA_FOUND
                  THEN dbms_output.put_line(sqlerrm||' No existe informacion para este registro FECXC_GET_SUBCLASIF_OTROS_FN Folio: '||PIINFOLIO_MANUAL);
        END;
RETURN NVL(LIN_IMPORTE,0);
END FECXC_GET_SUBCLASIF_OTROS_2_FN;
END;
/;
