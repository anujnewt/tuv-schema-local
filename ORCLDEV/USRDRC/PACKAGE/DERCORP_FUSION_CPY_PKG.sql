CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_FUSION_CPY_PKG" AS
  --
  --
  --
  PROCEDURE CPY_PR(Meta_key number, Id_Empresa number);
  --JJAQ 10/04/2017 para copiar un registro de aprobacion del ejercicio social
  PROCEDURE CPY_AES_PR(Meta_key number, Id_Empresa number);
END DERCORP_FUSION_CPY_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_FUSION_CPY_PKG" AS
    --
    --
    --
    PROCEDURE CPY_PR(Meta_key number, Id_Empresa number)
      AS
      var_seq number;
        CURSOR CUR_CPY_METATBL_ROW IS
          SELECT *
          FROM DERCORP_METATBL_TAB
          WHERE ID_META_ROW = Meta_key;
        ROW_CPY CUR_CPY_METATBL_ROW%ROWTYPE;
      BEGIN
        SELECT
          DERCORP_METATBL_SEQ.NEXTVAL INTO var_seq
        FROM
          DUAL;
          OPEN CUR_CPY_METATBL_ROW;
          FETCH CUR_CPY_METATBL_ROW INTO ROW_CPY;
          CLOSE CUR_CPY_METATBL_ROW;
          ROW_CPY.ID_META_ROW := var_seq;
          ROW_CPY.ID_EMPRESA := Id_Empresa;
          INSERT INTO DERCORP_METATBL_TAB
          VALUES ROW_CPY;
      END   CPY_PR;
    PROCEDURE CPY_AES_PR(Meta_key number, Id_Empresa number)
      AS
      var_seq number;
      var_seq_doc number;
        CURSOR CUR_CPY_METATBL_ROW IS
          SELECT *
          FROM DERCORP_METATBL_TAB
          WHERE ID_META_ROW = Meta_key;
        ROW_CPY CUR_CPY_METATBL_ROW%ROWTYPE;
        --cursor para obtener los documentos JAMS
        CURSOR CUR_DOC_EJER_ROW IS
          SELECT
          *
        FROM
          PENDIUM_EJERCICIO_SOCIAL_TAB
        WHERE
          ID_META_ROW=Meta_key;
        ROW_CPY_DOC CUR_DOC_EJER_ROW%ROWTYPE;
      BEGIN
        SELECT
          DERCORP_METATBL_SEQ.NEXTVAL INTO var_seq
        FROM
          DUAL;
        SELECT
      PENDIUM_EJERCICIO_SOC_SEQ.NEXTVAL INTO var_seq_doc
    FROM
      DUAL;
          OPEN CUR_CPY_METATBL_ROW;
          FETCH CUR_CPY_METATBL_ROW INTO ROW_CPY;
          CLOSE CUR_CPY_METATBL_ROW;
          ROW_CPY.ID_META_ROW := var_seq;
          ROW_CPY.ID_EMPRESA  := Id_Empresa;
          ROW_CPY.VAL_C149    := ROW_CPY.VAL_C149 || '*';
          INSERT INTO DERCORP_METATBL_TAB
          VALUES ROW_CPY;
          --INSERTAMOS DOCUMENTOS
       --   OPEN CUR_DOC_EJER_ROW;
    --      FETCH CUR_DOC_EJER_ROW INTO ROW_CPY_DOC;
     ---     CLOSE CUR_DOC_EJER_ROW;
          FOR ROW_CPY_DOC in CUR_DOC_EJER_ROW
            LOOP
                ROW_CPY_DOC.ID_EJERCICIO_ROW  :=var_seq_doc;
                ROW_CPY_DOC.ID_META_ROW := var_seq;
                INSERT INTO PENDIUM_EJERCICIO_SOCIAL_TAB
                VALUES ROW_CPY_DOC;
            END LOOP;
        --  ROW_CPY_DOC.ID_EJERCICIO_ROW  :=var_seq_doc;
         -- ROW_CPY_DOC.ID_META_ROW := var_seq;
          --INSERT INTO PENDIUM_EJERCICIO_SOCIAL_TAB
          --VALUES ROW_CPY_DOC;
          --UPDATE DERCORP_METATBL_TAB SET VAL_C149 =
          --WHERE ID_META_ROW = var_seq;
      END   CPY_AES_PR;
END DERCORP_FUSION_CPY_PKG;
/;
