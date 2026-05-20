CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."SS_CHANGE_PASSWORD_PKG" 
AS
PROCEDURE DO_CHANGE_PR(
                      pinUserId                 NUMBER,
                      pinRolId                  NUMBER,
                      pstOldPassword            VARCHAR2,
                      pstNewPasswd1             VARCHAR2,
                      pstNewPasswd2             VARCHAR2,
                      pstOutProcessResult       OUT VARCHAR2
                      );
PROCEDURE DO_CHANGE_PR_ADMIN_PR(
                               pinUserId                NUMBER,
                               pinRolId                 NUMBER,
                               pstNewPasswd1            VARCHAR2,
                               pstOutProcessResult      OUT VARCHAR2
                             );
PROCEDURE DO_CHANGE_PR_ADMIN_PLUS_PR(
                               pinUserId                NUMBER,
                               pinRolId                 NUMBER,
                               pstNewPasswd1            VARCHAR2,
                               pstNomCompl              VARCHAR2,
                               pstNomUsr                VARCHAR2,
                               pstStatus                VARCHAR2,
                               pstOutProcessResult      OUT VARCHAR2,
                               pinCreadoPor              NUMBER,
                               pinNumEmpleado           VARCHAR2
                             );
PROCEDURE CREATE_USER_ADMIN_PR(
                              pinRolId                  NUMBER,
                              pstUserLongName           VARCHAR2,
                              pstUserName               VARCHAR2,
                              pstNewPasswd1             VARCHAR2,
                              pstOutProcessResult       OUT VARCHAR2,
                              pinCreadoPor              NUMBER,
                               pinNumEmpleado           VARCHAR2
                            );
PROCEDURE CHANGE_USER_STATUS_PR (
                                pinUserId           NUMBER,
                                pinStatusId         NUMBER
                               );
PROCEDURE CHECK_IF_PASSWORD_IS_VALID_PR (
                                        pinUserId               NUMBER,
                                        pinRolId                NUMBER,
                                        pstNewPasswd1           VARCHAR2,
                                        pstOutProcessResult     OUT VARCHAR2
                                       );
PROCEDURE DELETE_USER_PR(
                        pinUserId           NUMBER,
                        pinEliminadoPor     NUMBER
                       );
PROCEDURE CHECK_IF_USER_EXISTS(
                                pstUserName           VARCHAR2,
                                pstOutProcessResult   OUT VARCHAR2
                               );
END SS_CHANGE_PASSWORD_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."SS_CHANGE_PASSWORD_PKG" 
AS
PROCEDURE DO_CHANGE_PR(
                            pinUserId                       NUMBER,
                            pinRolId                        NUMBER,
                            pstOldPassword                  VARCHAR2,
                            pstNewPasswd1                   VARCHAR2,
                            pstNewPasswd2                   VARCHAR2,
                            pstOutProcessResult     OUT     VARCHAR2
                      )
