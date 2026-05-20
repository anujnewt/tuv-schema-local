CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_EJERCICIO_SOCIAL_PKG" AS
PROCEDURE CREATE_EJERCICIOS_PR(PARAM_ID_EMPRESA NUMBER,
                               PARAM_EJERCICIO  NUMBER,
                               PARAM_DOCUMENTUM VARCHAR2,
                               PARAM_FECHA_DOC  VARCHAR2,
                               PARAM_FECHA_ENT  VARCHAR2,
                               pinUserID        NUMBER,
                               PARAM_TIPO_DOC   VARCHAR2
                               );
PROCEDURE CREATE_EJERCICIOS_METAROW_PR(PARAM_ID_META_ROW NUMBER,
                               PARAM_ID_EMPRESA NUMBER,
                               PARAM_EJERCICIO  NUMBER,
                               PARAM_DOCUMENTUM VARCHAR2,
                               PARAM_FECHA_DOC  VARCHAR2,
                               PARAM_FECHA_ENT  VARCHAR2,
                               pinUserID        NUMBER,
                               PARAM_TIPO_DOC   VARCHAR2
                               );
PROCEDURE FIND_EJERCICIOS_TMP_PR(PARAM_ID_EMPRESA NUMBER,
                                   EJERCICIOS_TEMP OUT SYS_REFCURSOR);
PROCEDURE FIND_EJERCICIOS_METAROW_PR(PARAM_ID_META_ROW NUMBER,
                                   EJERCICIOS_META_ROW OUT SYS_REFCURSOR);
PROCEDURE DELETE_EJERCICIO_PR(PARAM_ID_EJERCICIO_ROW NUMBER);
PROCEDURE FIND_ONE_EJERCICIO(
                             PARAM_ID_EJERCICIO_ROW NUMBER,
                             ID_EJERCICIO_OUT     OUT NUMBER,
                             EJERCICIO_OUT        OUT NUMBER,
                             NO_DOCUMENTUM_OUT    OUT VARCHAR2,
                             FECHA_DOCUMENTUM_OUT OUT VARCHAR2,
                             FECHA_ENTREGA_OUT    OUT VARCHAR2,
                             TIPO_DOCUMENT_OUT    OUT VARCHAR2
                            );
PROCEDURE UPDATE_EJERCICIO(
                             PARAM_ID_EJERCICIO_ROW NUMBER,
                             PARAM_EJERCICIO        VARCHAR2,
                             PARAM_NO_DOCUMENTUM    VARCHAR2,
                             PARAM_FECHA_DOCUMENTUM VARCHAR2,
                             PARAM_FECHA_ENTREGA    VARCHAR2,
                             PARAM_ID_USER          NUMBER
                            );
