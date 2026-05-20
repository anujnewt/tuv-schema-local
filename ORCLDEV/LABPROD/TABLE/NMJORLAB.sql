-- dmap_object_gen_tag : type : table name : nmjorlab
set search_path = labprod,oracle,dmap_extension,public;
create table "nmjorlab"  (
jor_keyjor numeric(38) not null,
jor_hrsdia decimal(5,2) not null,
jor_hrssem decimal(5,2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmjorlab
set search_path = labprod,oracle,dmap_extension,public;
alter table nmjorlab add primary key (jor_keyjor);
-- dmap_object_gen_tag : type : alter table name : nmjorlab
set search_path = labprod,oracle,dmap_extension,public;
alter table nmjorlab alter column jor_hrsdia set not null;
-- dmap_object_gen_tag : type : alter table name : nmjorlab
set search_path = labprod,oracle,dmap_extension,public;
alter table nmjorlab alter column jor_hrssem set not null;
