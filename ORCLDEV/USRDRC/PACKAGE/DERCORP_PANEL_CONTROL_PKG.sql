CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_PANEL_CONTROL_PKG" AS
/*===============================================================
FILE NAME :             APPS.dercorp_panel_control_pkg pks
NOMBRE DEL MODULO:         XXGL - Derecho corporativo
CREATED DATE:            15-Sept-2015
AUTHOR(S):                 Jesus Argumedo
SHORT DESCRIPTION:     Procedimeinto para el ABC del modulo de panel
                        de control de la aplicacion
PROCEDURES CONTAINS:
RELATED DOCUMENTS :     RFC Anexo B (Modificacion a Base de Datos)
===============================================================
MODIFICATION DATE :
MODIFICATION MADE BY:
CHANGE MADE:
RELATED DOCUMENTS :
===============================================================*/
    PROCEDURE insert_empresa_pr( pstCve_empresa    			VARCHAR2
                                ,pstNomEmpresa     			VARCHAR2
                                ,pstAttr1          			VARCHAR2
                                ,pstAttr2          			VARCHAR2
                                ,pstIdPais         			VARCHAR2
																,pstNum_created_by      NUMBER
                                ,pstOuterror   OUT      VARCHAR2);
                                --,pstAtributo3           VARCHAR2);
    PROCEDURE update_empresa_pr( pinIdempresa      NUMBER
                                ,pstCve_empresa    VARCHAR2
                                ,pstNomEmpresa     VARCHAR2
                                ,pstAttr1          VARCHAR2
                                ,pstAttr2          VARCHAR2
                                ,pstIdPais         VARCHAR2
																,pstNum_last_updated_by NUMBER
                                ,pstOuterror   OUT VARCHAR2);
                                --,pstAtributo3           VARCHAR2);
    PROCEDURE delete_empresa_pr( pinIdempresa      NUMBER
                                ,pstOuterror   OUT VARCHAR2);
    --
    -- NAVA - 21 Abril
    --
    FUNCTION IS_EMPRESA_DELETABLE_FN ( pinIdempresa NUMBER) RETURN VARCHAR;
    FUNCTION IS_EMPRESA_DELETABLE_FN2 ( pinIdempresa NUMBER) RETURN VARCHAR;
    FUNCTION  es_empresa_fn ( pinIdCat      NUMBER,
                              pstValCatVal  VARCHAR2)
    RETURN VARCHAR2;
    PROCEDURE insert_rol_pr ( pstNomRol         VARCHAR2
                             ,pstDescRol        VARCHAR2
                             ,pstNumExp         NUMBER
                             ,pstReportPre      VARCHAR2
                             ,pstReportPer      VARCHAR2
                             ,pstSeqIdMenu      NUMBER
                             ,pstOuterror   OUT VARCHAR2
                             ,pinModifico       NUMBER);
    PROCEDURE update_new_menu_pr ( pStMenuElement  VARCHAR2,pinIdMenu NUMBER);
    PROCEDURE update_rol_pr ( pinIdRol          NUMBER
                             ,pstNomRol         VARCHAR2
                             ,pstDescRol        VARCHAR2
                             ,pstNumExp         NUMBER
                             ,pstReportPre      VARCHAR2
                             ,pstReportPer      VARCHAR2
                             ,pstOuterror   OUT VARCHAR2
                             ,pinModifico       NUMBER);
    PROCEDURE update_menu_pr ( pStMenuElement  VARCHAR2);
    PROCEDURE update_new_rol_seccion_pr (pstRolSeccion VARCHAR2);
    PROCEDURE update_rol_seccion_pr (pstRolSeccion VARCHAR2);
    PROCEDURE elimina_rol_pr ( pinIdRol       NUMBER
                              ,pstOuterror    OUT VARCHAR2
                              ,pinModifico    NUMBER);
