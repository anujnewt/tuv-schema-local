-- dmap_object_gen_tag : type : table name : nmlosema
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlosema"  (
sem_keysem varchar(6) not null,
sem_numani varchar(4) not null,
sem_numsem varchar(2) not null,
sem_fecini timestamp(0) not null,
sem_fecfin timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmlosema
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlosema alter column sem_keysem set not null;
-- dmap_object_gen_tag : type : alter table name : nmlosema
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlosema alter column sem_numani set not null;
-- dmap_object_gen_tag : type : alter table name : nmlosema
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlosema alter column sem_numsem set not null;
-- dmap_object_gen_tag : type : alter table name : nmlosema
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlosema alter column sem_fecini set not null;
-- dmap_object_gen_tag : type : alter table name : nmlosema
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlosema alter column sem_fecfin set not null;
