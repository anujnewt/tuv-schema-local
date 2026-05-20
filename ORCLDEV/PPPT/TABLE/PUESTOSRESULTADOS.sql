-- dmap_object_gen_tag : type : table name : puestosresultados
set search_path = pppt,oracle,dmap_extension,public;
create table "puestosresultados"  (
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
idresultado numeric(38) not null,
valor numeric,
valoraux numeric
) ;
-- dmap_object_gen_tag : type : alter table name : puestosresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table puestosresultados alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestosresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table puestosresultados alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : puestosresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table puestosresultados alter column idresultado set not null;