END DERCORP_PANEL_CONTROL_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_PANEL_CONTROL_PKG" AS
/*===============================================================
FILE NAME :             dercorp_panel_control_pkg pkb
NOMBRE DEL MODULO:         XXGL - Derecho corporativo
CREATED DATE:            15-Sept-2015
AUTHOR(S):                 Jesus Argumedo
SHORT DESCRIPTION:     Procedimeinto para el ABC del modulo de panel
                        de control de la aplicacion
PROCEDURES CONTAINS:
RELATED DOCUMENTS :     RFC Anexo B (Modificacion a Base de Datos)
===============================================================
MODIFICATION DATE :
MODIFICATION MADE BY:
CHANGE MADE:
RELATED DOCUMENTS :
===============================================================*/
  PROCEDURE INSERT_EMPRESA_PR( pstCve_empresa         VARCHAR2,
                               pstNomEmpresa          VARCHAR2,
                               pstAttr1               VARCHAR2,
                               pstAttr2          		  VARCHAR2,
                               pstIdPais              VARCHAR2,
                               pstNum_created_by      NUMBER,
                               pstOuterror   OUT      VARCHAR2)AS
                               --pstAtributo3           VARCHAR2)AS
    linCountRepetidos   NUMBER;
    linconsecutivo      NUMBER;
    linCountExisteemp   NUMBER;
    linCountExisteAcc   NUMBER;
    linCountRFC         NUMBER;
    linCountPais        NUMBER;
    linIdEmpresa        NUMBER;
    linDenomActu        NUMBER;
    linIdCatVal         NUMBER;
    linCountNomCorto    NUMBER;
    eDuplicadoExcepcion EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO linCountRepetidos
    FROM   DERCORP_EMPRESA_TAB
    WHERE  NOM_EMPRESA = pstNomEmpresa;
    IF linCountRepetidos > 0  THEN
      RAISE eDuplicadoExcepcion;
    END IF;
    --SELECT MAX(id_empresa) INTO linconsecutivo
    --FROM DERCORP_EMPRESA_TAB;
    SELECT DERCORP_EMPRESA_SEQ.NEXTVAL INTO linconsecutivo
    FROM DUAL;
    --linconsecutivo := linconsecutivo + 1;
    BEGIN
        INSERT INTO DERCORP_EMPRESA_TAB( id_empresa
                                        ,cve_empresa
                                        ,nom_empresa
                                        ,atributo1
                                        ,atributo2
                                        ,fec_creation_date
                                        ,fec_last_update_date
                                        ,num_created_by)
                                        --,atributo3)
        VALUES                         (
                                         linconsecutivo
                                        ,pstCve_empresa
                                        ,pstNomEmpresa
                                        ,pstAttr1
                                        ,pstAttr2
                                        ,SYSDATE
                                        ,SYSDATE
                                        ,pstNum_created_by);
                                        --,pstAtributo3);
        --Inserta denominacion social
        SELECT COUNT(*) INTO linCountExisteemp
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND val_cat_val   = pstNomEmpresa;
        SELECT dercorp_cat_val_seq.NEXTVAL INTO linIdCatVal
        FROM dual;
        IF linCountExisteemp = 0
        THEN
            INSERT INTO dercorp_add_campo_cat_val_tab( id_catalogo_valor
                                                      ,id_catalogo
                                                      ,cod_cat_val
                                                      ,nom_cat_val
                                                      ,val_cat_val
                                                      ,des_cat_val
                                                      ,atributo1
                                                      ,atributo2
                                                      ,fec_creation_date)
            VALUES                                   (linIdCatVal
                                                      ,1
                                                      ,(SELECT MAX(TO_NUMBER(cod_cat_val)) + 1
                                                        FROM dercorp_add_campo_cat_val_tab
                                                        WHERE id_catalogo = 1)
                                                      ,pstCve_empresa
                                                      ,pstNomEmpresa
                                                      ,pstNomEmpresa
                                                      ,pstAttr1
                                                      ,pstAttr2
                                                      ,SYSDATE
                                                      );
        ELSE
            UPDATE dercorp_add_campo_cat_val_tab
            SET  nom_cat_val            = pstCve_empresa
                ,val_cat_val            = pstNomEmpresa
                ,des_cat_val            = pstNomEmpresa
                ,atributo1              = pstAttr1
                ,atributo2              = pstAttr2
                ,fec_last_update_date   = SYSDATE
            WHERE id_catalogo = 1
            AND  val_cat_val  = pstNomEmpresa;
        END IF;
        --Inserta en accionistas
        SELECT COUNT(*) INTO linCountExisteAcc
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 40
        AND val_cat_val   = pstNomEmpresa;
        IF linCountExisteAcc = 0
        THEN
            INSERT INTO dercorp_add_campo_cat_val_tab( id_catalogo_valor
                                                      ,id_catalogo
                                                      ,cod_cat_val
                                                      ,nom_cat_val
                                                      ,val_cat_val
                                                      ,des_cat_val
                                                      ,atributo1
                                                      ,atributo2
                                                      ,fec_creation_date)
            VALUES                                   (dercorp_cat_val_seq.NEXTVAL
                                                      ,40
                                                      ,(SELECT MAX(TO_NUMBER(cod_cat_val)) + 1
                                                        FROM dercorp_add_campo_cat_val_tab
                                                        WHERE id_catalogo = 40)
                                                      ,pstCve_empresa
                                                      ,pstNomEmpresa
                                                      ,pstNomEmpresa
                                                      ,pstAttr1
                                                      ,pstAttr2
                                                      ,SYSDATE
                                                      );
        ELSE
            UPDATE dercorp_add_campo_cat_val_tab
            SET  nom_cat_val            = pstCve_empresa
                ,val_cat_val            = pstNomEmpresa
                ,des_cat_val            = pstNomEmpresa
                ,atributo1              = pstAttr1
                ,atributo2              = pstAttr2
                ,fec_last_update_date   = SYSDATE
            WHERE id_catalogo = 40
            AND  val_cat_val  = pstNomEmpresa;
        END IF;
        /********INSERTA RFC*******/
        SELECT id_empresa INTO linIdEmpresa
        FROM DERCORP_EMPRESA_TAB
        WHERE nom_empresa = pstNomEmpresa;
        SELECT COUNT(*) INTO linCountRFC
        FROM dercorp_add_campo_valor_tab
        WHERE id_add_campo = 529 --Codigo RFC
        AND id_empresa     = linIdEmpresa;
        --AND val_valor      = pstAttr1;
        IF linCountRFC = 0
        THEN
            INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB( id_add_campo
                                                    ,id_empresa
                                                    ,val_valor
                                                    ,fec_creation_date)
            VALUES( 529
                   ,linconsecutivo
                   ,pstAttr1
                   ,SYSDATE);
        ELSE
            UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
            SET     VAL_VALOR               = pstAttr1,
                    FEC_LAST_UPDATE_DATE    = SYSDATE
            WHERE   1=1
            AND     ID_EMPRESA   = linIdEmpresa
            AND     ID_ADD_CAMPO = 529;
        END IF;
        /********INSERTA PAIS*******/
        SELECT COUNT(*) INTO linCountPais
        FROM dercorp_add_campo_valor_tab
        WHERE id_add_campo = 509 --Codigo RFC
        AND id_empresa     = linIdEmpresa;
        --AND val_valor      = pstIdPais;
        IF linCountPais = 0
        THEN
            INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB( id_add_campo
                                                    ,id_empresa
                                                    ,val_valor
                                                    ,fec_creation_date)
            VALUES( 509
                   ,linconsecutivo
                   ,DECODE(pstIdPais,'null','0',pstIdPais)
                   ,SYSDATE);
        ELSE
            UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
            SET     VAL_VALOR               = DECODE(pstIdPais,'null','0',pstIdPais),
                    FEC_LAST_UPDATE_DATE    = SYSDATE
            WHERE   1=1
            AND     ID_EMPRESA   = linIdEmpresa
            AND     ID_ADD_CAMPO = 509;
        END IF;
        /********INSERTA Denom Actual*******/
        SELECT COUNT(*) INTO linDenomActu
        FROM dercorp_add_campo_valor_tab
        WHERE id_add_campo = 500 --Codigo RFC
        AND id_empresa     = linIdEmpresa;
        --AND val_valor      = linIdCatVal;
        IF linDenomActu = 0
        THEN
            INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB( id_add_campo
                                                    ,id_empresa
                                                    ,val_valor
                                                    ,fec_creation_date)
            VALUES( 500
                   ,linconsecutivo
                   ,linIdCatVal
                   ,SYSDATE);
        ELSE
            UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
            SET     VAL_VALOR               = linIdCatVal,
                    FEC_LAST_UPDATE_DATE    = SYSDATE
            WHERE   1=1
            AND     ID_EMPRESA   = linIdEmpresa
            AND     ID_ADD_CAMPO = 500;
        END IF;
         /********INSERTA Nombre Corto*******/
        SELECT COUNT(*) INTO linCountNomCorto
        FROM dercorp_add_campo_valor_tab
        WHERE id_add_campo = 501 --Nombre corto
        AND id_empresa     = linIdEmpresa;
        --AND val_valor      = linIdCatVal;
        IF linCountNomCorto = 0
        THEN
            INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB( id_add_campo
                                                    ,id_empresa
                                                    ,val_valor
                                                    ,fec_creation_date)
            VALUES( 501
                   ,linconsecutivo
                   ,pstCve_empresa
                   ,SYSDATE);
        ELSE
            UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
            SET     VAL_VALOR               = pstCve_empresa,
                    FEC_LAST_UPDATE_DATE    = SYSDATE
            WHERE   1=1
            AND     ID_EMPRESA   = linIdEmpresa
            AND     ID_ADD_CAMPO = 501;
        END IF;
    EXCEPTION
      WHEN eDuplicadoExcepcion THEN
        pstOuterror := 'Empresa Duplicada';
      WHEN OTHERS THEN
        pstOuterror := SQLERRM;
    END;
