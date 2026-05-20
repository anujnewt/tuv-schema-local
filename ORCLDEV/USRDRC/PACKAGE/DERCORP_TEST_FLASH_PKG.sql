CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_TEST_FLASH_PKG" AS
    PROCEDURE MONITOR_FLASH_PR( pinIdEmpresa          NUMBER,
                                pinIdUser             NUMBER,
                                pistValorDenomSocial  VARCHAR2
                              );
    PROCEDURE MONITOR_RESUMEN_GENERAL_PR( pinIdEmpresa             NUMBER,
                                          pinIdUser                NUMBER,
                                          pistDenomActualNew       VARCHAR2,
                                          pistNombreCortoNew       VARCHAR2,
                                          pistCtaOracleNew         VARCHAR2,
                                          pistActividadNew         VARCHAR2,
                                          pistGiroNew              VARCHAR2,
                                          pistDivisionNew          VARCHAR2,
                                          pistSegResponsableNew    VARCHAR2,
                                          pistClasificacionNew     VARCHAR2,
                                          pistFecClasificacionNew  VARCHAR2,
                                          pistPaisNew              VARCHAR2,
                                          pistAdmiteExtNew         VARCHAR2,
                                          pistDomicilioSocNew      VARCHAR2,
                                          pistTieneInmuebleNew     VARCHAR2,
                                          pistDuracionNew          VARCHAR2,
                                          pistFecInicialNew        VARCHAR2,
                                          pistFecFinalNew          VARCHAR2,
                                          pistConsContableNew      VARCHAR2,
                                          pistTipoSociedadNew      VARCHAR2,
                                          pistAuditoresExtNew      VARCHAR2
                                        );
  FUNCTION INSERT_RG_LOG_FN(pist_nom_campo VARCHAR2,
                            pistNewValue   VARCHAR2,
                            pistOldValue   VARCHAR2,
                            pinIdUser      INT,
                            pinIdEmp       INT) RETURN VARCHAR;
