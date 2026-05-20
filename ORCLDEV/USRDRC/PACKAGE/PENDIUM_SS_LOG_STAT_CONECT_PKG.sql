CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_SS_LOG_STAT_CONECT_PKG" AS
  /* TODO enter package declarations (types, exceptions, methods etc) here */
    PROCEDURE INSERTAR_LOG_STAT_CONECT_PR(piIdUser IN INT);
    PROCEDURE VERIFICAR_LOG_STAT_CONECT_PR;
END PENDIUM_SS_LOG_STAT_CONECT_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_SS_LOG_STAT_CONECT_PKG" AS
    PROCEDURE INSERTAR_LOG_STAT_CONECT_PR(piIdUser IN INT)
    IS
    BEGIN
        INSERT INTO PENDIUM_SS_LOG_STAT_CONECT_TAB(ID_USER
                                                  ,FEC_LOG)VALUES(piIdUser
                                                                 ,SYSDATE
                                                  );
    EXCEPTION
        WHEN OTHERS THEN
        NULL;
    END INSERTAR_LOG_STAT_CONECT_PR;
    PROCEDURE VERIFICAR_LOG_STAT_CONECT_PR
    IS
        giUserActivos NUMBER := 3;
        ldFec DATE;
        --liDiezMin NUMBER := 0.0006944; 1 min
        liDiezMin NUMBER := 0.006944; --10 min
        CURSOR USER_ACTIVOS_CUR
        IS
        SELECT  ID_USER
        FROM    SS_USER_TAB
        WHERE   1=1
        AND     ID_STATUS = giUserActivos
        ;
    BEGIN
        FOR i IN USER_ACTIVOS_CUR
        LOOP
            BEGIN
                SELECT MAX(TO_DATE((TO_CHAR(FEC_LOG,'DD/MM/YYYY, HH24:MI:SS')),'DD/MM/YYYY, HH24:MI:SS')) AS FEC
                INTO   ldFec
                FROM   PENDIUM_SS_LOG_STAT_CONECT_TAB
                WHERE  1=1
                AND    ID_USER = i.ID_USER
                ;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                ldFec := SYSDATE;
            END;
            IF (SYSDATE - ldFec) > liDiezMin THEN
               DBMS_OUTPUT.PUT_LINE(ldFec||' es mayor a 10 minutos.');
               DELETE FROM PENDIUM_SS_LOG_STAT_CONECT_TAB
               WHERE  1=1
               AND    ID_USER = i.ID_USER
               ;
               UPDATE  SS_USER_TAB
               SET     ID_STATUS = 1
               WHERE   1=1
               AND     ID_USER = i.ID_USER
               ;
                --UPDATE ss_user_tab SET id_status = 1 WHERE id_status = 3;
                INSERT INTO SS_USER_ACCESS_LOG_TAB(
                                                    ID_USER_ACCESS_LOG
                                                   ,ID_USER,FEC_SESSION_START_DATE
                                                   ,FEC_SESSION_END_DATE
                                                   ,DES_SESSION_CLOSE_MODE
                                                 )
                VALUES(
                        SS_USER_ACCESS_LOG_SQ.NEXTVAL
                        ,i.ID_USER
                        ,SYSDATE
                        ,SYSDATE
                        ,'FORCED_LOGOUT'
                        );
        /*
                UPDATE ss_user_access_log_tab
                SET fec_session_end_date    = sysdate,
                  des_session_close_mode    = 'FORCED_LOGOUT'
                WHERE fec_session_end_date IS NULL;
                UPDATE DERCORP_CONTROL_SECCION SET
                  STATUS = 0
                WHERE
                  ID_USER IN (
                            SELECT
                              USR.ID_USER
                            FROM
                              SS_USER_TAB USR
                              LEFT JOIN SS_USER_ACCESS_LOG_TAB IUAL ON USR.ID_USER = IUAL.ID_USER
                            WHERE
                              IUAL.ID_USER_ACCESS_LOG = ( SELECT
                                                            MAX(INT_T.ID_USER_ACCESS_LOG)
                                                          FROM
                                                            ss_user_access_log_tab INT_T
                                                          WHERE
                                                              INT_T.id_user = USR.id_user)
                              AND
                                IUAL.DES_SESSION_CLOSE_MODE = 'FORCED_LOGOUT'
                            );
               */
                DELETE DERCORP_CONTROL_META_ROW
                WHERE
                  ID_USER = i.ID_USER; /*IN (
                            SELECT
                              USR.ID_USER
                            FROM
                              SS_USER_TAB USR
                              LEFT JOIN SS_USER_ACCESS_LOG_TAB IUAL ON USR.ID_USER = IUAL.ID_USER
                            WHERE
                              IUAL.ID_USER_ACCESS_LOG = ( SELECT
                                                            MAX(INT_T.ID_USER_ACCESS_LOG)
                                                          FROM
                                                            ss_user_access_log_tab INT_T
                                                          WHERE
                                                              INT_T.id_user = USR.id_user)
                              AND
                                IUAL.DES_SESSION_CLOSE_MODE = 'FORCED_LOGOUT'
                            );*/
               COMMIT;
            END IF;
        END LOOP;
    END VERIFICAR_LOG_STAT_CONECT_PR;
END PENDIUM_SS_LOG_STAT_CONECT_PKG;
/;
