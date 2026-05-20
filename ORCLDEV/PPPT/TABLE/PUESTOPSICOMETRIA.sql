-- dmap_object_gen_tag : type : table name : puestopsicometria
set search_path = pppt,oracle,dmap_extension,public;
create table "puestopsicometria"  (
idpuesto numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : puestopsicometria
set search_path = pppt,oracle,dmap_extension,public;
alter table puestopsicometria alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestopsicometria
set search_path = pppt,oracle,dmap_extension,public;
alter table puestopsicometria alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : puestopsicometria
set search_path = pppt,oracle,dmap_extension,public;
alter table puestopsicometria alter column nivel set not null;
