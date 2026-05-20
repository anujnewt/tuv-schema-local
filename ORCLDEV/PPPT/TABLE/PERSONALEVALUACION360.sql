-- dmap_object_gen_tag : type : table name : personalevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
create table "personalevaluacion360"  (
idpersonal numeric(38) not null,
idgrupo numeric(38) not null,
idgrupoentidad numeric(38) not null,
idcompetencia numeric(38) not null,
jefe numeric(38),
pares numeric(38),
subordinados numeric(38),
clientes numeric(38),
clientesexternos numeric(38),
autoevaluacion numeric(38),
idconducta numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : personalevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table personalevaluacion360 alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table personalevaluacion360 alter column idgrupo set not null;
-- dmap_object_gen_tag : type : alter table name : personalevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table personalevaluacion360 alter column idgrupoentidad set not null;
-- dmap_object_gen_tag : type : alter table name : personalevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table personalevaluacion360 alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : personalevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table personalevaluacion360 alter column idconducta set not null;
