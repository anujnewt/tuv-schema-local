-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_usuario_correo_bi_tr_01()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_usuario_correo_bi_tr_01() RETURNS trigger AS $BODY$
BEGIN
	SELECT nextval('admp_usuario_correo_sq') INTO STRICT NEW.ID_USUARIO_CORREO;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
