-- dmap_object_gen_tag : type : table name : hist_datos
set search_path = labconf,oracle,dmap_extension,public;
create table "hist_datos"  (
hid_anio numeric(38) not null,
hid_mes numeric(38) not null,
hid_keypro numeric(38) not null,
hid_keyemp numeric(38) not null,
hid_keydep varchar(16),
hid_tpoemp numeric(38),
hid_vicrh varchar(16),
hid_viccon varchar(16),
hid_keyplz numeric(38),
hid_keypue varchar(16)
) ;
-- dmap_object_gen_tag : type : alter table name : hist_datos
set search_path = labconf,oracle,dmap_extension,public;
alter table hist_datos add primary key (hid_anio,hid_mes,hid_keypro,hid_keyemp);
-- dmap_object_gen_tag : type : alter table name : hist_datos
set search_path = labconf,oracle,dmap_extension,public;
alter table hist_datos alter column hid_anio set not null;
-- dmap_object_gen_tag : type : alter table name : hist_datos
set search_path = labconf,oracle,dmap_extension,public;
alter table hist_datos alter column hid_mes set not null;
-- dmap_object_gen_tag : type : alter table name : hist_datos
set search_path = labconf,oracle,dmap_extension,public;
alter table hist_datos alter column hid_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : hist_datos
set search_path = labconf,oracle,dmap_extension,public;
alter table hist_datos alter column hid_keyemp set not null;
