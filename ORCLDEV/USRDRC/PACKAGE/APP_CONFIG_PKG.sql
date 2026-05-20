CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."APP_CONFIG_PKG" AS
    PROCEDURE GET_CONFIG_VAR(configCode VARCHAR2, configValue OUT VARCHAR2);
    --ECM 14 Enero 2016
    PROCEDURE ADD_APP_CONFIG_PR(pistCodCon IN VARCHAR2
                               ,pistNomCon IN VARCHAR2
                               ,pistDesCon IN VARCHAR2
                               ,pistValCon IN VARCHAR2
                               ,postMsg    OUT VARCHAR2
                             );
    --ECM 14 Enero 2016
    PROCEDURE UPDATE_APP_CONFIG_PR(piinIdCon  IN NUMBER
                                  ,pistCodCon IN VARCHAR2
                                  ,pistNomCon IN VARCHAR2
                                  ,pistDesCon IN VARCHAR2
                                  ,pistValCon IN VARCHAR2
                                  ,postMsg    OUT VARCHAR2
                              );
    --ECM 15 Enero 2016
    PROCEDURE DELETE_APP_CONFIG_PR(piinIdCon  IN NUMBER
                                  ,postMsg    OUT VARCHAR2
    );
END APP_CONFIG_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."APP_CONFIG_PKG" AS
  PROCEDURE GET_CONFIG_VAR(configCode VARCHAR2, configValue OUT VARCHAR2)
  AS
    gstEncryptedPassword  VARCHAR2(255);
  BEGIN
      IF configCode = 'PWD_DOC'
      THEN
           SELECT
                SS_CRYPTO_PKG.DECRYPT_FN(VAL_CONFIG) INTO configValue
              FROM
                APP_CONFIG_TAB
              WHERE
                COD_CONFIG = configCode;
      ELSE
          SELECT
                VAL_CONFIG INTO configValue
          FROM
            APP_CONFIG_TAB
          WHERE
            COD_CONFIG = configCode;
      END IF;
  END;
  PROCEDURE ADD_APP_CONFIG_PR(pistCodCon IN VARCHAR2
                               ,pistNomCon IN VARCHAR2
                               ,pistDesCon IN VARCHAR2
                               ,pistValCon IN VARCHAR2
                               ,postMsg    OUT VARCHAR2
                             )
    IS
        lstMaxIdConfig        VARCHAR2(32767) := 0;
        gstEncryptedPassword  VARCHAR2(255);
    BEGIN
    SELECT MAX(ID_CONFIG) INTO lstMaxIdConfig FROM APP_CONFIG_TAB;
    IF pistCodCon = 'PWD_DOC'
    THEN
        gstEncryptedPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pistValCon);
    ELSE
        gstEncryptedPassword := pistValCon;
    END IF;
    INSERT INTO APP_CONFIG_TAB(ID_CONFIG
                              ,COD_CONFIG
                              ,NOM_CONFIG
                              ,DES_CONFIG
                              ,VAL_CONFIG
                      )VALUES(TO_NUMBER(lstMaxIdConfig)+1
                              ,pistCodCon
                              ,pistNomCon
                              ,pistDesCon
                              ,gstEncryptedPassword
                      )
  ;
  COMMIT;
  postMsg := 'Registro creado correctamente en la tabla APP_CONFIG_TAB.';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        lstMaxIdConfig := 0;
        DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        postMsg := SQLERRM||' '||SQLCODE;
      WHEN OTHERS THEN
        lstMaxIdConfig := 0;
        DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        postMsg := SQLERRM||' '||SQLCODE;
    END ADD_APP_CONFIG_PR;--END PR
  PROCEDURE UPDATE_APP_CONFIG_PR(piinIdCon  IN NUMBER
                                  ,pistCodCon IN VARCHAR2
                                  ,pistNomCon IN VARCHAR2
                                  ,pistDesCon IN VARCHAR2
                                  ,pistValCon IN VARCHAR2
                                  ,postMsg    OUT VARCHAR2
                                  )
    IS
      gstEncryptedPassword  VARCHAR2(255);
    BEGIN
              IF pistCodCon = 'PWD_DOC'
              THEN
                  gstEncryptedPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pistValCon);
              ELSE
                  gstEncryptedPassword := pistValCon;
              END IF;
        UPDATE APP_CONFIG_TAB
        SET    COD_CONFIG = pistCodCon
              ,NOM_CONFIG = pistNomCon
              ,DES_CONFIG = pistDesCon
              ,VAL_CONFIG = gstEncryptedPassword
        WHERE 1=1
        AND   ID_CONFIG = piinIdCon
        ;
        COMMIT;
        postMsg := 'Registro actualizado correctamente en la tabla APP_CONFIG_TAB.';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        postMsg := SQLERRM||' '||SQLCODE;
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        postMsg := SQLERRM||' '||SQLCODE;
    END UPDATE_APP_CONFIG_PR;--END PR
  PROCEDURE DELETE_APP_CONFIG_PR(piinIdCon  IN NUMBER
                                ,postMsg    OUT VARCHAR2)
  IS
  BEGIN
    DELETE FROM APP_CONFIG_TAB WHERE 1=1 AND ID_CONFIG = piinIdCon;
    COMMIT;
    postMsg := 'Registro borrado correctamente en la tabla APP_CONFIG_TAB.';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      postMsg := SQLERRM||' '||SQLCODE;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      postMsg := SQLERRM||' '||SQLCODE;
  END DELETE_APP_CONFIG_PR;
END APP_CONFIG_PKG;
/;
