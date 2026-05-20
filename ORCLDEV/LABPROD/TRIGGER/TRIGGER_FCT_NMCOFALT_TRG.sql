-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_nmcofalt_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_nmcofalt_trg() RETURNS trigger AS $BODY$
BEGIN
      IF NEW.FAL_TIPIMS <> 'F' THEN
        LABPROD.call SP_NMREGINC(NEW.FAL_KEYEMP,
                        NEW.FAL_TIPIMS,
                        NEW.FAL_DIAINC,
                        NEW.FAL_FECINI);
      END IF;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