END INSERT_EMPRESA_PR;
PROCEDURE update_empresa_pr( pinIdempresa      NUMBER
                            ,pstCve_empresa    VARCHAR2
                            ,pstNomEmpresa     VARCHAR2
                            ,pstAttr1          VARCHAR2
                            ,pstAttr2          VARCHAR2
                            ,pstIdPais         VARCHAR2
														,pstNum_last_updated_by NUMBER
                            ,pstOuterror   OUT VARCHAR2)AS
                            --,pstAtributo3           VARCHAR2)AS
lstActNomEmpresa VARCHAR2(2000);
linCountRepetidos   NUMBER;
eDuplicadoExcepcion EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO linCountRepetidos
    FROM   DERCORP_EMPRESA_TAB
    WHERE  NOM_EMPRESA = pstNomEmpresa
    AND ID_EMPRESA NOT IN (pinIdempresa);--28-Sept-2017 EXCLUYE EMPRESA JAMS
    IF linCountRepetidos > 0  THEN
      RAISE eDuplicadoExcepcion;
    END IF;
    BEGIN
        BEGIN
          SELECT  nom_empresa INTO lstActNomEmpresa
          FROM    dercorp_empresa_tab
          WHERE   id_empresa  = pinIdempresa;
        EXCEPTION
          WHEN OTHERS THEN
            lstActNomEmpresa:= '';
        END;
        UPDATE  DERCORP_EMPRESA_TAB
        SET     cve_empresa             = pstCve_empresa
               ,nom_empresa             = pstNomEmpresa
               ,atributo1               = pstAttr1
               ,atributo2               = pstAttr2
               --,atributo3               = pstAtributo3
               ,fec_last_update_date    = SYSDATE
							 ,num_last_updated_by     = pstNum_last_updated_by
        WHERE   id_empresa              = pinIdempresa;
        UPDATE dercorp_add_campo_cat_val_tab
        SET  nom_cat_val            = pstCve_empresa
            ,val_cat_val            = pstNomEmpresa
            ,des_cat_val            = pstNomEmpresa
            ,atributo1              = pstAttr1
            ,atributo2              = pstAttr2
            ,fec_last_update_date   = SYSDATE
        WHERE id_catalogo = 1
        AND  val_cat_val  = lstActNomEmpresa;
        UPDATE dercorp_add_campo_cat_val_tab
        SET  nom_cat_val            = pstCve_empresa
            ,val_cat_val            = pstNomEmpresa
            ,des_cat_val            = pstNomEmpresa
            ,atributo1              = pstAttr1
            ,atributo2              = pstAttr2
            ,fec_last_update_date   = SYSDATE
        WHERE id_catalogo = 40
        AND  val_cat_val  = lstActNomEmpresa;
        /**RFC**/
        UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
        SET     VAL_VALOR               = pstAttr1,
                FEC_LAST_UPDATE_DATE    = SYSDATE
        WHERE   1=1
        AND     ID_EMPRESA   = pinIdempresa
        AND     ID_ADD_CAMPO = 529;
        /**Pais**/
        UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
        SET     VAL_VALOR               = DECODE(pstIdPais,'null','0',pstIdPais),
                FEC_LAST_UPDATE_DATE    = SYSDATE
        WHERE   1=1
        AND     ID_EMPRESA   = pinIdempresa
        AND     ID_ADD_CAMPO = 509;
        /**Denominacion actual**/
        /**Nombre Corto**/
        UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
        SET     VAL_VALOR               = pstCve_empresa,
                FEC_LAST_UPDATE_DATE    = SYSDATE
        WHERE   1=1
        AND     ID_EMPRESA   = pinIdempresa
        AND     ID_ADD_CAMPO = 501;
    EXCEPTION
    WHEN eDuplicadoExcepcion THEN
        pstOuterror := 'Empresa Duplicada';
    WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
    END;
