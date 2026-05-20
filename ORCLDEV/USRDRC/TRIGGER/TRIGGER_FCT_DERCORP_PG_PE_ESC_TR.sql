-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_dercorp_pg_pe_esc_tr()
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_dercorp_pg_pe_esc_tr() RETURNS trigger AS $BODY$
DECLARE
BEGIN
    IF (NEW.VAL_C8 <>'N/A') THEN
       UPDATE DERCORP_APODERADOS_TAB
       SET         DES_ESCRITURA = NEW.VAL_C8
       WHERE  ID_EMPRESA       = NEW.ID_EMPRESA
       AND       DES_ESCRITURA = OLD.VAL_C8;
    END IF;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
