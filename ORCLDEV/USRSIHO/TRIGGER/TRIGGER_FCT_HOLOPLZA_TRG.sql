-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holoplza_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holoplza_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT nextval('holoplza_seq') INTO STRICT NEW.PLZ_CTVPLZ;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