END update_empresa_pr;
PROCEDURE delete_empresa_pr( pinIdempresa      NUMBER
                            ,pstOuterror   OUT VARCHAR2)AS
BEGIN
    BEGIN
        DELETE
        FROM  dercorp_add_campo_cat_val_tab
        WHERE val_cat_val = (SELECT nom_empresa
                             FROM dercorp_empresa_tab
                             WHERE id_empresa = pinIdempresa)
        AND id_catalogo   IN (1,40);
        DELETE
        FROM  dercorp_empresa_tab
        WHERE id_empresa = pinIdempresa;
        --BORRA RFC Y PAIS
        DELETE FROM dercorp_add_campo_valor_tab
        WHERE id_empresa = pinIdempresa;
        --AND   id_add_campo IN (509,529);
        DELETE FROM dercorp_metatbl_tab
        WHERE id_empresa = pinIdempresa;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
    END;
END delete_empresa_pr;
--
-- NAVA - 21 Abril
--
FUNCTION IS_EMPRESA_DELETABLE_FN ( pinIdempresa NUMBER) RETURN VARCHAR
AS
    VAR_COUNT INT;
    VAR_ID_CAT_VAL_1 INT;
    VAR_ID_CAT_VAL_40 INT;
BEGIN
  /*
      SELECT count(*) INTO VAR_COUNT
      FROM DERCORP_METATBL_TAB WHERE ID_EMPRESA = pinIdempresa;
      IF VAR_COUNT < 5 THEN
        RETURN 'SI';
      END IF;*/
    --
    -- Campos de la Informacion de la empresa. Solo deben ser 4 (los default)
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_ADD_CAMPO_VALOR_TAB
    WHERE
      TRIM(VAL_VALOR) <> '0'
      AND TRIM(VAL_VALOR) <> '0.00'
      AND UPPER(TRIM(VAL_VALOR)) <> 'NULL'
      AND TRIM(VAL_VALOR) <> 'semaforo_green.png'
      AND ID_EMPRESA = pinIdempresa;
    IF VAR_COUNT > 4 THEN
        RETURN 'NO';
    END IF;
    --
    -- Info en Metatablas. Debe ser 0
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB WHERE ID_EMPRESA = pinIdempresa;
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
BEGIN
      SELECT
          ID_CATALOGO_VALOR INTO VAR_ID_CAT_VAL_1
      FROM
          DERCORP_ADD_CAMPO_CAT_VAL_TAB
      WHERE
        VAL_CAT_VAL IN (
              SELECT NOM_EMPRESA FROM DERCORP_EMPRESA_TAB WHERE ID_EMPRESA = pinIdempresa
        )
       AND
        ID_CATALOGO = 1;
EXCEPTION
   WHEN OTHERS THEN
     VAR_ID_CAT_VAL_1 := -99999;
