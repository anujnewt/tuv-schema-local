CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."SS_LOGIN_PKG" 
AS
PROCEDURE DO_LOGIN_PR(
                          pstUsername                     VARCHAR2
                         ,pstPassword                     VARCHAR2
                         ,pstOutProcessResult         OUT VARCHAR2
                         ,pstOutProcessMessage        OUT VARCHAR2
                         ,pinOutUserId                OUT NUMBER
                         ,pstOutUserLongName          OUT VARCHAR2
                         ,pstOutRolId                 OUT VARCHAR2
                         ,pstOutRolName               OUT VARCHAR2
                         ,pinOutUserAccesSLogId        OUT NUMBER
                     );
            --SECTIONS
--
TYPE USER_INFO_TYP IS RECORD(
                                USER_ID                   NUMBER         :=NULL,
                                USER_LONG_NAME            VARCHAR2(100)  :=NULL,
                                USERNAME                  VARCHAR2(30)   :=NULL,
                                REAL_PASSWORD             VARCHAR2(255)  :=NULL,
                                STATUS_ID                 NUMBER         :=NULL,
                                ROL_ID                    NUMBER         :=NULL,
                                ROL_NAME                  VARCHAR2(20)   :=NULL,
                                ROL_DESCRIPTION           VARCHAR2(100)  :=NULL,
                                PASSWORD_EXPIRATION_DAYS  NUMBER         :=NULL
                            );
PROCEDURE CHECK_IF_USER_EXIST_PR(
                                    pstUsername                VARCHAR2
                                   ,pobjOutUserInfoRow     OUT USER_INFO_TYP
                                );
PROCEDURE CHECK_IF_PWD_IS_CORRECT_PR(
                                        pstPassword         VARCHAR2
                                       ,pobjUserInfoRow     USER_INFO_TYP
                                    );
PROCEDURE INACTIVATE_USER_PR(
                                pinUserId NUMBER
                            );
PROCEDURE INSERT_INC_LOGIN_ATTEMPT_PR(
                                        pinUserId NUMBER
                                     );
PROCEDURE CHECK_IF_USER_IS_ACTIVE_PR(
                                        pobjUserInfoRow USER_INFO_TYP
                                    );
--
--
PROCEDURE CHECK_IF_USER_IS_LOGGED_IN_PR(
                                          pobjUserInfoRow USER_INFO_TYP
                                       );
--
--
PROCEDURE CHECK_IF_PWD_IS_EFFECTIVE_PR(
                                          pobjUserInfoRow USER_INFO_TYP
                                      );
--
--
PROCEDURE INSERT_USER_ACCESS_LOG_PR(
                                      pinUserId           NUMBER
                                     ,pinOutAccessLogId   OUT NUMBER
                                   );
PROCEDURE SET_OUTPUT_VARS_PR(
                                pobjUserInfoRow               USER_INFO_TYP
                               ,pinOutUserId              OUT NUMBER
                               ,pstOutUserLongName        OUT VARCHAR2
                               ,pstOutRolId               OUT VARCHAR2
                               ,pstOutRolName             OUT VARCHAR2
                            );
PROCEDURE DO_LOGOUT_PR(
                          pinUserId                NUMBER
                         ,pinUserAccessLogId       NUMBER
                     );
PROCEDURE CHECK_IF_USER_CHANGE_PWD_REQ(
                                          pobjUserInfoRow USER_INFO_TYP
                                      );
    --
    -- User Defined Exceptions.
    --
    USER_NOT_FOUND_EXCEPTION        EXCEPTION;
    ROL_NOT_FOUND_EXCEPTION         EXCEPTION;
    MORE_THAN_ONE_ROL_EXCEPTION     EXCEPTION;
    INCORRECT_PASSWORD_EXCEPTION    EXCEPTION;
    USER_JUST_BLOCKED_EXCEPTION     EXCEPTION;
    USER_NOT_ACTIVE_EXCEPTION       EXCEPTION;
    USER_YET_LOGGED_EXCEPTION       EXCEPTION;
    PASSWORD_SET_REQ_EXCEPTION      EXCEPTION;
    PASSWORD_CHANGE_REQ_EXCEPTION   EXCEPTION;
    CHANGE_PWD_REQUIRED_EXCEPTION   EXCEPTION;