AS
        gstCurrentPassword           VARCHAR2(255);
        gstEncryptedOldPassword      VARCHAR2(255);
        gstEncryptedNewPassword      VARCHAR2(255);
        ginRepetitions               NUMBER;
        gstOutProcessResult          VARCHAR2(255);
        liHistorialContrasena NUMBER;
        liMinNumCarPas        NUMBER;
    BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMinNumCarPas
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            AND     ID_CONFIG = 19
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMinNumCarPas:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMinNumCarPas:=0;
            WHEN OTHERS THEN
                liMinNumCarPas:=0;
        END;
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liHistorialContrasena
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            AND     ID_CONFIG = 17
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liHistorialContrasena:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liHistorialContrasena:=0;
            WHEN OTHERS THEN
                liHistorialContrasena:=0;
        END;
        IF pstNewPasswd1 = pstOldPassword
        THEN
            pstOutProcessResult := 'El nuevo password no puede ser igual al anterior';
            RETURN;
        END IF;
        IF pstNewPasswd1 <> pstNewPasswd2
        THEN
            pstOutProcessResult := 'El nuevo password no coincide con su confirmacion';
            RETURN;
        END IF;
        --Obtener el verdadero password actual
        SELECT  ss_user_tab.cve_password
        INTO    gstCurrentPassword
        FROM    ss_user_tab
        WHERE   ss_user_tab.id_user = pinUserId;
        gstEncryptedOldPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pstOldPassword);
        IF gstEncryptedOldPassword <> gstCurrentPassword
        THEN
            pstOutProcessResult := 'El password actual no es correcto';
            RETURN;
        END IF;
        CHECK_IF_PASSWORD_IS_VALID_PR(
                                        pinUserId
                                       ,pinRolId
                                       ,pstNewPasswd1
                                       ,gstOutProcessResult
                                     );
        IF gstOutProcessResult = '0'
        THEN
            pstOutProcessResult :=  'El nuevo password debe contener numeros, '
                                        ||'letras mayusculas, minusculas y '
                                        ||'un simbolo [@#$%&()_].'
                                        ||'Longitud minima para usuarios '||liMinNumCarPas||' chars. '
                                        --||'Longitud minima para usuarios -8 chars. '
                                        --||'Longitud minima para admin - 10 chars. '
                                        ;
            RETURN;
        END IF;
        gstEncryptedNewPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pstNewPasswd1);
/*
        /*SELECT  COUNT(*)
        INTO    ginRepetitions
        FROM    SS_USER_CHANGE_LOG_TAB
        WHERE   SS_USER_CHANGE_LOG_TAB.ID_USER      =  PINUSERID
        AND     SS_USER_CHANGE_LOG_TAB.CVE_PASSWORD = gstEncryptedNewPassword;*/
--        SELECT  COUNT(*)
--        INTO    ginRepetitions
       /* FROM    SS_USER_CHANGE_LOG_TAB
        WHERE   SS_USER_CHANGE_LOG_TAB.ID_USER      =  PINUSERID
        AND     SS_USER_CHANGE_LOG_TAB.CVE_PASSWORD = gstEncryptedNewPassword;
        *//*
        FROM (SELECT * FROM ss_user_change_log_tab
              Where id_user = PINUSERID
              AND SS_USER_CHANGE_LOG_TAB.CVE_PASSWORD = gstEncryptedNewPassword
              order BY fec_change_date)
        --WHERE ROWNUM < 7;
        --ECM 29 Septiembre 2016 Historial de Contrase?as
        WHERE ROWNUM < liHistorialContrasena;
*/
        --ECM 29 Septiembre 2016 Historial de Contrase?as
        SELECT COUNT(*) INTO ginRepetitions FROM(
                SELECT  *
                FROM (SELECT * FROM ss_user_change_log_tab
                      Where id_user = PINUSERID
                      ORDER BY fec_change_date)
                WHERE ROWNUM < liHistorialContrasena
                )A
        WHERE a.cve_password = gstEncryptedNewPassword
;
        IF ginRepetitions <> 0
        THEN
            pstOutProcessResult := 'Ya ha usado este password anteriormente. Debe definir uno nuevo';
            RETURN;
        END IF;
        UPDATE    SS_USER_TAB
        SET       SS_USER_TAB.CVE_PASSWORD          = gstEncryptedNewPassword,
                  SS_USER_TAB.NUM_CHANGE_PASSWORD   = 0,
                  SS_USER_TAB.ID_STATUS             = 1
        WHERE     SS_USER_TAB.ID_USER               = pinUserId;
        INSERT INTO SS_USER_CHANGE_LOG_TAB (
                                                ID_USER_CHANGE_LOG,
                                                ID_USER,
                                                CVE_PASSWORD,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS
                                            )
        VALUES (
                    SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                    pinUserId,
                    gstEncryptedNewPassword,
                    SYSDATE,
                    'PASSWORD CHANGE'
                );
        pstOutProcessResult := 'OK';
    END DO_CHANGE_PR;
