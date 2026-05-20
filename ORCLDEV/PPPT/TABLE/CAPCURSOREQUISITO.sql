-- dmap_object_gen_tag : type : table name : capcursorequisito
set search_path = pppt,oracle,dmap_extension,public;
create table "capcursorequisito"  (
idcurso numeric(38) not null,
idcursorequerido numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : capcursorequisito
set search_path = pppt,oracle,dmap_extension,public;
alter table capcursorequisito alter column idcurso set not null;
-- dmap_object_gen_tag : type : alter table name : capcursorequisito
set search_path = pppt,oracle,dmap_extension,public;
alter table capcursorequisito alter column idcursorequerido set not null;
