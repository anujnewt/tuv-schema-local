-- dmap_object_gen_tag : type : table name : ecpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "ecpersonapregunta"  (
idpersonapregunta numeric(38) not null default 0,
identrevista numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
respuesta numeric(38),
pregunta varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : ecpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapregunta alter column idpersonapregunta set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapregunta alter column identrevista set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapregunta alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapregunta alter column nivel set not null;
