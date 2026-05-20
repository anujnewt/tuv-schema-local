CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_AGREGAR_OTROS_PKG" AS
PROCEDURE CREATE_AGREGAR_PR(PARAM_ID_EMPRESA       NUMBER,
                               PARAM_ID_AGREGAR    VARCHAR2,
                               PARAM_AGREGAR       VARCHAR2,
                               pinUserID          NUMBER
                               );
PROCEDURE CREATE_AGREGAR_METAROW_PR(PARAM_ID_META_ROW    NUMBER,
                               PARAM_ID_EMPRESA         NUMBER,
                               PARAM_ID_AGREGAR          VARCHAR2,
                               PARAM_AGREGAR             VARCHAR2,
                               pinUserID                NUMBER
                               );
PROCEDURE FIND_AGREGAR_TMP_PR(PARAM_ID_EMPRESA NUMBER,
                             AGREGAR_TEMP     OUT SYS_REFCURSOR);
PROCEDURE FIND_AGREGAR_METAROW_PR(PARAM_ID_META_ROW  NUMBER,
                                 AGREGAR_META_ROW    OUT SYS_REFCURSOR);
PROCEDURE DELETE_AGREGAR_PR(PARAM_ID_AGREGAR_ROW NUMBER);
PROCEDURE FIND_ONE_AGREGAR(
                             PARAM_ID_AGREGAR_ROW  NUMBER,
                             P_ID_AGREGAR_ROW      OUT NUMBER,
                             ID_AGREGAR_OUT        OUT VARCHAR,
                             AGREGAR_OUT           OUT VARCHAR
                            );
PROCEDURE UPDATE_AGREGAR(
                             PARAM_ID_AGREGAR_ROW      NUMBER,
                             PARAM_AGREGAR             VARCHAR2,
                             PARAM_ID_AGREGAR          VARCHAR2,
                             PARAM_ID_USER            NUMBER
                            );
PROCEDURE UPDATE_AGREGAR_METAROW(
                                  PARAM_ID_META_ROW NUMBER,
                                  PARAM_ID_EMPRESA NUMBER
                                );
PROCEDURE DELETE_ALL_TEMP(PARAM_ID_EMPRESA NUMBER);
END PENDIUM_AGREGAR_OTROS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_AGREGAR_OTROS_PKG" AS
  PROCEDURE CREATE_AGREGAR_PR(PARAM_ID_EMPRESA NUMBER,
                               PARAM_ID_AGREGAR  VARCHAR2,
                               PARAM_AGREGAR VARCHAR2,
                               pinUserID        NUMBER
                               ) AS
var_seq number;
  BEGIN
    SELECT
      PENDIUM_AGREGAR_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO PENDIUM_AGREGAR_TAB
    (
      ID_AGREGAR_ROW,
      ID_EMPRESA,
      ID_AGREGAR,
      AGREGAR,
      NUM_CREATED_BY,
      FEC_CREATION_DATE,
      NUM_LAST_UPDATED_BY,
      FEC_LAST_UPDATE_DATE
    )VALUES(
      var_seq,
      PARAM_ID_EMPRESA,
      PARAM_ID_AGREGAR,
      PARAM_AGREGAR,
      pinUserID,
      SYSDATE,
      pinUserID,
      SYSDATE
    );
