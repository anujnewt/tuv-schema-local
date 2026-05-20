-- dmap_object_gen_tag : type : table name : glcodigo
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcodigo"  (
cod_keyemp numeric(10) not null,
cod_keypro numeric(5),
cod_nombre varchar(40),
cod_apllpa varchar(40),
cod_apllma varchar(40)
) ;
-- dmap_object_gen_tag : type : alter table name : glcodigo
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcodigo alter column cod_keyemp set not null;
