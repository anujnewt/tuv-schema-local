-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_t_pppagrales()
SET search_path = labppto,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_t_pppagrales() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('s_pppagrales') INTO STRICT NEW.gra_keysec;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
