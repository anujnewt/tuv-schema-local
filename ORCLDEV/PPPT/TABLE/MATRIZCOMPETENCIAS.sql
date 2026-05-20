-- dmap_object_gen_tag : type : table name : matrizcompetencias
set search_path = pppt,oracle,dmap_extension,public;
create table "matrizcompetencias"  (
idcompetencia numeric(38) not null,
idprueba numeric(38) not null,
dominancia varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : matrizcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table matrizcompetencias alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : matrizcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table matrizcompetencias alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : matrizcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table matrizcompetencias alter column dominancia set not null;
