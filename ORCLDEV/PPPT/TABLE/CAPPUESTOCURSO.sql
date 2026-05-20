-- dmap_object_gen_tag : type : table name : cappuestocurso
set search_path = pppt,oracle,dmap_extension,public;
create table "cappuestocurso"  (
idpuesto numeric(38) not null,
idcurso numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cappuestocurso
set search_path = pppt,oracle,dmap_extension,public;
alter table cappuestocurso alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : cappuestocurso
set search_path = pppt,oracle,dmap_extension,public;
alter table cappuestocurso alter column idcurso set not null;
