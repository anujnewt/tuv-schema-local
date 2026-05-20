-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_nmproche_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_nmproche_trg() RETURNS trigger AS $BODY$
BEGIN
        SELECT nextval('labprod.nmproche_seq') INTO STRICT NEW.ID;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
