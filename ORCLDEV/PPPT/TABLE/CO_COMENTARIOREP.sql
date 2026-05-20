-- dmap_object_gen_tag : type : table name : co_comentariorep
set search_path = pppt,oracle,dmap_extension,public;
create table "co_comentariorep"  (
idcomentariorep numeric(38) not null default 0,
comentariorep varchar(255),
tipo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : co_comentariorep
set search_path = pppt,oracle,dmap_extension,public;
alter table co_comentariorep alter column idcomentariorep set not null;
