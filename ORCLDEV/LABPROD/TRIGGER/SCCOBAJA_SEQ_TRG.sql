-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : sccobaja_seq_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS sccobaja_seq_trg ON sccobaja CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : sccobaja_seq_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "sccobaja_seq_trg"
BEFORE INSERT ON sccobaja FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_sccobaja_seq_trg();
