CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_REPORTFLEX_PKG" AS
    PROCEDURE GET_REPORTES_PR(  piinIdRol NUMBER,
                                resultSet OUT SYS_REFCURSOR);
    PROCEDURE GET_REPORTE_PR(resultSet OUT SYS_REFCURSOR, idReportFlex int);
    PROCEDURE GET_SECCIONES_PR(resultSet OUT SYS_REFCURSOR, idReportFlex int);
    PROCEDURE GET_ROWS_PR(resultSet OUT SYS_REFCURSOR, idSeccion int);
    PROCEDURE GET_FIELDS_PR(resultSet OUT SYS_REFCURSOR, idSeccionRow int);
    PROCEDURE GET_FIELD_PR(resultSet OUT SYS_REFCURSOR, idField int);
    PROCEDURE GET_FIELD_ECS_PR(resultSet OUT SYS_REFCURSOR, idField int,idEmpresa VARCHAR2);
    PROCEDURE INSERT_REPORT_PR(nomReport varchar2, descReport varchar2, descRFC varchar2, descPais varchar2, piinIdRol int);
    PROCEDURE UPDATE_REPORT_PR(idReportFlex int, nomReport varchar2, descReport varchar2, descRFC varchar2, descPais varchar2, saltoPag varchar2);
    PROCEDURE DELETE_REPORT_PR(idReportFlex int);
    PROCEDURE INSERT_SECCION_PR(idReportFlex int, nomSecc varchar2);
    PROCEDURE UPDATE_SECCION_PR(idSecc int, nomSecc varchar2);
    PROCEDURE DELETE_SECCION_PR(idSeccion int);
    PROCEDURE INSERT_ROW_PR(idSeccion int, numFields int);
    PROCEDURE DELETE_ROW_PR(idRow int);
    PROCEDURE GET_CAMPOS_PR(resultSet OUT SYS_REFCURSOR, sectionID number, subSectionID number, paramFilter varchar2, showFlexTabs varchar2, showFlexColumns varchar2);
    PROCEDURE UPDATE_FIELD_PR(reportFlexFieldId int, appFlexFieldIf int);
    PROCEDURE UPDATE_FIELD_COLUMNS_PR(reportFlexFieldId int, ids varchar2);
    PROCEDURE GET_PARAM_INFO_PR(resultSet OUT SYS_REFCURSOR, paramFilter varchar2);
    FUNCTION GET_FIELD_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2;
    FUNCTION GET_FIELD_TEXT_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2;
    PROCEDURE GET_INFO_MAP_PR(resultSet OUT SYS_REFCURSOR, idEmpresa int);
    PROCEDURE GET_INFO_MAP_ECS_PR(resultSet OUT SYS_REFCURSOR, idEmpresa int);
    FUNCTION GET_ENTIDAD_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2;
