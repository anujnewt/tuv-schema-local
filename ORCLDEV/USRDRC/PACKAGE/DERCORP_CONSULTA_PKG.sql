CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_CONSULTA_PKG" AS
  PROCEDURE GET_SECCIONES_PR(piinrolId number  ,resultSet OUT SYS_REFCURSOR
                                                --, sectionID varchar2
                                                );
  PROCEDURE GET_SECCIONES_FILTERED_PR(piinrolId number  ,resultSet OUT SYS_REFCURSOR, sectionID varchar2);
  PROCEDURE GET_MENU_REFORMA_FILTERED_PR(piinrolId number  ,resultSet OUT SYS_REFCURSOR, sectionID varchar2);
  --
  -- 10/May/16 - Nava - Se agrego SP
  --
  PROCEDURE GET_SECCIONES_CON_INFO_PR(piinrolId number  ,resultSet OUT SYS_REFCURSOR, sectionID varchar2, empresaID number);
  PROCEDURE GET_SECCIONES_FILTERED_REPO_PR(piinrolId number  ,resultSet OUT SYS_REFCURSOR, sectionID varchar2);
  PROCEDURE GET_SUB_SECCIONES_PR(sectionID number, resultSet OUT SYS_REFCURSOR);
  PROCEDURE GET_SUB_SECCIONES_CON_INFO_PR(sectionID number, empresaID number, resultSet OUT SYS_REFCURSOR);
  --
  -- NAVA 10-May-16
  --
  FUNCTION COUNT_SUB_SECCIONES_CON_INFO(
                                    sectionID number,
                                    empresaID number) RETURN INT;
  PROCEDURE GET_AGRUPACIONES_PR(sectionID number, subSectionID number, resultSet OUT SYS_REFCURSOR);
  PROCEDURE GET_CAMPOS_PR(empresaID number, subSectionID number, resultSet OUT SYS_REFCURSOR);
  PROCEDURE GET_CAMPOS_REPORTE_ECS_PR(empresaID number, subSectionID number, resultSet OUT SYS_REFCURSOR);
  PROCEDURE GET_VALUES_PR(empresaID number, isAsociacionCivil OUT NUMBER);
  --FUNCTION GET_INFO_ESCRITURA(empresaID number, param2 varchar2) RETURN varchar2;
    PROCEDURE CONSULTAR_ADM_VIG_PR(P_ID_EMPRESA   IN INTEGER
                                ,P_ID_FLEX_TAB  IN VARCHAR2);
    --ECM 20 Julio 2016 Obtener valores de los checks Utilidad y Perdida en AES.
    PROCEDURE GET_AES_RESULTADO_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,piinIdMetaRow   IN NUMBER
    );
    --ECM 27 Julio 2016 Obtener Capital Fijo, Capital Variable, Capital Social, Capital Total
    PROCEDURE GET_CAP_FIJ_VAR_SOC_AUM_DIS_PR(porcRSResultado OUT SYS_REFCURSOR
                                                ,piinIdMetaRow   IN NUMBER);
    --ECM 04 Agosto 2016 Obtener los valores de los campos restantes en Fusion.
    PROCEDURE GET_CAMPOS_VALORES_FUSION_PR(porcRSResultado OUT SYS_REFCURSOR
                                                ,piinIdMetaRow   IN NUMBER);
    --ECM 29 Agosto 2016 Obtner el valor nominal o valor te??rico nominal.
    PROCEDURE GET_VAL_NOM_TEO_PR(poinValor OUT NUMBER
                                ,piinIdAddCampo IN NUMBER
                                ,piinIdEmpresa  IN NUMBER
    );
    --ECM 29 Agosto 2016 Resumen General - Obtener el socio externo.
    PROCEDURE GET_SOCIO_EXTERNO_PR(postValor OUT VARCHAR2
                                  ,piinIdEmpresa  IN NUMBER
    );
    --ECM 29 Agosto 2016 Resumen General - Info General - Admite Extranjeros
    PROCEDURE GET_ADMITE_EXTRANJEROS_PR(postValor OUT VARCHAR2
                                       ,piinIdEmpresa  IN NUMBER
     );
    --ECM 31 Agosto 2016 - Reformas y Movimientos - Aprobaci??n Ejercicio Social
    --Obtener los valores de los checks de Otros Acuerdos.
    PROCEDURE GET_AES_OTROS_ACUERDOS_PR(porcRSResultado OUT SYS_REFCURSOR
                                       ,piinIdMetaRow  IN NUMBER
    );
    --ECM 09 Septiembre 2016 - Administracion y Vigilancia
    -- Super??ndice en el campo Nombre del Suplente
    PROCEDURE GET_ADM_VIG_NOMBRE_SUPLENTE_PR(piinIdMetaRow  IN NUMBER
                                            ,piinIdEmpresa  IN NUMBER
                                            ,piinIdFlex     IN NUMBER
                                            ,poinSuperindice OUT NUMBER
    );
    --ECM 12 Septiembre 2016 - Adm y Vig Referencia de nota al pie.
    PROCEDURE GET_ADM_VIG_REF_NOTA_PIE_PR(piinIdFlex  IN NUMBER
                                         ,piinIdEmp   IN NUMBER
                                         ,postRefNotaPies OUT VARCHAR2
    );
    --ECM 24 Octubre 2016 - getCamposConFlex
    PROCEDURE GET_CAMPOS_CON_FLEX_PR(EMPRESAID NUMBER, SUBSECTIONID NUMBER, RESULTSET OUT SYS_REFCURSOR);
    --ECM 24 Octubre 2016 - getAgrupacionesConFlex
    PROCEDURE GET_AGRUPACIONES_CON_FLEX_PR(sectionID number, subSectionID number, resultSet OUT SYS_REFCURSOR, piinIdEmp IN NUMBER);
    --JJAQ 08 Diciembre 2016 - Adm y Vig Referencia de nota al pie llena tabla con indice
    PROCEDURE INSERT_SUBINDICE_ADMIN_VIG_PR(piinIdFlex  IN NUMBER
                                           ,piinIdEmp   IN NUMBER
                                           ,postRefNotaPies OUT VARCHAR2
    );
    --JAMS 02-07-2018 Se valida informacion en las flextables para permitir o no
    --eliminar el detalle de algun catalogo
    PROCEDURE GET_DATOS_EN_FLEX_PR(
                                piinIdFlex       IN NUMBER
                                ,piinIdValor       IN VARCHAR2
                                ,poutResultado OUT NUMBER
    );
    PROCEDURE CONSULTAR_ADM_VIG_BY_NOMBRE_PR(P_ID_EMPRESA   IN INTEGER
                                            ,P_ID_FLEX_TAB  IN VARCHAR2
                                            ,P_NOMBRE       IN VARCHAR2);
