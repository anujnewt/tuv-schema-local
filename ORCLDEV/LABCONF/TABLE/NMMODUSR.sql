-- dmap_object_gen_tag : type : table name : nmmodusr
set search_path = labconf,oracle,dmap_extension,public;
create table "nmmodusr"  (
usr_keyusr varchar(5),
usr_nomusr char(35),
usr_passwd char(10)
) ;
