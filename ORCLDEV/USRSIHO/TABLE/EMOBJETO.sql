-- dmap_object_gen_tag : type : table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emobjeto"  (
obj_keypro varchar(10) not null,
obj_nomfrm varchar(20) not null,
obj_nomobj varchar(60) not null,
obj_keyobj numeric(10) not null,
obj_desobj varchar(60) not null,
obj_perfil varchar(1) not null,
obj_evento varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emobjeto alter column obj_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emobjeto alter column obj_nomfrm set not null;
-- dmap_object_gen_tag : type : alter table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emobjeto alter column obj_nomobj set not null;
-- dmap_object_gen_tag : type : alter table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emobjeto alter column obj_keyobj set not null;
-- dmap_object_gen_tag : type : alter table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emobjeto alter column obj_desobj set not null;
-- dmap_object_gen_tag : type : alter table name : emobjeto
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emobjeto alter column obj_perfil set not null;