PROCEDURE DO_CHANGE_PR_ADMIN_PR(
                                    pinUserId                       NUMBER,
                                    pinRolId                        NUMBER,
                                    pstNewPasswd1                   VARCHAR2,
                                    pstOutProcessResult     OUT     VARCHAR2
                               )
AS
    gstEncryptedNewPassword VARCHAR2(255);
    gstOutProcessResult     VARCHAR2(255);
    liMinNumCarPas          NUMBER;
    BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMinNumCarPas
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            AND     ID_CONFIG = 19
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMinNumCarPas:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMinNumCarPas:=0;
            WHEN OTHERS THEN
                liMinNumCarPas:=0;
        END;
        CHECK_IF_PASSWORD_IS_VALID_PR(
                                        pinUserId
                                       ,3
                                       ,pstNewPasswd1
                                       ,gstOutProcessResult
                                      );
        IF gstOutProcessResult = '0'
        THEN
            pstOutProcessResult :=  'El nuevo password debe contener numeros, '
                                        ||'letras mayusculas, minusculas y '
                                        ||'un simbolo [@#$%&()_].'
                                        ||'Longitud minima para usuarios '||liMinNumCarPas||' chars. '
                                        --||'Longitud minima para usuarios -8 chars. '
                                        --||'Longitud minima para admin - 10 chars. '
                                        ;
            RETURN;
        END IF;
        gstEncryptedNewPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pstNewPasswd1);
        UPDATE    SS_USER_TAB
        SET       SS_USER_TAB.CVE_PASSWORD          =  gstEncryptedNewPassword,
                  SS_USER_TAB.NUM_CHANGE_PASSWORD   =  1
        WHERE     SS_USER_TAB.ID_USER               = pinUserId;
       INSERT INTO SS_USER_CHANGE_LOG_TAB (
                                                ID_USER_CHANGE_LOG,
                                                ID_USER,
                                                CVE_PASSWORD,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS
                                            )
        VALUES (
                    SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                    pinUserId,
                    gstEncryptedNewPassword,
                    SYSDATE,
                    'PASSWORD CHANGE'
                );
        COMMIT;
        pstOutProcessResult := 'OK';
    END DO_CHANGE_PR_ADMIN_PR;
PROCEDURE DO_CHANGE_PR_ADMIN_PLUS_PR(
                                       pinUserId                NUMBER,
                                       pinRolId                 NUMBER,
                                       pstNewPasswd1            VARCHAR2,
                                       pstNomCompl              VARCHAR2,
                                       pstNomUsr                VARCHAR2,
                                       pstStatus                VARCHAR2,
                                       pstOutProcessResult      OUT VARCHAR2,
                                       pinCreadoPor              NUMBER,
                                       pinNumEmpleado           VARCHAR2--se agrega numero de empleado en JAMS
                               )
