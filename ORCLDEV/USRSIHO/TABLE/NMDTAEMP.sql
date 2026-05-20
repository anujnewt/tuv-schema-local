-- dmap_object_gen_tag : type : table name : nmdtaemp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmdtaemp"  (
aem_keyemp numeric(10) not null,
aem_keydep varchar(16),
aem_keypue varchar(16),
aem_tipem2 numeric(10),
aem_keyem2 numeric(10),
aem_tipemp numeric(10),
aem_keytco numeric(10),
aem_keyfol numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmdtaemp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmdtaemp add constraint pk_nmdtaemp primary key (aem_keyemp);
