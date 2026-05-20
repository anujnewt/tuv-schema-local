-- dmap_object_gen_tag : type : table name : nmcoestr
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcoestr"  (
est_nomvar varchar(3) not null,
est_nivjer numeric(5) not null,
est_cvecon varchar(20),
est_descri varchar(60) not null,
est_pref01 varchar(20),
est_pref02 varchar(20),
est_pref03 varchar(20),
est_pref04 varchar(20),
est_pref05 varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcoestr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcoestr alter column est_nomvar set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoestr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcoestr alter column est_nivjer set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoestr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcoestr alter column est_descri set not null;
