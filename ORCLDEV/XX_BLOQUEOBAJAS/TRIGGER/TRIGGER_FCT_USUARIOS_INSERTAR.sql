-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_usuarios_insertar()
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_usuarios_insertar() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('xx_bloqueobajas.usuario_seq')
  INTO STRICT NEW.IDUSUARIO
;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
