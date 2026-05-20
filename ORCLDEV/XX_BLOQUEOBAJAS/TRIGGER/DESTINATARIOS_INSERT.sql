-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : destinatarios_insert
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS destinatarios_insert ON destinatarios CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : destinatarios_insert
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE TRIGGER "destinatarios_insert"
BEFORE INSERT ON destinatarios FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_destinatarios_insert();
