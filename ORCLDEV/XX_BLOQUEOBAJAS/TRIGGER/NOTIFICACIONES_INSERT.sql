-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : notificaciones_insert
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS notificaciones_insert ON notificaciones CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : notificaciones_insert
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE TRIGGER "notificaciones_insert"
BEFORE INSERT ON notificaciones FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_notificaciones_insert();
