-- dmap_object_gen_tag : type : table name : ttcpregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "ttcpregunta"  (
idpregunta numeric(38) not null,
pregunta varchar(4000) not null,
idcompetencia numeric(38) not null,
secuencia numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : ttcpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcpregunta alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : ttcpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcpregunta alter column pregunta set not null;
-- dmap_object_gen_tag : type : alter table name : ttcpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcpregunta alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : ttcpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcpregunta alter column secuencia set not null;
