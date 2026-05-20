-- dmap_object_gen_tag : type : table name : aud_nmlohism
set search_path = usrsiho,oracle,dmap_extension,public;
create table "aud_nmlohism"  (
diayhora timestamp,
usuario varchar(8) not null,
ant_ca1aux varchar(16),
des_ca1aux varchar(16)
) ;
-- dmap_object_gen_tag : type : alter table name : aud_nmlohism
set search_path = usrsiho,oracle,dmap_extension,public;
alter table aud_nmlohism alter column usuario set not null;
