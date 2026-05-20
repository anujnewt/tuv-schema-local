-- dmap_object_gen_tag : type : table name : nmlocate
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlocate"  (
cat_keycat varchar(16) not null,
cat_descat varchar(40) not null,
cat_refcon varchar(20),
cat_nu1aux varchar(10),
cat_nu2aux varchar(10),
cat_nu3aux varchar(10),
cat_nu4aux varchar(10),
cat_nu5aux varchar(10),
cat_ca1aux varchar(10),
cat_ca2aux varchar(10),
cat_ca3aux varchar(10),
cat_ca4aux varchar(10),
cat_ca5aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlocate
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocate add constraint nmcate01 unique (cat_keycat);
-- dmap_object_gen_tag : type : alter table name : nmlocate
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocate alter column cat_keycat set not null;
-- dmap_object_gen_tag : type : alter table name : nmlocate
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocate alter column cat_descat set not null;
