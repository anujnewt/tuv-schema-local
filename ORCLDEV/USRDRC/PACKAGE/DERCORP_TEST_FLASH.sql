CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_TEST_FLASH" AS
    PROCEDURE MONITOR_FLASH_PR( pinIdEmpresa          NUMBER,
                                pinIdUser             NUMBER,
                                pistValorDenomSocial  VARCHAR2
                              );
END DERCORP_TEST_FLASH;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_TEST_FLASH" AS
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
END DERCORP_TEST_FLASH;
/;
