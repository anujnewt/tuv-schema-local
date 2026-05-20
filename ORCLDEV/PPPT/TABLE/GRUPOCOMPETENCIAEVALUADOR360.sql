-- dmap_object_gen_tag : type : table name : grupocompetenciaevaluador360
set search_path = pppt,oracle,dmap_extension,public;
create table "grupocompetenciaevaluador360"  (
idgrupo numeric(38) not null,
tipoentidad numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : grupocompetenciaevaluador360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupocompetenciaevaluador360 alter column idgrupo set not null;
-- dmap_object_gen_tag : type : alter table name : grupocompetenciaevaluador360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupocompetenciaevaluador360 alter column tipoentidad set not null;
-- dmap_object_gen_tag : type : alter table name : grupocompetenciaevaluador360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupocompetenciaevaluador360 alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : grupocompetenciaevaluador360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupocompetenciaevaluador360 alter column nivel set not null;