END;
BEGIN
      SELECT
          ID_CATALOGO_VALOR INTO VAR_ID_CAT_VAL_40
      FROM
          DERCORP_ADD_CAMPO_CAT_VAL_TAB
      WHERE
        VAL_CAT_VAL IN (
              SELECT NOM_EMPRESA FROM DERCORP_EMPRESA_TAB WHERE ID_EMPRESA = pinIdempresa
        )
       AND
        ID_CATALOGO = 40;
EXCEPTION
   WHEN OTHERS THEN
     VAR_ID_CAT_VAL_40 := -99999;
END;
    --
    -- Empresas que tienen esa denominacion actual, solo debe ser una
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_ADD_CAMPO_VALOR_TAB WHERE
    ID_ADD_CAMPO = 500
    AND
    VAL_VALOR IN (VAR_ID_CAT_VAL_1 || '');
    IF VAR_COUNT > 1 THEN
        RETURN 'NO';
    END IF;
    --
    -- Como Accionista
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 7
      AND
      VAL_C1 IN (VAR_ID_CAT_VAL_40 || '');
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- En Aumento de Capital S.A.
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 4
      AND
      (VAR_ID_CAT_VAL_1 || '')
        IN (VAL_C1, VAL_C5, VAL_C6, VAL_C8, VAL_C10);
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- Denominacion en Reforma Total de Estatutos
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 20
      AND
      (VAR_ID_CAT_VAL_1 || '')
        IN (VAL_C8);
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- Acta de Hechos levantada a solicitud de en Escrituras Otros
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 27
      AND
      (VAR_ID_CAT_VAL_1 || '')
        IN (VAL_C8);
     IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- En Fusion
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 34
      AND
      VAL_C99 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- En Fusion
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 34
      AND
      VAL_C98 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- Contrato
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 30
      AND
      VAL_C11 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --
    -- Contrato
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 30
      AND
      VAL_C7 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    --Poderes JAMS 04/10/2017
    SELECT count(*) INTO VAR_COUNT
    FROM PENDIUM_ESCRITURA_PODER_TAB
    WHERE ID_EMPRESA = pinIdempresa
    AND IND_STATUS = 1;
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO';
    END IF;
    RETURN 'SI';
END IS_EMPRESA_DELETABLE_FN;
FUNCTION  es_empresa_fn ( pinIdCat      NUMBER,
                          pstValCatVal  VARCHAR2)
RETURN VARCHAR2
IS
  lstCountEmp NUMBER := 0;
  lstResult   VARCHAR2(100) := '';
BEGIN
  IF pinIdCat IN (40,1) THEN
    SELECT COUNT(*) INTO lstCountEmp
    FROM dercorp_empresa_tab
    WHERE  nom_empresa = pstValCatVal;
    IF lstCountEmp > 0 THEN
      --lstResult := 'disabled';
      lstResult := 'readonly';
    END IF;
  ELSIF pinIdCat = 45 THEN
      lstResult := 'disabled';
  ELSE
    lstResult:=' ';
  END IF;
  RETURN lstResult;
END;
PROCEDURE insert_rol_pr ( pstNomRol         VARCHAR2
                         ,pstDescRol        VARCHAR2
                         ,pstNumExp         NUMBER
                         ,pstReportPre      VARCHAR2
                         ,pstReportPer      VARCHAR2
                         ,pstSeqIdMenu      NUMBER
                         ,pstOuterror   OUT VARCHAR2
                         ,pinModifico       NUMBER)
IS
  linRolSeq     NUMBER;
  --linMenuSeq    NUMBER;
  linCountMenu  NUMBER;
  linMaxIdElem  NUMBER;
  lstNomRol     VARCHAR2(1000);
  lstRevokeEmp  VARCHAR2(5000);
