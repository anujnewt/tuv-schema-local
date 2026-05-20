-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_t_com_sips_orac_bita()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_t_com_sips_orac_bita() RETURNS trigger AS $BODY$
BEGIN
     SELECT nextval('s_com_sips_orac_bita') INTO STRICT NEW.bit_noctvo;
   RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
