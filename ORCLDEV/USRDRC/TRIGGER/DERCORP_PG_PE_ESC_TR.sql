-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : dercorp_pg_pe_esc_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS dercorp_pg_pe_esc_tr ON dercorp_metatbl_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : dercorp_pg_pe_esc_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "dercorp_pg_pe_esc_tr"
BEFORE UPDATE OF VAL_C8 ON usrdrc.dercorp_metatbl_tab FOR EACH ROW
WHEN ((NEW.ID_FLEX_TBL  =17)OR (NEW.ID_FLEX_TBL =18))
EXECUTE PROCEDURE trigger_fct_dercorp_pg_pe_esc_tr();
