-- dmap_object_gen_tag : type : table name : entidadevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
create table "entidadevaluacion360"  (
idgrupoentidad numeric(38) not null,
idparametroevaluacion numeric(38) not null,
tipoevaluacion numeric(38) not null,
identidad1 numeric(38) not null,
identidad2 numeric(38) not null,
status numeric(38),
valor numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : entidadevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table entidadevaluacion360 alter column idgrupoentidad set not null;
-- dmap_object_gen_tag : type : alter table name : entidadevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table entidadevaluacion360 alter column idparametroevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : entidadevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table entidadevaluacion360 alter column tipoevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : entidadevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table entidadevaluacion360 alter column identidad1 set not null;
-- dmap_object_gen_tag : type : alter table name : entidadevaluacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table entidadevaluacion360 alter column identidad2 set not null;
