-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_com_sips_orac_bita
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS t_com_sips_orac_bita ON com_sips_orac_bita CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_com_sips_orac_bita
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "t_com_sips_orac_bita"
BEFORE INSERT ON com_sips_orac_bita "LABCONF"."T_COM_SIPS_ORAC_BITA"
BEFORE INSERT
ON LABCONF.com_sips_orac_bita
REFERENCING NEW AS NEW
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_t_com_sips_orac_bita();