END DERCORP_TEST_FLASH_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_TEST_FLASH_PKG" AS
  PROCEDURE MONITOR_FLASH_PR( pinIdEmpresa          NUMBER,
                              pinIdUser             NUMBER,
                              pistValorDenomSocial  VARCHAR2
                              ) AS
  linVal_valor   VARCHAR2(100);
  BEGIN
    SELECT val_valor INTO linVal_valor
      FROM DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE id_add_campo = 500
      AND id_empresa = pinIdEmpresa;
      IF linVal_valor <> pistValorDenomSocial
      THEN
              BEGIN
                  INSERT INTO LOG_FLAS_TAB
                                          (
                                            VALOR_ANTERIOR,
                                            VALOR_ACTUAL,
                                            CREATION_DATE,
                                            NOM_DENOMINACION_ACTUAL,
                                            NOM_DENOMINACION_ANTERIOR,
                                            nom_modifico
                                          )
                  VALUES
                  (
                    linVal_valor,
                    pistValorDenomSocial,
                    SYSDATE,
                    (SELECT VAL_CAT_VAL
                      FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                        WHERE id_catalogo = 1
                        AND id_catalogo_valor = pistValorDenomSocial),
                    (SELECT VAL_CAT_VAL
                      FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                        WHERE id_catalogo = 1
                        AND id_catalogo_valor = linVal_valor),
                    (SELECT nom_user_long_name
                      FROM ss_user_tab
                      WHERE id_user = pinIdUser)
                  );
                  EXCEPTION
                    WHEN OTHERS THEN
                     INSERT INTO LOG_FLAS_TAB
                          (VALOR_ANTERIOR)
                     VALUES('ERROR AL INSERTAR');
                  END;
      END IF;
  END MONITOR_FLASH_PR;
      PROCEDURE MONITOR_RESUMEN_GENERAL_PR( pinIdEmpresa             NUMBER,
                                            pinIdUser                NUMBER,
                                            pistDenomActualNew       VARCHAR2,
                                            pistNombreCortoNew       VARCHAR2,
                                            pistCtaOracleNew         VARCHAR2,
                                            pistActividadNew         VARCHAR2,
                                            pistGiroNew              VARCHAR2,
                                            pistDivisionNew          VARCHAR2,
                                            pistSegResponsableNew    VARCHAR2,
                                            pistClasificacionNew     VARCHAR2,
                                            pistFecClasificacionNew  VARCHAR2,
                                            pistPaisNew              VARCHAR2,
                                            pistAdmiteExtNew         VARCHAR2,
                                            pistDomicilioSocNew      VARCHAR2,
                                            pistTieneInmuebleNew     VARCHAR2,
                                            pistDuracionNew          VARCHAR2,
                                            pistFecInicialNew        VARCHAR2,
                                            pistFecFinalNew          VARCHAR2,
                                            pistConsContableNew      VARCHAR2,
                                            pistTipoSociedadNew      VARCHAR2,
                                            pistAuditoresExtNew      VARCHAR2
                                        )AS
        lstDenomActualOld       VARCHAR2(1000);
        lstNombreCortoOld       VARCHAR2(1000);
        lstCtaOracleOld         VARCHAR2(1000);
        lstActividadOld         VARCHAR2(1000);
        lstGiroOld              VARCHAR2(1000);
        lstDivisionOld          VARCHAR2(1000);
        lstSegResponsableOld    VARCHAR2(1000);
        lstClasificacionOld     VARCHAR2(1000);
        lstFecClasificacionOld  VARCHAR2(1000);
        lstPaisOld              VARCHAR2(1000);
        lstAdmiteExtOld         VARCHAR2(1000);
        lstDomicilioSocOld      VARCHAR2(1000);
        lstTieneInmuebleOld     VARCHAR2(1000);
        lstDuracionOld          VARCHAR2(1000);
        lstFecInicialOld        VARCHAR2(1000);
        lstFecFinalOld          VARCHAR2(1000);
        lstConsContableOld      VARCHAR2(1000);
        lstTipoSociedadOld      VARCHAR2(1000);
        lstAuditoresExtOld      VARCHAR2(1000);
        linIdReg                NUMBER;
        lstReturnFunc           VARCHAR2(1000);
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
     BEGIN
      FOR i IN (
                 SELECT
                    c.id_add_campo ,
                    c.nom_campo,
                    v.val_valor,
                    c.des_tipo_campo,
                    c.des_formula,
                    c.id_catalogo,
                    c.id_seccion,
                    c.id_subseccion
                  FROM
                    DERCORP_ADD_CAMPO_TAB c
                    LEFT JOIN DERCORP_ADD_CAMPO_VALOR_TAB v ON v.ID_ADD_CAMPO     = c.ID_ADD_CAMPO
                                                            AND v.ID_EMPRESA      = pinIdEmpresa
                  WHERE
                    c.ID_SUBSECCION = 17
                  ORDER BY
                    ID_SECCION,
                    ID_SUBSECCION,
                    c.ID_AGRUPACION,
                    TO_NUMBER(c.ID_ORDER) )
    LOOP
        linIdReg := 0;
        IF i.ID_ADD_CAMPO = 500 --******Denominacion Actual*****
        THEN
          lstDenomActualOld := i.VAL_VALOR;
          IF TRIM(lstDenomActualOld) <> TRIM(pistDenomActualNew)
          THEN
            lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistDenomActualNew,lstDenomActualOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 501 --*****Nombre Corto*****
        THEN
          lstNombreCortoOld := i.VAL_VALOR;
            IF TRIM(lstNombreCortoOld) <> TRIM(pistNombreCortoNew)
            THEN
              lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistNombreCortoNew,lstNombreCortoOld,pinIdUser,pinIdEmpresa);
            END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 502 --*****Cuenta Oracle*****
        THEN
          lstCtaOracleOld := i.VAL_VALOR;
             IF TRIM(lstCtaOracleOld) <> TRIM(pistCtaOracleNew)
              THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistCtaOracleNew,lstCtaOracleOld,pinIdUser,pinIdEmpresa);
              END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 503 --*****Actividad*****
        THEN
          lstActividadOld := i.VAL_VALOR;
          IF TRIM(lstActividadOld) <> TRIM(pistActividadNew)
          THEN
          lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistActividadNew,lstActividadOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 504 --*****Giro*****
        THEN
          lstGiroOld := i.VAL_VALOR;
          IF TRIM(lstGiroOld) <> TRIM(pistGiroNew)
          THEN
              lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistGiroNew,lstGiroOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 505 --*****Division*****
        THEN
          lstDivisionOld := i.VAL_VALOR;
          IF TRIM(lstDivisionOld) <> TRIM(pistDivisionNew)
          THEN
              lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistDivisionNew,lstDivisionOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 506 --*****Segmento Reportable*****
        THEN
          lstSegResponsableOld := i.VAL_VALOR;
          IF TRIM(lstSegResponsableOld) <> TRIM(pistSegResponsableNew)
          THEN
              lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistSegResponsableNew,lstSegResponsableOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 507--*****Clasificacion:*****
        THEN
          lstClasificacionOld := i.VAL_VALOR;
            IF TRIM(lstClasificacionOld) <> TRIM(pistClasificacionNew)
            THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistClasificacionNew,lstClasificacionOld,pinIdUser,pinIdEmpresa);
            END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 508--*****Fecha Clasificacion:*****
        THEN
          lstFecClasificacionOld := i.VAL_VALOR;
          IF TRIM(lstFecClasificacionOld) <> TRIM(pistFecClasificacionNew)
            THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistFecClasificacionNew,lstFecClasificacionOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 509--*****Pais:*****
        THEN
          lstPaisOld := i.VAL_VALOR;
          IF TRIM(lstPaisOld) <> TRIM(pistPaisNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistPaisNew,lstPaisOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 510--*****Admite extranjeros:*****
        THEN
          lstAdmiteExtOld := i.VAL_VALOR;
          IF TRIM(lstAdmiteExtOld) <> TRIM(pistAdmiteExtNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistAdmiteExtNew,lstAdmiteExtOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 511--*****Domicilio Social:*****
        THEN
          lstDomicilioSocOld := i.VAL_VALOR;
          IF TRIM(lstDomicilioSocOld) <> TRIM(pistDomicilioSocNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistDomicilioSocNew,lstDomicilioSocOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 512--*****Tiene Inmuebles:*****
        THEN
          lstTieneInmuebleOld := i.VAL_VALOR;
          IF TRIM(lstTieneInmuebleOld) <> TRIM(pistTieneInmuebleNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistTieneInmuebleNew,lstTieneInmuebleOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 513--*****Duracion:*****
        THEN
          lstDuracionOld := i.VAL_VALOR;
          IF TRIM(lstDuracionOld) <> TRIM(pistDuracionNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistDuracionNew,lstDuracionOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 514--*****Fecha Inicial:*****
        THEN
          lstFecInicialOld := i.VAL_VALOR;
          IF TRIM(lstFecInicialOld) <> TRIM(pistFecInicialNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistFecInicialNew,lstFecInicialOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 515--*****Fecha Final:*****
        THEN
          lstFecFinalOld := i.VAL_VALOR;
          IF TRIM(lstFecFinalOld) <> TRIM(pistFecFinalNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistFecFinalNew,lstFecFinalOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 516--*****Consolidacion Contable:*****
        THEN
          lstConsContableOld := i.VAL_VALOR;
          IF TRIM(lstConsContableOld) <> TRIM(pistConsContableNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistConsContableNew,lstConsContableOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 517--*****Tipo de Sociedad:*****
        THEN
          lstTipoSociedadOld := i.VAL_VALOR;
          IF TRIM(lstTipoSociedadOld) <> TRIM(pistTipoSociedadNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistTipoSociedadNew,lstTipoSociedadOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
        IF i.ID_ADD_CAMPO = 1052--*****Auditores Externos*****
        THEN
          lstAuditoresExtOld := i.VAL_VALOR;
          IF TRIM(lstAuditoresExtOld) <> TRIM(pistAuditoresExtNew)
          THEN
                lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(i.nom_campo,pistAuditoresExtNew,lstAuditoresExtOld,pinIdUser,pinIdEmpresa);
          END IF;
        END IF;
    END LOOP;
    EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      lstReturnFunc:=DERCORP_TEST_FLASH_PKG.INSERT_RG_LOG_FN(SQLERRM,'ERROR','ERROR','ERROR',pinIdEmpresa);
    END;
    COMMIT;
    null;
    END MONITOR_RESUMEN_GENERAL_PR;
  FUNCTION INSERT_RG_LOG_FN(pist_nom_campo VARCHAR2,
                            pistNewValue   VARCHAR2,
                            pistOldValue   VARCHAR2,
                            pinIdUser      INT,
                            pinIdEmp       INT) RETURN VARCHAR
  AS
  lstMensaje  VARCHAR2(250) := 'OK';
  linIdReg    NUMBER;
  BEGIN
      SELECT  NVL(MAX(id_reg) + 1,1) INTO linIdReg
                FROM dercorp_rg_log_tab;
    BEGIN
      INSERT INTO dercorp_rg_log_tab(
                                      id_reg,
                                      nom_campo,
                                      val_actual,
                                      val_anterior,
                                      num_created_by,
                                      fec_creation_date,
                                      atributo1
                                    )
                              VALUES(
                                      linIdReg,
                                      pist_nom_campo,
                                      pistNewValue,
                                      pistOldValue,
                                      pinIdUser,
                                      SYSDATE,
                                      pinIdEmp
                                     );
   EXCEPTION
    WHEN OTHERS THEN
    lstMensaje := 'ERROR AL INSERTAR EN LA TABLA DERCORP_RG_LOG_TAB';
  END;
    RETURN lstMensaje;
  END INSERT_RG_LOG_FN;
END DERCORP_TEST_FLASH_PKG;
/;
