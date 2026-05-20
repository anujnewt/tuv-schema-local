-- dmap_object_gen_tag : type : table name : caracteres
set search_path = usrsiho,oracle,dmap_extension,public;
create table "caracteres"  (
caracter varchar(1) not null,
descripcion varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : caracteres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table caracteres alter column caracter set not null;
-- dmap_object_gen_tag : type : alter table name : caracteres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table caracteres alter column descripcion set not null;
