-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_com_sips_orac_empl
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS t_com_sips_orac_empl ON com_sips_orac_empl CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_com_sips_orac_empl
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "t_com_sips_orac_empl"
BEFORE INSERT ON com_sips_orac_empl "LABCONF"."T_COM_SIPS_ORAC_EMPL"
BEFORE INSERT
ON LABCONF.com_sips_orac_empl
REFERENCING NEW AS NEW
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_t_com_sips_orac_empl();
