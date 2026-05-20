CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABCONF"."TVCAPDES_U" 
   before update on LABCONF.tvcapdes 
    for each row
    begin
        insert into tvcapdes_i (movimiento,old_pde_keyemp,
    old_pde_recurp,old_pde_fecmov,old_pde_capnew,old_pde_fecant,old_pde_capant,
    old_pde_status,old_pde_horant,old_pde_hormov,new_pde_keyemp,new_pde_recurp,
    new_pde_fecmov,new_pde_capnew,new_pde_fecant,new_pde_capant,new_pde_status,
    new_pde_horant,new_pde_hormov,orderid1,orderid2)  values ('update'
     ,:old.pde_keyemp ,:old.pde_recurp ,:old.pde_fecmov ,:old.pde_capnew 
    ,:old.pde_fecant ,:old.pde_capant ,:old.pde_status ,:old.pde_horant ,
    :old.pde_hormov ,:new.pde_keyemp ,:new.pde_recurp ,:new.pde_fecmov 
    ,:new.pde_capnew ,:new.pde_fecant ,:new.pde_capant ,:new.pde_status 
    ,:new.pde_horant ,:new.pde_hormov, sysdate ,0 );
    end;



/
ALTER TRIGGER "LABCONF"."TVCAPDES_U" ENABLE;