END;
PROCEDURE CREATE_AGREGAR_METAROW_PR(PARAM_ID_META_ROW NUMBER,
                               PARAM_ID_EMPRESA NUMBER,
                               PARAM_ID_AGREGAR  VARCHAR2,
                               PARAM_AGREGAR VARCHAR2,
                               pinUserID        NUMBER
                               )AS
  var_seq number;
  BEGIN
    SELECT
      PENDIUM_AGREGAR_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO PENDIUM_AGREGAR_TAB
    (
      ID_META_ROW,
      ID_AGREGAR_ROW,
      ID_EMPRESA,
      ID_AGREGAR,
      AGREGAR,
      NUM_CREATED_BY,
      FEC_CREATION_DATE,
      NUM_LAST_UPDATED_BY,
      FEC_LAST_UPDATE_DATE
    )VALUES(
      PARAM_ID_META_ROW,
      var_seq,
      PARAM_ID_EMPRESA,
      PARAM_ID_AGREGAR,
      PARAM_AGREGAR,
      pinUserID,
      SYSDATE,
      pinUserID,
      SYSDATE
    );
  END;
    PROCEDURE FIND_AGREGAR_TMP_PR(PARAM_ID_EMPRESA NUMBER,
                                  AGREGAR_TEMP     OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN AGREGAR_TEMP FOR
        SELECT
              ID_AGREGAR_ROW,
              ID_AGREGAR,
              AGREGAR
        FROM
          PENDIUM_AGREGAR_TAB
        WHERE
          ID_EMPRESA=PARAM_ID_EMPRESA
        AND
          ID_META_ROW IS NULL
          ORDER BY ID_AGREGAR_ROW ASC;
    END;
    PROCEDURE FIND_AGREGAR_METAROW_PR(PARAM_ID_META_ROW  NUMBER,
                                     AGREGAR_META_ROW    OUT SYS_REFCURSOR)
    AS
    BEGIN
      OPEN AGREGAR_META_ROW FOR
        SELECT
              ID_AGREGAR_ROW,
              ID_AGREGAR,
              AGREGAR
        FROM
          PENDIUM_AGREGAR_TAB
        WHERE
          ID_META_ROW = PARAM_ID_META_ROW
        ORDER BY ID_AGREGAR_ROW ASC;
    END FIND_AGREGAR_METAROW_PR;
    PROCEDURE DELETE_AGREGAR_PR(PARAM_ID_AGREGAR_ROW NUMBER)
    AS
    BEGIN
       DELETE
          FROM
              PENDIUM_AGREGAR_TAB
          WHERE
              ID_AGREGAR_ROW = PARAM_ID_AGREGAR_ROW;
    END;
    PROCEDURE FIND_ONE_AGREGAR(
                                 PARAM_ID_AGREGAR_ROW    NUMBER,
                                 P_ID_AGREGAR_ROW        OUT NUMBER,
                                 ID_AGREGAR_OUT          OUT VARCHAR,
                                 AGREGAR_OUT             OUT VARCHAR
                                )
    AS
    BEGIN
       SELECT
            ID_AGREGAR_ROW,
            ID_AGREGAR,
            AGREGAR
            INTO
            P_ID_AGREGAR_ROW,
            ID_AGREGAR_OUT,
            AGREGAR_OUT
          FROM
            PENDIUM_AGREGAR_TAB
          WHERE
            ID_AGREGAR_ROW = PARAM_ID_AGREGAR_ROW
          ;
    END;
    PROCEDURE UPDATE_AGREGAR(
                                 PARAM_ID_AGREGAR_ROW      NUMBER,
                                 PARAM_AGREGAR             VARCHAR2,
                                 PARAM_ID_AGREGAR          VARCHAR2,
                                 PARAM_ID_USER            NUMBER
                                )
    AS
    BEGIN
      UPDATE
            PENDIUM_AGREGAR_TAB
        SET
            AGREGAR              =   PARAM_AGREGAR,
            ID_AGREGAR           =   PARAM_ID_AGREGAR,
            NUM_LAST_UPDATED_BY =   PARAM_ID_USER,
            FEC_LAST_UPDATE_DATE=   SYSDATE
        WHERE ID_AGREGAR_ROW  =   PARAM_ID_AGREGAR_ROW;
    END UPDATE_AGREGAR;
    PROCEDURE UPDATE_AGREGAR_METAROW(
                                      PARAM_ID_META_ROW NUMBER,
                                      PARAM_ID_EMPRESA NUMBER
                                    )
    AS
    BEGIN
      UPDATE
            PENDIUM_AGREGAR_TAB
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
            PENDIUM_AGREGAR_TAB
        WHERE
            ID_EMPRESA = PARAM_ID_EMPRESA
        AND
            ID_META_ROW IS NULL
        ;
    END;
END PENDIUM_AGREGAR_OTROS_PKG;
/;
