-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : increment_comparativo
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS increment_comparativo ON comparativo CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : increment_comparativo
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "increment_comparativo"
BEFORE INSERT ON comparativo "LABCONF"."INCREMENT_COMPARATIVO"
BEFORE INSERT
ON LABCONF.comparativo
REFERENCING NEW AS NEW
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_increment_comparativo();
