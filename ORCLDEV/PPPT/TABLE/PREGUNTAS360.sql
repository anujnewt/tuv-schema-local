-- dmap_object_gen_tag : type : table name : preguntas360
set search_path = pppt,oracle,dmap_extension,public;
create table "preguntas360"  (
idpregunta numeric(38) not null default 0,
pregunta varchar(255) not null,
evaluadores varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : preguntas360
set search_path = pppt,oracle,dmap_extension,public;
alter table preguntas360 alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : preguntas360
set search_path = pppt,oracle,dmap_extension,public;
alter table preguntas360 alter column pregunta set not null;
