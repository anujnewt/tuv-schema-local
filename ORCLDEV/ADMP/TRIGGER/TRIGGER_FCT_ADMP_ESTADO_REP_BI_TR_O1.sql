-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_estado_rep_bi_tr_o1()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_estado_rep_bi_tr_o1() RETURNS trigger AS $BODY$
BEGIN
    SELECT nextval('admp_estado_rep_sq') INTO STRICT NEW.ID_ESTADO_REP;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
