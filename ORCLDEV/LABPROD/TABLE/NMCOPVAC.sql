-- dmap_object_gen_tag : type : table name : nmcopvac
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcopvac"  (
pva_keypro numeric(38) not null,
pva_plapre decimal(4, 2),
pva_connom varchar(3) not null,
pva_stapas varchar(1) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmcopvac
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcopvac alter column pva_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmcopvac
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcopvac alter column pva_connom set not null;
-- dmap_object_gen_tag : type : alter table name : nmcopvac
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcopvac alter column pva_stapas set not null;
