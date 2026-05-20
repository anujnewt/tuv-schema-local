CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_ASUNTO_PKG" AS
PROCEDURE CREATE_ASUNTO_PR(PARAM_ID_EMPRESA       NUMBER,
                               PARAM_ID_ASUNTO    VARCHAR2,
                               PARAM_ASUNTO       VARCHAR2,
                               pinUserID          NUMBER
                               );
PROCEDURE CREATE_ASUNTO_METAROW_PR(PARAM_ID_META_ROW    NUMBER,
                               PARAM_ID_EMPRESA         NUMBER,
                               PARAM_ID_ASUNTO          VARCHAR2,
                               PARAM_ASUNTO             VARCHAR2,
                               pinUserID                NUMBER
                               );
PROCEDURE FIND_ASUNTO_TMP_PR(PARAM_ID_EMPRESA NUMBER,
                             ASUNTOS_TEMP     OUT SYS_REFCURSOR);
PROCEDURE FIND_ASUNTO_METAROW_PR(PARAM_ID_META_ROW  NUMBER,
                                 ASUNTO_META_ROW    OUT SYS_REFCURSOR);
PROCEDURE DELETE_ASUNTO_PR(PARAM_ID_ASUNTO_ROW NUMBER);
PROCEDURE FIND_ONE_ASUNTO(
                             PARAM_ID_ASUNTO_ROW  NUMBER,
                             P_ID_ASUNTO_ROW      OUT NUMBER,
                             ID_ASUNTO_OUT        OUT VARCHAR,
                             ASUNTO_OUT           OUT VARCHAR
                            );
PROCEDURE UPDATE_ASUNTO(
                             PARAM_ID_ASUNTO_ROW      NUMBER,
                             PARAM_ASUNTO             VARCHAR2,
                             PARAM_ID_ASUNTO          VARCHAR2,
                             PARAM_ID_USER            NUMBER
                            );
PROCEDURE UPDATE_ASUNTO_METAROW(
                                  PARAM_ID_META_ROW NUMBER,
                                  PARAM_ID_EMPRESA NUMBER
                                );
PROCEDURE DELETE_ALL_TEMP(PARAM_ID_EMPRESA NUMBER);
END PENDIUM_ASUNTO_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_ASUNTO_PKG" AS
PROCEDURE CREATE_ASUNTO_PR(PARAM_ID_EMPRESA NUMBER,
                               PARAM_ID_ASUNTO  VARCHAR2,
                               PARAM_ASUNTO VARCHAR2,
                               pinUserID        NUMBER
                               ) AS
var_seq number;
  BEGIN
    SELECT
      PENDIUM_ASUNTO_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO PENDIUM_ASUNTO_TAB
    (
      ID_ASUNTO_ROW,
      ID_EMPRESA,
      ID_ASUNTO,
      ASUNTO,
      NUM_CREATED_BY,
      FEC_CREATION_DATE,
      NUM_LAST_UPDATED_BY,
      FEC_LAST_UPDATE_DATE
    )VALUES(
      var_seq,
      PARAM_ID_EMPRESA,
      PARAM_ID_ASUNTO,
      PARAM_ASUNTO,
      pinUserID,
      SYSDATE,
      pinUserID,
      SYSDATE
    );
