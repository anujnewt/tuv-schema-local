-- dmap_object_gen_tag : type : table name : catareainteres
set search_path = pppt,oracle,dmap_extension,public;
create table "catareainteres"  (
idareainteres numeric(38) not null default 0,
areainteres varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : catareainteres
set search_path = pppt,oracle,dmap_extension,public;
alter table catareainteres alter column idareainteres set not null;
