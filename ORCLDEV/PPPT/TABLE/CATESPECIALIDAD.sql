-- dmap_object_gen_tag : type : table name : catespecialidad
set search_path = pppt,oracle,dmap_extension,public;
create table "catespecialidad"  (
idespecialidad numeric(38) not null default 0,
especialidad varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : catespecialidad
set search_path = pppt,oracle,dmap_extension,public;
alter table catespecialidad alter column idespecialidad set not null;
