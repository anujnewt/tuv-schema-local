-- dmap_object_gen_tag : type : table name : nivelperfilcompetencia
set search_path = pppt,oracle,dmap_extension,public;
create table "nivelperfilcompetencia"  (
idempresa numeric(38) not null,
idnivel numeric(38) not null,
idcompetencia numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nivelperfilcompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfilcompetencia alter column idempresa set not null;
-- dmap_object_gen_tag : type : alter table name : nivelperfilcompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfilcompetencia alter column idnivel set not null;
-- dmap_object_gen_tag : type : alter table name : nivelperfilcompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table nivelperfilcompetencia alter column idcompetencia set not null;
