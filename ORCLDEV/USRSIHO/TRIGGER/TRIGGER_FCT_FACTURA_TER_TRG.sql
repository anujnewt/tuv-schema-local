-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_factura_ter_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_factura_ter_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column POLIZA
  NEW.POLIZA := nextval('factura_ter_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
