-- dmap_object_gen_tag : type : table name : mail
set search_path = labprod,oracle,dmap_extension,public;
create table "mail"  (
usuario varchar(60),
emp_keyemp numeric(38),
email varchar(50)
) ;
