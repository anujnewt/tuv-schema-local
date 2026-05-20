-- dmap_object_gen_tag : type : table name : sccobaja
set search_path = labconf,oracle,dmap_extension,public;
create table "sccobaja"  (
baj_keyemp numeric(5),
baj_fecbaj timestamp(0),
baj_feccap timestamp(0),
baj_cvebaj varchar(2),
baj_cvemot varchar(2),
baj_status varchar(2),
baj_keyusu numeric(5),
baj_fecims timestamp(0),
baj_numliq varchar(6),
baj_perbaj varchar(7),
baj_traemp numeric(38),
baj_trapro numeric(5)
) ;
