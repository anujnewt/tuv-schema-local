-- dmap_object_gen_tag : type : table name : com_sips_orac_empl
set search_path = labconf,oracle,dmap_extension,public;
create table "com_sips_orac_empl"  (
ora_ctvo numeric(10) not null,
ora_status varchar(1),
id_persona varchar(20),
apellidos varchar(150),
nombres varchar(150),
tipo_persona varchar(20),
sexo varchar(1),
rfc varchar(20),
curp varchar(20),
imss numeric(20),
fecha_alta timestamp(0),
fecha_nacimiento timestamp(0),
nacionalidad varchar(80),
business_group_id numeric(38),
email varchar(40),
end_date timestamp(0),
estado_empleado varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : com_sips_orac_empl
set search_path = labconf,oracle,dmap_extension,public;
alter table com_sips_orac_empl alter column ora_ctvo set not null;
