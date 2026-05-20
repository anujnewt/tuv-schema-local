-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvlofini_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvlofini_trg() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('tvlofini_seq') INTO STRICT NEW.FIN_KEYFIN;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
