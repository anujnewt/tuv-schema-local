-- dmap_object_gen_tag : type : table name : capcursotipo
set search_path = pppt,oracle,dmap_extension,public;
create table "capcursotipo"  (
idcurso numeric(38) not null,
idtipocurso numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : capcursotipo
set search_path = pppt,oracle,dmap_extension,public;
alter table capcursotipo alter column idcurso set not null;
-- dmap_object_gen_tag : type : alter table name : capcursotipo
set search_path = pppt,oracle,dmap_extension,public;
alter table capcursotipo alter column idtipocurso set not null;
