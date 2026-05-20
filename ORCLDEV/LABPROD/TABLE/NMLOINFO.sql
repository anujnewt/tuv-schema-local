-- dmap_object_gen_tag : type : table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
create table "nmloinfo"  (
id numeric(38) not null,
inf_keyemp numeric(10) not null,
inf_tipmov varchar(2) not null,
inf_fecmov timestamp(0) not null,
inf_tipdes varchar(1) not null,
inf_valdes decimal(10, 4) not null,
inf_reginf varchar(12),
inf_feccap timestamp(0) not null,
inf_horcap varchar(8) not null,
inf_keyusu numeric(5) not null,
inf_perini varchar(7)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column id set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_tipmov set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_fecmov set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_tipdes set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_valdes set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_feccap set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_horcap set not null;
-- dmap_object_gen_tag : type : alter table name : nmloinfo
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloinfo alter column inf_keyusu set not null;
