-- dmap_object_gen_tag : type : table name : nivelperfil
set search_path = pppt,oracle,dmap_extension,public;
create table "nivelperfil"  (
idnivel numeric(38) not null default 0,
nivel varchar(255) not null,
minimo numeric not null,
maximo numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : nivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfil alter column idnivel set not null;
-- dmap_object_gen_tag : type : alter table name : nivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfil alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : nivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfil alter column minimo set not null;
-- dmap_object_gen_tag : type : alter table name : nivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfil alter column maximo set not null;
