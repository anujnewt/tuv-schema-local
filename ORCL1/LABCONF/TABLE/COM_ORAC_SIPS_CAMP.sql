-- dmap_object_gen_tag : type : table name : com_orac_sips_camp
set search_path = labconf,oracle,dmap_extension,public;
create table "com_orac_sips_camp"  (
cam_tablas varchar(18) not null,
cam_campos varchar(18) not null,
cam_activo char(1) not null
) ;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_camp
set search_path = labconf,oracle,dmap_extension,public;
alter table com_orac_sips_camp alter column cam_tablas set not null;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_camp
set search_path = labconf,oracle,dmap_extension,public;
alter table com_orac_sips_camp alter column cam_campos set not null;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_camp
set search_path = labconf,oracle,dmap_extension,public;
alter table com_orac_sips_camp alter column cam_activo set not null;