END SS_LOGIN_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."SS_LOGIN_PKG" 
AS
PROCEDURE DO_LOGIN_PR(
                          pstUsername                     VARCHAR2
                         ,pstPassword                     VARCHAR2
                         ,pstOutProcessResult         OUT VARCHAR2
                         ,pstOutProcessMessage        OUT VARCHAR2
                         ,pinOutUserId                OUT NUMBER
                         ,pstOutUserLongName          OUT VARCHAR2
                         ,pstOutRolId                 OUT VARCHAR2
                         ,pstOutRolName               OUT VARCHAR2
                         ,pinOutUserAccessLogId       OUT NUMBER
                     )
AS
    gobjUserInfoRow       SS_LOGIN_PKG.USER_INFO_TYP;
    linStatusId           NUMBER;
    liMaxNumIntAcceso     NUMBER;
BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMaxNumIntAcceso
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            --AND     ID_CONFIG = 20
            AND cod_config = 'MaxNumInt'
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMaxNumIntAcceso:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMaxNumIntAcceso:=0;
            WHEN OTHERS THEN
                liMaxNumIntAcceso:=0;
        END;
    CHECK_IF_USER_EXIST_PR(
                              pstUsername
                             ,pobjOutUserInfoRow => gobjUserInfoRow
                          );
    CHECK_IF_USER_IS_ACTIVE_PR(
                                gobjUserInfoRow
                              );
    CHECK_IF_PWD_IS_CORRECT_PR(
                                  pstPassword
                                 ,gobjUserInfoRow
                              );
    --
    -- Validar sinle login
    --
    CHECK_IF_PWD_IS_EFFECTIVE_PR(
                                    gobjUserInfoRow
                                );
    CHECK_IF_USER_IS_LOGGED_IN_PR(
                                   gobjUserInfoRow
                                  ) ;
    CHECK_IF_USER_CHANGE_PWD_REQ(
                                   gobjUserInfoRow
                                  ) ;
    INSERT_USER_ACCESS_LOG_PR(
                                gobjUserInfoRow.USER_ID
                               ,pinOutUserAccessLogId
                             );
    pstOutProcessResult     :=  'OK';
    pstOutProcessMessage    :=    '';
    SET_OUTPUT_VARS_PR(
                          gobjUserInfoRow
                         ,pinOutUserId
                         ,pstOutUserLongName
                         ,pstOutRolId
                         ,pstOutRolName
                      );
    EXCEPTION
      WHEN USER_NOT_FOUND_EXCEPTION
      THEN
        pstOutProcessResult   := 'USER_NOT_FOUND';
        pstOutProcessMessage  := 'El nombre de usuario es incorrecto.';
      WHEN ROL_NOT_FOUND_EXCEPTION
      THEN
        pstOutProcessResult   := 'ROL_NOT_FOUND';
        pstOutProcessMessage  := 'El usuario no tiene asignado un Rol dentro de la aplicacion. Comuniquese con el administrador del sistema.';
      WHEN MORE_THAN_ONE_ROL_EXCEPTION
      THEN
        pstOutProcessResult   := 'MORE_THAN_ONE_ROL';
        pstOutProcessMessage  := 'El usuario tiene asignado mas de un Rol dentro de la aplicacion. Comuniquese con el administrador del sistema.';
      WHEN INCORRECT_PASSWORD_EXCEPTION
      THEN
        pstOutProcessResult   := 'INCORRECT_PASSWORD';
        pstOutProcessMessage  := 'El password es incorrecto. Por seguridad la cuenta se bloqueara al intento '||liMaxNumIntAcceso
        ||' incorrecto de acceso.';
      WHEN USER_JUST_BLOCKED_EXCEPTION
      THEN
        pstOutProcessResult   := 'USER_JUST_BLOCKED';
        pstOutProcessMessage  := 'El password es incorrecto. Por seguridad LA CUENTA HA SIDO BLOQUEADA despues de '||liMaxNumIntAcceso
        ||' intentos incorrectos de acceso. Comuniquese con el administrador del sistema.';
      WHEN USER_NOT_ACTIVE_EXCEPTION
      THEN
        pstOutProcessResult   := 'USER_NOT_ACTIVE';
        pstOutProcessMessage  := 'El usuario se encuentra Bloqueado. Comuniquese con el administrador del sistema.';
      WHEN USER_YET_LOGGED_EXCEPTION
      THEN
        pstOutProcessResult   := 'USER_YET_LOGGED';
        pstOutProcessMessage  := 'El usuario se encuentra Conectado desde otra computadora. '
        --||'No es posible iniciar una segunda sesion.'
        ||'De lo contrario espere 10 minutos.'
        ;
      WHEN PASSWORD_SET_REQ_EXCEPTION
      THEN
        pstOutProcessResult   := 'PASSWORD_SET_REQ';
        pstOutProcessMessage  := 'Por favor, defina una contrase?a personalizada.';
        SET_OUTPUT_VARS_PR(gobjUserInfoRow,pinOutUserId, pstOutUserLongName, pstOutRolId,pstOutRolName);
      WHEN PASSWORD_CHANGE_REQ_EXCEPTION
      THEN
        pstOutProcessResult  := 'PASSWORD_CHANGE_REQ';
        pstOutProcessMessage := 'Su contrase?a ha caducado. Por favor, defina una nueva contrase?a.';
        SET_OUTPUT_VARS_PR(gobjUserInfoRow,pinOutUserId, pstOutUserLongName, pstOutRolId,pstOutRolName);
      WHEN CHANGE_PWD_REQUIRED_EXCEPTION
      THEN
        pstOutProcessResult  := 'CHANGE_PWD_REQUIRED_REQ';
        pstOutProcessMessage := 'Por favor, defina una contrase?a personalizada.';
        SET_OUTPUT_VARS_PR(gobjUserInfoRow,pinOutUserId, pstOutUserLongName, pstOutRolId,pstOutRolName);
  END DO_LOGIN_PR;
  --
  --
