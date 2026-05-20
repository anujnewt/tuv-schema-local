-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holofrph_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holofrph_trg() RETURNS trigger AS $BODY$
BEGIN
      IF ( NEW.FRP_KEYRPH IS NULL or NEW.FRP_KEYRPH = 0 ) then
        SELECT nextval('holofrph_seq') INTO STRICT NEW.FRP_KEYRPH;
      end if;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
