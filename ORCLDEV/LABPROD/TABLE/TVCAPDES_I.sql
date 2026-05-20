-- dmap_object_gen_tag : type : table name : tvcapdes_i
set search_path = labprod,oracle,dmap_extension,public;
create table "tvcapdes_i"  (
movimiento varchar(10) not null,
marca varchar(2),
old_pde_keyemp numeric(38),
old_pde_recurp varchar(18),
old_pde_fecmov timestamp(0),
old_pde_capnew numeric(16),
old_pde_fecant timestamp(0),
old_pde_capant numeric(16),
old_pde_status numeric(38),
old_pde_horant varchar(10),
old_pde_hormov varchar(10),
new_pde_keyemp numeric(38),
new_pde_recurp varchar(18),
new_pde_fecmov timestamp(0),
new_pde_capnew numeric(16),
new_pde_fecant timestamp(0),
new_pde_capant numeric(16),
new_pde_status numeric(38),
new_pde_horant varchar(10),
new_pde_hormov varchar(10),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvcapdes_i
set search_path = labprod,oracle,dmap_extension,public;
alter table tvcapdes_i alter column movimiento set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes_i
set search_path = labprod,oracle,dmap_extension,public;
alter table tvcapdes_i alter column orderid2 set not null;
