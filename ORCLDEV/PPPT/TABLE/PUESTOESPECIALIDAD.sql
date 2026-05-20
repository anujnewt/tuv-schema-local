-- dmap_object_gen_tag : type : table name : puestoespecialidad
set search_path = pppt,oracle,dmap_extension,public;
create table "puestoespecialidad"  (
idpuesto numeric(38) not null,
idescolaridad numeric(38) not null,
idespecialidad numeric(38) not null,
peso numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : puestoespecialidad
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoespecialidad alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestoespecialidad
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoespecialidad alter column idescolaridad set not null;
-- dmap_object_gen_tag : type : alter table name : puestoespecialidad
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoespecialidad alter column idespecialidad set not null;
