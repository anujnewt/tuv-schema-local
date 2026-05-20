-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : recibos_generacion_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS recibos_generacion_seq_tr ON recibos_generacion CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : recibos_generacion_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "recibos_generacion_seq_tr"
BEFORE INSERT ON labconf.recibos_generacion FOR EACH ROW
WHEN (
NULLIF(NEW.ID::text, '') IS NULL
)
EXECUTE PROCEDURE trigger_fct_recibos_generacion_seq_tr();
