-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_udn_bi_tr_o1
SET search_path = admp,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS admp_udn_bi_tr_o1 ON admp_udn_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_udn_bi_tr_o1
SET search_path = admp,oracle,dmap_extension,public;
CREATE TRIGGER "admp_udn_bi_tr_o1"
BEFORE INSERT ON admp_udn_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_admp_udn_bi_tr_o1();
