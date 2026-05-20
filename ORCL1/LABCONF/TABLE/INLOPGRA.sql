-- dmap_object_gen_tag : type : table name : inlopgra
set search_path = labconf,oracle,dmap_extension,public;
create table "inlopgra"  (
pgr_keypgr numeric(5),
pgr_despgr varchar(30),
pgr_regpgr varchar(25),
pgr_tippgr varchar(1),
pgr_ca1aux varchar(10),
pgr_ca2aux varchar(10),
pgr_ca3aux varchar(10),
pgr_observ varchar(1),
pgr_keydep varchar(16),
pgr_keypue varchar(16)
) ;
