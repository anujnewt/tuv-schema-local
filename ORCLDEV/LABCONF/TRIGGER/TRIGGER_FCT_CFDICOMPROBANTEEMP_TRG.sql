-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_cfdicomprobanteemp_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_cfdicomprobanteemp_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT nextval('cfdicomprobanteemp_seq') INTO STRICT NEW.idComprobanteEmp;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
