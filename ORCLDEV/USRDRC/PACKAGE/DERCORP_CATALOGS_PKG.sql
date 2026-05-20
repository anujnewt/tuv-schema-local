CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_CATALOGS_PKG" AS
    PROCEDURE INSERT_BITACORA_CATGO_PR(piinIdCatalogo NUMBER,
                                       pistUsuario    VARCHAR2,
                                       pistAccion     VARCHAR2);
    PROCEDURE DELETE_BITACORA_CATGO_PR(pstNomCatalogo VARCHAR2,
                                       pistUsuario    VARCHAR2);
    PROCEDURE INSERT_BITACORA_CATGO_DET_PR(piinIdCatalogo NUMBER,
                                           pistUsuario    VARCHAR2,
                                           pistAccion     VARCHAR2,
                                           pinConsecutivo NUMBER);
    PROCEDURE DELETE_BITACORA_CATGO_DET_PR( pstNomCatalogo    VARCHAR2,
                                            pstNomDetCatalogo VARCHAR2,
                                            pistUsuario       VARCHAR2);
    PROCEDURE GET_CATALOG_ELEMENTS_PR(catalogId int, lstFilter varchar2, lstCurrentIds varchar2,piinRolId NUMBER, resultSet OUT SYS_REFCURSOR);
    FUNCTION  GET_ID_CATIN_CAT_FN(piinCatalogId NUMBER)
    RETURN NUMBER;
    FUNCTION GET_CAMP_CATIN_FN (piinCatalogId NUMBER)
    RETURN VARCHAR2;
    PROCEDURE RELOAD_CAT_PERSONAS_PR(lstDummy VARCHAR2);
    PROCEDURE GET_CATALOG_PODERES_PR(lstFilter varchar2, lstCurrentIds varchar2, resultSet OUT SYS_REFCURSOR);
    PROCEDURE GET_ELEMENT_DESCRIP_PR(catalogElementId varchar2, description OUT varchar2);
    FUNCTION GET_ELEMENT_DESCRIP_FN(catalogElementId varchar2) RETURN VARCHAR2;
    PROCEDURE RELOAD_CAT_PERSONAS_TOTAL_PR(lstDummy VARCHAR2);
    FUNCTION GET_FUNCIONARIOS_FN(piinIdCatalogoValor VARCHAR2)
    RETURN VARCHAR2;
    FUNCTION MAX_PERSONAS_TOTAL_FN(pinnrowNum NUMBER)
    RETURN NUMBER;
    PROCEDURE GET_CATALOG_ELEMENTS_CLASIF_PR( catalogId int, lstFilter varchar2,
                                              lstCurrentIds varchar2,piinRolId NUMBER,
                                              resultSet OUT SYS_REFCURSOR,
                                              lstClasif VARCHAR2,
                                              lstPais VARCHAR2);
