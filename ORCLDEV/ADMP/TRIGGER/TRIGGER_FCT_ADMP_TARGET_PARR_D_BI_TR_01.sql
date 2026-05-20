-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_target_parr_d_bi_tr_01()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_target_parr_d_bi_tr_01() RETURNS trigger AS $BODY$
BEGIN
	SELECT nextval('admp_target_parr_det_sq') INTO STRICT NEW.ID_TARGET_PARR_DET;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
