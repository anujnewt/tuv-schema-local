-- dmap_object_gen_tag : type : table name : tvpbincc
set search_path = labconf,oracle,dmap_extension,public;
create table "tvpbincc"  (
id numeric(10),
inc_keyemp numeric(10),
inc_diainc numeric(38),
inc_tipinc varchar(2),
inc_fecini timestamp(0),
inc_fecfin timestamp(0),
inc_fecmod timestamp(0)
) ;
