-- dmap_object_gen_tag : type : table name : nmloconc
set search_path = labprod,oracle,dmap_extension,public;
create table "nmloconc"  (
con_keycon varchar(3) not null,
con_descon varchar(30) not null,
con_descor varchar(10),
con_keyfor varchar(4),
con_leeinc varchar(1),
con_leedfi varchar(1),
con_leepre varchar(1),
con_leeacu varchar(1),
con_leedfc varchar(1),
con_codimp varchar(2),
con_codacu varchar(2),
con_codval varchar(2),
con_uniini decimal(12, 2),
con_unifin decimal(12, 2),
con_impini decimal(12, 2),
con_impfin decimal(12, 2),
con_ctaref varchar(20),
con_ctaaux varchar(20),
con_nu1aux varchar(10),
con_nu2aux varchar(10),
con_ca1aux varchar(10),
con_ca2aux varchar(10),
con_forval varchar(4),
con_porcen decimal(12, 2),
con_leeaus varchar(1),
con_leeben varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloconc
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloconc add constraint nmconc01 unique (con_keycon);
-- dmap_object_gen_tag : type : alter table name : nmloconc
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloconc alter column con_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : nmloconc
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloconc alter column con_descon set not null;
