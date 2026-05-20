-- dmap_object_gen_tag : type : table name : tvpbvacc
set search_path = labconf,oracle,dmap_extension,public;
create table "tvpbvacc"  (
id numeric(10),
vac_keyemp numeric(10),
vac_diavac numeric(38),
vac_fecini timestamp(0),
vac_fecfin timestamp(0),
vac_fecmod timestamp(0)
) ;
