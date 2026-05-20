-- dmap_object_gen_tag : type : table name : glcoresu
set search_path = labconf,oracle,dmap_extension,public;
create table "glcoresu"  (
res_idepro varchar(10),
res_idepcc varchar(15),
res_keyusu numeric(10),
res_fecini timestamp(0),
res_fecfin timestamp(0),
res_horini varchar(8),
res_horfin varchar(8),
res_horreg varchar(8),
res_numreg numeric(10),
res_totreg numeric(10),
res_status varchar(1),
res_sqlerr numeric(10),
res_isaerr numeric(10),
res_deserr varchar(2000)
) ;
