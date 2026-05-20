-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_estado_rep_bi_tr_o1
SET search_path = admp,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS admp_estado_rep_bi_tr_o1 ON admp_estado_rep_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : admp_estado_rep_bi_tr_o1
SET search_path = admp,oracle,dmap_extension,public;
CREATE TRIGGER "admp_estado_rep_bi_tr_o1"
BEFORE INSERT ON admp_estado_rep_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_admp_estado_rep_bi_tr_o1();
