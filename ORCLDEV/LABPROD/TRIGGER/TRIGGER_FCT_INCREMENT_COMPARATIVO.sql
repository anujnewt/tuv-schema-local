-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_increment_comparativo()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_increment_comparativo() RETURNS trigger AS $BODY$
BEGIN
     SELECT nextval('seq_comparativo') INTO STRICT NEW.ID_comp;
   RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
