-- dmap_object_gen_tag : type : table name : inlopcap
set search_path = labconf,oracle,dmap_extension,public;
create table "inlopcap"  (
pca_keypca numeric(5),
pca_keycia varchar(2),
pca_regpla varchar(25),
pca_fecini timestamp(0),
pca_fecfin timestamp(0),
pca_ca1aux varchar(10),
pca_ca2aux varchar(10),
pca_ca3aux varchar(10),
pca_tippla varchar(1)
) ;
