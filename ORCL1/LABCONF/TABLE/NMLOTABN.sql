-- dmap_object_gen_tag : type : table name : nmlotabn
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlotabn"  (
tab_keytab varchar(3),
tab_sectab numeric(10),
tab_eleuno decimal(18, 6),
tab_eledos decimal(18, 6),
tab_eletre decimal(18, 6),
tab_elecua decimal(18, 6)
) ;
