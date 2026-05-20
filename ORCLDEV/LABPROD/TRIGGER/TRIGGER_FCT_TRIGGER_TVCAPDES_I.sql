-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trigger_tvcapdes_i()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trigger_tvcapdes_i() RETURNS trigger AS $BODY$
BEGIN
select nextval('sequ_capdes_i') into STRICT NEW.ORDERID2;
RETURN NEW;
end
$BODY$
 LANGUAGE 'plpgsql';
