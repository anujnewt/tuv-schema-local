-- dmap_object_gen_tag : type : table name : glcopams_aux
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcopams_aux"  (
pam_keypar varchar(4),
pam_cvesec varchar(6),
pam_nompar varchar(40),
pam_folini varchar(16),
pam_folfin varchar(16)
) ;
