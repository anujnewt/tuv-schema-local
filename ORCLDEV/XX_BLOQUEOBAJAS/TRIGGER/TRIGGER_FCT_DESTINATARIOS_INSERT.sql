-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_destinatarios_insert()
SET search_path = xx_bloqueobajas,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_destinatarios_insert() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('xx_bloqueobajas.destinatarios_seq')
  INTO STRICT NEW.IDDESTINATARIO
;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
