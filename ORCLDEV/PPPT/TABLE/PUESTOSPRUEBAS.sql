-- dmap_object_gen_tag : type : table name : puestospruebas
set search_path = pppt,oracle,dmap_extension,public;
create table "puestospruebas"  (
idpuestoprueba numeric(38) not null default 0,
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
peso numeric,
observaciones varchar(4000),
aux numeric(38),
opciones varchar(255),
resultado varchar(255),
auxiliar varchar(255),
bdirecto numeric(1) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : puestospruebas
set search_path = pppt,oracle,dmap_extension,public;
alter table puestospruebas alter column idpuestoprueba set not null;
-- dmap_object_gen_tag : type : alter table name : puestospruebas
set search_path = pppt,oracle,dmap_extension,public;
alter table puestospruebas alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestospruebas
set search_path = pppt,oracle,dmap_extension,public;
alter table puestospruebas alter column idprueba set not null;
