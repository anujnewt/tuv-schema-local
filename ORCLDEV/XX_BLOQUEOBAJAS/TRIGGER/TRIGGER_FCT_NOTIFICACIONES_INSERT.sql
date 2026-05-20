-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_notificaciones_insert()
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_notificaciones_insert() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('xx_bloqueobajas.notificaciones_seq')
  INTO STRICT NEW.IDNOTIFICACION
;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
