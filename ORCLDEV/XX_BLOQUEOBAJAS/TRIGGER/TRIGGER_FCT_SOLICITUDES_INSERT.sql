-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_solicitudes_insert()
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_solicitudes_insert() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('xx_bloqueobajas.solicitudes_seq')
  INTO STRICT NEW.IDSOLICITUD
;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
