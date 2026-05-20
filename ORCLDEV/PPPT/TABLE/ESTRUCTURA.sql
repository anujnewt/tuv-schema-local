-- dmap_object_gen_tag : type : table name : estructura
set search_path = pppt,oracle,dmap_extension,public;
create table "estructura"  (
idestructura numeric(38) not null,
estructura varchar(100) not null,
idestructuranivel numeric(38) not null default 0,
idestructurapadre numeric(38) not null default 0,
clave varchar(50),
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : estructura
set search_path = pppt,oracle,dmap_extension,public;
alter table estructura alter column idestructura set not null;
-- dmap_object_gen_tag : type : alter table name : estructura
set search_path = pppt,oracle,dmap_extension,public;
alter table estructura alter column estructura set not null;
-- dmap_object_gen_tag : type : alter table name : estructura
set search_path = pppt,oracle,dmap_extension,public;
alter table estructura alter column idestructuranivel set not null;
-- dmap_object_gen_tag : type : alter table name : estructura
set search_path = pppt,oracle,dmap_extension,public;
alter table estructura alter column idestructurapadre set not null;
-- dmap_object_gen_tag : type : alter table name : estructura
set search_path = pppt,oracle,dmap_extension,public;
alter table estructura alter column idempresa set not null;