BEGIN
  lstNomRol := substr(pstNomRol,1,instr(pstNomRol,'|')-1);
  lstRevokeEmp := substr(pstNomRol,instr(pstNomRol,'|',-1,1)+1);
  IF lstNomRol IS NULL THEN
    lstNomRol:= pstNomRol;
    lstRevokeEmp := NULL;
  END IF;
  IF lstRevokeEmp = 'null' THEN
    lstRevokeEmp := NULL;
  END IF;
  SELECT COUNT(DISTINCT id_menu) INTO  linCountMenu
  FROM ss_menu_element_tab;
  SELECT MAX(id_menu_element) INTO linMaxIdElem
  FROM ss_menu_element_tab;
  SELECT dercorp_rol_sq.nextval INTO linRolSeq
  FROM DUAL;
  --SELECT dercorp_menu_sq.nextval INTO linMenuSeq
  --FROM DUAL;
  INSERT INTO ss_menu_tab ( id_menu
                          ,nom_name
                          ,num_created_by
                          ,fec_creation_date)
  VALUES ( pstSeqIdMenu--linMenuSeq
          ,'MENU_'||lstNomRol
          ,1
          ,SYSDATE
          );
        INSERT INTO ss_rol_tab ( id_rol
                                ,nom_name
                                ,des_description
                                ,num_password_expiration_days
                                ,id_menu
                                ,num_created_by
                                ,fec_creation_date
                                ,atributo1
                                ,atributo2
                                ,atributo3)
        VALUES ( linRolSeq
                ,lstNomRol
                ,pstDescRol
                ,pstNumExp
                ,pstSeqIdMenu--linMenuSeq
                ,pinModifico
                ,SYSDATE
                ,lstRevokeEmp
                ,DECODE(pstReportPre,'null',NULL,pstReportPre)
                ,DECODE(pstReportPer,'null',NULL,pstReportPer));
        INSERT INTO SS_ROL_CHANGE_LOG_TAB (
                                                ID_ROL_CHANGE_LOG,
                                                NUM_CREATED_BY,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS,
                                                ID_ROL,
                                                NOM_ROL
                                            )
        VALUES (
                    SS_ROL_ACCESS_LOG_SQ.NEXTVAL,
                    pinModifico,
                    SYSDATE,
                    'CREATED ROL',
                    linRolSeq,
                    lstNomRol
                );
  FOR i IN ( SELECT   *
             FROM     ss_menu_element_tab
             WHERE    id_menu= 1
             ORDER BY id_menu_element
            )
  LOOP
    INSERT INTO ss_menu_element_tab ( id_menu_element
                                     ,id_menu
                                     ,id_section
                                     ,id_menu_element_parent
                                     ,nom_name
                                     ,id_order
                                     ,des_target
                                     ,num_created_by
                                    ,fec_creation_date)
    VALUES ( linMaxIdElem + i.id_menu_element  --(linCountMenu*12)+ i.id_menu_element
            ,pstSeqIdMenu--linMenuSeq
            ,i.id_section
            --,DECODE(i.id_menu_element_parent,0,0,(linCountMenu*12)+ i.id_menu_element_parent)
            ,DECODE(i.id_menu_element_parent,0,0,linMaxIdElem+ i.id_menu_element_parent)
            ,i.nom_name
            ,i.id_order
            ,i.des_target
            ,1
            ,SYSDATE
            );
  END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      pstOuterror := SQLERRM;
END;
PROCEDURE update_new_menu_pr ( pStMenuElement  VARCHAR2,pinIdMenu NUMBER)
IS
  lstMenuElement VARCHAR2(100);
  linMenuElement NUMBER;
  linCountMenu  NUMBER;
  linMaxIdElem  NUMBER;
  lstNomMenu    VARCHAR2(1000);
BEGIN
  --SELECT COUNT(DISTINCT id_menu) INTO  linCountMenu
  --FROM ss_menu_element_tab;
  --linCountMenu := linCountMenu -1;
 /* SELECT MAX(id_menu_element) INTO linMaxIdElem
  FROM ss_menu_element_tab;
  linMaxIdElem := linMaxIdElem -12;
  */
  BEGIN
    lstMenuElement := REPLACE(pstMenuElement,'chk_','');
   -- linMenuElement := linMaxIdElem +TO_NUMBER(lstMenuElement); --(linCountMenu*12)+TO_NUMBER(lstMenuElement);
   --Argu
   SELECT NOM_NAME INTO lstNomMenu
          FROM ss_menu_element_tab
          WHERE ID_MENU = 1
          AND ID_MENU_ELEMENT = lstMenuElement;
  EXCEPTION
    WHEN OTHERS THEN
      linMenuElement:= 0;
  END;
 /* UPDATE ss_menu_element_tab
  SET    atributo1        = 1
  WHERE  id_menu_element  = linMenuElement;
  */
  --Argu
  UPDATE ss_menu_element_tab
  SET    atributo1        = 1
  WHERE  NOM_NAME = lstNomMenu
  AND ID_MENU = pinIdMenu;
END;
PROCEDURE update_rol_pr ( pinIdRol          NUMBER
                         ,pstNomRol         VARCHAR2
                         ,pstDescRol        VARCHAR2
                         ,pstNumExp         NUMBER
                         ,pstReportPre      VARCHAR2
                         ,pstReportPer      VARCHAR2
                         ,pstOuterror   OUT VARCHAR2
                         ,pinModifico       NUMBER)
IS
  linIdMenu NUMBER;
  lstNomRol     VARCHAR2(1000);
  lstRevokeEmp  VARCHAR2(5000);
BEGIN
  BEGIN
    SELECT id_menu INTO linIdMenu
    FROM   ss_rol_tab
    WHERE  id_rol   = pinIdRol;
  EXCEPTION
    WHEN OTHERS THEN
      linIdMenu := 0;
  END;
  lstNomRol := substr(pstNomRol,1,instr(pstNomRol,'|')-1);
  lstRevokeEmp := substr(pstNomRol,instr(pstNomRol,'|',-1,1)+1);
  IF lstNomRol IS NULL THEN
    lstNomRol:= pstNomRol;
    lstRevokeEmp := NULL;
  END IF;
  UPDATE  ss_rol_tab  SET nom_name                      = lstNomRol
                         ,des_description               = pstDescRol
                         ,num_password_expiration_days  = pstNumExp
                         ,num_last_updated_by           = pinModifico
                         ,fec_last_update_date          = SYSDATE
                         ,atributo1                     = DECODE(lstRevokeEmp,'null',NULL,lstRevokeEmp)
                         ,atributo2                     = DECODE(pstReportPre,'null',NULL,pstReportPre)
                         ,atributo3                     = DECODE(pstReportPer,'null',NULL,pstReportPer)
  WHERE                   id_rol                        = pinIdRol;
  UPDATE  ss_menu_element_tab SET atributo1 = 0
  WHERE   id_menu = linIdMenu;
  DELETE  FROM dercorp_rol_seccion_tab
  WHERE   id_rol = pinIdRol;
        INSERT INTO SS_ROL_CHANGE_LOG_TAB (
                                                ID_ROL_CHANGE_LOG,
                                                NUM_LAST_UPDATED_BY,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS,
                                                ID_ROL,
                                                NOM_ROL
                                            )
        VALUES (
                    SS_ROL_ACCESS_LOG_SQ.NEXTVAL,
                    pinModifico,
                    SYSDATE,
                    'UPDATE ROL',
                    pinIdRol,
                    lstNomRol
                );
  EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE update_menu_pr ( pStMenuElement  VARCHAR2)
