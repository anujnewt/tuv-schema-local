-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_reporte_bi_tr_01()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_reporte_bi_tr_01() RETURNS trigger AS $BODY$
BEGIN
	SELECT nextval('admp_reporte_sq') INTO STRICT NEW.ID_REPORTE;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
