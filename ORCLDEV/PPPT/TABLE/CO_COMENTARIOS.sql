-- dmap_object_gen_tag : type : table name : co_comentarios
set search_path = pppt,oracle,dmap_extension,public;
create table "co_comentarios"  (
idcomentario numeric(38) not null default 0,
comentario varchar(255),
idcomentariorep numeric(38),
tipo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : co_comentarios
set search_path = pppt,oracle,dmap_extension,public;
alter table co_comentarios alter column idcomentario set not null;
