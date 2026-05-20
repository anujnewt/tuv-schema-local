-- dmap_object_gen_tag : type : table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcooana"  (
oan_nomvar varchar(3) not null,
oan_catalo varchar(10) not null,
oan_concep varchar(10) not null,
oan_alias numeric(5) not null,
oan_descri varchar(30) not null,
oan_nivjer numeric(5) not null,
oan_longit numeric(5) not null,
oan_pref01 numeric(5),
oan_pref02 numeric(5),
oan_pref03 numeric(5),
oan_pref04 numeric(5),
oan_pref05 numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_nomvar set not null;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_catalo set not null;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_concep set not null;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_alias set not null;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_descri set not null;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_nivjer set not null;
-- dmap_object_gen_tag : type : alter table name : nmcooana
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcooana alter column oan_longit set not null;
