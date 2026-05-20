-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_tipo_elemento_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS admp_tipo_elemento_bi_tr_01 ON admp_tipo_elemento_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_tipo_elemento_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
CREATE TRIGGER "admp_tipo_elemento_bi_tr_01"
BEFORE INSERT ON admp_tipo_elemento_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_admp_tipo_elemento_bi_tr_01();
