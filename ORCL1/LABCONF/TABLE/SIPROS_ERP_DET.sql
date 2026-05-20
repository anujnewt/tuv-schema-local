-- dmap_object_gen_tag : type : table name : sipros_erp_det
set search_path = labconf,oracle,dmap_extension,public;
create table "sipros_erp_det"  (
apd_keypol varchar(30),
apd_fecpol timestamp(0),
apd_numlin numeric(38),
apd_ciaemi varchar(3),
segment1 varchar(3),
apd_cveban varchar(20),
apd_cvecta varchar(1),
segment2 varchar(2),
segment3 varchar(3),
segment4 varchar(6),
segment5 varchar(8),
segment6 varchar(3),
segment7 varchar(1),
apd_tipmov varchar(1),
apd_import decimal(16, 2),
apd_progas varchar(1),
apd_keyemp numeric(38),
apd_keylot varchar(20),
apd_auxnu1 numeric(38),
apd_auxca1 varchar(20),
apd_caietu numeric(38)
) ;
