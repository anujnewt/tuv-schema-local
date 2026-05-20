-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_cambio_bi_tr_01()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_cambio_bi_tr_01() RETURNS trigger AS $BODY$
BEGIN
    SELECT nextval('admp_cambio_sq') INTO STRICT NEW.ID_CAMBIO;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