END;
PROCEDURE CREATE_ASUNTO_METAROW_PR(PARAM_ID_META_ROW NUMBER,
                               PARAM_ID_EMPRESA NUMBER,
                               PARAM_ID_ASUNTO  VARCHAR2,
                               PARAM_ASUNTO VARCHAR2,
                               pinUserID        NUMBER
                               )AS
  var_seq number;
  BEGIN
    SELECT
      PENDIUM_ASUNTO_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO PENDIUM_ASUNTO_TAB
    (
      ID_META_ROW,
      ID_ASUNTO_ROW,
      ID_EMPRESA,
      ID_ASUNTO,
      ASUNTO,
      NUM_CREATED_BY,
      FEC_CREATION_DATE,
      NUM_LAST_UPDATED_BY,
      FEC_LAST_UPDATE_DATE
    )VALUES(
      PARAM_ID_META_ROW,
      var_seq,
      PARAM_ID_EMPRESA,
      PARAM_ID_ASUNTO,
      PARAM_ASUNTO,
      pinUserID,
      SYSDATE,
      pinUserID,
      SYSDATE
    );
  END;
    PROCEDURE FIND_ASUNTO_TMP_PR(PARAM_ID_EMPRESA NUMBER,
                                  ASUNTOS_TEMP     OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN ASUNTOS_TEMP FOR
        SELECT
              ID_ASUNTO_ROW,
              ID_ASUNTO,
              ASUNTO
        FROM
          PENDIUM_ASUNTO_TAB
        WHERE
          ID_EMPRESA=PARAM_ID_EMPRESA
        AND
          ID_META_ROW IS NULL
          ORDER BY ID_ASUNTO_ROW ASC;
    END;
    PROCEDURE FIND_ASUNTO_METAROW_PR(PARAM_ID_META_ROW  NUMBER,
                                     ASUNTO_META_ROW    OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN ASUNTO_META_ROW FOR
        SELECT
              ID_ASUNTO_ROW,
              ID_ASUNTO,
              ASUNTO
        FROM
          PENDIUM_ASUNTO_TAB
        WHERE
          ID_META_ROW = PARAM_ID_META_ROW
        ORDER BY ID_ASUNTO_ROW ASC;
    END FIND_ASUNTO_METAROW_PR;
    PROCEDURE DELETE_ASUNTO_PR(PARAM_ID_ASUNTO_ROW NUMBER)
    AS
    BEGIN
       DELETE
          FROM
              PENDIUM_ASUNTO_TAB
          WHERE
              ID_ASUNTO_ROW = PARAM_ID_ASUNTO_ROW;
    END;
    PROCEDURE FIND_ONE_ASUNTO(
                                 PARAM_ID_ASUNTO_ROW    NUMBER,
                                 P_ID_ASUNTO_ROW        OUT NUMBER,
                                 ID_ASUNTO_OUT          OUT VARCHAR,
                                 ASUNTO_OUT             OUT VARCHAR
                                )
    AS
    BEGIN
       SELECT
            ID_ASUNTO_ROW,
            ID_ASUNTO,
            ASUNTO
            INTO
            P_ID_ASUNTO_ROW,
            ID_ASUNTO_OUT,
            ASUNTO_OUT
          FROM
            PENDIUM_ASUNTO_TAB
          WHERE
            ID_ASUNTO_ROW = PARAM_ID_ASUNTO_ROW
          ;
    END;
    PROCEDURE UPDATE_ASUNTO(
                                 PARAM_ID_ASUNTO_ROW      NUMBER,
                                 PARAM_ASUNTO             VARCHAR2,
                                 PARAM_ID_ASUNTO          VARCHAR2,
                                 PARAM_ID_USER            NUMBER
                                )
    AS
    BEGIN
      UPDATE
            PENDIUM_ASUNTO_TAB
        SET
            ASUNTO              =   PARAM_ASUNTO,
            ID_ASUNTO           =   PARAM_ID_ASUNTO,
            NUM_LAST_UPDATED_BY =   PARAM_ID_USER,
            FEC_LAST_UPDATE_DATE=   SYSDATE
        WHERE ID_ASUNTO_ROW  =   PARAM_ID_ASUNTO_ROW;
    END UPDATE_ASUNTO;
    PROCEDURE UPDATE_ASUNTO_METAROW(
                                      PARAM_ID_META_ROW NUMBER,
                                      PARAM_ID_EMPRESA NUMBER
                                    )
    AS
    BEGIN
      UPDATE
            PENDIUM_ASUNTO_TAB
        SET
            ID_META_ROW         = PARAM_ID_META_ROW
        WHERE
            ID_EMPRESA          = PARAM_ID_EMPRESA
        AND
            ID_META_ROW IS NULL;
    END;
    PROCEDURE DELETE_ALL_TEMP(PARAM_ID_EMPRESA NUMBER)
    AS
    BEGIN
      DELETE
        FROM
            PENDIUM_ASUNTO_TAB
        WHERE
            ID_EMPRESA = PARAM_ID_EMPRESA
        AND
            ID_META_ROW IS NULL
        ;
    END;
END PENDIUM_ASUNTO_PKG;
/;
