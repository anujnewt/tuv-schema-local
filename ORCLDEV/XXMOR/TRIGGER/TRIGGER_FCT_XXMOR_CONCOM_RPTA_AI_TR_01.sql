-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_xxmor_concom_rpta_ai_tr_01()
SET search_path = xxmor,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_xxmor_concom_rpta_ai_tr_01() RETURNS trigger AS $BODY$
BEGIN
DECLARE
tmpVar NUMBER;
V_RPTA_CONCOM xxmor_Funcional_pkg_Mor_Rpta_Concom_Type;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