END DERCORP_CONSULTA_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_CONSULTA_PKG" AS
    PROCEDURE GET_SECCIONES_PR(piinrolId NUMBER,resultSet OUT SYS_REFCURSOR
        --, sectionID varchar2
        )
    AS
    BEGIN
      OPEN resultSet FOR
        SELECT   CS.*
        FROM     DERCORP_ADD_CAMPO_SECCION_TAB  CS,
                 DERCORP_ROL_SECCION_TAB        RS
        WHERE    CS.ID_SECCION = RS.ID_SECCION
        AND      RS.ID_ROL     = piinrolId
        --AND      (TO_CHAR(CS.ID_SECCION) = sectionID OR sectionID = '*')
        AND      CS.ID_SECCION not in (23,24) -- JJAQ Para que no aparezca poderes especial y Apoderados
        ORDER BY CS.ID_SECCION;
    END GET_SECCIONES_PR;
    --
    --
    --
    PROCEDURE GET_SECCIONES_FILTERED_PR(piinrolId NUMBER,resultSet OUT SYS_REFCURSOR, sectionID varchar2)
    AS
    BEGIN
      OPEN resultSet FOR
        SELECT   CS.*
        FROM     DERCORP_ADD_CAMPO_SECCION_TAB  CS,
                 DERCORP_ROL_SECCION_TAB        RS
        WHERE    CS.ID_SECCION = RS.ID_SECCION
        AND      RS.ID_ROL     = piinrolId
        AND      (TO_CHAR(CS.ID_SECCION) = sectionID OR sectionID = '*')
        AND      CS.LIKE_SUB_SEC = '0'
        --AND     CS.NOM_SECCION NOT LIKE '%Apoderados%'
        AND      CS.ID_SECCION not in (23,24)
        ORDER BY CS.ID_SECCION;
    END GET_SECCIONES_FILTERED_PR;
    PROCEDURE GET_MENU_REFORMA_FILTERED_PR(piinrolId NUMBER,resultSet OUT SYS_REFCURSOR, sectionID varchar2)
    AS
    BEGIN
      OPEN resultSet FOR
        SELECT   CS.*
        FROM     DERCORP_ADD_CAMPO_SECCION_TAB  CS,
                 DERCORP_ROL_SECCION_TAB        RS
        WHERE    CS.ID_SECCION = RS.ID_SECCION
        AND      RS.ID_ROL     = piinrolId
        AND      (TO_CHAR(CS.ID_SECCION) = sectionID OR sectionID = '*')
        AND      CS.LIKE_SUB_SEC = '1'
        AND      CS.ID_SECCION not in (23,24,33)
        ORDER BY CS.NOM_SECCION;
    END GET_MENU_REFORMA_FILTERED_PR;
      --
      -- 10/May/16 - Nava - Se agrego SP
      --
      PROCEDURE GET_SECCIONES_CON_INFO_PR(piinrolId number  ,resultSet OUT SYS_REFCURSOR, sectionID varchar2, empresaID number)
       AS
        BEGIN
          OPEN resultSet FOR
            SELECT   CS.*
            FROM     DERCORP_ADD_CAMPO_SECCION_TAB  CS,
                     DERCORP_ROL_SECCION_TAB        RS
            WHERE    CS.ID_SECCION = RS.ID_SECCION
            AND      RS.ID_ROL     = piinrolId
            AND      (TO_CHAR(CS.ID_SECCION) = sectionID OR sectionID = '*')
            AND      CS.ID_SECCION not in (23,24)
            --AND     CS.NOM_SECCION NOT LIKE '%Apoderados%'
            AND      CS.LIKE_SUB_SEC = '0'
            --
            --
            --
            AND
              (
              COUNT_SUB_SECCIONES_CON_INFO(CS.ID_SECCION, empresaID) > 0
                OR CS.ID_SECCION = 28
            )
            ORDER BY CS.ID_SECCION;
        END GET_SECCIONES_CON_INFO_PR;
     PROCEDURE GET_SECCIONES_FILTERED_REPO_PR(piinrolId NUMBER,resultSet OUT SYS_REFCURSOR, sectionID varchar2)
    AS
    BEGIN
      OPEN resultSet FOR
        SELECT   CS.*
        FROM     DERCORP_ADD_CAMPO_SECCION_TAB  CS,
                 DERCORP_ROL_SECCION_TAB        RS
        WHERE    CS.ID_SECCION = RS.ID_SECCION
        AND      RS.ID_ROL     = piinrolId
        AND      (TO_CHAR(CS.ID_SECCION) = sectionID OR sectionID = '*')
        AND     CS.NOM_SECCION NOT LIKE '%Apoderados%'
        AND      CS.ID_SECCION not in (22,23,24)
        AND    CS.LIKE_SUB_SEC = 0
        ORDER BY CS.ID_SECCION;
    END GET_SECCIONES_FILTERED_REPO_PR;
    PROCEDURE GET_SUB_SECCIONES_PR(sectionID number,
                                    resultSet OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN resultSet FOR
            SELECT
              *
            FROM
              DERCORP_ADD_CAMPO_SUB_SEC_TAB
            WHERE
              ID_SECCION = (CASE sectionID WHEN 0 THEN ID_SECCION ELSE sectionID END)
              --and ID_SUBSECCION = 17
            ORDER BY
              NUM_ORDER ,ID_SECCION, ID_SUBSECCION;
    END GET_SUB_SECCIONES_PR;
  --
  -- NAVA 27 Abr
  --
  PROCEDURE GET_SUB_SECCIONES_CON_INFO_PR(
                                    sectionID number,
                                    empresaID number,
                                    resultSet OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN resultSet FOR
            SELECT
              *
            FROM
              DERCORP_ADD_CAMPO_SUB_SEC_TAB
            WHERE
              ID_SECCION = (CASE sectionID WHEN 0 THEN ID_SECCION ELSE sectionID END)
              AND
              (
                  (SELECT COUNT(*)
                   FROM DERCORP_ADD_CAMPO_VALOR_TAB
                   WHERE
                      ID_EMPRESA = empresaID
                      AND
                      ID_ADD_CAMPO IN (
                            SELECT ID_ADD_CAMPO
                            FROM DERCORP_ADD_CAMPO_TAB
                            WHERE
                              ID_SUBSECCION = DERCORP_ADD_CAMPO_SUB_SEC_TAB.ID_SUBSECCION
                              )
                      --AND
                      --VAL_VALOR IS NOT NULL      -- SE AGREGO
                      AND
                        NVL(VAL_VALOR,'0') <> '0'      -- SE AGREGO
                    ) <> 0
              OR
                   (SELECT count(*)
                   FROM DERCORP_ADD_CAMPO_TAB
                   WHERE
                      ID_SECCION = sectionID
                      AND
                      ID_SUBSECCION = DERCORP_ADD_CAMPO_SUB_SEC_TAB.ID_SUBSECCION     --NAVA - 10-May-16 - faltaba condicion
                      --AND
                      --DES_TIPO_CAMPO IN ('FLEXTABLE','AJAX_PAGE')                   --NAVA - 10-May-16 - se quito condicion
                      AND
                      (                                                       --NAVA - 10-May-16 - se agrego condicion compuesta
                        DES_TIPO_CAMPO IN ('AJAX_PAGE')
                        OR
                        ID_FLEX_TBL IN (SELECT ID_FLEX_TBL FROM DERCORP_METATBL_TAB WHERE ID_EMPRESA = empresaID)
                        OR
                        ID_FLEX_TBL IN (2,36)--JJAQ Para que muestre observaciones grales y denom anteriores
                      )
                    ) > 0
                    OR ID_SECCION = 28
                )
            ORDER BY
              NUM_ORDER, ID_SECCION, ID_SUBSECCION;
    END GET_SUB_SECCIONES_CON_INFO_PR;
  --
  -- NAVA 10-May-16
  --
  FUNCTION COUNT_SUB_SECCIONES_CON_INFO(
                                    sectionID number,
                                    empresaID number) RETURN INT
    AS
        VAR_COUNT INT;
    BEGIN
            SELECT
              COUNT(*) INTO VAR_COUNT
            FROM
              DERCORP_ADD_CAMPO_SUB_SEC_TAB
            WHERE
              ID_SECCION = (CASE sectionID WHEN 0 THEN ID_SECCION ELSE sectionID END)
              AND
              (
                  (SELECT COUNT(*)
                   FROM DERCORP_ADD_CAMPO_VALOR_TAB
                   WHERE
                      ID_EMPRESA = empresaID
                      AND
                      ID_ADD_CAMPO IN (
                            SELECT ID_ADD_CAMPO
                            FROM DERCORP_ADD_CAMPO_TAB
                            WHERE
                              ID_SUBSECCION = DERCORP_ADD_CAMPO_SUB_SEC_TAB.ID_SUBSECCION
                              )
                      --AND
                      --VAL_VALOR IS NOT NULL      -- SE QUITO
                      AND
                        NVL(VAL_VALOR,'0') <> '0'       -- SE AGREGO
                    ) <> 0
              OR
                   (SELECT count(*)
                   FROM DERCORP_ADD_CAMPO_TAB
                   WHERE
                      ID_SECCION = sectionID
                      AND
                      ID_SUBSECCION = DERCORP_ADD_CAMPO_SUB_SEC_TAB.ID_SUBSECCION     --NAVA - 10-May-16 - faltaba condicion
                      --AND
                      --DES_TIPO_CAMPO IN ('FLEXTABLE','AJAX_PAGE')                   --NAVA - 10-May-16 - se quito condicion
                      AND
                      (                                                       --NAVA - 10-May-16 - se agrego condicion compuesta
                        DES_TIPO_CAMPO IN ('AJAX_PAGE')
                        OR
                        ID_FLEX_TBL IN (SELECT ID_FLEX_TBL FROM DERCORP_METATBL_TAB WHERE ID_EMPRESA = empresaID)
                      )
                    ) > 0
                )
            ORDER BY
              ID_SECCION, ID_SUBSECCION;
        RETURN VAR_COUNT;
    END COUNT_SUB_SECCIONES_CON_INFO;
    PROCEDURE GET_AGRUPACIONES_PR(sectionID number, subSectionID number,
                                              resultSet OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN resultSet FOR
              SELECT
                ID_AGRUPACION,
                count(*) COUNT_CAMPOS,
                DECODE (DES_TIPO_CAMPO, 'FLEXTABLE', 'YES','AJAX_PAGE','YES', 'NO') IS_FLEX,
                CASE (SELECT count(*)
                      FROM DERCORP_ADD_CAMPO_TAB
                      WHERE ID_SECCION = C.ID_SECCION
                      AND ID_SUBSECCION = C.ID_SUBSECCION
                      AND ID_AGRUPACION = C.ID_AGRUPACION
                      AND ATRIBUTO2 = 'PAIR')  WHEN 0 THEN 'NO' ELSE 'YES' END IS_PAIR
              FROM
                DERCORP_ADD_CAMPO_TAB C
              WHERE
                1=1
              AND
                ID_SECCION =  sectionID
              AND
                ID_SUBSECCION = subSectionID
              GROUP BY
                ID_AGRUPACION,
                DECODE (DES_TIPO_CAMPO, 'FLEXTABLE', 'YES','AJAX_PAGE','YES', 'NO'),
                ID_SECCION,
                ID_SUBSECCION
              ORDER BY
                C.ID_AGRUPACION;
    END GET_AGRUPACIONES_PR;
    PROCEDURE GET_CAMPOS_PR(empresaID number, subSectionID number, resultSet OUT SYS_REFCURSOR)
    AS
    BEGIN
         OPEN resultSet FOR
              SELECT
                --c.* ,
                c.id_add_campo,
                c.cod_campo,
                c.nom_campo,
                c.des_campo,
                c.des_tipo_campo,
                c.can_tamanno_campo,
                c.des_formula,
                c.id_flex_tbl,
                c.id_catalogo,
                c.id_seccion,
                c.id_subseccion,
                c.id_agrupacion,
                c.atributo1,
                c.atributo2,
                c.atributo3,
                c.atributo4,
                c.atributo5,
                c.atributo11,
                c.atributo12,
                c.atributo13,
                c.atributo14,
                c.atributo15,
                c.id_order,
                v.VAL_VALOR
              FROM
                DERCORP_ADD_CAMPO_TAB c
                LEFT JOIN DERCORP_ADD_CAMPO_VALOR_TAB v ON v.ID_ADD_CAMPO     = c.ID_ADD_CAMPO
                                                        AND v.ID_EMPRESA      = empresaID
              WHERE
                c.ID_SUBSECCION = subSectionID AND
                c.ATRIBUTO7 IS NULL
              ORDER BY
                ID_SECCION,
                ID_SUBSECCION,
                c.ID_AGRUPACION,
                TO_NUMBER(c.ID_ORDER);
    END GET_CAMPOS_PR;
    --JJAQ 15/01/2019 PARA EL REPORTE DE ESTRUCTURA DE CAPITAL SOCIAL
    PROCEDURE GET_CAMPOS_REPORTE_ECS_PR(empresaID number, subSectionID number, resultSet OUT SYS_REFCURSOR)
    AS
    BEGIN
         OPEN resultSet FOR
              SELECT
                --c.* ,
                c.id_add_campo,
                c.cod_campo,
                c.nom_campo,
                c.des_campo,
                c.des_tipo_campo,
                c.can_tamanno_campo,
                c.des_formula,
                c.id_flex_tbl,
                c.id_catalogo,
                c.id_seccion,
                c.id_subseccion,
                c.id_agrupacion,
                c.atributo1,
                c.atributo2,
                c.atributo3,
                c.atributo4,
                c.atributo5,
                c.atributo11,
                c.atributo12,
                c.atributo13,
                c.atributo14,
                c.atributo15,
                c.id_order,
                v.VAL_VALOR
              FROM
                DERCORP_ADD_CAMPO_TAB c
                LEFT JOIN DERCORP_ADD_CAMPO_VALOR_TAB v ON v.ID_ADD_CAMPO     = c.ID_ADD_CAMPO
                                                        AND v.ID_EMPRESA      = empresaID
              WHERE
                c.ID_SUBSECCION = subSectionID AND
                c.ATRIBUTO7 IS NULL
                AND c.des_tipo_campo not in ('CHECKBOX_D','CHECKBOX')
              ORDER BY
                ID_SECCION,
                ID_SUBSECCION,
                c.ID_AGRUPACION,
                TO_NUMBER(c.ID_ORDER);
    END GET_CAMPOS_REPORTE_ECS_PR;
    PROCEDURE GET_VALUES_PR(empresaID number, isAsociacionCivil OUT NUMBER)
    AS
    BEGIN
      SELECT
        COUNT(*) INTO isAsociacionCivil
      FROM
        DERCORP_ADD_CAMPO_VALOR_TAB EMP
        INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
              ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
      WHERE
        EMP.ID_EMPRESA = empresaID
        AND
        EMP.ID_ADD_CAMPO = 517
        AND
        UPPER(CAT.NOM_CAT_VAL) LIKE '%ASOC%CIVIL%';
    END GET_VALUES_PR;
/*
  --ECM 10 MARZO 2016
  PROCEDURE CONSULTAR_ADM_VIG_PR(P_ID_EMPRESA   IN INTEGER
                                ,P_ID_FLEX_TAB  IN VARCHAR2)
  IS
    CURSOR CON_ADM_VIG_CUR(CP_ID_EMPRESA   IN INTEGER
                          ,CP_ID_FLEX_TAB  IN VARCHAR2)
    IS
    SELECT   META.*
    FROM     DERCORP_METATBL_TAB META
    WHERE    META.ID_EMPRESA  =   CP_ID_EMPRESA
    AND      META.ID_FLEX_TBL =   CP_ID_FLEX_TAB
    AND      ((META.VAL_C4 IS NULL OR META.VAL_C4 = '') OR (META.VAL_C7 IS NULL OR META.VAL_C7 = ''))
    ORDER BY TO_NUMBER(META.VAL_C15), DERCORP_CATALOGS_PKG.GET_FUNCIONARIOS_FN(META.VAL_C1)
    ;
  BEGIN
        DELETE DERCORP_CON_ADM_VIG_TMP
        WHERE 1=1
        AND ID_EMPRESA = P_ID_EMPRESA
        AND ID_FLEX_TBL = P_ID_FLEX_TAB
        ;
        FOR i IN CON_ADM_VIG_CUR(P_ID_EMPRESA,P_ID_FLEX_TAB)
        LOOP
            IF i.VAL_C4 IS NULL OR i.VAL_C4 = '' THEN
                INSERT INTO DERCORP_CON_ADM_VIG_TMP(ID_META_ROW
                                                    ,ID_FLEX_TBL
                                                    ,ID_EMPRESA
                                                    ,VAL_C1
                                                    ,VAL_C2
                                                    ,VAL_C3
                                                    ,VAL_C4
                                                    ,VAL_C5
                                                    ,VAL_C6
                                                    ,VAL_C7
                                                    ,VAL_C8
                                                    ,VAL_C9
                                                    ,VAL_C10
                                                    ,VAL_C11
                                                    ,VAL_C12
                                                    ,VAL_C13
                                                    ,VAL_C14
                                                    ,VAL_C15
                                                    ) VALUES(
                                                     i.ID_META_ROW
                                                    ,i.ID_FLEX_TBL
                                                    ,i.ID_EMPRESA
                                                    ,i.VAL_C1
                                                    ,i.VAL_C2
                                                    ,i.VAL_C3
                                                    ,i.VAL_C4
                                                    ,i.VAL_C5
                                                    ,i.VAL_C6
                                                    ,i.VAL_C7
                                                    ,i.VAL_C8
                                                    ,i.VAL_C9
                                                    ,i.VAL_C10
                                                    ,i.VAL_C11
                                                    ,i.VAL_C12
                                                    ,i.VAL_C13
                                                    ,i.VAL_C14
                                                    ,i.VAL_C15
                                                    );
            ELSE
                INSERT INTO DERCORP_CON_ADM_VIG_TMP(ID_META_ROW
                                                    ,ID_FLEX_TBL
                                                    ,ID_EMPRESA
                                                    ,VAL_C1
                                                    ,VAL_C2
                                                    ,VAL_C3
                                                    ,VAL_C4
                                                    ,VAL_C5
                                                    ,VAL_C6
                                                    ,VAL_C7
                                                    ,VAL_C8
                                                    ,VAL_C9
                                                    ,VAL_C10
                                                    ,VAL_C11
                                                    ,VAL_C12
                                                    ,VAL_C13
                                                    ,VAL_C14
                                                    ,VAL_C15
                                                    ) VALUES(
                                                     i.ID_META_ROW
                                                    ,i.ID_FLEX_TBL
                                                    ,i.ID_EMPRESA
                                                    ,NULL
                                                    ,NULL
                                                    ,NULL
                                                    ,NULL
                                                    ,i.VAL_C5
                                                    ,i.VAL_C6
                                                    ,i.VAL_C7
                                                    ,i.VAL_C8
                                                    ,i.VAL_C9
                                                    ,i.VAL_C10
                                                    ,i.VAL_C11
                                                    ,i.VAL_C12
                                                    ,i.VAL_C13
                                                    ,i.VAL_C14
                                                    ,i.VAL_C15
                                                    );
            END IF;
            IF i.VAL_C7 IS NOT NULL OR i.VAL_C7 <> '' THEN
                UPDATE DERCORP_CON_ADM_VIG_TMP
                SET    VAL_C5 = NULL
                      ,VAL_C6 = NULL
                      ,VAL_C7 = NULL
                      ,VAL_C8 = NULL
                WHERE 1=1
                AND   ID_META_ROW = i.ID_META_ROW
                AND   ID_FLEX_TBL = i.ID_FLEX_TBL
                AND   ID_EMPRESA  = i.ID_EMPRESA
                ;
            END IF;
        END LOOP;
      COMMIT;
  END CONSULTAR_ADM_VIG_PR;
*/
  --ECM 07 ABRIL 2016
  PROCEDURE CONSULTAR_ADM_VIG_PR(P_ID_EMPRESA   IN INTEGER
                                ,P_ID_FLEX_TAB  IN VARCHAR2)
  IS
    CURSOR CON_ADM_VIG_CUR(CP_ID_EMPRESA   IN INTEGER
                          ,CP_ID_FLEX_TAB  IN VARCHAR2)
    IS
    SELECT   META.*
    FROM     DERCORP_METATBL_TAB META
    WHERE    META.ID_EMPRESA  =   CP_ID_EMPRESA
    AND      META.ID_FLEX_TBL =   CP_ID_FLEX_TAB
    AND      META.VAL_C15 IS NOT NULL --No de orden
    --AND      ( (META.VAL_C4 IS NULL ) OR (META.VAL_C7 IS NULL ) ) --JJAQ 09/01/2019 Se comenta para el punto prioritario numero 16
    ORDER BY TO_NUMBER(META.VAL_C15), DERCORP_CATALOGS_PKG.GET_FUNCIONARIOS_FN(META.VAL_C1)
    ;
  BEGIN
        DELETE DERCORP_CON_ADM_VIG_TMP
        WHERE 1=1
        AND ID_EMPRESA = P_ID_EMPRESA
        AND ID_FLEX_TBL = P_ID_FLEX_TAB
        ;
        IF  P_ID_FLEX_TAB = '8' OR
            --P_ID_FLEX_TAB = '16' OR
            P_ID_FLEX_TAB = '25' OR
            --P_ID_FLEX_TAB = '26' OR
            P_ID_FLEX_TAB = '39'
            --P_ID_FLEX_TAB = '44' OR
            --P_ID_FLEX_TAB = '45' OR
            --P_ID_FLEX_TAB = '43'
            THEN
            FOR i IN CON_ADM_VIG_CUR(P_ID_EMPRESA,P_ID_FLEX_TAB)
            LOOP
--                IF (i.VAL_C4 IS NOT NULL)THEN  --JJAQ 11/01/2019 Se comenta para el punto prioritario numero 16
--                    NULL;
--                ELSE
                    INSERT INTO DERCORP_CON_ADM_VIG_TMP(ID_META_ROW
                                                        ,ID_FLEX_TBL
                                                        ,ID_EMPRESA
                                                        ,VAL_C1
                                                        ,VAL_C2
                                                        ,VAL_C3
                                                        ,VAL_C15
                                                        ) VALUES(
                                                         i.ID_META_ROW
                                                        ,i.ID_FLEX_TBL
                                                        ,i.ID_EMPRESA
                                                        ,i.VAL_C1
                                                        ,i.VAL_C2
                                                        ,i.VAL_C3
                                                        ,i.VAL_C15
                    );
--                END IF;
            END LOOP;
        END IF;
        IF  P_ID_FLEX_TAB = '9' OR
            P_ID_FLEX_TAB = '11' OR
            P_ID_FLEX_TAB = '12' OR
            P_ID_FLEX_TAB = '13' OR
            P_ID_FLEX_TAB = '14' OR
            P_ID_FLEX_TAB = '15' OR
            P_ID_FLEX_TAB = '16' OR
            P_ID_FLEX_TAB = '26' OR
            P_ID_FLEX_TAB = '43' OR
            P_ID_FLEX_TAB = '44' OR
            P_ID_FLEX_TAB = '45' OR
            P_ID_FLEX_TAB = '46' OR -- se agrega flex table JAMS 04/07/2017
            P_ID_FLEX_TAB = '40' THEN
            FOR i IN CON_ADM_VIG_CUR(P_ID_EMPRESA,P_ID_FLEX_TAB)
            LOOP
--                IF (i.VAL_C4 IS NOT NULL) AND
--                   (i.VAL_C7 IS NOT NULL)THEN
--                    NULL;                             --JJAQ 11/01/2019 Se comenta para el punto prioritario numero 16
--                ELSIF(i.VAL_C4 IS NOT NULL) AND
--                     (i.VAL_C7 IS NULL)THEN           --JJAQ 11/01/2019 Se comenta para el punto prioritario numero 16
/*
                         INSERT INTO DERCORP_CON_ADM_VIG_TMP(ID_META_ROW
                                        ,ID_FLEX_TBL
                                        ,ID_EMPRESA
                                        ,VAL_C1
                                        ,VAL_C2
                                        ,VAL_C3
                                        ,VAL_C5
                                        ,VAL_C6
                                        ,VAL_C8
                                        ,VAL_C15
                                        ) VALUES(
                                         i.ID_META_ROW
                                        ,i.ID_FLEX_TBL
                                        ,i.ID_EMPRESA
                                        ,NULL
                                        ,i.VAL_C2
                                        ,NULL
                                        ,i.VAL_C5
                                        ,i.VAL_C6
                                        ,i.VAL_C8
                                        ,i.VAL_C15
                );
                ELSIF(i.VAL_C4 IS NULL) AND
                     (i.VAL_C7 IS NOT NULL)THEN
                    INSERT INTO DERCORP_CON_ADM_VIG_TMP( ID_META_ROW
                                                        ,ID_FLEX_TBL
                                                        ,ID_EMPRESA
                                                        ,VAL_C1
                                                        ,VAL_C2
                                                        ,VAL_C3
                                                        ,VAL_C5
                                                        ,VAL_C6
                                                        ,VAL_C8
                                                        ,VAL_C15
                                                        ) VALUES(
                                                         i.ID_META_ROW
                                                        ,i.ID_FLEX_TBL
                                                        ,i.ID_EMPRESA
                                                        ,i.VAL_C1
                                                        ,i.VAL_C2
                                                        ,i.VAL_C3
                                                        ,null--i.VAL_C5       --jjaq 22-10-2018 no antes null, con null no muestra la suplencia en consulta
                                                        ,NULL
                                                        ,i.VAL_C8
                                                        ,i.VAL_C15
                                                        );
*/
--                ELSIF(i.VAL_C4 IS NULL) AND
--                     (i.VAL_C7 IS NULL)THEN
                    INSERT INTO DERCORP_CON_ADM_VIG_TMP( ID_META_ROW
                                                        ,ID_FLEX_TBL
                                                        ,ID_EMPRESA
                                                        ,VAL_C1
                                                        ,VAL_C2
                                                        ,VAL_C3
                                                        ,VAL_C5
                                                        ,VAL_C6
                                                        ,VAL_C8
                                                        ,VAL_C15
                                                        ) VALUES(
                                                         i.ID_META_ROW
                                                        ,i.ID_FLEX_TBL
                                                        ,i.ID_EMPRESA
                                                        ,i.VAL_C1
                                                        ,i.VAL_C2
                                                        ,i.VAL_C3
                                                        ,i.VAL_C5
                                                        ,i.VAL_C6
                                                        ,i.VAL_C8
                                                        ,i.VAL_C15
                                                        );
--                END IF;
            END LOOP;
        END IF;
      COMMIT;
  END CONSULTAR_ADM_VIG_PR;
    --ECM 20 Julio 2016 Obtener valores de los checks Utilidad y Perdida en AES.
    PROCEDURE GET_AES_RESULTADO_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,piinIdMetaRow   IN NUMBER
    )
    IS
    BEGIN
        OPEN porcRSResultado FOR
        SELECT  VAL_C7 AS UTILIDAD,
                VAL_C9 AS PERDIDA
        FROM    DERCORP_METATBL_TAB
        WHERE   1 = 1
        AND     ID_META_ROW = piinIdMetaRow
        ;
    END GET_AES_RESULTADO_PR;
    --ECM 27 Julio 2016 Obtener Capital Fijo, Capital Variable, Capital Social, Capital Total
    PROCEDURE GET_CAP_FIJ_VAR_SOC_AUM_DIS_PR(porcRSResultado OUT SYS_REFCURSOR
                                            ,piinIdMetaRow   IN NUMBER)
    IS
    BEGIN
        OPEN porcRSResultado FOR
            SELECT  VAL_C9  AS CAPITAL_FIJO_AUM,
                    VAL_C10 AS DE_CAP_FIJ_AUM,
                    VAL_C11 AS CON_CAP_FIJ_AUM,
                    VAL_C12 AS QUEDAR_CAP_FIJ_AUM,
                    VAL_C13 AS CAPITAL_VARIABLE_AUM,
                    VAL_C14 AS DE_CAP_VAR_AUM,
                    VAL_C15 AS CON_CAP_VAR_AUM,
                    VAL_C16 AS QUEDAR_CAP_VAR_AUM,
                    VAL_C17 AS CAPITAL_SOCIAL_AUM,
                    VAL_C43 AS CAPITAL_FIJO_DIS,
                    VAL_C44 AS DE_CAP_FIJ_DIS,
                    VAL_C45 AS CON_CAP_FIJ_DIS,
                    VAL_C46 AS QUEDAR_CAP_FIJ_DIS,
                    VAL_C47 AS CAPITAL_VARIABLE_DIS,
                    VAL_C48 AS DE_CAP_VAR_DIS,
                    VAL_C49 AS CON_CAP_VAR_DIS,
                    VAL_C50 AS QUEDAR_CAP_VAR_DIS,
                    VAL_C51 AS CAPITAL_SOCIAL_DIS,
                    VAL_C52 AS CAPITAL_TOTAL
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND   ID_META_ROW = piinIdMetaRow
            ;
    END;
    --ECM 04 Agosto 2016 Obtener los valores de los campos restantes en Fusion.
    PROCEDURE GET_CAMPOS_VALORES_FUSION_PR(porcRSResultado OUT SYS_REFCURSOR
                                          ,piinIdMetaRow   IN NUMBER)
    IS
    BEGIN
        OPEN porcRSResultado FOR
        SELECT   VAL_C149 AS Asunto
                ,VAL_C2   AS TipoReunion
                ,VAL_C98  AS SociedadFusionante
                ,VAL_C3   AS Fecha
                ,VAL_C4   AS Hora
                ,VAL_C99  AS AsambleasSociedadesFusionadas
                ,VAL_C18  AS FechaEfectosPartes
                ,VAL_C19  AS FechaEfectosTerceros
                ,VAL_C20  AS ArtClauEstatRefor
                ,VAL_C21  AS OtrosObservaciones
                ,VAL_C100 AS OtrosRegistros
        FROM    DERCORP_METATBL_TAB
        WHERE   1=1
        AND     ID_META_ROW = piinIdMetaRow
        ;
    END;
    --ECM 29 Agosto 2016 Obtner el valor nominal o valor te??rico nominal.
    PROCEDURE GET_VAL_NOM_TEO_PR(poinValor OUT NUMBER
                                ,piinIdAddCampo IN NUMBER
                                ,piinIdEmpresa  IN NUMBER
    )
    IS
    BEGIN
        SELECT   VAL_VALOR
        INTO     poinValor
        FROM     DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE    1=1
        AND      ID_ADD_CAMPO IN (piinIdAddCampo)
        AND      ID_EMPRESA = piinIdEmpresa
        ;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      poinValor := 0;
    END GET_VAL_NOM_TEO_PR;
    --ECM 29 Agosto 2016 Resumen General - Obtener el socio externo.
    PROCEDURE GET_SOCIO_EXTERNO_PR(postValor OUT VARCHAR2
                                  ,piinIdEmpresa  IN NUMBER
    )
    IS
    BEGIN
        SELECT  VAL_CAT_VAL
        INTO    postValor
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
        WHERE   1=1
        AND     ID_CATALOGO_VALOR = (
                                      SELECT   VAL_VALOR
                                      FROM     DERCORP_ADD_CAMPO_VALOR_TAB
                                      WHERE    1=1
                                      AND      ID_ADD_CAMPO IN (521)
                                      AND      ID_EMPRESA = piinIdEmpresa
        )
        ;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      postValor := '';
    END GET_SOCIO_EXTERNO_PR;
    --ECM 29 Agosto 2016 Resumen General - Info General - Admite Extranjeros
    PROCEDURE GET_ADMITE_EXTRANJEROS_PR(postValor OUT VARCHAR2
                                       ,piinIdEmpresa  IN NUMBER
     )
     IS
     BEGIN
        SELECT  VAL_CAT_VAL
        INTO    postValor
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
        WHERE   1=1
        AND     ID_CATALOGO_VALOR = (
                                      SELECT   VAL_VALOR
                                      FROM     DERCORP_ADD_CAMPO_VALOR_TAB
                                      WHERE    1=1
                                      AND      ID_ADD_CAMPO IN (510)
                                      AND      ID_EMPRESA = piinIdEmpresa
        )
        ;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        postValor := '';
     END GET_ADMITE_EXTRANJEROS_PR;
    --ECM 31 Agosto 2016 - Reformas y Movimientos - Aprobacion Ejercicio Social
    --Obtener los valores de los checks de Otros Acuerdos.
    PROCEDURE GET_AES_OTROS_ACUERDOS_PR(porcRSResultado OUT SYS_REFCURSOR
                                       ,piinIdMetaRow   IN NUMBER
    )
    IS
    BEGIN
        OPEN porcRSResultado FOR
            SELECT VAL_C8  AS APROB_DIC_FISCAL
                  ,VAL_C92 AS DECRE_DIVIDENDOS
                  ,VAL_C22 AS RATIFI_CONSEJEROS
                  ,VAL_C23 AS RATIFI_FUNCIONARIOS
                  ,VAL_C24 AS RATIFI_COMISARIOS
                  ,VAL_C25 AS DESIG_CONSEJEROS
                  ,VAL_C26 AS DESIG_FUNCIONARIOS
                  ,VAL_C27 AS DESIG_COMISARIOS
                  ,VAL_C29 AS OTORGA_PODERES
                  ,VAL_C30 AS REVOCA_PODERES
            FROM  DERCORP_METATBL_TAB
            WHERE 1=1
            AND   ID_META_ROW = piinIdMetaRow
        ;
    END GET_AES_OTROS_ACUERDOS_PR;
    --ECM 09 Septiembre 2016 - Administracion y Vigilancia
    -- Superindice en el campo Nombre del Suplente
    PROCEDURE GET_ADM_VIG_NOMBRE_SUPLENTE_PR(piinIdMetaRow  IN NUMBER
                                            ,piinIdEmpresa  IN NUMBER
                                            ,piinIdFlex     IN NUMBER
                                            ,poinSuperindice OUT NUMBER
    )
    IS
        piSuperindice NUMBER;
        piValor_c8    VARCHAR2(3000);
    BEGIN
        /*SELECT  COD_CAT_VAL
        INTO    piSuperindice
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
        WHERE   1=1
        AND     ID_CATALOGO_VALOR = (SELECT VAL_C8
                                     FROM   DERCORP_METATBL_TAB
                                     WHERE  1=1
                                     AND    ID_META_ROW = piinIdMetaRow
                                     )
        ;*/
        --JJAQ PARA ASIGNAR NUMERO DE INDICE DESDE 1
       /* SELECT num_indice INTO    piSuperindice
        FROM PENDIUM_INDICES_ADMIN_VIG_TAB
        WHERE 1           = 1
        AND   ID_META_ROW = piinIdMetaRow
        ORDER BY VAL_C8;
        */
        SELECT VAL_C8 INTO piValor_c8
                                     FROM   DERCORP_METATBL_TAB
                                     WHERE  1=1
                                     AND    ID_META_ROW = piinIdMetaRow;
        SELECT num_indice INTO    piSuperindice
          FROM PENDIUM_INDICES_ADMIN_VIG_TAB ind
          WHERE 1           = 1
          AND   ind.VAL_C8 = piValor_c8
          AND   ind.id_flex_tbl = piinIdFlex
          AND   ind.id_empresa = piinIdEmpresa;
          poinSuperindice := piSuperindice;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        piSuperindice := 0;
        poinSuperindice := piSuperindice;
    END GET_ADM_VIG_NOMBRE_SUPLENTE_PR;
    --ECM 12 Septiembre 2016 - Adm y Vig Referencia de nota al pie.
    PROCEDURE GET_ADM_VIG_REF_NOTA_PIE_PR(piinIdFlex  IN NUMBER
                                         ,piinIdEmp   IN NUMBER
                                         ,postRefNotaPies OUT VARCHAR2
    )
    IS
      lstRefNotaPie VARCHAR2(32000);
      liSubIndice   NUMBER;
      lstSubIni  VARCHAR2(32000) := '<sup class=''superIndice''>';
      lstSubFin  VARCHAR2(32000) := '</sup>';
      CURSOR  REF_NOTA_PIE_CUR(piIdFlex NUMBER, piIdEmp  NUMBER)
      IS
      /*SELECT  DISTINCT(VAL_C8)
             ,NVL((SELECT  COD_CAT_VAL
                   FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                   WHERE 1=1
                   AND ID_CATALOGO_VALOR IN (VAL_C8))
                   , 0) AS subIndice
      --FROM    DERCORP_METATBL_TAB
      FROM    DERCORP_CON_ADM_VIG_TMP
      WHERE   1=1
      AND     ID_FLEX_TBL = piIdFlex
      AND     ID_EMPRESA  = piIdEmp
      AND     VAL_C5 IS NOT NULL
      AND     VAL_C5 > 0
      ORDER BY VAL_C8
      ;
      --JJAQ 06/12/2016 indice desde 1
      SELECT T1.VAL_C8,ROWNUM AS subIndice,ID_META_ROW
      FROM (
              SELECT  DISTINCT(VAL_C8) AS VAL_C8
                       ,NVL((SELECT  COD_CAT_VAL
                             FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                             WHERE 1=1
                             AND ID_CATALOGO_VALOR IN (VAL_C8))
                             , 0) AS subIndice
                             ,ID_META_ROW
                --FROM    DERCORP_METATBL_TAB
                FROM    DERCORP_CON_ADM_VIG_TMP
                WHERE   1=1
                AND     ID_FLEX_TBL = piIdFlex
                AND     ID_EMPRESA  = piIdEmp
                AND     VAL_C5 IS NOT NULL
                AND     VAL_C5 > 0
                ORDER BY VAL_C8 )t1
                ;*/
        --ULR indice desde 1 sin repetir registros
        --SELECT T1.VAL_C8
        --FROM (
                SELECT  DISTINCT(tmp.VAL_C8) AS VAL_C8,
                        (SELECT num_indice
                          FROM PENDIUM_INDICES_ADMIN_VIG_TAB ind
                          WHERE 1           = 1
                          AND   ind.VAL_C8 = tmp.VAL_C8
                          AND   ind.id_flex_tbl = piIdFlex
                          AND   ind.id_empresa = piIdEmp)as subIndice
                  --FROM    DERCORP_METATBL_TAB
                  FROM    DERCORP_CON_ADM_VIG_TMP tmp
                  WHERE   1=1
                  AND     ID_FLEX_TBL = piIdFlex
                  AND     ID_EMPRESA  = piIdEmp
                  AND     VAL_C5 IS NOT NULL
                  AND     VAL_C5 > 0
                  ORDER BY tmp.VAL_C8
                  --)t1
                  ;
    BEGIN
        --liSubIndice :=0;
        FOR i IN REF_NOTA_PIE_CUR(piinIdFlex, piinIdEmp)
        LOOP
            BEGIN
                --liSubIndice :=liSubIndice +1;
                SELECT  VAL_CAT_VAL
                INTO    lstRefNotaPie
                FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                WHERE   1=1
                AND     ID_CATALOGO_VALOR = i.VAL_C8
                ;
                postRefNotaPies := postRefNotaPies||
                                   CHR(13)||'<br>'||lstRefNotaPie||lstSubIni||i.subIndice||lstSubFin;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lstRefNotaPie :='';
                postRefNotaPies := postRefNotaPies||
                                   CHR(13)||lstRefNotaPie||i.subIndice;
            END;
        END LOOP;
    END GET_ADM_VIG_REF_NOTA_PIE_PR;
    --ECM 24 Octubre 2016 - getCamposConFlex
    PROCEDURE GET_CAMPOS_CON_FLEX_PR(EMPRESAID NUMBER, SUBSECTIONID NUMBER, RESULTSET OUT SYS_REFCURSOR)
    AS
    BEGIN
        OPEN RESULTSET FOR
        SELECT C.*
               ,V.VAL_VALOR
        FROM   DERCORP_ADD_CAMPO_TAB C
        LEFT JOIN DERCORP_ADD_CAMPO_VALOR_TAB V ON V.ID_ADD_CAMPO     = C.ID_ADD_CAMPO
                                                AND V.ID_EMPRESA      = EMPRESAID
        WHERE   1=1
        AND     C.ID_SUBSECCION = SUBSECTIONID
        AND     DES_TIPO_CAMPO = 'FLEXTABLE'
        AND     C.ID_FLEX_TBL  IN (
                                    SELECT  CT.ID_FLEX_TBL
                                    FROM    DERCORP_ADD_CAMPO_TAB CT
                                    LEFT    JOIN DERCORP_ADD_CAMPO_VALOR_TAB CVT
                                    ON      CVT.ID_ADD_CAMPO = CT.ID_ADD_CAMPO
                                    WHERE   1=1
                                    AND     CT.DES_TIPO_CAMPO = 'CHECKBOX_A'
                                    AND     CVT.VAL_VALOR IS NOT NULL
                                    AND     CVT.ID_EMPRESA = EMPRESAID
        )
        ORDER BY ID_SECCION, ID_SUBSECCION, C.ID_AGRUPACION, TO_NUMBER(C.ID_ORDER)
        ;
    END GET_CAMPOS_CON_FLEX_PR;
    --24 Octubre 2016 - getAgrupacionesConFlex
    PROCEDURE GET_AGRUPACIONES_CON_FLEX_PR(sectionID number, subSectionID number, resultSet OUT SYS_REFCURSOR, piinIdEmp IN NUMBER)
    AS
    BEGIN
      OPEN resultSet FOR
          SELECT    ID_AGRUPACION
                   ,DECODE (DES_TIPO_CAMPO, 'FLEXTABLE', 'YES','AJAX_PAGE','YES', 'NO') IS_FLEX
                   ,CASE (SELECT COUNT(*)
                          FROM DERCORP_ADD_CAMPO_TAB
                          WHERE ID_SECCION = C.ID_SECCION
                          AND ID_SUBSECCION = C.ID_SUBSECCION
                          AND ID_AGRUPACION = C.ID_AGRUPACION
                          AND ATRIBUTO2 = 'PAIR')  WHEN 0 THEN 'NO' ELSE 'YES' END IS_PAIR
          FROM    DERCORP_ADD_CAMPO_TAB C
          WHERE   1=1
          AND     ID_SECCION =  sectionID
          AND     ID_SUBSECCION = subSectionID
          AND     DES_TIPO_CAMPO = 'FLEXTABLE'
          AND     C.ID_FLEX_TBL  IN (
                                      SELECT  CT.ID_FLEX_TBL
                                      FROM    DERCORP_ADD_CAMPO_TAB CT
                                      LEFT    JOIN DERCORP_ADD_CAMPO_VALOR_TAB CVT
                                      ON      CVT.ID_ADD_CAMPO = CT.ID_ADD_CAMPO
                                      WHERE   1=1
                                      AND     CT.DES_TIPO_CAMPO = 'CHECKBOX_A'
                                      AND     CVT.VAL_VALOR IS NOT NULL
                                      AND     CVT.ID_EMPRESA = piinIdEmp
          )
          GROUP BY
          ID_AGRUPACION,
          DECODE (DES_TIPO_CAMPO, 'FLEXTABLE', 'YES','AJAX_PAGE','YES', 'NO'),
          ID_SECCION,
          ID_SUBSECCION
          ORDER BY  C.ID_AGRUPACION
          ;
    END GET_AGRUPACIONES_CON_FLEX_PR;
    PROCEDURE INSERT_SUBINDICE_ADMIN_VIG_PR(piinIdFlex  IN NUMBER
                                             ,piinIdEmp   IN NUMBER
                                             ,postRefNotaPies OUT VARCHAR2
      )
      IS
      lstRefNotaPie  VARCHAR2(32000);
      liSubIndice    NUMBER;
      liExisteVal_C8 NUMBER;
      CURSOR  REF_NOTA_PIE_CUR(piIdFlex NUMBER, piIdEmp  NUMBER)
      IS
      --JJAQ 06/12/2016 indice desde 1
     /* SELECT T1.VAL_C8,ROWNUM AS subIndice,ID_META_ROW
      FROM (
              SELECT  DISTINCT(VAL_C8) AS VAL_C8
                       ,NVL((SELECT  COD_CAT_VAL
                             FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                             WHERE 1=1
                             AND ID_CATALOGO_VALOR IN (VAL_C8))
                             , 0) AS subIndice
                             ,ID_META_ROW
                --FROM    DERCORP_METATBL_TAB
                FROM    DERCORP_CON_ADM_VIG_TMP
                WHERE   1=1
                AND     ID_FLEX_TBL = piIdFlex
                AND     ID_EMPRESA  = piIdEmp
                AND     VAL_C5 IS NOT NULL
                AND     VAL_C5 > 0
                ORDER BY VAL_C8 )t1
                ;
      */
      SELECT T1.VAL_C8,ROWNUM AS subIndice
      FROM (
              SELECT  DISTINCT(VAL_C8) AS VAL_C8
                       ,NVL((SELECT  COD_CAT_VAL
                             FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                             WHERE 1=1
                             AND ID_CATALOGO_VALOR IN (VAL_C8))
                             , 0) AS subIndice
                             --,ID_META_ROW
                --FROM    DERCORP_METATBL_TAB
                FROM    DERCORP_CON_ADM_VIG_TMP
                WHERE   1=1
                AND     ID_FLEX_TBL = piIdFlex
                AND     ID_EMPRESA  = piIdEmp
                AND     VAL_C5 IS NOT NULL
                AND     VAL_C5 > 0
                ORDER BY VAL_C8 )t1
                ;
    BEGIN
          --JJAQ Indices desde 1 Admin y Vigilancia
                DELETE FROM USRDRC.PENDIUM_INDICES_ADMIN_VIG_TAB
                WHERE ID_EMPRESA  = piinIdEmp
                AND   ID_FLEX_TBL = piinIdFlex;
        FOR i IN REF_NOTA_PIE_CUR(piinIdFlex, piinIdEmp)
        LOOP
            BEGIN
                --AND   ID_META_ROW = i.id_meta_row;
                INSERT INTO PENDIUM_INDICES_ADMIN_VIG_TAB(
                                                                  ID_EMPRESA,
                                                                  ID_FLEX_TBL
                                                                  --ID_META_ROW
                                                                  ,NUM_INDICE
                                                                  ,VAL_C8
                                                                )
                VALUES(
                      piinIdEmp,
                      piinIdFlex
                      --i.id_meta_row
                     ,i.subIndice
                     ,i.VAL_C8
                      );
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lstRefNotaPie :=SQLERRM;
            END;
        END LOOP;
END INSERT_SUBINDICE_ADMIN_VIG_PR;
--JAMS 02-07-2018 Se valida informacion en las flextables para permitir o no
    --eliminar el detalle de algun catalogo
    --Modificacion JJAQ 21-09-2018 Ya no se ocupa la variable piinIdFlex
PROCEDURE GET_DATOS_EN_FLEX_PR(
                            piinIdFlex  IN NUMBER
                            ,piinIdValor IN VARCHAR2
                            ,poutResultado OUT NUMBER
)
  IS
  v_cadena_sql          VARCHAR2(5000);
  rsResultado           SYS_REFCURSOR;
  linCount              NUMBER := 0;
  linCoincidencias      NUMBER := 0;
  /*
    CURSOR QUERY_ID_FLEXS_CUR
        IS
            SELECT ID_FLEX_TBL
            FROM DERCORP_FLEX_TBLS_TAB
            WHERE attribute_category is null;
      */
    CURSOR QUERY_COLUMS_FLEX(
                            piinIdFlex NUMBER
                            )
        IS
            /*SELECT COD_FLEX_COLUM
            FROM DERCORP_FLEX_COLUMS_TAB
            WHERE ID_FLEX_TBL  = piinIdFlex
            AND DES_TIPO_COLUM ='SELECT';*/
            SELECT COD_FLEX_COLUM,ID_FLEX_TBL
            FROM DERCORP_FLEX_COLUMS_TAB
            WHERE ID_FLEX_TBL in (SELECT ID_FLEX_TBL from DERCORP_FLEX_TBLS_TAB where id_flex_tbl not in (17,18))
            AND DES_TIPO_COLUM ='SELECT';
  BEGIN
 -- FOR i IN QUERY_ID_FLEXS_CUR
   -- LOOP
         FOR u IN QUERY_COLUMS_FLEX(piinIdFlex)
            LOOP
                 dbms_output.put_line('U.ID_FLEX_TBL: '      || U.ID_FLEX_TBL);
                 dbms_output.put_line('piinIdValor: '        || piinIdValor);
                 dbms_output.put_line('u.COD_FLEX_COLUM: '   || u.COD_FLEX_COLUM);
                v_cadena_sql:= 'SELECT COUNT(1) FROM DERCORP_METATBL_TAB
                WHERE ID_FLEX_TBL = ' || TO_NUMBER(U.ID_FLEX_TBL) || '
                AND ' || u.COD_FLEX_COLUM || ' = ' || ''''||piinIdValor||'''';
                --and VAL_C5 = to_char(18100)';
                OPEN rsResultado for v_cadena_sql;
                LOOP
                     FETCH rsResultado INTO linCount;
                     exit when rsResultado%notfound;
                     IF linCount > 0
                     THEN
                        linCoincidencias := linCoincidencias + linCount;
                     END IF;
                END LOOP;
                    poutResultado := linCoincidencias;
            END LOOP;
  --  END LOOP;
END GET_DATOS_EN_FLEX_PR;
--JJAQ 27/01/2019 PARA EL REPORTE PREDEFINIDO DE ADMIN Y VIGILANCIA SE AGREGA IN EN EL QUERY PARA QUE SE TRAIGA
--SOLO A LAS PERSONAS QUE SOLICITEN EN EL REPORTE
PROCEDURE CONSULTAR_ADM_VIG_BY_NOMBRE_PR(P_ID_EMPRESA   IN INTEGER
                                        ,P_ID_FLEX_TAB  IN VARCHAR2
                                        ,P_NOMBRE       IN VARCHAR2)
  IS
   v_cadena_sql             VARCHAR2(5000);
   rsResultado              SYS_REFCURSOR;
   rowMeta                  DERCORP_METATBL_TAB%ROWTYPE;
  /*
    CURSOR CON_ADM_VIG_CUR(CP_ID_EMPRESA   IN INTEGER
                          ,CP_ID_FLEX_TAB  IN VARCHAR2)
    IS
    SELECT   META.*
    FROM     DERCORP_METATBL_TAB META
    WHERE    META.ID_EMPRESA  =   CP_ID_EMPRESA
    AND      META.ID_FLEX_TBL =   CP_ID_FLEX_TAB
    AND      META.VAL_C15 IS NOT NULL --No de orden
    --AND      ( (META.VAL_C4 IS NULL ) OR (META.VAL_C7 IS NULL ) ) --JJAQ 09/01/2019 Se comenta para el punto prioritario numero 16
    AND VAL_C1 IN('15611,16787')
    ORDER BY TO_NUMBER(META.VAL_C15), DERCORP_CATALOGS_PKG.GET_FUNCIONARIOS_FN(META.VAL_C1);
    */
    BEGIN
        DELETE DERCORP_CON_ADM_VIG_TMP
        WHERE 1=1
        AND ID_EMPRESA = P_ID_EMPRESA
        AND ID_FLEX_TBL = P_ID_FLEX_TAB
        ;
        v_cadena_sql := 'SELECT META.*
                     FROM     DERCORP_METATBL_TAB META ' ||
                     ' WHERE    META.ID_EMPRESA  = ' || P_ID_EMPRESA ||
                     ' AND      META.ID_FLEX_TBL = '||  P_ID_FLEX_TAB ||
                     ' AND      META.VAL_C15 IS NOT NULL '||
                     ' AND VAL_C1 IN(' || P_NOMBRE || ')'||
                     ' ORDER BY TO_NUMBER(META.VAL_C15), DERCORP_CATALOGS_PKG.GET_FUNCIONARIOS_FN(META.VAL_C1)';
        IF  P_ID_FLEX_TAB = '8' OR
            --P_ID_FLEX_TAB = '16' OR
            P_ID_FLEX_TAB = '25' OR
            --P_ID_FLEX_TAB = '26' OR
            P_ID_FLEX_TAB = '39'
            --P_ID_FLEX_TAB = '44' OR
            --P_ID_FLEX_TAB = '45' OR
            --P_ID_FLEX_TAB = '43'
            THEN
              /*
                OPEN rsResultado for v_cadena_sql;
                LOOP
                     FETCH rsResultado INTO linCount;
                     exit when rsResultado%notfound;
                END LOOP;*/
            --FOR i IN CON_ADM_VIG_CUR(P_ID_EMPRESA,P_ID_FLEX_TAB)
            OPEN rsResultado for v_cadena_sql;
            LOOP
                FETCH rsResultado INTO rowMeta;
                exit when rsResultado%notfound;
--                IF (i.VAL_C4 IS NOT NULL)THEN  --JJAQ 11/01/2019 Se comenta para el punto prioritario numero 16
--                    NULL;
--                ELSE
                    INSERT INTO DERCORP_CON_ADM_VIG_TMP(ID_META_ROW
                                                        ,ID_FLEX_TBL
                                                        ,ID_EMPRESA
                                                        ,VAL_C1
                                                        ,VAL_C2
                                                        ,VAL_C3
                                                        ,VAL_C15
                                                        ) VALUES(
                                                         rowMeta.ID_META_ROW
                                                        ,rowMeta.ID_FLEX_TBL
                                                        ,rowMeta.ID_EMPRESA
                                                        ,rowMeta.VAL_C1
                                                        ,rowMeta.VAL_C2
                                                        ,rowMeta.VAL_C3
                                                        ,rowMeta.VAL_C15
                    );
--                END IF;
            END LOOP;
        END IF;
        IF  P_ID_FLEX_TAB = '9' OR
            P_ID_FLEX_TAB = '11' OR
            P_ID_FLEX_TAB = '12' OR
            P_ID_FLEX_TAB = '13' OR
            P_ID_FLEX_TAB = '14' OR
            P_ID_FLEX_TAB = '15' OR
            P_ID_FLEX_TAB = '16' OR
            P_ID_FLEX_TAB = '26' OR
            P_ID_FLEX_TAB = '43' OR
            P_ID_FLEX_TAB = '44' OR
            P_ID_FLEX_TAB = '45' OR
            P_ID_FLEX_TAB = '46' OR -- se agrega flex table JAMS 04/07/2017
            P_ID_FLEX_TAB = '40' THEN
            --FOR i IN CON_ADM_VIG_CUR(P_ID_EMPRESA,P_ID_FLEX_TAB)
             OPEN rsResultado for v_cadena_sql;
            LOOP
                FETCH rsResultado INTO rowMeta;
                exit when rsResultado%notfound;
--                IF (i.VAL_C4 IS NOT NULL) AND
--                   (i.VAL_C7 IS NOT NULL)THEN
--                    NULL;                             --JJAQ 11/01/2019 Se comenta para el punto prioritario numero 16
--                ELSIF(i.VAL_C4 IS NOT NULL) AND
--                     (i.VAL_C7 IS NULL)THEN           --JJAQ 11/01/2019 Se comenta para el punto prioritario numero 16
/*
                         INSERT INTO DERCORP_CON_ADM_VIG_TMP(ID_META_ROW
                                        ,ID_FLEX_TBL
                                        ,ID_EMPRESA
                                        ,VAL_C1
                                        ,VAL_C2
                                        ,VAL_C3
                                        ,VAL_C5
                                        ,VAL_C6
                                        ,VAL_C8
                                        ,VAL_C15
                                        ) VALUES(
                                         i.ID_META_ROW
                                        ,i.ID_FLEX_TBL
                                        ,i.ID_EMPRESA
                                        ,NULL
                                        ,i.VAL_C2
                                        ,NULL
                                        ,i.VAL_C5
                                        ,i.VAL_C6
                                        ,i.VAL_C8
                                        ,i.VAL_C15
                );
                ELSIF(i.VAL_C4 IS NULL) AND
                     (i.VAL_C7 IS NOT NULL)THEN
                    INSERT INTO DERCORP_CON_ADM_VIG_TMP( ID_META_ROW
                                                        ,ID_FLEX_TBL
                                                        ,ID_EMPRESA
                                                        ,VAL_C1
                                                        ,VAL_C2
                                                        ,VAL_C3
                                                        ,VAL_C5
                                                        ,VAL_C6
                                                        ,VAL_C8
                                                        ,VAL_C15
                                                        ) VALUES(
                                                         i.ID_META_ROW
                                                        ,i.ID_FLEX_TBL
                                                        ,i.ID_EMPRESA
                                                        ,i.VAL_C1
                                                        ,i.VAL_C2
                                                        ,i.VAL_C3
                                                        ,null--i.VAL_C5       --jjaq 22-10-2018 no antes null, con null no muestra la suplencia en consulta
                                                        ,NULL
                                                        ,i.VAL_C8
                                                        ,i.VAL_C15
                                                        );
*/
--                ELSIF(i.VAL_C4 IS NULL) AND
--                     (i.VAL_C7 IS NULL)THEN
                    INSERT INTO DERCORP_CON_ADM_VIG_TMP( ID_META_ROW
                                                        ,ID_FLEX_TBL
                                                        ,ID_EMPRESA
                                                        ,VAL_C1
                                                        ,VAL_C2
                                                        ,VAL_C3
                                                        ,VAL_C5
                                                        ,VAL_C6
                                                        ,VAL_C8
                                                        ,VAL_C15
                                                        ) VALUES(
                                                         rowMeta.ID_META_ROW
                                                        ,rowMeta.ID_FLEX_TBL
                                                        ,rowMeta.ID_EMPRESA
                                                        ,rowMeta.VAL_C1
                                                        ,rowMeta.VAL_C2
                                                        ,rowMeta.VAL_C3
                                                        ,rowMeta.VAL_C5
                                                        ,rowMeta.VAL_C6
                                                        ,rowMeta.VAL_C8
                                                        ,rowMeta.VAL_C15
                                                        );
--                END IF;
            END LOOP;
        END IF;
      COMMIT;
END  CONSULTAR_ADM_VIG_BY_NOMBRE_PR;
END DERCORP_CONSULTA_PKG;
/;
