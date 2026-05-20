-- dmap_object_gen_tag : type : table name : glcopams
set search_path = labconf,oracle,dmap_extension,public;
create table "glcopams"  (
pam_keypar varchar(4),
pam_cvesec varchar(6),
pam_nompar varchar(200),
pam_folini varchar(100),
pam_folfin varchar(100)
) ;