END DERCORP_REPORTFLEX_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_REPORTFLEX_PKG" AS
    --
    --
    --
   PROCEDURE GET_REPORTES_PR( piinIdRol NUMBER,
                              resultSet OUT SYS_REFCURSOR)
    AS
      lstIn     VARCHAR2(3000);
      lstQuery  VARCHAR2(5000);
   BEGIN
     BEGIN
       SELECT ATRIBUTO3 INTO lstIn
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
       lstQuery := 'SELECT * FROM DERCORP_REPORTFLEX_TAB';
     ELSE
       lstQuery := 'SELECT * FROM DERCORP_REPORTFLEX_TAB WHERE ID_REPORTFLEX IN('
                  ||lstIn||')';
     END IF;
     OPEN resultSet FOR lstQuery;
    END GET_REPORTES_PR;
    --
    --
    --
    PROCEDURE GET_REPORTE_PR(resultSet OUT SYS_REFCURSOR, idReportFlex int)
    AS
    BEGIN
      OPEN resultSet FOR
            SELECT
              *
            FROM
              DERCORP_REPORTFLEX_TAB
            WHERE
              ID_REPORTFLEX = idReportFlex;
    END GET_REPORTE_PR;
    --
    --
    --
    PROCEDURE GET_SECCIONES_PR(resultSet OUT SYS_REFCURSOR, idReportFlex int)
    AS
    BEGIN
      OPEN resultSet FOR
            SELECT
              *
            FROM
              DERCORP_REPORTFLEX_SECCION_TAB
            WHERE
              ID_REPORTFLEX = idReportFlex
            ORDER BY
              ID_SECCION
              ;
    END GET_SECCIONES_PR;
    --
    --
    --
    PROCEDURE GET_ROWS_PR(resultSet OUT SYS_REFCURSOR, idSeccion int)
    AS
    BEGIN
      OPEN resultSet FOR
            SELECT
              *
            FROM
              DERCORP_REPORTFLEX_S_ROW_TAB
            WHERE
             ID_SECCION = idSeccion
            ORDER BY
              ID_ORDER;
    END GET_ROWS_PR;
    --
    --
    --
    PROCEDURE GET_FIELDS_PR(resultSet OUT SYS_REFCURSOR, idSeccionRow int)
    AS
    BEGIN
      OPEN resultSet FOR
             SELECT
              flexRepField.ID_CAMPO,
              flexRepField.ID_SECCION_ROW,
              flexRepField.ID_ORDER,
              flexRepField.ID_ADD_CAMPO,
              --flexField.NOM_CAMPO,
              (
                CASE flexRepField.ID_ADD_CAMPO
                  WHEN 520 THEN flexField.ATRIBUTO6
                  WHEN 1077 THEN flexField.ATRIBUTO6
                  ELSE
                    flexField.NOM_CAMPO END
              ) AS NOM_CAMPO,
              flexField.DES_TIPO_CAMPO,
              flexField.ID_CATALOGO,
              NVL(flexField.ID_FLEX_TBL,0) ID_FLEX_TBL,
              flexRepField.ATRIBUTO1
            FROM
              DERCORP_REPORTFLEX_CAMPO_TAB flexRepField
              LEFT JOIN DERCORP_ADD_CAMPO_TAB flexField ON  flexField.ID_ADD_CAMPO = flexRepField.ID_ADD_CAMPO
            WHERE
              flexRepField.ID_SECCION_ROW = idSeccionRow
            ORDER BY
              flexRepField.ID_CAMPO
              ;
    END GET_FIELDS_PR;
    --
    --
    --
    PROCEDURE GET_FIELD_PR(resultSet OUT SYS_REFCURSOR, idField int)
    AS
    BEGIN
      OPEN resultSet FOR
             SELECT
              flexRepField.ID_CAMPO,
              flexRepField.ID_SECCION_ROW,
              flexRepField.ID_ORDER,
              flexRepField.ID_ADD_CAMPO,
              flexField.NOM_CAMPO,
              flexField.DES_TIPO_CAMPO,
              flexField.ID_CATALOGO,
              NVL(flexField.ID_FLEX_TBL,0) ID_FLEX_TBL,
              flexRepField.ATRIBUTO1
            FROM
              DERCORP_REPORTFLEX_CAMPO_TAB flexRepField
              LEFT JOIN DERCORP_ADD_CAMPO_TAB flexField ON  flexField.ID_ADD_CAMPO = flexRepField.ID_ADD_CAMPO
            WHERE
              flexRepField.ID_CAMPO = idField
              ;
    END GET_FIELD_PR;