PROCEDURE UPDATE_EJERCICIO_METAROW(
                            PARAM_ID_META_ROW NUMBER,
                            PARAM_ID_EMPRESA NUMBER
);
PROCEDURE DELETE_ALL_TEMP(PARAM_ID_EMPRESA NUMBER);
END PENDIUM_EJERCICIO_SOCIAL_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_EJERCICIO_SOCIAL_PKG" AS
  --ULR 15-03-2017 insertar ejercicios
  PROCEDURE CREATE_EJERCICIOS_PR(PARAM_ID_EMPRESA NUMBER,
                                 PARAM_EJERCICIO  NUMBER,
                                 PARAM_DOCUMENTUM VARCHAR2,
                                 PARAM_FECHA_DOC  VARCHAR2,
                                 PARAM_FECHA_ENT  VARCHAR2,
                                 pinUserID        NUMBER,
                                 PARAM_TIPO_DOC   VARCHAR2
                               ) AS
  var_seq number;
  BEGIN
    SELECT
      PENDIUM_EJERCICIO_SOC_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO PENDIUM_EJERCICIO_SOCIAL_TAB
    (
      ID_EJERCICIO_ROW,
      ID_EMPRESA,
      EJERCICIO_SOCIAL,
      NO_DOCUMENTUM,
      FECHA_DOCUMENTUM,
      FECHA_ENTREGA,
      NUM_CREATED_BY,
      FEC_CREATION_DATE,
      TIPO_DOCUMENT,
      NUM_LAST_UPDATED_BY,
      FEC_LAST_UPDATE_DATE
    )VALUES(
      var_seq,
      PARAM_ID_EMPRESA,
      PARAM_EJERCICIO,
      PARAM_DOCUMENTUM,
      PARAM_FECHA_DOC,
      PARAM_FECHA_ENT,
      pinUserID,
      SYSDATE,
      PARAM_TIPO_DOC,
      pinUserID,
      SYSDATE
    );
  END;
  PROCEDURE CREATE_EJERCICIOS_METAROW_PR(PARAM_ID_META_ROW NUMBER,
                               PARAM_ID_EMPRESA NUMBER,
                               PARAM_EJERCICIO  NUMBER,
                               PARAM_DOCUMENTUM VARCHAR2,
                               PARAM_FECHA_DOC  VARCHAR2,
                               PARAM_FECHA_ENT  VARCHAR2,
                               pinUserID        NUMBER,
                               PARAM_TIPO_DOC   VARCHAR2
                               )AS
  var_seq number;
  BEGIN
    SELECT
      PENDIUM_EJERCICIO_SOC_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO PENDIUM_EJERCICIO_SOCIAL_TAB
    (
      ID_META_ROW,
      ID_EJERCICIO_ROW,
      ID_EMPRESA,
      EJERCICIO_SOCIAL,
      NO_DOCUMENTUM,
      FECHA_DOCUMENTUM,
      FECHA_ENTREGA,
      NUM_CREATED_BY,
      FEC_CREATION_DATE,
      TIPO_DOCUMENT,
      NUM_LAST_UPDATED_BY,
      FEC_LAST_UPDATE_DATE
    )VALUES(
      PARAM_ID_META_ROW,
      var_seq,
      PARAM_ID_EMPRESA,
      PARAM_EJERCICIO,
      PARAM_DOCUMENTUM,
      PARAM_FECHA_DOC,
      PARAM_FECHA_ENT,
      pinUserID,
      SYSDATE,
      PARAM_TIPO_DOC,
      pinUserID,
      SYSDATE
    );
  END;
  --ULR 15-03-2017 obtener ejercicios temporales
  PROCEDURE FIND_EJERCICIOS_TMP_PR(PARAM_ID_EMPRESA NUMBER,
                                     EJERCICIOS_TEMP OUT SYS_REFCURSOR)AS
    BEGIN
    OPEN EJERCICIOS_TEMP FOR
        SELECT
          ID_EJERCICIO_ROW,
          EJERCICIO_SOCIAL,
          NO_DOCUMENTUM,
          FECHA_DOCUMENTUM,
          FECHA_ENTREGA,
          TIPO_DOCUMENT
        FROM
          PENDIUM_EJERCICIO_SOCIAL_TAB
        WHERE
          ID_EMPRESA=PARAM_ID_EMPRESA
        AND
          ID_META_ROW IS NULL
        ;
  END;
  PROCEDURE FIND_EJERCICIOS_METAROW_PR(PARAM_ID_META_ROW NUMBER,
                                   EJERCICIOS_META_ROW OUT SYS_REFCURSOR)AS
      BEGIN
          OPEN EJERCICIOS_META_ROW FOR
        SELECT
          ID_EJERCICIO_ROW,
          EJERCICIO_SOCIAL,
          NO_DOCUMENTUM,
          FECHA_DOCUMENTUM,
          FECHA_ENTREGA,
          TIPO_DOCUMENT
        FROM
          PENDIUM_EJERCICIO_SOCIAL_TAB
        WHERE
          ID_META_ROW=PARAM_ID_META_ROW
        ;
  END;
  PROCEDURE DELETE_EJERCICIO_PR(PARAM_ID_EJERCICIO_ROW NUMBER)AS
      BEGIN
          DELETE
          FROM
              PENDIUM_EJERCICIO_SOCIAL_TAB
          WHERE
              ID_EJERCICIO_ROW=PARAM_ID_EJERCICIO_ROW
          ;
  END;
  PROCEDURE FIND_ONE_EJERCICIO(
                             PARAM_ID_EJERCICIO_ROW NUMBER,
                             ID_EJERCICIO_OUT     OUT NUMBER,
                             EJERCICIO_OUT        OUT NUMBER,
                             NO_DOCUMENTUM_OUT    OUT VARCHAR2,
                             FECHA_DOCUMENTUM_OUT OUT VARCHAR2,
                             FECHA_ENTREGA_OUT    OUT VARCHAR2,
                             TIPO_DOCUMENT_OUT    OUT VARCHAR2
                            ) AS
      BEGIN
          SELECT
            ID_EJERCICIO_ROW,
            EJERCICIO_SOCIAL,
            NO_DOCUMENTUM,
            FECHA_DOCUMENTUM,
            FECHA_ENTREGA,
            TIPO_DOCUMENT
            INTO
            ID_EJERCICIO_OUT,
            EJERCICIO_OUT,
            NO_DOCUMENTUM_OUT,
            FECHA_DOCUMENTUM_OUT,
            FECHA_ENTREGA_OUT,
            TIPO_DOCUMENT_OUT
          FROM
            PENDIUM_EJERCICIO_SOCIAL_TAB
          WHERE
            ID_EJERCICIO_ROW=PARAM_ID_EJERCICIO_ROW
          ;
  END;
