-- dmap_object_gen_tag : type : table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
create table "tvpretar"  (
tar_keyemp numeric(38) not null,
tar_tpopro numeric(38) not null,
tar_status numeric(38) not null,
tar_fecha char(10) not null,
tar_hora char(8) not null,
tar_importe decimal(12, 2) not null,
tar_nombre varchar(70) not null,
tar_usuario numeric(38),
tar_auxc char(60),
tar_auxn numeric(38),
tar_idnnum numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar add primary key (tar_keyemp,tar_tpopro,tar_status);
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_tpopro set not null;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_status set not null;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_fecha set not null;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_hora set not null;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_importe set not null;
-- dmap_object_gen_tag : type : alter table name : tvpretar
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpretar alter column tar_nombre set not null;
