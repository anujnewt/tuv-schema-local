-- dmap_object_gen_tag : type : table name : catescolaridad
set search_path = pppt,oracle,dmap_extension,public;
create table "catescolaridad"  (
idescolaridad numeric(38) not null default 0,
escolaridad varchar(50),
especialidad numeric(38),
nivel numeric(38) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : catescolaridad
set search_path = pppt,oracle,dmap_extension,public;
alter table catescolaridad alter column idescolaridad set not null;