PROCEDURE UPDATE_EJERCICIO(
                             PARAM_ID_EJERCICIO_ROW NUMBER,
                             PARAM_EJERCICIO        VARCHAR2,
                             PARAM_NO_DOCUMENTUM    VARCHAR2,
                             PARAM_FECHA_DOCUMENTUM VARCHAR2,
                             PARAM_FECHA_ENTREGA    VARCHAR2,
                             PARAM_ID_USER          NUMBER
                            )AS
    BEGIN
        UPDATE
            PENDIUM_EJERCICIO_SOCIAL_TAB
        SET
            TIPO_DOCUMENT    =   PARAM_EJERCICIO,
            NO_DOCUMENTUM       =   PARAM_NO_DOCUMENTUM,
            FECHA_DOCUMENTUM    =   PARAM_FECHA_DOCUMENTUM,
            FECHA_ENTREGA       =   PARAM_FECHA_ENTREGA,
            NUM_LAST_UPDATED_BY =   PARAM_ID_USER,
            FEC_LAST_UPDATE_DATE=   SYSDATE
        WHERE ID_EJERCICIO_ROW  =   PARAM_ID_EJERCICIO_ROW
    ;
END;
PROCEDURE UPDATE_EJERCICIO_METAROW(
                            PARAM_ID_META_ROW NUMBER,
                            PARAM_ID_EMPRESA NUMBER
)AS
    BEGIN
        UPDATE
            PENDIUM_EJERCICIO_SOCIAL_TAB
        SET
            ID_META_ROW         =   PARAM_ID_META_ROW
        WHERE
            ID_EMPRESA=PARAM_ID_EMPRESA
        AND
            ID_META_ROW IS NULL;
END;
PROCEDURE DELETE_ALL_TEMP(PARAM_ID_EMPRESA NUMBER) AS
    BEGIN
        DELETE
        FROM
            PENDIUM_EJERCICIO_SOCIAL_TAB
        WHERE
            ID_EMPRESA=PARAM_ID_EMPRESA
        AND
            ID_META_ROW IS NULL
        ;
END;
END PENDIUM_EJERCICIO_SOCIAL_PKG;
/;
