-- dmap_object_gen_tag : type : table name : xxchk_catalogo_bancos
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_catalogo_bancos"  (
id_banco numeric(38) not null,
descripcion_banco varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_catalogo_bancos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_catalogo_bancos add constraint pk_xxchk_catalogo_bancos primary key (id_banco);
-- dmap_object_gen_tag : type : alter table name : xxchk_catalogo_bancos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_catalogo_bancos alter column id_banco set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_catalogo_bancos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_catalogo_bancos alter column descripcion_banco set not null;
