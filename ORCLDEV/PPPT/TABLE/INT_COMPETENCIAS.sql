-- dmap_object_gen_tag : type : table name : int_competencias
set search_path = pppt,oracle,dmap_extension,public;
create table "int_competencias"  (
idcompetencia numeric(38) not null,
competencia varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : int_competencias
set search_path = pppt,oracle,dmap_extension,public;
alter table int_competencias alter column idcompetencia set not null;
