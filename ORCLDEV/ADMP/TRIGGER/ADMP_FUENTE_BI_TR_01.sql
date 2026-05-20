-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_fuente_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS admp_fuente_bi_tr_01 ON admp_fuente_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_fuente_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
CREATE TRIGGER "admp_fuente_bi_tr_01"
BEFORE INSERT ON admp_fuente_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_admp_fuente_bi_tr_01();