PROCEDURE SET_OUTPUT_VARS_PR(
                              pobjUserInfoRow           USER_INFO_TYP
                             ,pinOutUserId              OUT NUMBER
                             ,pstOutUserLongName        OUT VARCHAR2
                             ,pstOutRolId               OUT VARCHAR2
                             ,pstOutRolName             OUT VARCHAR2
                          ) AS
BEGIN
  pinOutUserId                := pobjUserInfoRow.USER_ID;
  pstOutUserLongName          := pobjUserInfoRow.USER_LONG_NAME;
  pstOutRolId                 := pobjUserInfoRow.ROL_ID;
  pstOutRolName               := pobjUserInfoRow.ROL_NAME;
END SET_OUTPUT_VARS_PR;
  --
  --
PROCEDURE CHECK_IF_USER_EXIST_PR(
                                    pstUsername                   VARCHAR2
                                   ,pobjOutUserInfoRow      OUT   USER_INFO_TYP
                                )
AS
 CURSOR CUR_USER_EXIST IS
          SELECT     SS_USER.ID_USER                         USER_ID
                    ,SS_USER.NOM_USER_LONG_NAME              USER_LONG_NAME
                    ,SS_USER.NOM_USERNAME                    USERNAME
                    ,SS_USER.CVE_PASSWORD                    PASSWORD
                    ,SS_USER.ID_STATUS                       STATUS_ID
                    ,SS_ROL.ID_ROL                           ROL_ID
                    ,SS_ROL.NOM_NAME                         NAME
                    ,SS_ROL.DES_DESCRIPTION                  DESCRIPTION
                    ,SS_ROL.NUM_PASSWORD_EXPIRATION_DAYS     PASSWORD_EXPIRATION_DAYS
          FROM
                    SS_USER_TAB SS_USER
          LEFT JOIN SS_USER_ROL_TAB     ON SS_USER_ROL_TAB.ID_USER    =   SS_USER.ID_USER
          LEFT JOIN SS_ROL_TAB SS_ROL   ON SS_ROL.ID_ROL              =   SS_USER_ROL_TAB.ID_ROL
          WHERE                            SS_USER.NOM_USERNAME       =   pstUsername;
  ERROR_FLAG NUMBER;
