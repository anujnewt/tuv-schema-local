-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tri_pppagrales()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tri_pppagrales() RETURNS trigger AS $BODY$
BEGIN
select nextval('sec_pppagrales') into STRICT NEW.gra_keysec;
RETURN NEW;
end
$BODY$
 LANGUAGE 'plpgsql';
