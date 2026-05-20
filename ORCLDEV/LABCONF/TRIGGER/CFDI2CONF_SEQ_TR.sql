-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2conf_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2conf_seq_tr ON cfdi2conf CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2conf_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2conf_seq_tr"
BEFORE INSERT ON labconf.cfdi2conf FOR EACH ROW
WHEN (NULLIF(NEW.idConfig::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2conf_seq_tr();
