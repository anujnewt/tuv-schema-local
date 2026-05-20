-- dmap_object_gen_tag : type : table name : evalpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "evalpersonapregunta"  (
idpersonaevaluacion numeric(38) not null,
idpregunta numeric(38) not null,
idseccion numeric(38) not null,
idopcion numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : evalpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersonapregunta alter column idpersonaevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersonapregunta alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersonapregunta alter column idseccion set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersonapregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersonapregunta alter column idopcion set not null;