IS
  lstMenuElement VARCHAR2(100);
  linMenuElement NUMBER;
BEGIN
  BEGIN
    lstMenuElement := REPLACE(pstMenuElement,'chk_','');
    linMenuElement := TO_NUMBER(lstMenuElement);
  EXCEPTION
    WHEN OTHERS THEN
      linMenuElement:= 0;
  END;
  UPDATE ss_menu_element_tab
  SET    atributo1        = 1
  WHERE  id_menu_element  = linMenuElement;
END;
PROCEDURE update_new_rol_seccion_pr (pstRolSeccion VARCHAR2)
IS
  lstDelimited  VARCHAR2(100);
  lstIdRol      VARCHAR2(100);
  lstIdSeccion  VARCHAR2(100);
BEGIN
  BEGIN
    lstDelimited := REPLACE(pstRolSeccion,'chkp_','');
    lstIdSeccion := SUBSTR(lstDelimited, 1 ,INSTR(lstDelimited, '_', 1, 1)-1);
    --lstIdRol     := SUBSTR(lstDelimited, INSTR(lstDelimited,'_', -1, 1)+1);
    SELECT MAX(id_rol) INTO  lstIdRol
    FROM   ss_rol_tab;
  EXCEPTION
    WHEN OTHERS THEN
      lstIdSeccion:= 0;
      lstIdRol    := 0;
  END;
  INSERT INTO dercorp_rol_seccion_tab (id_rol,
                                      id_seccion,
                                      num_created_by,
                                      fec_creation_date)
  VALUES ( lstIdRol,
           lstIdSeccion,
           1,
           SYSDATE
         );
END;
PROCEDURE update_rol_seccion_pr (pstRolSeccion VARCHAR2)
IS
  lstDelimited  VARCHAR2(100);
  lstIdRol      VARCHAR2(100);
  lstIdSeccion  VARCHAR2(100);
BEGIN
  BEGIN
    lstDelimited := REPLACE(pstRolSeccion,'chkp_','');
    lstIdSeccion := SUBSTR(lstDelimited, 1 ,INSTR(lstDelimited, '_', 1, 1)-1);
    lstIdRol     := SUBSTR(lstDelimited, INSTR(lstDelimited,'_', -1, 1)+1);
  EXCEPTION
    WHEN OTHERS THEN
      lstIdSeccion:= 0;
      lstIdRol    := 0;
  END;
  BEGIN
    INSERT INTO dercorp_rol_seccion_tab (id_rol,
                                        id_seccion,
                                        num_created_by,
                                        fec_creation_date)
    VALUES ( lstIdRol,
             lstIdSeccion,
             1,
             SYSDATE
           );
  EXCEPTION
    WHEN OTHERS THEN
        NULL;
  END;
END;
PROCEDURE elimina_rol_pr ( pinIdRol  NUMBER
                          ,pstOuterror   OUT VARCHAR2
                          ,pinModifico    NUMBER)
IS
  linIdMenu   NUMBER;
  linCountRol NUMBER;
BEGIN
  BEGIN
    SELECT id_menu INTO linIdMenu
    FROM   ss_rol_tab
    WHERE  id_rol   = pinIdRol;
  EXCEPTION
    WHEN OTHERS THEN
      linIdMenu := 0;
  END;
  BEGIN
    SELECT COUNT(*) INTO linCountRol
    FROM   ss_user_rol_tab
    WHERE  id_rol   = pinIdRol;
  EXCEPTION
    WHEN OTHERS THEN
      linCountRol := 0;
  END;
  IF linCountRol = 0 THEN
    DELETE FROM ss_menu_element_tab
    WHERE  id_menu  = linIdMenu;
    DELETE FROM ss_menu_tab
    WHERE  id_menu  = linIdMenu;
    DELETE FROM ss_user_rol_tab
    WHERE  id_rol   = pinIdRol;
    DELETE FROM dercorp_rol_seccion_tab
    WHERE  id_rol   = pinIdRol;
        INSERT INTO SS_ROL_CHANGE_LOG_TAB (
                                                ID_ROL_CHANGE_LOG,
                                                NUM_LAST_UPDATED_BY,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS,
                                                ID_ROL,
                                                NOM_ROL
                                            )
        VALUES (
                    SS_ROL_ACCESS_LOG_SQ.NEXTVAL,
                    pinModifico,
                    SYSDATE,
                    'DELETED ROL',
                    pinIdRol,
                    (SELECT nom_name
                      FROM   ss_rol_tab
                      WHERE  id_rol   = pinIdRol)
                );
        DELETE FROM ss_rol_tab  WHERE  id_rol   = pinIdRol;
  ELSE
    pstOuterror:= 'El Rol no puede ser borrado ya que esta siendo ocupado';
  END IF;
