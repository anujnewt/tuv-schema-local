-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_xxhr_act_plazas_lab_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_xxhr_act_plazas_lab_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT labprod.nextval('xxhr_act_plazas_lab_seq') INTO STRICT NEW.ID_LABORA;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
