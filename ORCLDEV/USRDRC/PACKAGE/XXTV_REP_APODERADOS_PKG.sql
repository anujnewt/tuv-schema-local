CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."XXTV_REP_APODERADOS_PKG" AS
  --
  --
  --
  PROCEDURE GET_EMPRESAS_PR(resultSet OUT SYS_REFCURSOR,  paramEmpresas varchar2, paramApoderados varchar2, paramPoder varchar2);
  --
  --
  --
  PROCEDURE GET_INFO_PR(resultSet OUT SYS_REFCURSOR,  paramEmpresas varchar2,
                                                      paramTipoPoder varchar2,
                                                      paramEscritura varchar2
                                                      );
END XXTV_REP_APODERADOS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."XXTV_REP_APODERADOS_PKG" AS
  --
  --
  --
  PROCEDURE GET_EMPRESAS_PR(resultSet OUT SYS_REFCURSOR,  paramEmpresas varchar2, paramApoderados varchar2, paramPoder varchar2)
  AS
  BEGIN
      IF LENGTH(TRIM(paramPoder)) > 0 THEN
            OPEN resultSet FOR
              SELECT
                ID_EMPRESA,
                --NOM_EMPRESA
                (SELECT val_cat_val
                  FROM dercorp_add_campo_cat_val_tab ac
                  WHERE id_catalogo = 1
                  AND   ac.id_catalogo_valor = (SELECT val_valor
                                             FROM dercorp_add_campo_valor_tab
                                             WHERE id_empresa = emp.id_empresa
                                             AND id_add_campo = 500))AS NOM_EMPRESA
              FROM
                DERCORP_EMPRESA_TAB EMP
              WHERE
                (',' || NVL(paramEmpresas,ID_EMPRESA) || ','  LIKE '%,' || ID_EMPRESA || ',%')
                AND
                ID_EMPRESA IN (
                      SELECT ID_EMPRESA
                      FROM DERCORP_APODERADOS_NAMES_VW
                      WHERE
                        (',' || paramApoderados || ','  LIKE '%,' || ID_CATALOGO_VALOR || ',%')
                        )
                AND
                ID_EMPRESA IN (
                      SELECT ID_EMPRESA
                      FROM DERCORP_APODERADOS_PODERES_VW
                      WHERE
                        (',' || paramPoder || ','  LIKE '%,' || ID_CATALOGO_VALOR || ',%')
                        )
              ORDER BY NOM_EMPRESA
                ;
      ELSE
            OPEN resultSet FOR
              SELECT
                ID_EMPRESA,
                --NOM_EMPRESA
                (SELECT val_cat_val
                  FROM dercorp_add_campo_cat_val_tab ac
                  WHERE id_catalogo = 1
                  AND   ac.id_catalogo_valor = (SELECT val_valor
                                             FROM dercorp_add_campo_valor_tab
                                             WHERE id_empresa = emp.id_empresa
                                             AND id_add_campo = 500))AS NOM_EMPRESA
              FROM
                DERCORP_EMPRESA_TAB EMP
              WHERE
                (',' || NVL(paramEmpresas,ID_EMPRESA) || ','  LIKE '%,' || ID_EMPRESA || ',%')
                AND
                ID_EMPRESA IN (
                      SELECT ID_EMPRESA
                      FROM DERCORP_APODERADOS_NAMES_VW
                      WHERE
                        (',' || paramApoderados || ','  LIKE '%,' || ID_CATALOGO_VALOR || ',%')
                        )
              ORDER BY NOM_EMPRESA
                ;
      END IF;
  END GET_EMPRESAS_PR;
    --
    --
    --
   PROCEDURE GET_INFO_PR(resultSet OUT SYS_REFCURSOR,  paramEmpresas varchar2,
                                                      paramTipoPoder varchar2,
                                                      paramEscritura varchar2
                                                      )
    AS
    BEGIN
      OPEN resultSet FOR
            SELECT
              DISTINCT
              NAMES.ID_EMPRESA,
              NAMES.NOM_EMPRESA,
              NAMES.DES_ESCRITURA,
              NAMES.NUM_TIPO_PODER,
              NAMES.TIPO_PODER,
              NAMES.DES_GRUPO,
              NAMES.ID_CATALOGO,
              NAMES.ID_CATALOGO_VALOR ID_APODERADO,
              NAMES.VAL_CAT_VAL NOMBRE_APODERADO,
              NAMES.DES_TIPO_BAJA,
              NAMES.DES_DOCUMENTO,
              NAMES.FEC_FECHA_BAJA,
              POD.ID_CATALOGO,
              CAT_POD.NOM_CATALOGO CONCEPTO_PODER,
              POD.ID_CATALOGO_VALOR,
              POD.VAL_CAT_VAL DESCRIPCION_PODER
            FROM
              DERCORP_APODERADOS_NAMES_VW NAMES
              INNER JOIN DERCORP_APODERADOS_PODERES_VW POD ON
                                    POD.ID_EMPRESA =      NAMES.ID_EMPRESA
                                    AND POD.NOM_EMPRESA =     NAMES.NOM_EMPRESA
                                    AND POD.DES_ESCRITURA =   NAMES.DES_ESCRITURA
                                    AND POD.NUM_TIPO_PODER =  NAMES.NUM_TIPO_PODER
                                    AND POD.TIPO_PODER =      NAMES.TIPO_PODER
                                    AND POD.DES_GRUPO =       NAMES.DES_GRUPO
              INNER JOIN DERCORP_ADD_CAMPO_CAT_TAB CAT_POD ON CAT_POD.ID_CATALOGO = POD.ID_CATALOGO
            WHERE
              --NAMES.VAL_CAT_VAL LIKE '%Azcarraga%'
              --AND
              (',' || paramEmpresas || ','  LIKE '%,' || NAMES.ID_EMPRESA || ',%')
              --NAMES.NOM_EMPRESA = 'TELEVISA, S.A. DE C.V.'
              --AND
              --UPPER(POD.VAL_CAT_VAL) LIKE '%ILIM%'
              AND
              (',' || paramTipoPoder || ','  LIKE '%,' || NAMES.NUM_TIPO_PODER || ',%')
              --AND
              --(REPLACE(NAMES.DES_ESCRITURA,',','') LIKE '%' || REPLACE(paramEscritura,',','') || '%')
            ORDER BY
              NAMES.ID_EMPRESA,
              NAMES.DES_ESCRITURA,
              NAMES.NUM_TIPO_PODER,
              NAMES.DES_GRUPO,
              NAMES.VAL_CAT_VAL,
              POD.ID_CATALOGO,
              POD.VAL_CAT_VAL;
    END GET_INFO_PR;
END XXTV_REP_APODERADOS_PKG;
/;
