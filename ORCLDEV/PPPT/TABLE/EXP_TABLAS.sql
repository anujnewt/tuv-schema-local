-- dmap_object_gen_tag : type : table name : exp_tablas
set search_path = pppt,oracle,dmap_extension,public;
create table "exp_tablas"  (
idcatalogo numeric(38) not null,
tipo numeric(38) not null,
tabla varchar(50) not null,
id varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : exp_tablas
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_tablas alter column idcatalogo set not null;
-- dmap_object_gen_tag : type : alter table name : exp_tablas
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_tablas alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : exp_tablas
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_tablas alter column tabla set not null;
-- dmap_object_gen_tag : type : alter table name : exp_tablas
set search_path = pppt,oracle,dmap_extension,public;
alter table exp_tablas alter column id set not null;
