-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_detalleparametrosid_seq_tr()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_detalleparametrosid_seq_tr() RETURNS trigger AS $BODY$
BEGIN
 SELECT nextval('usrsiho.detalleparametrosid_seq') INTO STRICT NEW.IdDetalle;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
