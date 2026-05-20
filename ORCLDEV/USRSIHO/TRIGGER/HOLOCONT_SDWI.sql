-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_sdwi
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holocont_sdwi ON holocont CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_sdwi
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holocont_sdwi"
AFTER INSERT ON holocont "USRSIHO"."HOLOCONT_SDWI"
AFTER INSERT
ON USRSIHO.HOLOCONT
REFERENCING NEW AS New
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holocont_sdwi();
