-- dmap_object_gen_tag : type : table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
create table "pcencabezadoanda"  (
enaidnumenc numeric(10) not null,
enacentrocostos varchar(16) not null,
enafechapeticion timestamp(0) not null,
enaidnumerousuario numeric(10) not null,
enaestatus numeric(10) not null,
enaproceso numeric(5),
enaauxiliarnum numeric(10),
enaauxiliarchar varchar(20),
enaobservacion varchar(255),
enaidproduccion numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcencabezadoanda add constraint ct_pcencabezado2 primary key (enaidnumenc);
-- dmap_object_gen_tag : type : alter table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcencabezadoanda alter column enaidnumenc set not null;
-- dmap_object_gen_tag : type : alter table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcencabezadoanda alter column enacentrocostos set not null;
-- dmap_object_gen_tag : type : alter table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcencabezadoanda alter column enafechapeticion set not null;
-- dmap_object_gen_tag : type : alter table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcencabezadoanda alter column enaidnumerousuario set not null;
-- dmap_object_gen_tag : type : alter table name : pcencabezadoanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcencabezadoanda alter column enaestatus set not null;
