-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_contrato_memo_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS admp_contrato_memo_bi_tr_01 ON admp_contrato_memo_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_contrato_memo_bi_tr_01
SET search_path = admp,oracle,dmap_extension,public;
CREATE TRIGGER "admp_contrato_memo_bi_tr_01"
BEFORE INSERT ON admp_contrato_memo_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_admp_contrato_memo_bi_tr_01();
