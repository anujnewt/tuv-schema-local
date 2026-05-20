-- dmap_object_gen_tag : type : table name : tvcapdes
set search_path = labprod,oracle,dmap_extension,public;
create table "tvcapdes"  (
pde_keyemp numeric(38),
pde_recurp char(18),
pde_fecmov timestamp(0),
pde_capnew decimal(16, 2),
pde_fecant timestamp(0),
pde_capant decimal(16, 2),
pde_status numeric(38),
pde_horant char(10),
pde_hormov char(10)
) ;
