-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : solicitudes_insert
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS solicitudes_insert ON solicitudes CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : solicitudes_insert
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE TRIGGER "solicitudes_insert"
BEFORE INSERT ON solicitudes FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_solicitudes_insert();
