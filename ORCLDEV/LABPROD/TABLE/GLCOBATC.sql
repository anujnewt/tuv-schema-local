-- dmap_object_gen_tag : type : table name : glcobatc
set search_path = labprod,oracle,dmap_extension,public;
create table "glcobatc"  (
bat_idepro varchar(10),
bat_idepcc varchar(15),
bat_keyusu numeric(10),
bat_fecini timestamp(0),
bat_horini varchar(8),
bat_logusu varchar(15),
bat_keymen varchar(4),
bat_status varchar(1),
bat_valpro varchar(5),
bat_keynom numeric(5)
) ;
