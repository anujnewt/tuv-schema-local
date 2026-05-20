-- dmap_object_gen_tag : type : table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "evacatpregunta"  (
idpregunta numeric(38) not null default 0,
idempresa numeric(38) not null default 0,
idtema numeric(38) not null default 0,
idcompetencia numeric(38) not null default 0,
nivel numeric(38) not null default 1,
activa numeric(1) not null default 1,
casignada numeric(38) not null default 0,
pregunta varchar(4000) not null
) ;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column idempresa set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column idtema set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column activa set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column casignada set not null;
-- dmap_object_gen_tag : type : alter table name : evacatpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatpregunta alter column pregunta set not null;
