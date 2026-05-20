-- dmap_object_gen_tag : type : table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
create table "det_capinc"  (
det_numid numeric(10) not null,
det_cvedia varchar(2) not null,
det_keyusu varchar(18) not null,
det_keyemp numeric(38) not null,
det_keysem numeric(38) not null,
det_ccosto varchar(18),
det_ent varchar(5),
det_sal varchar(5),
det_concep varchar(3),
det_fecha timestamp(0) not null,
det_horas decimal(10, 2) not null,
det_impor decimal(16, 2),
det_cveinc varchar(2),
det_xytech numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_numid set not null;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_cvedia set not null;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_keysem set not null;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_fecha set not null;
-- dmap_object_gen_tag : type : alter table name : det_capinc
set search_path = labprod,oracle,dmap_extension,public;
alter table det_capinc alter column det_horas set not null;
