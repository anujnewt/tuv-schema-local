-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_comparativo
SET search_path = labppto,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS t_comparativo ON comparativo CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_comparativo
SET search_path = labppto,oracle,dmap_extension,public;
CREATE TRIGGER "t_comparativo"
BEFORE INSERT ON comparativo "LABPPTO"."T_COMPARATIVO" BEFORE
INSERT ON "LABPPTO".comparativo REFERENCING NEW AS NEW FOR EACH ROW  FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_t_comparativo();
