-- dmap_object_gen_tag : type : table name : eccompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "eccompetenciapregunta"  (
idcompetenciapregunta numeric(38) not null default 0,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
pregunta varchar(4000) not null
) ;
-- dmap_object_gen_tag : type : alter table name : eccompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table eccompetenciapregunta alter column idcompetenciapregunta set not null;
-- dmap_object_gen_tag : type : alter table name : eccompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table eccompetenciapregunta alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : eccompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table eccompetenciapregunta alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : eccompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table eccompetenciapregunta alter column pregunta set not null;
