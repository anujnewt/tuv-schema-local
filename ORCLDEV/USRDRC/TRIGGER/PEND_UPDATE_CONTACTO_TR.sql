CREATE OR REPLACE NONEDITIONABLE TRIGGER "USRDRC"."PEND_UPDATE_CONTACTO_TR" AFTER UPDATE
ON USRDRC.DERCORP_ADD_CAMPO_CAT_VAL_TAB REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
/******************************************************************************
   NAME     : Jose de Jesus Argumedo Q.
   PURPOSE  : Actualizar el catalogo de Contactos en todas sus referencias de la metatbl
   REVISIONS: 1
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14/12/2016  JJAQ             1. Created this trigger.

   NOTES:


*******************************************************************************/
BEGIN
IF :OLD.id_catalogo = 56
THEN
   --IF :new.DES_CAT_VAL != :OLD.DES_CAT_VAL
   --THEN
        --Tipo de Contacto
        UPDATE USRDRC.DERCORP_METATBL_TAB SET VAL_C2 = :new.DES_CAT_VAL
        WHERE id_flex_tbl = 1
        AND val_c1 = :OLD.ID_CATALOGO_VALOR;
        --Telefono
        UPDATE USRDRC.DERCORP_METATBL_TAB SET VAL_C3 = :new.atributo1
        WHERE id_flex_tbl = 1
        AND val_c1 = :OLD.ID_CATALOGO_VALOR;

        --Correo
        UPDATE USRDRC.DERCORP_METATBL_TAB SET VAL_C5 = :new.atributo3
        WHERE id_flex_tbl = 1
        AND val_c1 = :OLD.ID_CATALOGO_VALOR;
   --END IF;
END IF;
END;


/
ALTER TRIGGER "USRDRC"."PEND_UPDATE_CONTACTO_TR" ENABLE;
