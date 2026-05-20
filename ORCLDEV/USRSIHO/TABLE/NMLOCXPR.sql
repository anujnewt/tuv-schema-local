-- dmap_object_gen_tag : type : table name : nmlocxpr
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlocxpr"  (
cxp_keypro numeric(5),
cxp_keynom numeric(5),
cxp_numsec numeric(5),
cxp_keycon varchar(3),
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
cxp_porcen decimal(12, 2)
) ;
