-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tr_det_capinc()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tr_det_capinc() RETURNS trigger AS $BODY$
BEGIN SELECT nextval('det_capinc_seq01') INTO STRICT NEW.det_numid;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
