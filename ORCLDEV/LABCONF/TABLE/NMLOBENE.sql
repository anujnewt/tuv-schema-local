-- dmap_object_gen_tag : type : table name : nmlobene
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlobene"  (
ben_keyemp numeric(10),
ben_keyben numeric(5),
ben_comfam numeric(5),
ben_rfcben varchar(13),
ben_nomben varchar(60),
ben_fecnac timestamp(0),
ben_cvesex varchar(1),
ben_tippar varchar(2),
ben_keyban varchar(7),
ben_ctaban varchar(16),
ben_keydep varchar(16),
ben_keycen varchar(16),
ben_nomtut varchar(60),
ben_ca1aux varchar(10),
ben_ca2aux varchar(10)
) ;
