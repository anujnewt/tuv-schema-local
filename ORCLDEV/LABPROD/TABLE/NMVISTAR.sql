-- dmap_object_gen_tag : type : table name : nmvistar
set search_path = labprod,oracle,dmap_extension,public;
create table "nmvistar"  (
vis_folio numeric(5) not null,
vis_keyemp numeric(10) not null,
vis_feccap timestamp(0),
vis_tipmov char(2),
vis_fecmov timestamp(0) not null,
vis_obser1 varchar(50),
vis_obser2 varchar(50),
vis_status char(1),
vis_keyusr varchar(5),
vis_cantid decimal(5, 2),
vis_cctoan char(16),
vis_cctoac char(16),
vis_gpoant varchar(10),
vis_codact varchar(16),
vis_codant varchar(16),
vis_gpo varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmvistar
set search_path = labprod,oracle,dmap_extension,public;
alter table nmvistar alter column vis_folio set not null;
-- dmap_object_gen_tag : type : alter table name : nmvistar
set search_path = labprod,oracle,dmap_extension,public;
alter table nmvistar alter column vis_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmvistar
set search_path = labprod,oracle,dmap_extension,public;
alter table nmvistar alter column vis_fecmov set not null;
