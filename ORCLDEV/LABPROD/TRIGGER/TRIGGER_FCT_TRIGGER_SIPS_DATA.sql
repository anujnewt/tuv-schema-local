-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trigger_sips_data()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trigger_sips_data() RETURNS trigger AS $BODY$
BEGIN
select nextval('sips_data') into STRICT NEW.ora_noctvo;
RETURN NEW;
end
$BODY$
 LANGUAGE 'plpgsql';