END;
FUNCTION IS_EMPRESA_DELETABLE_FN2 ( pinIdempresa NUMBER) RETURN VARCHAR
AS
    VAR_COUNT INT;
    VAR_ID_CAT_VAL_1 INT;
    VAR_ID_CAT_VAL_40 INT;
BEGIN
  /*
      SELECT count(*) INTO VAR_COUNT
      FROM DERCORP_METATBL_TAB WHERE ID_EMPRESA = pinIdempresa;
      IF VAR_COUNT < 5 THEN
        RETURN 'SI';
      END IF;*/
    --
    -- Campos de la Informacion de la empresa. Solo deben ser 4 (los default)
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_ADD_CAMPO_VALOR_TAB
    WHERE
      TRIM(VAL_VALOR) <> '0'
      AND TRIM(VAL_VALOR) <> '0.00'
      AND UPPER(TRIM(VAL_VALOR)) <> 'NULL'
      AND TRIM(VAL_VALOR) <> 'semaforo_green.png'
      AND ID_EMPRESA = pinIdempresa;
    IF VAR_COUNT > 4 THEN
        RETURN 'NO1';
    END IF;
    --
    -- Info en Metatablas. Debe ser 0
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB WHERE ID_EMPRESA = pinIdempresa;
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO2'||pinIdempresa;
    END IF;
      SELECT
          ID_CATALOGO_VALOR INTO VAR_ID_CAT_VAL_1
      FROM
          DERCORP_ADD_CAMPO_CAT_VAL_TAB
      WHERE
        VAL_CAT_VAL IN (
              SELECT NOM_EMPRESA FROM DERCORP_EMPRESA_TAB WHERE ID_EMPRESA = pinIdempresa
        )
       AND
        ID_CATALOGO = 1;
      SELECT
          ID_CATALOGO_VALOR INTO VAR_ID_CAT_VAL_40
      FROM
          DERCORP_ADD_CAMPO_CAT_VAL_TAB
      WHERE
        VAL_CAT_VAL IN (
              SELECT NOM_EMPRESA FROM DERCORP_EMPRESA_TAB WHERE ID_EMPRESA = pinIdempresa
        )
       AND
        ID_CATALOGO = 40;
    --
    -- Empresas que tienen esa denominacion actual, solo debe ser una
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_ADD_CAMPO_VALOR_TAB WHERE
    ID_ADD_CAMPO = 500
    AND
    VAL_VALOR IN (VAR_ID_CAT_VAL_1 || '');
    IF VAR_COUNT > 1 THEN
        RETURN 'NO3';
    END IF;
    --
    -- Como Accionista
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 7
      AND
      VAL_C1 IN (VAR_ID_CAT_VAL_40 || '');
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO4';
    END IF;
    --
    -- En Aumento de Capital S.A.
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 4
      AND
      (VAR_ID_CAT_VAL_1 || '')
        IN (VAL_C1, VAL_C5, VAL_C6, VAL_C8, VAL_C10);
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO5';
    END IF;
    --
    -- Denominacion en Reforma Total de Estatutos
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 20
      AND
      (VAR_ID_CAT_VAL_1 || '')
        IN (VAL_C8);
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO6';
    END IF;
    --
    -- Acta de Hechos levantada a solicitud de en Escrituras Otros
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 27
      AND
      (VAR_ID_CAT_VAL_1 || '')
        IN (VAL_C8);
     IF VAR_COUNT <> 0 THEN
        RETURN 'NO7';
    END IF;
    --
    -- En Fusion
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 34
      AND
      VAL_C99 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO8';
    END IF;
    --
    -- En Fusion
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 34
      AND
      VAL_C98 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO9';
    END IF;
    --
    -- Contrato
    --
    SELECT count(*)  INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 30
      AND
      VAL_C11 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO10';
    END IF;
    --
    -- Contrato
    --
    SELECT count(*) INTO VAR_COUNT
    FROM DERCORP_METATBL_TAB
    WHERE
      ID_FLEX_TBL = 30
      AND
      VAL_C7 LIKE '%' || (
              VAR_ID_CAT_VAL_1
                ) || '%';
    IF VAR_COUNT <> 0 THEN
        RETURN 'NO11';
    END IF;
    RETURN 'SI';
EXCEPTION
   WHEN OTHERS THEN
     --rr_code := SQLCODE;
     --rr_msg := SUBSTR(SQLERRM, 1, 200);
      RETURN ''||SUBSTR(SQLERRM, 1, 200);
END IS_EMPRESA_DELETABLE_FN2;
END DERCORP_PANEL_CONTROL_PKG;
/;
