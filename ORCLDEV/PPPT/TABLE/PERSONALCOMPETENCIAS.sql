-- dmap_object_gen_tag : type : table name : personalcompetencias
set search_path = pppt,oracle,dmap_extension,public;
create table "personalcompetencias"  (
idpersonal numeric(38) not null,
idcompetencia numeric(38) not null,
valor0 numeric not null,
valor1 numeric not null,
valor2 numeric not null,
porcentaje0 numeric,
porcentaje1 numeric,
porcentaje2 numeric
) ;
-- dmap_object_gen_tag : type : alter table name : personalcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table personalcompetencias alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table personalcompetencias alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : personalcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table personalcompetencias alter column valor0 set not null;
-- dmap_object_gen_tag : type : alter table name : personalcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table personalcompetencias alter column valor1 set not null;
-- dmap_object_gen_tag : type : alter table name : personalcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table personalcompetencias alter column valor2 set not null;
