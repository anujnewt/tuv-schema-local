-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_xxhr_revertir_transf_lab_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_xxhr_revertir_transf_lab_trg() RETURNS trigger AS $BODY$
BEGIN
      IF NEW.ID_LABORA IS NULL THEN
        SELECT labprod.nextval('xxhr_revertir_transf_lab_seq') INTO STRICT NEW.ID_LABORA;
      END IF;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
