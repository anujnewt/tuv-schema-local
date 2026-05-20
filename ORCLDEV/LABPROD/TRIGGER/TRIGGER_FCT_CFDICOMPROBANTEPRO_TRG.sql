-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_cfdicomprobantepro_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_cfdicomprobantepro_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT nextval('cfdicomprobantepro_seq') INTO STRICT NEW.idComprobantePro;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
