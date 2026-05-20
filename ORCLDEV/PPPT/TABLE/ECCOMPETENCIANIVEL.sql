-- dmap_object_gen_tag : type : table name : eccompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
create table "eccompetencianivel"  (
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
titulo char(150),
descripcion varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : eccompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
alter table eccompetencianivel alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : eccompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
alter table eccompetencianivel alter column nivel set not null;
