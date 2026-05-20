-- dmap_object_gen_tag : type : table name : emmodulo
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emmodulo"  (
mod_keymod numeric(10) not null,
mod_descri varchar(60) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emmodulo
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmodulo alter column mod_keymod set not null;
-- dmap_object_gen_tag : type : alter table name : emmodulo
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmodulo alter column mod_descri set not null;
