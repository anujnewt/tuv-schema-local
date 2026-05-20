-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : eolohplz_seq_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS eolohplz_seq_trg ON eolohplz CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : eolohplz_seq_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "eolohplz_seq_trg"
BEFORE INSERT ON eolohplz FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_eolohplz_seq_trg();
