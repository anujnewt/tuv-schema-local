CREATE OR REPLACE NONEDITIONABLE TRIGGER "USRDRC"."LOG_FLASH" 
BEFORE UPDATE OF VAL_VALOR ON USRDRC.DERCORP_ADD_CAMPO_VALOR_TAB 
FOR EACH ROW
     WHEN (NEW.id_add_campo = 500) BEGIN

BEGIN



   INSERT
          INTO LOG_FLAS_TAB
            (
              VALOR_ANTERIOR,
              VALOR_ACTUAL,
              CREATION_DATE,
              NOM_DENOMINACION_ACTUAL,
              NOM_DENOMINACION_ANTERIOR
            )
            VALUES
            (
              :old.val_valor,
              :new.val_valor,
              SYSDATE,
              (SELECT VAL_CAT_VAL 
                FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB 
                  WHERE id_catalogo = 1
                  AND id_catalogo_valor = :new.val_valor),
              (SELECT VAL_CAT_VAL 
                FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB 
                  WHERE id_catalogo = 1
                  AND id_catalogo_valor = :old.val_valor)
            );
 EXCEPTION
      WHEN OTHERS THEN
       INSERT INTO LOG_FLAS_TAB
            (VALOR_ANTERIOR)
       VALUES('ERROR AL INSERTAR');
    END;      
END;


/
ALTER TRIGGER "USRDRC"."LOG_FLASH" ENABLE;