BEGIN
  OPEN CUR_USER_EXIST;
  FETCH CUR_USER_EXIST
  INTO
      pobjOutUserInfoRow.USER_ID
     ,pobjOutUserInfoRow.USER_LONG_NAME
     ,pobjOutUserInfoRow.USERNAME
     ,pobjOutUserInfoRow.REAL_PASSWORD
     ,pobjOutUserInfoRow.STATUS_ID
     ,pobjOutUserInfoRow.ROL_ID
     ,pobjOutUserInfoRow.ROL_NAME
     ,pobjOutUserInfoRow.ROL_DESCRIPTION
     ,pobjOutUserInfoRow.PASSWORD_EXPIRATION_DAYS
     ;
    IF CUR_USER_EXIST%NOTFOUND
    THEN
      ERROR_FLAG := 1;
    ELSE
        IF pobjOutUserInfoRow.ROL_ID IS NULL
        THEN
          ERROR_FLAG := 2;
        ELSE
            IF CUR_USER_EXIST%ROWCOUNT > 1
            THEN
              ERROR_FLAG := 3;
            END IF;
        END IF;
    END IF;
  CLOSE CUR_USER_EXIST;
  IF ERROR_FLAG = 1
  THEN
    RAISE USER_NOT_FOUND_EXCEPTION;
  END IF;
  IF ERROR_FLAG = 2
  THEN
    RAISE ROL_NOT_FOUND_EXCEPTION;
  END IF;
  IF ERROR_FLAG = 3
  THEN
    RAISE MORE_THAN_ONE_ROL_EXCEPTION;
  END IF;
END CHECK_IF_USER_EXIST_PR;
--
--
PROCEDURE CHECK_IF_PWD_IS_CORRECT_PR(
                                      pstPassword       VARCHAR2
                                     ,pobjUserInfoRow   USER_INFO_TYP
                                    )
AS
  gstEncryptedPassword        VARCHAR2(255);
  ginIncorrectLoginAttempts   NUMBER;
  liMaxNumIntAcceso           NUMBER;
BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMaxNumIntAcceso
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            --AND     ID_CONFIG = 20
            AND cod_config = 'MaxNumInt'
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMaxNumIntAcceso:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMaxNumIntAcceso:=0;
            WHEN OTHERS THEN
                liMaxNumIntAcceso:=0;
        END;
  IF pstPassword IS NULL THEN
    RAISE INCORRECT_PASSWORD_EXCEPTION;
  END IF;
  gstEncryptedPassword := SS_CRYPTO_PKG.ENCRYPT_FN(pstPassword);
  IF pobjUserInfoRow.REAL_PASSWORD <> gstEncryptedPassword
  THEN
      SELECT  COUNT(*)
      INTO    ginIncorrectLoginAttempts
      FROM    SS_USER_ACCESS_LOG_TAB
      WHERE   DES_SESSION_CLOSE_MODE    =   'INCORRECT_PASSWORD'
      AND     ID_USER                   =   pobjUserInfoRow.USER_ID ;
      --ECM 30 Septiembre 2016 Maximo numero de intentos de acceso.
      --IF ginIncorrectLoginAttempts >= 2
      IF ginIncorrectLoginAttempts >= liMaxNumIntAcceso THEN
          INACTIVATE_USER_PR(
                                pobjUserInfoRow.USER_ID
                            );
          RAISE USER_JUST_BLOCKED_EXCEPTION;
      ELSE
        INSERT_INC_LOGIN_ATTEMPT_PR(
                                      pobjUserInfoRow.USER_ID
                                   );
        RAISE INCORRECT_PASSWORD_EXCEPTION;
      END IF;
  ELSE
    DELETE FROM SS_USER_ACCESS_LOG_TAB
    WHERE       ID_USER                =   pobjUserInfoRow.USER_ID
        AND     DES_SESSION_CLOSE_MODE =   'INCORRECT_PASSWORD';
  END IF;
END CHECK_IF_PWD_IS_CORRECT_PR;
--
--
PROCEDURE INACTIVATE_USER_PR(
                                pinUserId NUMBER
                            )
