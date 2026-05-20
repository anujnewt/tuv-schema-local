-- dmap_object_gen_tag : type : table name : cfdiperiodos
set search_path = usrsiho,oracle,dmap_extension,public;
create table "cfdiperiodos"  (
per_keypro numeric(5),
per_keynom numeric(5),
per_keyper varchar(7),
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0)
) ;
