-- dmap_object_gen_tag : type : table name : catexperiencia
set search_path = pppt,oracle,dmap_extension,public;
create table "catexperiencia"  (
idexperiencia numeric(38) not null default 0,
experiencia varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : catexperiencia
set search_path = pppt,oracle,dmap_extension,public;
alter table catexperiencia alter column idexperiencia set not null;