AS
    gstEncryptedNewPassword VARCHAR2(255);
    gstOutProcessResult     VARCHAR2(255);
    liMinNumCarPas          NUMBER;
    BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMinNumCarPas
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            AND     ID_CONFIG = 19
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMinNumCarPas:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMinNumCarPas:=0;
            WHEN OTHERS THEN
                liMinNumCarPas:=0;
        END;
        CHECK_IF_PASSWORD_IS_VALID_PR(
                                        pinUserId
                                       ,3
                                       ,pstNewPasswd1
                                       ,gstOutProcessResult
                                      );
        IF gstOutProcessResult = '0'
        THEN
            pstOutProcessResult :=  'El nuevo password debe contener numeros, '
                                        ||'letras mayusculas, minusculas y '
                                        ||'un simbolo [@#$%&()_].'
                                        ||'Longitud minima para usuarios '||liMinNumCarPas||' chars. '
                                        --||'Longitud minima para usuarios -8 chars. '
                                        --||'Longitud minima para admin - 10 chars. '
                                        ;
            RETURN;
        END IF;
        gstEncryptedNewPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pstNewPasswd1);
        UPDATE    SS_USER_TAB
        SET       SS_USER_TAB.CVE_PASSWORD          =  gstEncryptedNewPassword,
                  SS_USER_TAB.NUM_CHANGE_PASSWORD   =  0,
                  SS_USER_TAB.nom_user_long_name    =  pstNomCompl,
                  SS_USER_TAB.nom_username          =  pstNomUsr,
                  SS_USER_TAB.id_status             =  pstStatus,
                  NUM_LAST_UPDATED_BY               =  pinCreadoPor,
                  SS_USER_TAB.ATRIBUTO1             =  pinNumEmpleado, --se agrega numero de empleado en JAMS
                  FEC_LAST_UPDATE_DATE              =  SYSDATE
        WHERE     SS_USER_TAB.ID_USER               = pinUserId;
        IF pstStatus = '1'
        THEN
          DELETE FROM DERCORP_CONTROL_META_ROW
                WHERE DERCORP_CONTROL_META_ROW.ID_USER = pinUserId;
          UPDATE      DERCORP_CONTROL_SECCION
          SET         DERCORP_CONTROL_SECCION.STATUS = 0
          WHERE       DERCORP_CONTROL_SECCION.ID_USER = pinUserId;
        END IF;
        UPDATE SS_USER_ROL_TAB
        SET    ID_ROL = pinRolId
        WHERE  ID_USER = pinUserId;
       INSERT INTO SS_USER_CHANGE_LOG_TAB (
                                                ID_USER_CHANGE_LOG,
                                                ID_USER,
                                                CVE_PASSWORD,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS,
                                                NUM_LAST_UPDATED_BY
                                            )
        VALUES (
                    SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                    pinUserId,
                    gstEncryptedNewPassword,
                    SYSDATE,
                    'PASSWORD CHANGE',
                    pinCreadoPor
                );
        COMMIT;
        pstOutProcessResult := 'OK';
    END DO_CHANGE_PR_ADMIN_PLUS_PR;
PROCEDURE CHANGE_USER_STATUS_PR(
                                        pinUserId       NUMBER,
                                        pinStatusId     NUMBER
                                    )
AS
BEGIN
        UPDATE     SS_USER_TAB
        SET        SS_USER_TAB.ID_STATUS     =  pinStatusId
        WHERE      SS_USER_TAB.ID_USER       =  pinUserId;
        COMMIT;
        DELETE FROM SS_USER_ACCESS_LOG_TAB
        WHERE       ID_USER = pinUserId
        AND         DES_SESSION_CLOSE_MODE = 'INCORRECT_PASSWORD';
        INSERT INTO SS_USER_CHANGE_LOG_TAB (
                                                ID_USER_CHANGE_LOG,
                                                ID_USER,
                                                CVE_PASSWORD,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS
                                            )
        VALUES (
                    SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                    pinUserId,
                    '',
                    SYSDATE,
                    'UNBLOCKED'
                );
    END CHANGE_USER_STATUS_PR;
PROCEDURE CREATE_USER_ADMIN_PR(
                                        pinRolId                NUMBER,
                                        pstUserLongName         VARCHAR2,
                                        pstUserName             VARCHAR2,
                                        pstNewPasswd1           VARCHAR2,
                                        pstOutProcessResult OUT VARCHAR2,
                                        pinCreadoPor              NUMBER,
                                        pinNumEmpleado           VARCHAR2
                              )
