-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trigger_ap_sipros()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trigger_ap_sipros() RETURNS trigger AS $BODY$
BEGIN
     SELECT emp_keypro,emp_status INTO STRICT NEW.SOI_KEYPRO,NEW.SOI_STATUS FROM nmcoempl WHERE emp_keyemp = NEW.SOI_KEYEMP;
   RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
