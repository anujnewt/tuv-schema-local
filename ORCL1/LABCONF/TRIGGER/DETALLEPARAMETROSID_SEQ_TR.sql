-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : detalleparametrosid_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS detalleparametrosid_seq_tr ON detalleparametros CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : detalleparametrosid_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "detalleparametrosid_seq_tr"
BEFORE INSERT ON labconf.detalleparametros FOR EACH ROW
WHEN (NULLIF(NEW.IdDetalle::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_detalleparametrosid_seq_tr();
