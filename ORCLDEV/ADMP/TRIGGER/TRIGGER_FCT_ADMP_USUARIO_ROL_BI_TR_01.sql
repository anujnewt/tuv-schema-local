-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_usuario_rol_bi_tr_01()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_usuario_rol_bi_tr_01() RETURNS trigger AS $BODY$
BEGIN
    SELECT nextval('admp_usuario_rol_sq') INTO STRICT NEW.ID_USUARIO_ROL;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
