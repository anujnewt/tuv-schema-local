-- dmap_object_gen_tag : type : table name : laboral
set search_path = pppt,oracle,dmap_extension,public;
create table "laboral"  (
idpersonal numeric(38) not null,
empresa varchar(50),
giro varchar(50),
domicilio varchar(50),
telefono varchar(50),
puesto varchar(50),
funcion numeric(38),
jefeinmediato varchar(50),
sueldo numeric,
sueldof numeric,
de timestamp(0) not null,
a timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : laboral
set search_path = pppt,oracle,dmap_extension,public;
alter table laboral alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : laboral
set search_path = pppt,oracle,dmap_extension,public;
alter table laboral alter column de set not null;
