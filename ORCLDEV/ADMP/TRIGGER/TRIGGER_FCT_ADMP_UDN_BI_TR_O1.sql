-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_admp_udn_bi_tr_o1()
SET search_path = admp,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_admp_udn_bi_tr_o1() RETURNS trigger AS $BODY$
BEGIN
    SELECT nextval('admp_udn_sq') INTO STRICT NEW.ID_UDN;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