END DERCORP_CATALOGS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_CATALOGS_PKG" AS
    PROCEDURE DELETE_BITACORA_CATGO_DET_PR( pstNomCatalogo    VARCHAR2,
                                            pstNomDetCatalogo VARCHAR2,
                                            pistUsuario       VARCHAR2)
    AS
      linIdConsecutivo  NUMBER;
      linCount          NUMBER;
      linRegistroBorrar NUMBER;
    BEGIN
      SELECT COUNT(id_bitacora_del)INTO linCount
      FROM dercorp_bita_delete_catdet_tab;
      IF linCount = 100
      THEN
        SELECT MIN(id_bitacora_del) INTO linRegistroBorrar
        FROM dercorp_bita_delete_catdet_tab;
        DELETE FROM dercorp_bita_delete_catdet_tab
        WHERE id_bitacora_del = linRegistroBorrar;
      END IF;
      SELECT  NVL(MAX(id_bitacora_del) + 1,1) INTO linIdConsecutivo
      FROM dercorp_bita_delete_catdet_tab;
      INSERT INTO dercorp_bita_delete_catdet_tab(id_bitacora_del,
                                                nom_catalogo,
                                                num_created_by,
                                                fec_creation_date,
                                                nom_det_catalogo)
      VALUES( linIdConsecutivo,
              pstNomCatalogo,
              pistUsuario,
              SYSDATE,
              pstNomDetCatalogo);
    END;
    PROCEDURE INSERT_BITACORA_CATGO_DET_PR(piinIdCatalogo NUMBER,
                                           pistUsuario    VARCHAR2,
                                           pistAccion     VARCHAR2,
                                           pinConsecutivo NUMBER)
    AS
    linIdConsecutivo  NUMBER; --Id consecutivo hasta 3 registros
    linIdBitacora     NUMBER; --Id de la tabla
    linRegistroBorrar NUMBER; --id a borrar cuando sea mayor a 3
    BEGIN
    SELECT COUNT(id_bitacora_mod_det)INTO linIdConsecutivo
    FROM dercorp_bita_mod_cat_det_tab
    WHERE id_catalogo = piinIdCatalogo;
    IF linIdConsecutivo = 100 --Porque solo se requiere los ultimos 100 modificaciones
    THEN
    BEGIN
        SELECT MIN(id_bitacora_mod_det) INTO linRegistroBorrar
        FROM dercorp_bita_mod_cat_det_tab
        WHERE id_catalogo = piinIdCatalogo;
        DELETE FROM dercorp_bita_mod_cat_det_tab
        WHERE id_catalogo         = piinIdCatalogo
        AND   id_bitacora_mod_det = linRegistroBorrar;
      EXCEPTION
      WHEN OTHERS THEN
           dbms_output.put_line('Error en la transaccion:'||SQLERRM);
           dbms_output.put_line('Se deshacen las modificaciones');
           ROLLBACK;
      END;
    END IF;
    SELECT  NVL(MAX(id_bitacora_mod_det) + 1,1) INTO linIdBitacora
    FROM dercorp_bita_mod_cat_det_tab;
    IF pistAccion = 'NUEVO'
    THEN
        INSERT INTO dercorp_bita_mod_cat_det_tab( id_bitacora_mod_det,
                                                  id_catalogo,
                                                  num_created_by,
                                                  fec_creation_date,
                                                  num_consecutivo)
        VALUES( linIdBitacora,
                piinIdCatalogo,
                pistUsuario,
                SYSDATE,
                pinConsecutivo);
    ELSE IF pistAccion = 'MODIFICACION'
    THEN
        INSERT INTO dercorp_bita_mod_cat_det_tab( id_bitacora_mod_det,
                                                  id_catalogo,
                                                  num_last_updated_by,
                                                  fec_last_update_date,
                                                  num_consecutivo)
        VALUES( linIdBitacora,
                piinIdCatalogo,
                pistUsuario,
                SYSDATE,
                pinConsecutivo);
    END IF;
    END IF;
    END;
    PROCEDURE DELETE_BITACORA_CATGO_PR(pstNomCatalogo VARCHAR2,
                                       pistUsuario    VARCHAR2)
    AS
      linIdConsecutivo  NUMBER;
      linCount          NUMBER;
      linRegistroBorrar NUMBER;
    BEGIN
      SELECT COUNT(id_bitacora_del)INTO linCount
      FROM dercorp_bita_delete_cat_tab;
      IF linCount = 20
      THEN
        SELECT MIN(id_bitacora_del) INTO linRegistroBorrar
        FROM dercorp_bita_delete_cat_tab;
        DELETE FROM dercorp_bita_delete_cat_tab
        WHERE id_bitacora_del = linRegistroBorrar;
      END IF;
      SELECT  NVL(MAX(id_bitacora_del) + 1,1) INTO linIdConsecutivo
      FROM dercorp_bita_delete_cat_tab;
      INSERT INTO dercorp_bita_delete_cat_tab(id_bitacora_del,
                                                nom_catalogo,
                                                num_created_by,
                                                fec_creation_date)
      VALUES( linIdConsecutivo,
              pstNomCatalogo,
              pistUsuario,
              SYSDATE);
    END;
    PROCEDURE INSERT_BITACORA_CATGO_PR(  piinIdCatalogo NUMBER,
                                        pistUsuario    VARCHAR2,
                                        pistAccion     VARCHAR2)
    AS
    linIdConsecutivo  NUMBER; --Id consecutivo hasta 3 registros
    linIdBitacora     NUMBER; --Id de la tabla
    linRegistroBorrar NUMBER; --id a borrar cuando sea mayor a 3
    BEGIN
    SELECT COUNT(ID_BITACORA_MOD)INTO linIdConsecutivo
    FROM DERCORP_BITA_MOD_CAT_TAB
    WHERE id_catalogo = piinIdCatalogo;
    IF linIdConsecutivo = 20 --Porque solo se requiere los ultimos 3 modificaciones
    THEN
    BEGIN
        SELECT MIN(id_bitacora_mod) INTO linRegistroBorrar
        FROM DERCORP_BITA_MOD_CAT_TAB
        WHERE id_catalogo = piinIdCatalogo;
        DELETE FROM dercorp_bita_mod_cat_tab
        WHERE id_catalogo     = piinIdCatalogo
        AND   id_bitacora_mod = linRegistroBorrar;
      EXCEPTION
      WHEN OTHERS THEN
           dbms_output.put_line('Error en la transaccion:'||SQLERRM);
           dbms_output.put_line('Se deshacen las modificaciones');
           ROLLBACK;
      END;
    END IF;
    SELECT  NVL(MAX(id_bitacora_mod) + 1,1) INTO linIdBitacora
    FROM dercorp_bita_mod_cat_tab;
    IF pistAccion = 'NUEVO'
    THEN
        INSERT INTO Dercorp_Bita_Mod_Cat_Tab( id_bitacora_mod,
                                              id_catalogo,
                                              num_created_by,
                                              fec_creation_date)
        VALUES( linIdBitacora,
                piinIdCatalogo,
                pistUsuario,
                SYSDATE);
    ELSE IF pistAccion = 'MODIFICACION'
    THEN
        INSERT INTO Dercorp_Bita_Mod_Cat_Tab( id_bitacora_mod,
                                              id_catalogo,
                                              num_last_updated_by,
                                              fec_last_update_date)
        VALUES( linIdBitacora,
                piinIdCatalogo,
                pistUsuario,
                SYSDATE);
    END IF;
    END IF;
    END;
   PROCEDURE GET_CATALOG_ELEMENTS_PR(catalogId int, lstFilter varchar2, lstCurrentIds varchar2,piinRolId NUMBER, resultSet OUT SYS_REFCURSOR)
   AS
     lstQuery VARCHAR2(4000):= '' ;
     lstIn    VARCHAR2 (2000) := '';
   BEGIN
       BEGIN
         SELECT ATRIBUTO1 INTO lstIn
         FROM   SS_ROL_TAB
         WHERE  ID_ROL = piinRolId;
         IF lstIn IS NULL THEN
           lstIn := '0';
         END IF;
       EXCEPTION
         WHEN OTHERS THEN
         lstIn := '0';
       END;
      IF catalogId = 0 THEN
         OPEN resultSet FOR
           SELECT   ID_EMPRESA,
                    NOM_EMPRESA
           FROM     DERCORP_EMPRESA_TAB
           WHERE    (
                      APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOM_EMPRESA)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
                      OR
                      lstCurrentIds LIKE '%'|| ID_EMPRESA || '%'
                    )
          ORDER BY  NOM_EMPRESA;
      ELSIF catalogId = 1 THEN
        IF piinRolId = 0 THEN
          --ECM 04 Mayo 2016
