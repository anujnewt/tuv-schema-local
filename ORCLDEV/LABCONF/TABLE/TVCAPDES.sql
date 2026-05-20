-- dmap_object_gen_tag : type : table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
create table "tvcapdes"  (
pde_keyemp numeric(38) not null,
pde_recurp char(18) not null,
pde_fecmov timestamp(0) not null,
pde_capnew decimal(16, 2) not null,
pde_fecant timestamp(0) not null,
pde_capant decimal(16, 2) not null,
pde_status numeric(38) not null,
pde_horant char(10) not null,
pde_hormov char(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_recurp set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_fecmov set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_capnew set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_fecant set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_capant set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_status set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_horant set not null;
-- dmap_object_gen_tag : type : alter table name : tvcapdes
set search_path = labconf,oracle,dmap_extension,public;
alter table tvcapdes alter column pde_hormov set not null;
