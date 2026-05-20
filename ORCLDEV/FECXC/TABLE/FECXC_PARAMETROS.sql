-- dmap_object_gen_tag : type : table name : fecxc_parametros
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_parametros"  (
dias numeric(38) not null,
hora varchar(5) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_parametros
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_parametros alter column dias set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_parametros
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_parametros alter column hora set not null;
