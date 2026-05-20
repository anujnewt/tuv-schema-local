-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : usuarios_insertar
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS usuarios_insertar ON usuarioempleado CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : usuarios_insertar
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE TRIGGER "usuarios_insertar"
BEFORE INSERT ON usuarioempleado FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_usuarios_insertar();
