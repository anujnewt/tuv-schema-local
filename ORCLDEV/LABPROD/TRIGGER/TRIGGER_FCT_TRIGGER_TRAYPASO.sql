-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trigger_traypaso()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trigger_traypaso() RETURNS trigger AS $BODY$
BEGIN
select nextval('sequ_traypaso') into STRICT NEW.ora_noctvo;
RETURN NEW;
end
$BODY$
 LANGUAGE 'plpgsql';
