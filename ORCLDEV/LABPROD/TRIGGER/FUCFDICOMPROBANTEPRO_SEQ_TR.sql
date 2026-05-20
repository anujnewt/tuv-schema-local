-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fucfdicomprobantepro_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS fucfdicomprobantepro_seq_tr ON fucfdicomprobantepro CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fucfdicomprobantepro_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "fucfdicomprobantepro_seq_tr"  BEFORE
INSERT ON labprod.fucfdicomprobantepro FOR EACH ROW
WHEN (NULLIF(NEW.idComprobantePro::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_fucfdicomprobantepro_seq_tr();
