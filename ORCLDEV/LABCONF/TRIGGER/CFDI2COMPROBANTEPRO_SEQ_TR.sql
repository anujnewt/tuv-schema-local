-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2comprobantepro_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2comprobantepro_seq_tr ON cfdi2comprobantepro CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2comprobantepro_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2comprobantepro_seq_tr"
BEFORE INSERT ON labconf.cfdi2comprobantepro FOR EACH ROW
WHEN (NULLIF(NEW.idComprobantePro::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2comprobantepro_seq_tr();
