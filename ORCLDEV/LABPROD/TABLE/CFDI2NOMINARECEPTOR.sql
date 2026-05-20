-- dmap_object_gen_tag : type : table name : cfdi2nominareceptor
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2nominareceptor"  (
idnomina numeric(10) not null,
curp varchar(18),
numseguridadsocial varchar(15),
fechainiciorellaboral timestamp(0),
antiguedad varchar(20),
tipocontrato varchar(2),
sindicalizado varchar(2),
tipojornada varchar(2),
tiporegimen varchar(2),
numempleado varchar(15),
departamento varchar(100),
puesto varchar(100),
riesgopuesto varchar(1),
periodicidadpago varchar(2),
banco varchar(3),
cuentabancaria varchar(18),
salariobasecotapor decimal(18, 2),
salariodiariointegrado decimal(18, 2),
claveentfed varchar(3)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2nominareceptor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2nominareceptor add constraint pk_cfdi2nominareceptor primary key (idnomina);
-- dmap_object_gen_tag : type : alter table name : cfdi2nominareceptor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2nominareceptor alter column idnomina set not null;