AS
BEGIN
  UPDATE  SS_USER_TAB
  SET     ID_STATUS =   2
  WHERE   ID_USER   =   pinUserId;
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
                    'BLOCKED'
                );
 INSERT INTO SS_USER_ACCESS_LOG_TAB(
                                        ID_USER_ACCESS_LOG
                                       ,ID_USER
                                       ,FEC_SESSION_START_DATE
                                       ,FEC_SESSION_END_DATE
                                       ,DES_SESSION_CLOSE_MODE
                                    )
  VALUES(
            SS_USER_ACCESS_LOG_SQ.NEXTVAL
           ,pinUserId
           ,NULL
           ,SYSDATE
           ,'BLOCKED'
        );
END INACTIVATE_USER_PR;
--
--
PROCEDURE INSERT_INC_LOGIN_ATTEMPT_PR(pinUserId NUMBER) AS
BEGIN
  INSERT INTO SS_USER_ACCESS_LOG_TAB(
                                        ID_USER_ACCESS_LOG
                                       ,ID_USER,FEC_SESSION_START_DATE
                                       ,FEC_SESSION_END_DATE
                                       ,DES_SESSION_CLOSE_MODE
                                    )
  VALUES(
            SS_USER_ACCESS_LOG_SQ.NEXTVAL
           ,pinUserId
           ,SYSDATE
           ,SYSDATE
           ,'INCORRECT_PASSWORD'
        );
END INSERT_INC_LOGIN_ATTEMPT_PR;
--
--
PROCEDURE CHECK_IF_USER_IS_ACTIVE_PR(
                                      pobjUserInfoRow USER_INFO_TYP
                                    )
AS
BEGIN
  IF pobjUserInfoRow.STATUS_ID = 2
  THEN
      RAISE USER_NOT_ACTIVE_EXCEPTION;
  END IF;
END CHECK_IF_USER_IS_ACTIVE_PR;
--
--
PROCEDURE CHECK_IF_USER_IS_LOGGED_IN_PR(
                                          pobjUserInfoRow USER_INFO_TYP
                                       )
AS
BEGIN
  IF pobjUserInfoRow.STATUS_ID = 3
  THEN
      RAISE USER_YET_LOGGED_EXCEPTION;
  END IF;
END CHECK_IF_USER_IS_LOGGED_IN_PR;
--checar si es necesario cambio de contrase?a
PROCEDURE CHECK_IF_USER_CHANGE_PWD_REQ(
                                          pobjUserInfoRow USER_INFO_TYP
                                       )
AS
BEGIN
  IF pobjUserInfoRow.STATUS_ID = 4 --estatus 4 necesario cambio de contrase?a
  THEN
      RAISE CHANGE_PWD_REQUIRED_EXCEPTION;
  END IF;
END CHECK_IF_USER_CHANGE_PWD_REQ;
--
--
PROCEDURE CHECK_IF_PWD_IS_EFFECTIVE_PR(
                                          pobjUserInfoRow USER_INFO_TYP
                                      )
AS
  ginPasswordChangeCount    NUMBER;
  ginDaysElapsed            NUMBER; -- since last password change
  ginPasswordChangeAdminCount NUMBER;
  ginChangePasswordFlag     NUMBER;
  liMaxNumCon               NUMBER;
