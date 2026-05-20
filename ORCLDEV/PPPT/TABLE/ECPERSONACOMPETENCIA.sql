-- dmap_object_gen_tag : type : table name : ecpersonacompetencia
set search_path = pppt,oracle,dmap_extension,public;
create table "ecpersonacompetencia"  (
identrevista numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null default 0,
resultado numeric not null default 0,
compatibilidad numeric not null default 0,
comentarios varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : ecpersonacompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonacompetencia alter column identrevista set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonacompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonacompetencia alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonacompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonacompetencia alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonacompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonacompetencia alter column resultado set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonacompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonacompetencia alter column compatibilidad set not null;
