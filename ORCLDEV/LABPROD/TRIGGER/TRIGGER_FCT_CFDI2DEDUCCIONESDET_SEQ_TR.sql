-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_cfdi2deduccionesdet_seq_tr()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_cfdi2deduccionesdet_seq_tr() RETURNS trigger AS $BODY$
BEGIN
 SELECT nextval('labprod.cfdi2deduccionesdetalle_seq') INTO STRICT NEW.idDeduccion;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
