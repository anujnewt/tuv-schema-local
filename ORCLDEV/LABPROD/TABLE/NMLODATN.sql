-- dmap_object_gen_tag : type : table name : nmlodatn
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlodatn"  (
dat_keycfg varchar(5),
dat_keycia varchar(2),
dat_keypro numeric(10),
dat_keydep varchar(16),
dat_nomfor varchar(30),
dat_nomela varchar(30),
dat_nomaut varchar(30),
dat_visbue varchar(30)
) ;
