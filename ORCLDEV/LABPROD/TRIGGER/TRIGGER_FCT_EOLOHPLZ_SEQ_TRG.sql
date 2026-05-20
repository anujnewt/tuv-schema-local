-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_eolohplz_seq_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_eolohplz_seq_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.id, nextval('labprod.eolohplz_seq')) INTO STRICT NEW.id;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
