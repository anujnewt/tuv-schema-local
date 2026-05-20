-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_cfdipagos_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_cfdipagos_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column IDCOMPROBANTEEMP
  NEW.IDCOMPROBANTEEMP := nextval('cfdipagos_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
