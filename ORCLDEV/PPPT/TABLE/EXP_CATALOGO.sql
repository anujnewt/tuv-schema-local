-- dmap_object_gen_tag : type : table name : exp_catalogo
set search_path = pppt,oracle,dmap_extension,public;
create table "exp_catalogo"  (
idcatalogo numeric(38) not null,
catalogo varchar(50) not null,
id varchar(50) not null,
nombre varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : exp_catalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_catalogo alter column idcatalogo set not null;
-- dmap_object_gen_tag : type : alter table name : exp_catalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_catalogo alter column catalogo set not null;
-- dmap_object_gen_tag : type : alter table name : exp_catalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_catalogo alter column id set not null;
-- dmap_object_gen_tag : type : alter table name : exp_catalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_catalogo alter column nombre set not null;
