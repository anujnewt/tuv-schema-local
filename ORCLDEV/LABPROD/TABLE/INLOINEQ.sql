-- dmap_object_gen_tag : type : table name : inloineq
set search_path = labprod,oracle,dmap_extension,public;
create table "inloineq"  (
ine_keyequ varchar(16),
ine_desequ varchar(40),
ine_marca varchar(20),
ine_modelo varchar(20),
ine_numser varchar(16),
ine_status varchar(6),
ine_fecsta timestamp(0),
ine_ca1aux varchar(10),
ine_ca2aux varchar(10),
ine_ca3aux varchar(10),
ine_ca4aux varchar(10)
) ;
