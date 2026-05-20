-- dmap_object_gen_tag : type : table name : pppcatalogo
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create table "pppcatalogo"  (
idcatalogo numeric(38) not null,
catalogo varchar(50) not null,
activo numeric(1) default 0,
secuencia numeric(38) default 0,
tabla varchar(50),
idfield varchar(50),
nomfield varchar(50),
nomlen numeric(38) not null default 0,
"location" varchar(250),
descripcion varchar(250),
relacionnoborra varchar(250),
idcatrel numeric(38),
relfield varchar(50),
porempresa numeric(1),
compartir numeric(1),
modempresa numeric(1),
modpersona numeric(1)
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : pppcatalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table pppcatalogo alter column idcatalogo set not null;
-- dmap_object_gen_tag : type : alter table name : pppcatalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table pppcatalogo alter column catalogo set not null;
-- dmap_object_gen_tag : type : alter table name : pppcatalogo
set search_path = pppt,oracle,dmap_extension,public;
alter table pppcatalogo alter column nomlen set not null;
