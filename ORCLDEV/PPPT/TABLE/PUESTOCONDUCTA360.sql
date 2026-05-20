-- dmap_object_gen_tag : type : table name : puestoconducta360
set search_path = pppt,oracle,dmap_extension,public;
create table "puestoconducta360"  (
idpuestoconducta numeric(38) not null default 0,
idpuesto numeric(38) not null,
idconducta numeric(38) not null,
peso numeric(38) not null,
idpuestocompetencia numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : puestoconducta360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoconducta360 alter column idpuestoconducta set not null;
-- dmap_object_gen_tag : type : alter table name : puestoconducta360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoconducta360 alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestoconducta360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoconducta360 alter column idconducta set not null;
-- dmap_object_gen_tag : type : alter table name : puestoconducta360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoconducta360 alter column peso set not null;
-- dmap_object_gen_tag : type : alter table name : puestoconducta360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoconducta360 alter column idpuestocompetencia set not null;
