-- dmap_object_gen_tag : type : table name : captipocurso
set search_path = pppt,oracle,dmap_extension,public;
create table "captipocurso"  (
idtipocurso numeric(38) not null default 0,
tipocurso varchar(100) not null,
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : captipocurso
set search_path = pppt,oracle,dmap_extension,public;
alter table captipocurso alter column idtipocurso set not null;
-- dmap_object_gen_tag : type : alter table name : captipocurso
set search_path = pppt,oracle,dmap_extension,public;
alter table captipocurso alter column tipocurso set not null;
-- dmap_object_gen_tag : type : alter table name : captipocurso
set search_path = pppt,oracle,dmap_extension,public;
alter table captipocurso alter column idempresa set not null;
