-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvcapdes_u()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvcapdes_u() RETURNS trigger AS $BODY$
BEGIN
        insert into tvcapdes_i(movimiento,old_pde_keyemp,
    old_pde_recurp,old_pde_fecmov,old_pde_capnew,old_pde_fecant,old_pde_capant,
    old_pde_status,old_pde_horant,old_pde_hormov,new_pde_keyemp,new_pde_recurp,
    new_pde_fecmov,new_pde_capnew,new_pde_fecant,new_pde_capant,new_pde_status,
    new_pde_horant,new_pde_hormov,orderid1,orderid2)  values ('update'
     ,OLD.pde_keyemp ,OLD.pde_recurp ,OLD.pde_fecmov ,OLD.pde_capnew
    ,OLD.pde_fecant ,OLD.pde_capant ,OLD.pde_status ,OLD.pde_horant ,
    OLD.pde_hormov ,NEW.pde_keyemp ,NEW.pde_recurp ,NEW.pde_fecmov 
    ,NEW.pde_capnew ,NEW.pde_fecant ,NEW.pde_capant ,NEW.pde_status 
    ,NEW.pde_horant ,NEW.pde_hormov, statement_timestamp() ,0 );
    RETURN NEW;
end
$BODY$
 LANGUAGE 'plpgsql';
