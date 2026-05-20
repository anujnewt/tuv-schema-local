-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trigger_sips_empl()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trigger_sips_empl() RETURNS trigger AS $BODY$
BEGIN
select nextval('sips_empl') into STRICT NEW.ora_noctvo;
RETURN NEW;
end
$BODY$
 LANGUAGE 'plpgsql';