/*
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    ( APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(CAT.VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(''%' ||replace(lstFilter, ' ', '%') || '%''))
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       ORDER BY VAL_CAT_VAL';
*/
          --ECM 25 Mayo 2016
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    (CAT.VAL_CAT_VAL LIKE ''%' ||replace(lstFilter, ' ', '%') || '%''
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       ORDER BY VAL_CAT_VAL';
         ELSE
/*
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    ( APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(CAT.VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(''%' ||replace(lstFilter, ' ', '%')||'%''))
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       AND     VEMP.ID_EMPRESA NOT IN ('||lstIn||')
                       ORDER BY VAL_CAT_VAL';
*/
          --ECM 25 Mayo 2016
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    (CAT.VAL_CAT_VAL LIKE ''%' ||replace(lstFilter, ' ', '%') || '%''
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       AND     VEMP.ID_EMPRESA NOT IN ('||lstIn||')
                       ORDER BY VAL_CAT_VAL';
        END IF;
        OPEN resultSet FOR lstQuery;
      ELSIF catalogId = 1000 THEN
         OPEN resultSet FOR
           SELECT   ID_REPORTE,
                    NOM_REPORTE
           FROM     DERCORP_REPORTE_TAB
           WHERE    (
                      APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOM_REPORTE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
                      OR
                      lstCurrentIds LIKE '%'|| ID_REPORTE || '%'
                    )
          ORDER BY  NOM_REPORTE;
      ELSIF catalogId = 2000 THEN
         OPEN resultSet FOR
           SELECT   ID_REPORTFLEX,
                    NOM_REPORTE
           FROM     DERCORP_REPORTFLEX_TAB
           WHERE    (
                      APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOM_REPORTE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
                      OR
                      lstCurrentIds LIKE '%'|| ID_REPORTFLEX || '%'
                    )
          ORDER BY  NOM_REPORTE;
      ELSIF catalogId = 666 THEN
        OPEN resultSet FOR
          SELECT  DISTINCT(1)
                  ,TRIM(NOMBRE) AS  NOMBRE
          FROM    DERCORP_REP_HIST_FUNC_VW
          WHERE   1=1
          AND     NOMBRE IS NOT NULL
          AND     APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
          ORDER BY NOMBRE
          ;
		--ECM 27 ENERO 2016 Agregar catalogo manual para la pesta?a Contratos, campo nombres en Captura.
      ELSIF catalogId = 6969 THEN
        OPEN resultSet FOR
              SELECT  PT.PERSON_ID
                      ,PT.NOMBRE
              FROM    DERCORP_CAT_PERSONAS_TOTAL_TAB PT
              WHERE   1=1
              AND     APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(PT.NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
              ORDER BY PT.NOMBRE
              ;
      ELSIF catalogId = 6969 THEN
        OPEN resultSet FOR
              SELECT  PT.PERSON_ID
                      ,PT.NOMBRE
              FROM    DERCORP_CAT_PERSONAS_TOTAL_TAB PT
              WHERE   1=1
              AND     APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(PT.NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
              ORDER BY PT.NOMBRE
              ;
          --- NAVA
          --- Enero 2016
          --- Catalogo de Semaforo para que se muestre el nombre del color en espaniol
      ELSIF catalogId = 31 THEN
        OPEN resultSet FOR
              SELECT
                ID_CATALOGO_VALOR,
                --COD_CAT_VAL,
                --VAL_CAT_VAL
                NOM_CAT_VAL
              FROM
                DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE
                ID_CATALOGO = catalogId
                AND
                (
                  APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%' || replace(lstFilter, ' ', '%') || '%'))
                  OR
                  lstCurrentIds LIKE '%' || ID_CATALOGO_VALOR || '%'
                )
              ORDER BY
                --VAL_CAT_VAL
                NOM_CAT_VAL
              ;
      ELSE
        OPEN resultSet FOR
              SELECT
                ID_CATALOGO_VALOR,
                --COD_CAT_VAL,
                VAL_CAT_VAL
              FROM
                DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE
                ID_CATALOGO = catalogId
                AND
                (
                  APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%' || replace(lstFilter, ' ', '%') || '%'))
                  OR
                  lstCurrentIds LIKE '%' || ID_CATALOGO_VALOR || '%'
                )
              ORDER BY
                APP_COMMON_PKG.SIN_ACENTOS_FN(VAL_CAT_VAL)
              ;
      END IF;
    END GET_CATALOG_ELEMENTS_PR;
  --JJAQ PARA QUE FILTRE POR CLASIFICACION EN LOS FILTROS DE DENOMINACION SOCIAL DE LOS REPORTES PERSONALIZADOS
    PROCEDURE GET_CATALOG_ELEMENTS_CLASIF_PR(catalogId int, lstFilter varchar2,
                                              lstCurrentIds varchar2,piinRolId NUMBER,
                                              resultSet OUT SYS_REFCURSOR,
                                              lstClasif VARCHAR2,
                                              lstPais VARCHAR2)
   AS
     lstQuery VARCHAR2(4000):= '' ;
     lstIn    VARCHAR2 (2000) := '';
   BEGIN
       BEGIN
         SELECT ATRIBUTO1 INTO lstIn
         FROM   SS_ROL_TAB
         WHERE  ID_ROL = piinRolId;
         IF lstIn IS NULL THEN
           lstIn := '0';
         END IF;
       EXCEPTION
         WHEN OTHERS THEN
         lstIn := '0';
       END;
      IF catalogId = 0 THEN
         OPEN resultSet FOR
           SELECT   ID_EMPRESA,
                    NOM_EMPRESA
           FROM     DERCORP_EMPRESA_TAB
           WHERE    (
                      APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOM_EMPRESA)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
                      OR
                      lstCurrentIds LIKE '%'|| ID_EMPRESA || '%'
                    )
          ORDER BY  NOM_EMPRESA;
      ELSIF catalogId = 1 THEN
        IF piinRolId = 0 THEN
          --ECM 04 Mayo 2016
/*
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    ( APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(CAT.VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(''%' ||replace(lstFilter, ' ', '%') || '%''))
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       ORDER BY VAL_CAT_VAL';
*/
          --ECM 25 Mayo 2016
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    (CAT.VAL_CAT_VAL LIKE ''%' ||replace(lstFilter, ' ', '%') || '%''
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       ORDER BY VAL_CAT_VAL';
         ELSE
/*
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    ( APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(CAT.VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(''%' ||replace(lstFilter, ' ', '%')||'%''))
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       AND     VEMP.ID_EMPRESA NOT IN ('||lstIn||')
                       ORDER BY VAL_CAT_VAL';
*/
          --ECM 25 Mayo 2016
          lstQuery := 'SELECT DISTINCT(CAT.ID_CATALOGO_VALOR),
                              CAT.VAL_CAT_VAL,
                              VEMP.id_clasificacion
                       FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT,
                              DERCORP_BUSQUEDA_VIEW VEMP
                       WHERE  1=1
                       AND    CAT.VAL_CAT_VAL = VEMP.DENOM_ACTUAL
                       AND    CAT.ID_CATALOGO = 1
                       AND    (CAT.VAL_CAT_VAL LIKE ''%' ||replace(lstFilter, ' ', '%') || '%''
                       OR '
                              ||''''||lstCurrentIds||''''||' LIKE  ''%''||CAT.ID_CATALOGO_VALOR||''%'')
                       AND     VEMP.ID_EMPRESA NOT IN ('||lstIn||')
                       '||lstPais||'
                       '||lstClasif||'
                       ORDER BY VAL_CAT_VAL';
        END IF;
        OPEN resultSet FOR lstQuery;
      ELSIF catalogId = 1000 THEN
         OPEN resultSet FOR
           SELECT   ID_REPORTE,
                    NOM_REPORTE
           FROM     DERCORP_REPORTE_TAB
           WHERE    (
                      APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOM_REPORTE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
                      OR
                      lstCurrentIds LIKE '%'|| ID_REPORTE || '%'
                    )
          ORDER BY  NOM_REPORTE;
      ELSIF catalogId = 2000 THEN
         OPEN resultSet FOR
           SELECT   ID_REPORTFLEX,
                    NOM_REPORTE
           FROM     DERCORP_REPORTFLEX_TAB
           WHERE    (
                      APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOM_REPORTE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
                      OR
                      lstCurrentIds LIKE '%'|| ID_REPORTFLEX || '%'
                    )
          ORDER BY  NOM_REPORTE;
      ELSIF catalogId = 666 THEN
        OPEN resultSet FOR
          SELECT  DISTINCT(1)
                  ,TRIM(NOMBRE) AS  NOMBRE
          FROM    DERCORP_REP_HIST_FUNC_VW
          WHERE   1=1
          AND     NOMBRE IS NOT NULL
          AND     APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
          ORDER BY NOMBRE
          ;
		--ECM 27 ENERO 2016 Agregar catalogo manual para la pesta?a Contratos, campo nombres en Captura.
      ELSIF catalogId = 6969 THEN
        OPEN resultSet FOR
              SELECT  PT.PERSON_ID
                      ,PT.NOMBRE
              FROM    DERCORP_CAT_PERSONAS_TOTAL_TAB PT
              WHERE   1=1
              AND     APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(PT.NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
              ORDER BY PT.NOMBRE
              ;
      ELSIF catalogId = 6969 THEN
        OPEN resultSet FOR
              SELECT  PT.PERSON_ID
                      ,PT.NOMBRE
              FROM    DERCORP_CAT_PERSONAS_TOTAL_TAB PT
              WHERE   1=1
              AND     APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(PT.NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%'||replace(lstFilter,' ','%')||'%'))
              ORDER BY PT.NOMBRE
              ;
          --- NAVA
          --- Enero 2016
          --- Catalogo de Semaforo para que se muestre el nombre del color en espaniol
      ELSIF catalogId = 31 THEN
        OPEN resultSet FOR
              SELECT
                ID_CATALOGO_VALOR,
                --COD_CAT_VAL,
                --VAL_CAT_VAL
                NOM_CAT_VAL
              FROM
                DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE
                ID_CATALOGO = catalogId
                AND
                (
                  APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%' || replace(lstFilter, ' ', '%') || '%'))
                  OR
                  lstCurrentIds LIKE '%' || ID_CATALOGO_VALOR || '%'
                )
              ORDER BY
                --VAL_CAT_VAL
                NOM_CAT_VAL
              ;
      ELSE
        OPEN resultSet FOR
              SELECT
                ID_CATALOGO_VALOR,
                --COD_CAT_VAL,
                VAL_CAT_VAL
              FROM
                DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE
                ID_CATALOGO = catalogId
                AND
                (
                  APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(VAL_CAT_VAL)) LIKE APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER('%' || replace(lstFilter, ' ', '%') || '%'))
                  OR
                  lstCurrentIds LIKE '%' || ID_CATALOGO_VALOR || '%'
                )
              ORDER BY
                APP_COMMON_PKG.SIN_ACENTOS_FN(VAL_CAT_VAL)
              ;
      END IF;
    END GET_CATALOG_ELEMENTS_CLASIF_PR;
    FUNCTION  GET_ID_CATIN_CAT_FN(piinCatalogId NUMBER)
    RETURN NUMBER
    IS
      linCatalogoFin NUMBER;
    BEGIN
      BEGIN
        SELECT app_config.id_cat_in INTO linCatalogoFin
        FROM (
              SELECT config.nom_config,
                     config.des_config,
                     config.val_config,
                     (SELECT id_catalogo
                      FROM   dercorp_add_campo_cat_tab
                      WHERE  cod_catalogo = config.nom_config) id_cat_ori,
                      (SELECT id_catalogo
                      FROM   dercorp_add_campo_cat_tab
                      WHERE  cod_catalogo = config.val_config) id_cat_in
              FROM   app_config_tab config
              WHERE  cod_config = 'CATIN_CAT' ) app_config
        WHERE app_config.id_cat_ori = piinCatalogId;
      EXCEPTION
        WHEN OTHERS THEN
          linCatalogoFin := 0;
      END;
      RETURN linCatalogoFin;
    END;
    FUNCTION GET_CAMP_CATIN_FN (piinCatalogId NUMBER)
    RETURN VARCHAR2
    IS
      lstCampo VARCHAR2(1000);
    BEGIN
      BEGIN
        SELECT app_config.des_config INTO lstCampo
        FROM (
              SELECT config.nom_config,
                     config.des_config,
                     config.val_config,
                     (SELECT id_catalogo
                      FROM   dercorp_add_campo_cat_tab
                      WHERE  cod_catalogo = config.nom_config) id_cat_ori,
                      (SELECT id_catalogo
                      FROM   dercorp_add_campo_cat_tab
                      WHERE  cod_catalogo = config.val_config) id_cat_in
              FROM   app_config_tab config
              WHERE  cod_config = 'CATIN_CAT' ) app_config
        WHERE app_config.id_cat_ori = piinCatalogId;
      EXCEPTION
        WHEN OTHERS THEN
          lstCampo := '0';
      END;
      RETURN lstCampo;
    END;
    --
    --
    --
    PROCEDURE RELOAD_CAT_PERSONAS_PR(lstDummy VARCHAR2)
    AS
    BEGIN
        DELETE FROM DERCORP_CAT_PERSONAS_TAB;
        INSERT INTO DERCORP_CAT_PERSONAS_TAB
        SELECT
          ROWNUM PERSON_ID
          --,PERSON_ID
          ,NOMBRE
        FROM
          (
              SELECT  DISTINCT
                          --TRIM(APP_COMMON_PKG.SIN_ACENTOS_NI_NN_FN(UPPER(REPLACE(REPLACE(REPLACE(NOMBRE,' ','_'),'.',''),',','')))) PERSON_ID
                        --,
                        TRIM(NOMBRE) AS  NOMBRE
                FROM    DERCORP_REP_HIST_FUNC_VW
                WHERE   1=1
                AND     NOMBRE IS NOT NULL
                --AND     APP_COMMON_PKG.SIN_ACENTOS_NI_NN_FN(UPPER(NOMBRE)) LIKE APP_COMMON_PKG.SIN_ACENTOS_NI_NN_FN(UPPER('%'||replace('',' ','%')||'%'))
                ORDER BY NOMBRE
        ) PERSONS;
    END RELOAD_CAT_PERSONAS_PR;
    FUNCTION MAX_PERSONAS_TOTAL_FN(pinnrowNum NUMBER)
    RETURN NUMBER
    IS
    linNumMaximo  NUMBER := 0;
    BEGIN
    --  BEGIN
        SELECT MAX(person_id) + pinnrowNum INTO linNumMaximo
        FROM DERCORP_CAT_PERSONAS_TOTAL_TAB;
       /* EXCEPTION WHEN OTHERS THEN
        linNumMaximo := 0;
        END;*/
         RETURN linNumMaximo;
    END;
    --
    --
    PROCEDURE RELOAD_CAT_PERSONAS_TOTAL_PR(lstDummy VARCHAR2)
    AS
    BEGIN
         FOR i IN(
                     SELECT
                      DERCORP_CATALOGS_PKG.MAX_PERSONAS_TOTAL_FN(ROWNUM) PERSON_ID
                      --,PERSON_ID
                      ,NOMBRE
                    FROM
                      (
                          SELECT   DISTINCT
                                   TRIM(NOMBRE) AS  NOMBRE
                            FROM   DERCORP_CAT_PERSONAS_TOTAL_VW
                            WHERE  1=1
                            AND    NOMBRE IS NOT NULL
                            ORDER BY NOMBRE
                      ) PERSONS
                    WHERE  NOT EXISTS (SELECT CATTOT.NOMBRE
                                       FROM   DERCORP_CAT_PERSONAS_TOTAL_TAB CATTOT
                                       WHERE  CATTOT.NOMBRE = PERSONS.NOMBRE)
                )
          LOOP
                INSERT INTO DERCORP_CAT_PERSONAS_TOTAL_TAB(PERSON_ID,NOMBRE)
                VALUES(i.PERSON_ID,i.NOMBRE);
          END LOOP;
      COMMIT;
    END RELOAD_CAT_PERSONAS_TOTAL_PR;
    --
    --
    --
    PROCEDURE GET_CATALOG_PODERES_PR(lstFilter varchar2, lstCurrentIds varchar2, resultSet OUT SYS_REFCURSOR)
    AS
    BEGIN
       OPEN resultSet FOR
             SELECT
                CAT.ID_PODER_PK AS ID_CATALOGO,
                CASE CAT.IND_PODERTIPO
                 WHEN 'PG' THEN CAT.IND_PODERTIPO||' - '||CAT.DES_PODERTIPO
                ELSE  'CP/PE - '||CAT.DES_PODERTIPO end AS VAL_CAT_VAL
              FROM
                PENDIUM_CATALOGO_PODERES_TAB CAT
              WHERE
                CAT.IND_STATUS = 1
              ORDER BY
                CAT.IND_PODERTIPO desc,CAT.DES_PODERTIPO;
    END GET_CATALOG_PODERES_PR;
    PROCEDURE GET_ELEMENT_DESCRIP_PR(catalogElementId varchar2, description OUT varchar2)
    AS
    BEGIN
        SELECT
          VAL_CAT_VAL INTO description
        FROM
          DERCORP_ADD_CAMPO_CAT_VAL_TAB
        WHERE
          ID_CATALOGO_VALOR = catalogElementId;
    END GET_ELEMENT_DESCRIP_PR;
    --
    -- NAVA
    --
    FUNCTION GET_ELEMENT_DESCRIP_FN(catalogElementId varchar2) RETURN VARCHAR2
    AS
      description varchar2(255);
    BEGIN
        BEGIN
              SELECT
                VAL_CAT_VAL INTO description
              FROM
                DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE
                ID_CATALOGO_VALOR = catalogElementId;
              RETURN description;
        EXCEPTION
            WHEN OTHERS THEN
              RETURN '-';
        END;
    END GET_ELEMENT_DESCRIP_FN;
    FUNCTION GET_FUNCIONARIOS_FN(piinIdCatalogoValor VARCHAR2)
    RETURN VARCHAR2
    IS
    lstNombreFuncionario VARCHAR2(2000) := '';
    BEGIN
        BEGIN
            SELECT APP_COMMON_PKG.SIN_ACENTOS_FN(UPPER(VAL_CAT_VAL))
            INTO   lstNombreFuncionario
            FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
            WHERE  1=1
            AND    ID_CATALOGO = 10
            AND    ID_CATALOGO_VALOR = piinIdCatalogoValor
            ;
            IF lstNombreFuncionario IS NULL THEN
                lstNombreFuncionario := 'N/A';
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lstNombreFuncionario := 'N/A';
            WHEN OTHERS THEN
                lstNombreFuncionario := 'N/A';
        END;
    RETURN lstNombreFuncionario;
    END;
END DERCORP_CATALOGS_PKG;
/;