AS
    gstEncryptedNewPassword     VARCHAR2(255);
    ginUserIdNextval            NUMBER;
    gstOutProcessResult         VARCHAR2(255);
    liMinNumCarPas              NUMBER;
    BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMinNumCarPas
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            AND     ID_CONFIG = 19
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMinNumCarPas:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMinNumCarPas:=0;
            WHEN OTHERS THEN
                liMinNumCarPas:=0;
        END;
        CHECK_IF_PASSWORD_IS_VALID_PR(
                                        0
                                       ,3
                                       ,pstNewPasswd1
                                       ,gstOutProcessResult
                                     );
        IF gstOutProcessResult = '0'
        THEN
            pstOutProcessResult :=  'El nuevo password debe contener numeros, '
                                        ||'letras mayusculas, minusculas y '
                                        ||'un simbolo [@#$%&()_].'
                                        ||'Longitud minima es de '||liMinNumCarPas||' chars. '
                                        --||'Longitud minima para usuarios -8 chars. '
                                        --||'Longitud minima para admin - 10 chars. '
                                        ;
            RETURN;
        END IF;
        CHECK_IF_USER_EXISTS(  pstUserName
                              ,gstOutProcessResult
                            );
        IF gstOutProcessResult = '0'
        THEN
            pstOutProcessResult :=  'El usuario '||pstUserName||' ya existe';
            RETURN;
        END IF;
        gstEncryptedNewPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pstNewPasswd1);
        SELECT  ss_user_sq.NEXTVAL
        INTO    ginUserIdNextval
        FROM    DUAL;
        INSERT INTO    SS_USER_TAB(
                                    ID_USER,
                                    NOM_USER_LONG_NAME,
                                    NOM_USERNAME,
                                    CVE_PASSWORD,
                                    ID_STATUS,
                                    NUM_CREATED_BY,
                                    FEC_CREATION_DATE,
                                    ATRIBUTO1
                                  )
        VALUES (
                    ginUserIdNextval,
                    pstUserLongName,
                    pstUserName,
                    gstEncryptedNewPassword,
                    1,
                    pinCreadoPor,
                    SYSDATE,
                    pinNumEmpleado
                );
        INSERT INTO DERCORP_CONTROL_SECCION(
                                            ID_USER
                                            )
        VALUES (
                  ginUserIdNextval
                );
        INSERT INTO SS_USER_ROL_TAB
            (
                ID_USER
               ,ID_ROL
            )
        VALUES
            (
                ginUserIdNextval
               ,pinRolId
            );
        COMMIT;
        pstOutProcessResult := 'Usuario Creado Satisfactoriamente';
        INSERT INTO SS_USER_CHANGE_LOG_TAB (
                                                ID_USER_CHANGE_LOG,
                                                ID_USER,
                                                CVE_PASSWORD,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS,
                                                NUM_CREATED_BY
                                            )
        VALUES (
                    SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                    ginUserIdNextval,
                    gstEncryptedNewPassword,
                    SYSDATE,
                    'NEW USER',
                    pinCreadoPor
                );
    END CREATE_USER_ADMIN_PR;
PROCEDURE CHECK_IF_PASSWORD_IS_VALID_PR(
                                                pinUserId               NUMBER,
                                                pinRolId                NUMBER,
                                                pstNewPasswd1           VARCHAR2,
                                                pstOutProcessResult OUT VARCHAR2
                                       )
