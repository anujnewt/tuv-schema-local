-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_t_com_sips_orac_empl()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_t_com_sips_orac_empl() RETURNS trigger AS $BODY$
BEGIN
     SELECT nextval('s_com_sips_orac_empl') INTO STRICT NEW.ora_ctvo;
   RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
