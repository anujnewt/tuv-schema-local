-- dmap_object_gen_tag : type : table name : co_personalcomentario
set search_path = pppt,oracle,dmap_extension,public;
create table "co_personalcomentario"  (
idpersonalcomentario numeric(38) not null default 0,
idpersonal numeric(38),
idcomentario numeric(38),
anio numeric(38),
tipo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : co_personalcomentario
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalcomentario alter column idpersonalcomentario set not null;
