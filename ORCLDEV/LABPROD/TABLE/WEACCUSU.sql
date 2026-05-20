-- dmap_object_gen_tag : type : table name : weaccusu
set search_path = labprod,oracle,dmap_extension,public;
create table "weaccusu"  (
usu_keyemp numeric(38) not null,
wea_keyemp varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : weaccusu
set search_path = labprod,oracle,dmap_extension,public;
alter table weaccusu add primary key (usu_keyemp);
