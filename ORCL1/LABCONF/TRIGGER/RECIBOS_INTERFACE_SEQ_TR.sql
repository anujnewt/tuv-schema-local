-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : recibos_interface_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS recibos_interface_seq_tr ON recibos_interface CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : recibos_interface_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "recibos_interface_seq_tr"
BEFORE INSERT ON labconf.recibos_interface FOR EACH ROW
WHEN (
NULLIF(NEW.ID::text, '') IS NULL
)
EXECUTE PROCEDURE trigger_fct_recibos_interface_seq_tr();
