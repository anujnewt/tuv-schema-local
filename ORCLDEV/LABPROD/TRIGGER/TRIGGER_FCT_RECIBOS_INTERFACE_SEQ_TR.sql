-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_recibos_interface_seq_tr()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_recibos_interface_seq_tr() RETURNS trigger AS $BODY$
BEGIN
 SELECT nextval('labprod.recibos_interface_seq') INTO STRICT NEW.ID;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
