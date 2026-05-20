-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_dominio_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS admp_dominio_bi_tr_01 ON admp_dominio_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_dominio_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
CREATE TRIGGER "admp_dominio_bi_tr_01"
BEFORE INSERT ON admp_dominio_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_admp_dominio_bi_tr_01();
