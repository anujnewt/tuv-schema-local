-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_pend_update_contacto_tr()
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_pend_update_contacto_tr() RETURNS trigger AS $BODY$
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
IF OLD.id_catalogo = 56
THEN
   --IF :new.DES_CAT_VAL != :OLD.DES_CAT_VAL
   --THEN
        --Tipo de Contacto
        UPDATE USRDRC.DERCORP_METATBL_TAB SET VAL_C2 = NEW.DES_CAT_VAL
        WHERE id_flex_tbl = 1
        AND val_c1 = OLD.ID_CATALOGO_VALOR;
        --Telefono
        UPDATE USRDRC.DERCORP_METATBL_TAB SET VAL_C3 = NEW.atributo1
        WHERE id_flex_tbl = 1
        AND val_c1 = OLD.ID_CATALOGO_VALOR;
        --Correo
        UPDATE USRDRC.DERCORP_METATBL_TAB SET VAL_C5 = NEW.atributo3
        WHERE id_flex_tbl = 1
        AND val_c1 = OLD.ID_CATALOGO_VALOR;
   --END IF;
END IF;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
