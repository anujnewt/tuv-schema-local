-- dmap_object_gen_tag : type : table name : escolaridad
set search_path = pppt,oracle,dmap_extension,public;
create table "escolaridad"  (
idpersonal numeric(38) not null,
grado numeric(38) not null,
especialidad numeric(38) not null,
escuela varchar(50),
ubicacion varchar(50),
titulo numeric(38),
de numeric(38),
a numeric(38),
actual numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : escolaridad
set search_path = pppt,oracle,dmap_extension,public;
alter table escolaridad alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : escolaridad
set search_path = pppt,oracle,dmap_extension,public;
alter table escolaridad alter column grado set not null;
-- dmap_object_gen_tag : type : alter table name : escolaridad
set search_path = pppt,oracle,dmap_extension,public;
alter table escolaridad alter column especialidad set not null;
