-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_t_nmcoempl_sdw()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_t_nmcoempl_sdw() RETURNS trigger AS $BODY$
BEGIN
     SELECT nextval('s_nmcoempl_sdw') INTO STRICT NEW.orderid2;
   RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