BEGIN
        BEGIN
            SELECT  NVL(VAL_CONFIG,0)
            INTO    liMaxNumCon
            FROM    APP_CONFIG_TAB
            WHERE   1=1
            --AND     ID_CONFIG = 18
            AND COD_CONFIG = 'MaxNumCon'
            ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liMaxNumCon:=0;
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('Conversion of string to number failed');
                liMaxNumCon:=0;
            WHEN OTHERS THEN
                liMaxNumCon:=0;
        END;
  --
 -- SELECT  COUNT(*)
  --INTO    ginPasswordChangeAdminCount
  --FROM    SS_USER_CHANGE_LOG_TAB
  --WHERE   ID_USER       =   pobjUserInfoRow.USER_ID
  --AND     DES_STATUS    <>  'CHANGE PASSWORD';
  SELECT  COUNT(*)
  INTO    ginPasswordChangeCount
  FROM    SS_USER_CHANGE_LOG_TAB
  WHERE   ID_USER       =   pobjUserInfoRow.USER_ID
  AND     DES_STATUS    <>  'NEW USER';
  IF ginPasswordChangeCount = 0
  THEN
    RAISE PASSWORD_SET_REQ_EXCEPTION;
  END IF;
  SELECT    NUM_CHANGE_PASSWORD
  INTO      ginChangePasswordFlag
  FROM      SS_USER_TAB
  WHERE     SS_USER_TAB.ID_USER   =   pobjUserInfoRow.USER_ID;
  IF ginChangePasswordFlag = 1
  THEN
    RAISE PASSWORD_SET_REQ_EXCEPTION;
  END IF;
  --Last Record From SS_USER_CHANGE_LOG
  SELECT    MIN(TRUNC(SYSDATE-FEC_CHANGE_DATE))
  INTO      ginDaysElapsed
  FROM      SS_USER_CHANGE_LOG_TAB
  WHERE     ID_USER   =   pobjUserInfoRow.USER_ID
    --AND     ROWNUM    =   1
  ORDER BY  ID_USER_CHANGE_LOG  DESC;
  --ECM 29 Septiembre 2016 --Maximo numero de contrase?a.
  --IF ginDaysElapsed >= pobjUserInfoRow.PASSWORD_EXPIRATION_DAYS
  IF ginDaysElapsed >= liMaxNumCon
  THEN
    RAISE PASSWORD_CHANGE_REQ_EXCEPTION;
  END IF;
END CHECK_IF_PWD_IS_EFFECTIVE_PR;
--
--
PROCEDURE INSERT_USER_ACCESS_LOG_PR(
                                        pinUserId           NUMBER
                                       ,pinOutAccessLogId   OUT NUMBER
                                   )
AS
BEGIN
  pinOutAccessLogId:= SS_USER_ACCESS_LOG_SQ.NEXTVAL;
  INSERT INTO SS_USER_ACCESS_LOG_TAB(
                                        ID_USER_ACCESS_LOG
                                       ,ID_USER
                                       ,FEC_SESSION_START_DATE
                                       ,FEC_SESSION_END_DATE
                                       ,DES_SESSION_CLOSE_MODE
                                    )
  VALUES(
            pinOutAccessLogId
           ,pinUserId
           ,SYSDATE
           ,NULL
           ,'LOGIN_EXITOSO'
        );
  UPDATE SS_USER_TAB
  SET    ID_STATUS = 3
  WHERE  ID_USER   =  pinUserId;
    --JJAQ 04/09/2017 SE INSERTA TAMBIEN EN LA TABLA PENDIUM_SS_LOG_STAT_CONECT_TAB PARA PARA EL
    --CIERRE DE SESION AUTOMATICO Y NO ESPERE DESPUES DE UN MINUTO A INSERTAR EN ESTA TABLA.
    usrdrc.PENDIUM_SS_LOG_STAT_CONECT_PKG.INSERTAR_LOG_STAT_CONECT_PR(pinUserId);
END INSERT_USER_ACCESS_LOG_PR;
PROCEDURE DO_LOGOUT_PR(
                          pinUserId                NUMBER
                         ,pinUserAccessLogId       NUMBER
                     )
AS
BEGIN
  UPDATE SS_USER_TAB
  SET    ID_STATUS = 1
  WHERE  ID_USER   =  pinUserId;
  UPDATE  DERCORP_CONTROL_SECCION
  SET     STATUS = '0'
  WHERE   ID_USER = pinUserId;
  DELETE  DERCORP_CONTROL_META_ROW
  WHERE   ID_USER = pinUserId;
  INSERT INTO SS_USER_ACCESS_LOG_TAB(FEC_SESSION_END_DATE,DES_SESSION_CLOSE_MODE,ID_USER_ACCESS_LOG,ID_USER)
  VALUES(SYSDATE,'NORMAL_LOGOUT',SS_USER_ACCESS_LOG_SQ.NEXTVAL,pinUserId);
  /*
  UPDATE SS_USER_ACCESS_LOG_TAB
  SET    FEC_SESSION_END_DATE   = SYSDATE
        ,DES_SESSION_CLOSE_MODE = 'NORMAL_LOGOUT'
  WHERE  ID_USER_ACCESS_LOG     = pinUserAccessLogId;*/
END DO_LOGOUT_PR;
END SS_LOGIN_PKG;
/;
