-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : increment_comparativo
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS increment_comparativo ON comparativo CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : increment_comparativo
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "increment_comparativo"
BEFORE INSERT ON comparativo "LABPROD"."INCREMENT_COMPARATIVO"
BEFORE INSERT
ON LABPROD.comparativo
REFERENCING NEW AS NEW
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_increment_comparativo();
