-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_hologdpr_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_hologdpr_trg() RETURNS trigger AS $BODY$
BEGIN
    SELECT nextval('hologdpr_seq') INTO STRICT NEW.GDP_KEYSEC;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
