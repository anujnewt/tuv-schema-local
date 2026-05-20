-- dmap_object_gen_tag : type : table name : detsolact
set search_path = usrsiho,oracle,dmap_extension,public;
create table "detsolact"  (
dsa_numsol numeric(10),
dsa_idereg numeric(10),
dsa_keyemp numeric(10),
dsa_nomart varchar(40),
dsa_person varchar(40),
dsa_sindicato varchar(12),
dsa_keypue varchar(16),
dsa_keynac varchar(20),
dsa_numcap varchar(60),
dsa_coment varchar(255),
dsa_stsreg numeric(10),
dsa_tipodis varchar(25),
dsa_revdis varchar(20),
dsa_numpet numeric(10),
dsa_numlla numeric(10),
dsa_npcanr numeric(10),
dsa_nreptra numeric(10)
) ;