AS
        ginIsValid      NUMBER;
        liMinNumCarPas  NUMBER;
    BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMinNumCarPas
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            AND     ID_CONFIG = 19
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMinNumCarPas:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMinNumCarPas:=0;
            WHEN OTHERS THEN
                liMinNumCarPas:=0;
        END;
        IF pinRolId = 3 THEN
            SELECT  COUNT (*)
            INTO    ginIsValid
            FROM    (
                      SELECT 1
                      FROM  DUAL
                      WHERE REGEXP_LIKE (pstNewPasswd1, '*\d', 'c')  -- Al menos un numero
                        AND REGEXP_LIKE (pstNewPasswd1, '*[a-z]', 'c') -- Al menos una letra minuscula
                        AND REGEXP_LIKE (pstNewPasswd1, '*[A-Z]', 'c') -- Al menos una letra mayuscula
                        AND REGEXP_LIKE (pstNewPasswd1, '*[@#$%&()_]','c')-- Al menos uno de los siguientes: "@#$%"
                        --AND (LENGTH(pstNewPasswd1)>=10 ) -- Igual o mayor a 10 caracteres
                        AND (LENGTH(pstNewPasswd1)>=liMinNumCarPas ) -- Igual o mayor a 10 caracteres
                    );
        ELSE
            SELECT  COUNT (*)
            INTO    ginIsValid
            FROM    (
                      SELECT 1
                      FROM  DUAL
                      WHERE REGEXP_LIKE (pstNewPasswd1, '*\d', 'c')  -- Al menos un numero
                        AND REGEXP_LIKE (pstNewPasswd1, '*[a-z]', 'c') -- Al menos una letra minuscula
                        AND REGEXP_LIKE (pstNewPasswd1, '*[A-Z]', 'c') -- Al menos una letra mayuscula
                        AND REGEXP_LIKE (pstNewPasswd1, '*[@#$%&()_]','c')-- Al menos uno de los siguientes: "@#$%"
                        --AND (LENGTH(pstNewPasswd1)>=8 ) -- Igual o mayor a 8 caracteres
                        AND (LENGTH(pstNewPasswd1)>=liMinNumCarPas ) -- Igual o mayor a 8 caracteres
                    );
        END IF;
        IF ginIsValid = 0
        THEN
          pstOutProcessResult := '0';
        END IF;
    END CHECK_IF_PASSWORD_IS_VALID_PR;
PROCEDURE DELETE_USER_PR(
                                PINUSERID  NUMBER,
                                pinEliminadoPor     NUMBER
                        )
AS
      ginremainadminusers           NUMBER;
      gExUnicoAdministradorRestante EXCEPTION;
    BEGIN
        IF PINUSERID <> 1
        THEN
            --JJAQ Para Bitacora de usuarios y grupos Baja
            INSERT INTO SS_USER_CHANGE_LOG_TAB
                    (
                      ID_USER_CHANGE_LOG,
                      ID_USER,
                      FEC_CHANGE_DATE,
                      DES_STATUS,
                      NUM_LAST_UPDATED_BY
                    )
                    VALUES
                    (
                      SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                      PINUSERID,
                      SYSDATE,
                      'DELETED USER',
                      pinEliminadoPor
                    );
            DELETE FROM SS_USER_ROL_TAB
            WHERE       ID_USER = PINUSERID;
            DELETE FROM SS_USER_TAB
            WHERE       ID_USER = PINUSERID;
        ELSE
           raise_application_error(-20101, 'El super usuario admin no puede ser eliminado');
        END IF;
        COMMIT;
        DELETE FROM SS_USER_ROL_TAB
        WHERE  ID_USER = PINUSERID;
        /*
        INSERT INTO SS_USER_CHANGE_LOG_TAB (
                                                ID_USER_CHANGE_LOG,
                                                ID_USER,
                                                CVE_PASSWORD,
                                                FEC_CHANGE_DATE,
                                                DES_STATUS
                                            )
        VALUES (
                    SS_USER_CHANGE_LOG_SQ.NEXTVAL,
                    PINUSERID,
                    '',
                    SYSDATE,
                    'DELETED USER'
                );*/
    END DELETE_USER_PR;
PROCEDURE CHECK_IF_USER_EXISTS(
                                pstUserName           VARCHAR2,
                                pstOutProcessResult   OUT VARCHAR2
                               )
IS
  linCountUser NUMBER;
BEGIN
  BEGIN
    SELECT  COUNT(*)  INTO linCountUser
    FROM    SS_USER_TAB
    WHERE   UPPER(NOM_USERNAME) = UPPER(pstUserName);
  EXCEPTION
    WHEN OTHERS THEN
       linCountUser := 0;
  END;
  IF linCountUser > 0 THEN
    pstOutProcessResult := '0';
  END IF;
END;
END SS_CHANGE_PASSWORD_PKG;
/;
