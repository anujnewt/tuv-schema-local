-- dmap_object_gen_tag : type : table name : nmlocxpr
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlocxpr"  (
cxp_keypro numeric(5) not null,
cxp_keynom numeric(5) not null,
cxp_numsec numeric(5),
cxp_keycon varchar(3) not null,
cxp_keyfor varchar(4),
cxp_leeinc varchar(1),
cxp_leedfi varchar(1),
cxp_leedfc varchar(1),
cxp_leepre varchar(1),
cxp_leeacu varchar(1),
cxp_codacu varchar(2),
cxp_codimp varchar(2),
cxp_codval varchar(2),
cxp_uniini decimal(12, 2),
cxp_unifin decimal(12, 2),
cxp_impini decimal(12, 2),
cxp_impfin decimal(12, 2),
cxp_forval varchar(4),
cxp_porcen decimal(12, 2),
cxp_leeaus varchar(1),
cxp_leeben varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlocxpr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocxpr alter column cxp_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmlocxpr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocxpr alter column cxp_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : nmlocxpr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocxpr alter column cxp_keycon set not null;
