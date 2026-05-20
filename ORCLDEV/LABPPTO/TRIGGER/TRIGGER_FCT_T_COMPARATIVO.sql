-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_t_comparativo()
SET search_path = labppto,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_t_comparativo() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('s_comparativo') INTO STRICT NEW.id_comp;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
