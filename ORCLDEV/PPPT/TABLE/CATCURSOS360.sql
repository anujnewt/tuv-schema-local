-- dmap_object_gen_tag : type : table name : catcursos360
set search_path = pppt,oracle,dmap_extension,public;
create table "catcursos360"  (
idcurso numeric(38) not null default 0,
curso varchar(255) not null,
interno numeric(38),
duracion numeric(38),
temario varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : catcursos360
set search_path = pppt,oracle,dmap_extension,public;
alter table catcursos360 alter column idcurso set not null;
-- dmap_object_gen_tag : type : alter table name : catcursos360
set search_path = pppt,oracle,dmap_extension,public;
alter table catcursos360 alter column curso set not null;
