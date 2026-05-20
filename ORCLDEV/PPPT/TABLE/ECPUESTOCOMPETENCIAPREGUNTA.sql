-- dmap_object_gen_tag : type : table name : ecpuestocompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "ecpuestocompetenciapregunta"  (
idpuestopregunta numeric(38) not null default 0,
idpuesto numeric(38) not null,
idcompetenciapregunta numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : ecpuestocompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpuestocompetenciapregunta alter column idpuestopregunta set not null;
-- dmap_object_gen_tag : type : alter table name : ecpuestocompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpuestocompetenciapregunta alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : ecpuestocompetenciapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpuestocompetenciapregunta alter column idcompetenciapregunta set not null;
