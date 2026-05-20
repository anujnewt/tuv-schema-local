-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_sdwu
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holocont_sdwu ON holocont CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_sdwu
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holocont_sdwu"
AFTER UPDATE ON holocont "USRSIHO"."HOLOCONT_SDWU"
AFTER UPDATE
ON USRSIHO.HOLOCONT
REFERENCING NEW AS pos OLD AS pre
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holocont_sdwu();