PROCEDURE GET_FIELD_ECS_PR(resultSet OUT SYS_REFCURSOR, idField int,idEmpresa VARCHAR2)
    AS
    v_isAC NUMBER := 0;
    BEGIN
    SELECT USRDRC.XXTV_CAPITAL_SOC_PKG.GET_TIPO_SOCIEDAD_FN(TO_NUMBER(idEmpresa)) INTO v_isAC FROM dual;
    IF v_isAC = 1
    THEN
        OPEN resultSet FOR
           SELECT * FROM(
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
                                                        AND v.ID_EMPRESA      = idEmpresa
              WHERE
                c.ID_SUBSECCION = 29
                AND c.ATRIBUTO7 IS NULL
                --AND (( v.VAL_VALOR is not null) OR (des_tipo_campo = 'FLEXTABLE'))
                --and v.VAL_VALOR != '0'
                and v.VAL_VALOR IS NOT NULL --JJAQ 21-03-2019 CAMBIO PARA EL REPORTE DE ECS PUNTO NUMERO 1 DE LOS PRIORITARIOS
                and c.ID_ADD_CAMPO not in (1030,1031,1022,1028,1029,541)--JJAQ 21-03-2019 CAMBIO PARA EL REPORTE DE ECS PUNTO NUMERO 1 DE LOS PRIORITARIOS
UNION
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
                                                        AND v.ID_EMPRESA      = idEmpresa
              WHERE
                c.ID_SUBSECCION = 29
                AND c.ATRIBUTO7 IS NULL
                AND des_tipo_campo = 'FLEXTABLE'
                )TMP
                ORDER BY
                ID_SECCION,
                ID_SUBSECCION,
                ID_AGRUPACION,
                TO_NUMBER(ID_ORDER);
    ELSE
        OPEN resultSet FOR
           SELECT * FROM(
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
                                                        AND v.ID_EMPRESA      = idEmpresa
              WHERE
                c.ID_SUBSECCION = 29
                AND c.ATRIBUTO7 IS NULL
                --AND (( v.VAL_VALOR is not null) OR (des_tipo_campo = 'FLEXTABLE'))
                --and v.VAL_VALOR != '0'
                and v.VAL_VALOR IS NOT NULL --JJAQ 21-03-2019 CAMBIO PARA EL REPORTE DE ECS PUNTO NUMERO 1 DE LOS PRIORITARIOS
                and c.ID_ADD_CAMPO not in (1030,1031,1022)--JJAQ 21-03-2019 CAMBIO PARA EL REPORTE DE ECS PUNTO NUMERO 1 DE LOS PRIORITARIOS
UNION
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
                                                        AND v.ID_EMPRESA      = idEmpresa
              WHERE
                c.ID_SUBSECCION = 29
                AND c.ATRIBUTO7 IS NULL
                AND des_tipo_campo = 'FLEXTABLE'
                )TMP
                ORDER BY
                ID_SECCION,
                ID_SUBSECCION,
                ID_AGRUPACION,
                TO_NUMBER(ID_ORDER);
    END IF;
    END GET_FIELD_ECS_PR;
    --
    --
    --
    PROCEDURE INSERT_REPORT_PR(nomReport varchar2, descReport varchar2, descRFC varchar2, descPais varchar2, piinIdRol int)
    AS
      linNewId int;
      lstInRol varchar2(2500);
    BEGIN
         SELECT
            DERCORP_REPORTFLEX_SEQ.NEXTVAL INTO linNewId
          FROM
            DUAL;
          INSERT INTO DERCORP_REPORTFLEX_TAB
              (ID_REPORTFLEX, NOM_REPORTE, DES_REPORTE, ATRIBUTO1, ATRIBUTO2)
          VALUES
              (linNewId, nomReport, descReport, descRFC, descPais);
        BEGIN
          SELECT atributo3 INTO lstInRol
          FROM   ss_rol_tab
          WHERE  id_rol   = piinIdRol;
        EXCEPTION
          WHEN OTHERS THEN
            lstInRol := NULL;
        END;
        IF lstInRol IS NULL THEN
          UPDATE ss_rol_tab
          SET    atributo3  = linNewId
          WHERE  id_rol     = piinIdRol;
        ELSE
          UPDATE ss_rol_tab
          SET    atributo3  = atributo3||','||linNewId
          WHERE  id_rol     = piinIdRol;
        END IF;
    END INSERT_REPORT_PR;
    PROCEDURE UPDATE_REPORT_PR(idReportFlex int, nomReport varchar2, descReport varchar2, descRFC varchar2, descPais varchar2, saltoPag varchar2)
    AS
    BEGIN
        UPDATE DERCORP_REPORTFLEX_TAB SET
          NOM_REPORTE = nomReport,
          DES_REPORTE = descReport,
          ATRIBUTO1 = descRFC,
          ATRIBUTO2 = descPais,
          ATRIBUTO15 = saltoPag
        WHERE
          ID_REPORTFLEX = idReportFlex;
    END UPDATE_REPORT_PR;
    --
    --
    --
    PROCEDURE DELETE_REPORT_PR(idReportFlex int)
    AS
    BEGIN
          DELETE FROM DERCORP_REPORTFLEX_TAB
          WHERE
            ID_REPORTFLEX = idReportFlex;
          DELETE FROM DERCORP_REPORTFLEX_CAMPO_TAB
          WHERE
            ID_SECCION_ROW IN (
                  SELECT ID_SECCION_ROW
                  FROM DERCORP_REPORTFLEX_S_ROW_TAB
                  WHERE
                    ID_SECCION IN (
                        SELECT ID_SECCION
                        FROM DERCORP_REPORTFLEX_SECCION_TAB
                        WHERE ID_REPORTFLEX = idReportFlex
                        )
                    );
            DELETE
            FROM DERCORP_REPORTFLEX_S_ROW_TAB
            WHERE
              ID_SECCION IN (
                  SELECT ID_SECCION
                  FROM DERCORP_REPORTFLEX_SECCION_TAB
                  WHERE ID_REPORTFLEX = idReportFlex
              );
            DELETE
            FROM DERCORP_REPORTFLEX_SECCION_TAB
            WHERE ID_REPORTFLEX = idReportFlex;
    END DELETE_REPORT_PR;
    --
    --
    --
    PROCEDURE INSERT_SECCION_PR(idReportFlex int, nomSecc varchar2)
    AS
      linNewId int;
    BEGIN
      SELECT
        DERCORP_REPORTFLEX_SECCION_SEQ.NEXTVAL + 1 INTO linNewId
      FROM
        DUAL;
      INSERT INTO DERCORP_REPORTFLEX_SECCION_TAB
        (ID_SECCION, ID_REPORTFLEX, NOM_SECCION)
      VALUES
        (linNewId, idReportFlex, nomSecc)
        ;
    END INSERT_SECCION_PR;
    --
    --
    --
    PROCEDURE UPDATE_SECCION_PR(idSecc int, nomSecc varchar2)
    AS
    BEGIN
      UPDATE DERCORP_REPORTFLEX_SECCION_TAB SET
          NOM_SECCION = nomSecc
      WHERE
        ID_SECCION = idSecc;
    END UPDATE_SECCION_PR;
    --
    --
    --
    PROCEDURE DELETE_SECCION_PR(idSeccion int)
    AS
    BEGIN
      DELETE FROM DERCORP_REPORTFLEX_SECCION_TAB
      WHERE
        ID_SECCION = idSeccion;
        DELETE FROM DERCORP_REPORTFLEX_CAMPO_TAB
        WHERE
          ID_SECCION_ROW IN (
                SELECT ID_SECCION_ROW
                FROM DERCORP_REPORTFLEX_S_ROW_TAB
                WHERE
                  ID_SECCION = idSeccion
            );
          DELETE FROM DERCORP_REPORTFLEX_S_ROW_TAB
          WHERE
            ID_SECCION = idSeccion;
    END DELETE_SECCION_PR;
    --
    --
    --
    PROCEDURE INSERT_ROW_PR(idSeccion int, numFields int)
    AS
     linNewId int;
     linNewIdCampo int;
    BEGIN
        SELECT
          DERCORP_REPORTFLEX_S_ROW_SEQ.NEXTVAL + 1 INTO linNewId
        FROM
          DUAL;
        INSERT INTO DERCORP_REPORTFLEX_S_ROW_TAB
        (
          ID_SECCION_ROW,
          ID_SECCION,
          ID_ORDER,
          ATRIBUTO1
        )
        VALUES
        (
          linNewId,
         idSeccion,
         linNewId,
         numFields
        );
        SELECT
          DERCORP_REPORTFLEX_CAMPO_SEQ.NEXTVAL INTO linNewIdCampo
        FROM
          DUAL;
        INSERT INTO DERCORP_REPORTFLEX_CAMPO_TAB
        (
          ID_CAMPO,
          ID_SECCION_ROW,
          ID_ADD_CAMPO,
          ID_ORDER
        )
        VALUES
        (
          linNewIdCampo,
          linNewId,
          0,
          1
        );
        IF numFields = 2 THEN
             SELECT
              DERCORP_REPORTFLEX_CAMPO_SEQ.NEXTVAL INTO linNewIdCampo
            FROM
              DUAL;
            INSERT INTO DERCORP_REPORTFLEX_CAMPO_TAB
            (
              ID_CAMPO,
              ID_SECCION_ROW,
              ID_ADD_CAMPO,
              ID_ORDER
            )
            VALUES
            (
              linNewIdCampo,
              linNewId,
              0,
              2
            );
        END IF;
    END INSERT_ROW_PR;
    --
    --
    --
    PROCEDURE DELETE_ROW_PR(idRow int)
    AS
    BEGIN
      DELETE FROM DERCORP_REPORTFLEX_S_ROW_TAB
      WHERE
        ID_SECCION_ROW = idRow;
      DELETE FROM DERCORP_REPORTFLEX_CAMPO_TAB
      WHERE
        ID_SECCION_ROW = idRow;
    END DELETE_ROW_PR;
    --
    --
    --
    PROCEDURE GET_CAMPOS_PR(resultSet OUT SYS_REFCURSOR, sectionID number, subSectionID number, paramFilter varchar2, showFlexTabs varchar2, showFlexColumns varchar2)
    AS
    BEGIN
         OPEN resultSet FOR
            SELECT * FROM (
            SELECT
              CAMPO.ID_ADD_CAMPO,
              --TO_CHAR(CAMPO.ID_ADD_CAMPO),
              (
                CASE CAMPO.ID_ADD_CAMPO
                  WHEN 520 THEN CAMPO.ATRIBUTO6
                  WHEN 1077 THEN CAMPO.ATRIBUTO6
                  WHEN 564 THEN CAMPO.ATRIBUTO6
                  WHEN 1051 THEN CAMPO.ATRIBUTO6
                  ELSE
                    CAMPO.NOM_CAMPO END
              )
                ||
                (
                  CASE CAMPO.DES_TIPO_CAMPO WHEN 'FLEXTABLE' THEN ' (TABLA)'
                  ELSE '' END
                ) AS NOM_CAMPO,
              CAMPO.DES_TIPO_CAMPO,
              CAMPO.ID_FLEX_TBL,
              CAMPO.ID_CATALOGO,
              SECC.NOM_SECCION,
              SUBSECC.NOM_SUBSECCION,
              SECC.ID_SECCION,
              SUBSECC.ID_SUBSECCION,
              0 AS ID_ORDEN,
              '' AS COD_FLEX_COLUM
            FROM
              DERCORP_ADD_CAMPO_TAB CAMPO
              INNER JOIN DERCORP_ADD_CAMPO_SECCION_TAB SECC ON SECC.ID_SECCION = CAMPO.ID_SECCION
              INNER JOIN DERCORP_ADD_CAMPO_SUB_SEC_TAB SUBSECC ON SUBSECC.ID_SUBSECCION = CAMPO.ID_SUBSECCION
            WHERE
              (
                  LENGTH(TRIM(CAMPO.NOM_CAMPO)) > 0
                  OR
                  ID_ADD_CAMPO IN (520,1077)
              )
              AND
              SECC.ID_SECCION = (CASE sectionID WHEN 0 THEN SECC.ID_SECCION ELSE sectionID END)
              AND
              SUBSECC.ID_SUBSECCION = (CASE subSectionID WHEN 0 THEN SUBSECC.ID_SUBSECCION ELSE subSectionID END)
              AND
              (
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER((
                                            CASE CAMPO.ID_ADD_CAMPO
                                              WHEN 520 THEN CAMPO.ATRIBUTO6
                                              WHEN 1077 THEN CAMPO.ATRIBUTO6
                                              ELSE
                                                CAMPO.NOM_CAMPO END
                                          ))) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              OR
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(SUBSECC.NOM_SUBSECCION)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              OR
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(SECC.NOM_SECCION)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              )
              AND
              CAMPO.DES_TIPO_CAMPO NOT IN ('LABEL','AJAX_PAGE')
              AND
              (CAMPO.DES_TIPO_CAMPO NOT IN ('FLEXTABLE') OR showFlexTabs = 'SI')
              AND SUBSECC.atributo1 is null
              AND
              NVL(CAMPO.DES_FORMULA,'NULL') NOT LIKE '%showMe%'
              AND CAMPO.ATRIBUTO7 IS NULL
              AND CAMPO.ID_ADD_CAMPO NOT IN (1058,2002)--SE OMITE REFORMA TOTAL
              AND CAMPO.ID_ADD_CAMPO NOT IN (1070)--JAMS 20/02/2018 SE OMITE CONTRATOS DE REFORMAS Y MOVIMIENTOS
              AND CAMPO.ID_ADD_CAMPO NOT IN (1057)--JAMS 09/03/2018 SE OMITE Aumento de Capital S.A. (TABLA)
              AND SECC.ID_SECCION NOT IN (22,23,24)--JJAQ 05/09/2017 SE OMITE TODO LO QUE TENGA QUE VER CN PODERES
            UNION ALL
            SELECT
              CAMPO.ID_ADD_CAMPO,
              --TO_CHAR(CAMPO.ID_ADD_CAMPO),
              --CAMPO.NOM_CAMPO
              (
                CASE CAMPO.ID_ADD_CAMPO
                  WHEN 520 THEN CAMPO.ATRIBUTO6
                  WHEN 1077 THEN CAMPO.ATRIBUTO6
                  WHEN 564 THEN CAMPO.ATRIBUTO6
                  WHEN 1051 THEN CAMPO.ATRIBUTO6
                  ELSE
                    CAMPO.NOM_CAMPO END
              )
                ||
                (
                  CASE CAMPO.DES_TIPO_CAMPO WHEN 'FLEXTABLE' THEN ' (TABLA)'
                  ELSE '' END
                ) AS NOM_CAMPO,
              CAMPO.DES_TIPO_CAMPO,
              CAMPO.ID_FLEX_TBL,
              CAMPO.ID_CATALOGO,
              SECC.NOM_SECCION,
              SUBSECC.NOM_SUBSECCION,
              SECC.ID_SECCION,
              SUBSECC.ID_SUBSECCION,
              0 AS ID_ORDEN,
              '' AS COD_FLEX_COLUM
            FROM
              DERCORP_ADD_CAMPO_TAB CAMPO
              --ULR 15/05/2017 ULR se a?adio condicion al decode para que aparezca comites
              INNER JOIN DERCORP_ADD_CAMPO_SECCION_TAB SECC ON SECC.ID_SECCION = DECODE(CAMPO.ID_SECCION,250,25
                                                                                                        ,31,25)
              INNER JOIN DERCORP_ADD_CAMPO_SUB_SEC_TAB SUBSECC ON SUBSECC.ID_SUBSECCION = DECODE(CAMPO.ID_SUBSECCION,470,47
                                                                                                                    ,60,47)
            WHERE
              (
                  LENGTH(TRIM(CAMPO.NOM_CAMPO)) > 0
                  OR
                  ID_ADD_CAMPO IN (520,1077)
              )
              AND
              SECC.ID_SECCION = (CASE sectionID WHEN 0 THEN SECC.ID_SECCION ELSE sectionID END)
              AND
              SUBSECC.ID_SUBSECCION = (CASE subSectionID WHEN 0 THEN SUBSECC.ID_SUBSECCION ELSE subSectionID END)
              AND
              (
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(CAMPO.NOM_CAMPO)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              OR
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(SUBSECC.NOM_SUBSECCION)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              OR
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(SECC.NOM_SECCION)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              )
              AND
              CAMPO.DES_TIPO_CAMPO NOT IN ('LABEL','AJAX_PAGE')
              AND
              (CAMPO.DES_TIPO_CAMPO NOT IN ('FLEXTABLE') OR showFlexTabs = 'SI')
              AND
              NVL(CAMPO.DES_FORMULA,'NULL') NOT LIKE '%showMe%'
              AND
              CAMPO.ATRIBUTO7 IS NULL
              AND CAMPO.ID_ADD_CAMPO NOT IN (1058,2002)--SE OMITE REFORMA TOTAL
              AND CAMPO.ID_ADD_CAMPO NOT IN (1070)--JAMS 20/02/2018 SE OMITE CONTRATOS DE REFORMAS Y MOVIMIENTOS
              AND CAMPO.ID_ADD_CAMPO NOT IN (1057)--JAMS 09/03/2018 SE OMITE Aumento de Capital S.A. (TABLA)
              AND SECC.ID_SECCION NOT IN (22,23,24)--JJAQ 05/09/2017 SE OMITE TODO LO QUE TENGA QUE VER CN PODERES
          UNION ALL
          SELECT
            FLEXCOL.ID_FLEX_COLUM * 10000,
            --FLEXCOL.COD_FLEX_COLUM,
            --FLEXCOL.DES_FLEX_COLUM NOM_CAMPO,
            FLEXCOL.NOM_FLEX_COLUM NOM_CAMPO,
            FLEXCOL.DES_TIPO_COLUM,
            FLEXCOL.ID_FLEX_TBL,
            FLEXCOL.ID_CATALOGO,
            SECC.NOM_SECCION,
            FLEXTAB.NOM_FLEX NOM_SUBSECCION,
            --SUBSECC.NOM_SUBSECCION,
            SECC.ID_SECCION,
            SUBSECC.ID_SUBSECCION,
            FLEXCOL.ID_ORDEN,
            FLEXCOL.COD_FLEX_COLUM
          FROM
            DERCORP_FLEX_COLUMS_TAB                 FLEXCOL
            INNER JOIN DERCORP_FLEX_TBLS_TAB        FLEXTAB ON  FLEXTAB.ID_FLEX_TBL = FLEXCOL.ID_FLEX_TBL
                                                                AND
                                                                FLEXTAB.ATTRIBUTE_CATEGORY IS NULL
                                                                AND FLEXTAB.ID_FLEX_TBL NOT IN (20)--SE OMITE REFORMA TOTAL
                                                                --FLEXTAB.ATTRIBUTE_CATEGORY NOT IN ('DESHABILITADA')
            LEFT JOIN DERCORP_ADD_CAMPO_TAB         CAMPO   ON  CAMPO.ID_FLEX_TBL = FLEXCOL.ID_FLEX_TBL
            LEFT JOIN DERCORP_ADD_CAMPO_SECCION_TAB SECC    ON  SECC.ID_SECCION = DECODE(CAMPO.ID_SECCION,250,25,31,25,CAMPO.ID_SECCION)
                                                                AND
                                                                SECC.ID_SECCION = (CASE sectionID WHEN 0 THEN SECC.ID_SECCION ELSE sectionID END)
            LEFT JOIN DERCORP_ADD_CAMPO_SUB_SEC_TAB SUBSECC ON  SUBSECC.ID_SUBSECCION = DECODE(CAMPO.ID_SUBSECCION,470,47,60,47,CAMPO.ID_SUBSECCION)
                                                                AND
                                                                SUBSECC.ID_SUBSECCION = (CASE subSectionID WHEN 0 THEN SUBSECC.ID_SUBSECCION ELSE subSectionID END)
          WHERE
              --LENGTH(TRIM(FLEXCOL.DES_FLEX_COLUM)) > 0
              LENGTH(TRIM(FLEXCOL.NOM_FLEX_COLUM)) > 0
              AND
              (
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(FLEXCOL.NOM_FLEX_COLUM)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              OR
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(FLEXTAB.NOM_FLEX)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              OR
              APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(SECC.NOM_SECCION)) LIKE '%' || APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(paramFilter)) || '%'
              )
              AND
              --LENGTH(TRIM(FLEXCOL.DES_FLEX_COLUM)) > 0
              LENGTH(TRIM(FLEXCOL.NOM_FLEX_COLUM)) > 0
              AND
              showFlexColumns = 'SI'
              AND FLEXCOL.ID_FLEX_COLUM NOT IN (303)--SE OMITE REFORMA TOTAL
              AND
              CAMPO.ATRIBUTO7 IS NULL
              AND SECC.ID_SECCION NOT IN (22,23,24)--JJAQ 05/09/2017 SE OMITE TODO LO QUE TENGA QUE VER CN PODERES
              AND CAMPO.ID_ADD_CAMPO NOT IN (1070)--JAMS 20/02/2018 SE OMITE CONTRATOS DE REFORMAS Y MOVIMIENTOS
               group by
                FLEXCOL.ID_FLEX_COLUM * 10000,
                FLEXCOL.NOM_FLEX_COLUM ,
                FLEXCOL.DES_TIPO_COLUM,
                FLEXCOL.ID_FLEX_TBL,
                FLEXCOL.ID_CATALOGO,
                SECC.NOM_SECCION,
                FLEXTAB.NOM_FLEX ,
                SECC.ID_SECCION,
                SUBSECC.ID_SUBSECCION,
                FLEXCOL.ID_ORDEN,
                FLEXCOL.COD_FLEX_COLUM) A
          ORDER BY
          /*
              ID_SECCION,
              ID_SUBSECCION,
              NOM_SUBSECCION,
              NOM_CAMPO
            */
              ID_SECCION,
              A.ID_FLEX_TBL,
              A.ID_ORDEN,
              TO_NUMBER(REPLACE(A.COD_FLEX_COLUM, 'VAL_C', ''))
          ;
    END GET_CAMPOS_PR;
    --
    --
    --
    PROCEDURE UPDATE_FIELD_PR(reportFlexFieldId int, appFlexFieldIf int)
    AS
    BEGIN
      UPDATE DERCORP_REPORTFLEX_CAMPO_TAB SET
        ID_ADD_CAMPO = appFlexFieldIf
      WHERE
        ID_CAMPO = reportFlexFieldId;
    END UPDATE_FIELD_PR;
    --
    --
    --
    PROCEDURE UPDATE_FIELD_COLUMNS_PR(reportFlexFieldId int, ids varchar2)
    AS
    BEGIN
      UPDATE DERCORP_REPORTFLEX_CAMPO_TAB SET
        ATRIBUTO1 = ids
      WHERE
        ID_CAMPO = reportFlexFieldId;
    END UPDATE_FIELD_COLUMNS_PR;
    PROCEDURE GET_PARAM_INFO_PR(resultSet OUT SYS_REFCURSOR, paramFilter varchar2)
    AS
    BEGIN
         OPEN resultSet FOR
            SELECT
              ID_ADD_CAMPO,
              --TO_CHAR(ID_ADD_CAMPO),
              (
                CASE ID_ADD_CAMPO
                  WHEN 520 THEN ATRIBUTO6
                  WHEN 1077 THEN ATRIBUTO6
                  ELSE
                    NOM_CAMPO END
              ) NOM_CAMPO,
              ID_CATALOGO,
              DES_TIPO_CAMPO AS TIPO_CAMPO
            FROM
              DERCORP_ADD_CAMPO_TAB
            WHERE
              paramFilter LIKE '%' || ID_ADD_CAMPO || '%'
            UNION
             SELECT
                ID_FLEX_COLUM  * 10000,
                --COD_FLEX_COLUM,
                DES_FLEX_COLUM,
                ID_CATALOGO,
                DES_TIPO_COLUM AS TIPO_CAMPO
            FROM
              DERCORP_FLEX_COLUMS_TAB
            WHERE
              paramFilter LIKE '%' || (ID_FLEX_COLUM * 10000) || '%'
              --paramFilter LIKE '%' || COD_FLEX_COLUM || '%'
          ;
    END GET_PARAM_INFO_PR;
    --
    --
    --
    FUNCTION GET_FIELD_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2
    AS
        val varchar2(255);
    BEGIN
      SELECT
        VAL_VALOR INTO val
      FROM
        DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE
        ID_EMPRESA = idEmpresa
        AND
        ID_ADD_CAMPO = idAddCampo
      ;
      RETURN val;
    END GET_FIELD_VALUE;
    --
    --
    --
    FUNCTION GET_FIELD_TEXT_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2
    AS
        val varchar2(255);
    BEGIN
          SELECT
            --CV.ID_ADD_CAMPO,
            NVL(CAT.VAL_CAT_VAL,CV.VAL_VALOR) INTO val
          FROM
            DERCORP_ADD_CAMPO_VALOR_TAB CV
            INNER JOIN DERCORP_ADD_CAMPO_TAB AC ON AC.ID_ADD_CAMPO = CV.ID_ADD_CAMPO
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON TO_NUMBER(CAT.ID_CATALOGO) = TO_NUMBER(NVL(TRIM(AC.ID_CATALOGO),'0'))
                                                        AND TO_CHAR(CAT.ID_CATALOGO_VALOR) = CV.VAL_VALOR
          WHERE
            CV.ID_EMPRESA = idEmpresa
            AND
            CV.ID_ADD_CAMPO = idAddCampo
          ;
        RETURN val;
    END;
    FUNCTION GET_ENTIDAD_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2
    AS
        val varchar2(255);
    BEGIN
          SELECT
            --CV.ID_ADD_CAMPO,
            NVL(CAT.ATRIBUTO2,CV.VAL_VALOR) INTO val
          FROM
            DERCORP_ADD_CAMPO_VALOR_TAB CV
            INNER JOIN DERCORP_ADD_CAMPO_TAB AC ON AC.ID_ADD_CAMPO = CV.ID_ADD_CAMPO
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON TO_NUMBER(CAT.ID_CATALOGO) = TO_NUMBER(NVL(TRIM(AC.ID_CATALOGO),'0'))
                                                        AND TO_CHAR(CAT.ID_CATALOGO_VALOR) = CV.VAL_VALOR
          WHERE
            CV.ID_EMPRESA = idEmpresa
            AND
            CV.ID_ADD_CAMPO = idAddCampo
          ;
        RETURN val;
    END;
    --
    --
    --
    PROCEDURE GET_INFO_MAP_PR(resultSet OUT SYS_REFCURSOR, idEmpresa int)
    AS
    BEGIN
      OPEN resultSet FOR
          SELECT
            CV.ID_ADD_CAMPO,
            NVL(CAT.VAL_CAT_VAL,CV.VAL_VALOR) VALOR_TEXTUAL
          FROM
            DERCORP_ADD_CAMPO_VALOR_TAB CV
            INNER JOIN DERCORP_ADD_CAMPO_TAB AC ON AC.ID_ADD_CAMPO = CV.ID_ADD_CAMPO
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON TO_NUMBER(CAT.ID_CATALOGO) = TO_NUMBER(NVL(TRIM(AC.ID_CATALOGO),'0'))
                                                        AND TO_CHAR(CAT.ID_CATALOGO_VALOR) = CV.VAL_VALOR
          WHERE
            CV.ID_EMPRESA = idEmpresa
          ;
    END GET_INFO_MAP_PR;
    /*
    *JJAQ 21/01/2019 para el reporte de estructura de capital social
    */
    PROCEDURE GET_INFO_MAP_ECS_PR(resultSet OUT SYS_REFCURSOR, idEmpresa int)
    AS
    BEGIN
      OPEN resultSet FOR
          SELECT
            CV.ID_ADD_CAMPO,
            NVL(CAT.VAL_CAT_VAL,CV.VAL_VALOR) VALOR_TEXTUAL
          FROM
            DERCORP_ADD_CAMPO_VALOR_TAB CV
            INNER JOIN DERCORP_ADD_CAMPO_TAB AC ON AC.ID_ADD_CAMPO = CV.ID_ADD_CAMPO
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON TO_NUMBER(CAT.ID_CATALOGO) = TO_NUMBER(NVL(TRIM(AC.ID_CATALOGO),'0'))
                                                        AND TO_CHAR(CAT.ID_CATALOGO_VALOR) = CV.VAL_VALOR
          WHERE
            CV.ID_EMPRESA = idEmpresa
            and id_seccion = 19
            and id_subseccion = 29
            and VAL_VALOR is not null
            and VAL_VALOR != '0'
          ;
    END GET_INFO_MAP_ECS_PR;
END DERCORP_REPORTFLEX_PKG;
/;
