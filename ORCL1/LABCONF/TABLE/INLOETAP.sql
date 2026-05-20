-- dmap_object_gen_tag : type : table name : inloetap
set search_path = labconf,oracle,dmap_extension,public;
create table "inloetap"  (
eta_keypca numeric(5),
eta_keycia varchar(2),
eta_keyeta numeric(5),
eta_fecini timestamp(0),
eta_fecfin timestamp(0)
) ;
