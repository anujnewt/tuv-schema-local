-- dmap_object_gen_tag : type : table name : folios_cont
set search_path = usrsiho,oracle,dmap_extension,public;
create table "folios_cont"  (
fol_keypol numeric(10) not null,
fol_keyfol numeric(6) not null
) ;
-- dmap_object_gen_tag : type : alter table name : folios_cont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table folios_cont alter column fol_keypol set not null;
-- dmap_object_gen_tag : type : alter table name : folios_cont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table folios_cont alter column fol_keyfol set not null;
