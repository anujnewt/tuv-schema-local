CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_REPORTS_PKG" AS
    PROCEDURE GET_REPORTES_PR(  piinIdRol NUMBER,
                                resultSet OUT SYS_REFCURSOR);
    FUNCTION GET_INFO_ESCRITURA (idEmpresa varchar2, escritura varchar2) RETURN varchar2;
    --ECM 26 Octubre 2016 Ejecutar reporte aprovacion del ejercicio social.
    PROCEDURE GET_REP_RM_AES_PR(lstEjercicioSocial IN VARCHAR2
                                ,liNumberCreateBy  IN NUMBER
    );
END DERCORP_REPORTS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_REPORTS_PKG" AS
   PROCEDURE GET_REPORTES_PR( piinIdRol NUMBER,
                              resultSet OUT SYS_REFCURSOR)
   AS
      lstIn     VARCHAR2(3000);
      lstQuery  VARCHAR2(5000);
   BEGIN
     BEGIN
       SELECT ATRIBUTO2 INTO lstIn
       FROM   SS_ROL_TAB
       WHERE  ID_ROL = piinIdRol;
       IF lstIn IS NULL THEN
         lstIn := '0';
       END IF;
     EXCEPTION
       WHEN OTHERS THEN
         lstIn := '0';
     END;
     IF piinIdRol = 0 THEN
       lstQuery := 'SELECT * FROM DERCORP_REPORTE_TAB ORDER BY NOM_REPORTE';
     ELSE
       lstQuery := 'SELECT * FROM DERCORP_REPORTE_TAB WHERE ID_REPORTE IN('
                  ||lstIn||') ORDER BY NOM_REPORTE';
     END IF;
      OPEN resultSet FOR lstQuery;
    END GET_REPORTES_PR;
    --
    --
    --
    FUNCTION GET_INFO_ESCRITURA (idEmpresa varchar2, escritura varchar2) RETURN varchar2
    As
      countConstitutiva INT;
      countPoderesGenerales INT;
      textResult varchar2(1000);
    Begin
          SELECT
            count(*) INTO countConstitutiva
          FROM
            DERCORP_ADD_CAMPO_VALOR_TAB
          WHERE
            VAL_VALOR = escritura
            AND
            ID_EMPRESA = idEmpresa;
        /*
        select
          COUNT(*) INTO countPoderesGenerales
        from DERCORP_METATBL_TAB
        WHERE
          VAL_C8 = escritura
          AND
          ID_EMPRESA = idEmpresa;
        */
        textResult := '';
        IF countConstitutiva > 0 THEN
            SELECT
                ' de fecha '
                ||
                NVL(DERCORP_REPORTFLEX_PKG.GET_FIELD_TEXT_VALUE(552, idEmpresa),'')
                ||
                ' firmada ante el '||NVL(DERCORP_REPORTFLEX_PKG.GET_FIELD_TEXT_VALUE(553, idEmpresa),'')  -- Lic
                ||
                ' Notario # '
                ||
                NVL(DERCORP_REPORTFLEX_PKG.GET_FIELD_TEXT_VALUE(554, idEmpresa),'')
                ||
                ' de  '||NVL(DERCORP_REPORTFLEX_PKG.GET_ENTIDAD_VALUE(553, idEmpresa),'') --Entidad federativa
                 INTO textResult
            FROM
                DUAL;
        ELSE
            --IF countPoderesGenerales > 0 THEN
            SELECT
                ' de fecha '
                ||
                NVL(VAL_C9,'')
                ||
                ' firmada ante el ' || NVL((SELECT NOM_CAT_VAL FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      where ID_CATALOGO = 12
                      AND ID_CATALOGO_VALOR = VAL_C10),'')  -- Lic
                || ' Notario # ' ||
                NVL(VAL_C11,'')
                ||
                ' de '|| NVL((SELECT ATRIBUTO2 FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                          where ID_CATALOGO = 12
                          AND ID_CATALOGO_VALOR = VAL_C10),'')  -- Entidad federativa
                      INTO textResult
           from DERCORP_METATBL_TAB
            WHERE
              VAL_C8 = escritura
              AND
              ID_EMPRESA = idEmpresa
              AND
              ROWNUM = 1
              ;
        END IF;
        RETURN textResult;
    END GET_INFO_ESCRITURA;
    --ECM 26 Octubre 2016 Ejecutar reporte aprovacion del ejercicio social.
    PROCEDURE GET_REP_RM_AES_PR(lstEjercicioSocial IN VARCHAR2
                                ,liNumberCreateBy  IN NUMBER
                                )
    IS
        CURSOR META_REP_RF_AES_CUR IS
        SELECT   META.ID_EMPRESA,
              ( SELECT  DISTINCT(BUS.DENOM_ACTUAL)
              FROM    DERCORP_BUSQUEDA_VIEW BUS
              WHERE   1=1
              AND     BUS.DENOM_ACTUAL IS NOT NULL
              AND     BUS.ID_CLASIFICACION IN (462,466)
              AND     BUS.ID_PAIS = 624
              AND     BUS.ID_EMPRESA = META.ID_EMPRESA
              )AS DENOM_ACTUAL,
              META.VAL_C51 AS FEC_DICTAMEN_FISCAL,
              META.VAL_C46 AS FEC_DIC_FINAN,
              META.VAL_C41 AS FEC_INF_COMI,
              META.VAL_C88 AS FEC_CONSTANCIA,
              META.VAL_C36 AS FEC_ANUAL,
              META.VAL_C5  AS EJERCICIOSOCIAL
        FROM DERCORP_METATBL_TAB META
        WHERE 1=1
        AND   ID_FLEX_TBL = 23
        AND   ID_EMPRESA IN (
                  SELECT  DISTINCT ID_EMPRESA
                  FROM DERCORP_BUSQUEDA_VIEW
                  WHERE DENOM_ACTUAL IS NOT NULL
                  AND ID_CLASIFICACION IN (462,466)
                  AND ID_PAIS = 624
        )
        AND   (META.VAL_C5 LIKE '%'||lstEjercicioSocial||'%'
               OR META.VAL_C5 IS NULL
        )
    /*
        UNION ALL
            SELECT es.id_empresa,
                   ( SELECT  DISTINCT(BUS.DENOM_ACTUAL)
                          FROM    DERCORP_BUSQUEDA_VIEW BUS
                          WHERE   1=1
                          AND     BUS.DENOM_ACTUAL IS NOT NULL
                          AND     BUS.ID_CLASIFICACION IN (462,466)
                          AND     BUS.ID_PAIS = 624
                          AND     BUS.ID_EMPRESA = es.ID_EMPRESA
                    )AS DENOM_ACTUAL,
                    to_char(es.fecha_entrega) as FEC_DICTAMEN_FISCAL,
                    null AS FEC_DIC_FINAN,
                    null AS FEC_INF_COMI,
                    null AS FEC_CONSTANCIA,
                    null AS FEC_ANUAL,
                    null  AS EJERCICIOSOCIAL
          From PENDIUM_EJERCICIO_SOCIAL_TAB es
          WHERE 1=1--id_empresa = 776--ID_META_ROW = 11441
          AND EJERCICIO_SOCIAL = lstEjercicioSocial
          and TIPO_DOCUMENT = 'df'
      UNION ALL
          SELECT es.id_empresa,
                 ( SELECT  DISTINCT(BUS.DENOM_ACTUAL)
                        FROM    DERCORP_BUSQUEDA_VIEW BUS
                        WHERE   1=1
                        AND     BUS.DENOM_ACTUAL IS NOT NULL
                        AND     BUS.ID_CLASIFICACION IN (462,466)
                        AND     BUS.ID_PAIS = 624
                        AND     BUS.ID_EMPRESA = es.ID_EMPRESA
                  )AS DENOM_ACTUAL,
                  null as FEC_DICTAMEN_FISCAL,
                  to_char(es.fecha_entrega) AS FEC_DIC_FINAN,
                  null AS FEC_INF_COMI,
                  null AS FEC_CONSTANCIA,
                  null AS FEC_ANUAL,
                  null  AS EJERCICIOSOCIAL
          From PENDIUM_EJERCICIO_SOCIAL_TAB es
          WHERE 1=1--id_empresa = 776--ID_META_ROW = 11441
          AND EJERCICIO_SOCIAL = lstEjercicioSocial
          and TIPO_DOCUMENT = 'def'
    UNION ALL
          SELECT es.id_empresa,
                 ( SELECT  DISTINCT(BUS.DENOM_ACTUAL)
                        FROM    DERCORP_BUSQUEDA_VIEW BUS
                        WHERE   1=1
                        AND     BUS.DENOM_ACTUAL IS NOT NULL
                        AND     BUS.ID_CLASIFICACION IN (462,466)
                        AND     BUS.ID_PAIS = 624
                        AND     BUS.ID_EMPRESA = es.ID_EMPRESA
                  )AS DENOM_ACTUAL,
                  null as FEC_DICTAMEN_FISCAL,
                  null AS FEC_DIC_FINAN,
                  to_char(es.fecha_entrega) AS FEC_INF_COMI,
                  null AS FEC_CONSTANCIA,
                  null AS FEC_ANUAL,
                  null  AS EJERCICIOSOCIAL
          From PENDIUM_EJERCICIO_SOCIAL_TAB es
          WHERE 1=1--id_empresa = 776--ID_META_ROW = 11441
          AND EJERCICIO_SOCIAL = lstEjercicioSocial
          and TIPO_DOCUMENT = 'infCom'
      UNION ALL
          SELECT es.id_empresa,
                 ( SELECT  DISTINCT(BUS.DENOM_ACTUAL)
                        FROM    DERCORP_BUSQUEDA_VIEW BUS
                        WHERE   1=1
                        AND     BUS.DENOM_ACTUAL IS NOT NULL
                        AND     BUS.ID_CLASIFICACION IN (462,466)
                        AND     BUS.ID_PAIS = 624
                        AND     BUS.ID_EMPRESA = es.ID_EMPRESA
                  )AS DENOM_ACTUAL,
                  null as FEC_DICTAMEN_FISCAL,
                  null AS FEC_DIC_FINAN,
                  null AS FEC_INF_COMI,
                  null AS FEC_CONSTANCIA,
                  to_char(es.fecha_entrega) AS FEC_ANUAL,
                  null  AS EJERCICIOSOCIAL
          From PENDIUM_EJERCICIO_SOCIAL_TAB es
          WHERE 1=1--id_empresa = 776--ID_META_ROW = 11441
          AND EJERCICIO_SOCIAL = lstEjercicioSocial
          and TIPO_DOCUMENT = 'solicitud'
          */
        ORDER BY DENOM_ACTUAL
        ;
        CURSOR  EMPRESAS_RESTANTES_CUR IS
        SELECT  DISTINCT BUS.ID_EMPRESA, BUS.DENOM_ACTUAL
        FROM    DERCORP_BUSQUEDA_VIEW BUS
        WHERE   DENOM_ACTUAL IS NOT NULL
        AND     ID_CLASIFICACION IN (462,466)
        AND     ID_PAIS = 624
        AND     NOT EXISTS (SELECT   META.ID_EMPRESA
                            FROM DERCORP_METATBL_TAB META
                            WHERE 1=1
                            AND   META.ID_FLEX_TBL = 23
                            AND   META.ID_EMPRESA = BUS.ID_EMPRESA
                            AND   (META.VAL_C5 LIKE '%'||lstEjercicioSocial||'%'
                                   OR META.VAL_C5 IS NULL
                            )
        )
        ;
    BEGIN
        DELETE FROM USRDRC.PENDIUM_REP_RM_AES_TMP;
        BEGIN
            FOR i IN META_REP_RF_AES_CUR
            LOOP
                INSERT INTO USRDRC.PENDIUM_REP_RM_AES_TMP( ID_EMPRESA
                                                          ,DENOM_ACTUAL
                                                          ,FEC_DICTAMEN_FISCAL
                                                          ,FEC_DIC_FINAN
                                                          ,FEC_INF_COMI
                                                          ,FEC_CONSTANCIA
                                                          ,FEC_ANUAL
                                                          ,EJERCICIOSOCIAL
                                                          ,NUM_CREATED_BY
                                                          ,FEC_CREATION_DATE
                                                          )VALUES(
                                                           i.ID_EMPRESA
                                                          ,i.DENOM_ACTUAL
                                                          ,i.FEC_DICTAMEN_FISCAL
                                                          ,i.FEC_DIC_FINAN
                                                          ,i.FEC_INF_COMI
                                                          ,i.FEC_CONSTANCIA
                                                          ,i.FEC_ANUAL
                                                          ,i.EJERCICIOSOCIAL
                                                          ,liNumberCreateBy
                                                          ,SYSDATE
                                                          );
            END LOOP;
            COMMIT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
        END;
        BEGIN
            FOR i IN EMPRESAS_RESTANTES_CUR
            LOOP
                INSERT INTO USRDRC.PENDIUM_REP_RM_AES_TMP( ID_EMPRESA
                                                          ,DENOM_ACTUAL
                                                          ,NUM_CREATED_BY
                                                          ,FEC_CREATION_DATE
                                                          )VALUES(
                                                          i.ID_EMPRESA
                                                          ,i.DENOM_ACTUAL
                                                          ,liNumberCreateBy
                                                          ,SYSDATE
                                                          );
            END LOOP;
            COMMIT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
        END;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    END GET_REP_RM_AES_PR;
END DERCORP_REPORTS_PKG;
/;
