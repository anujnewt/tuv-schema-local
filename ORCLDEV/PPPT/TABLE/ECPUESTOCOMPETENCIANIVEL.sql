-- dmap_object_gen_tag : type : table name : ecpuestocompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
create table "ecpuestocompetencianivel"  (
idpuesto numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
npnivel numeric(38) default 0,
npinferior numeric(38) default 0,
npsuperior numeric(38) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : ecpuestocompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpuestocompetencianivel alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : ecpuestocompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpuestocompetencianivel alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : ecpuestocompetencianivel
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpuestocompetencianivel alter column nivel set not null;
