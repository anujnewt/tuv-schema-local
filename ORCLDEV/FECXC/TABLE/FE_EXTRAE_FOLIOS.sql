-- dmap_object_gen_tag : type : table name : fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
create table "fe_extrae_folios"  (
folio numeric(15) not null,
no_empresa numeric(15) not null,
id_banco numeric(15) not null,
id_chequera varchar(80) not null,
id_divisa varchar(3) not null,
fecha timestamp(0),
ingresos numeric(15),
egresos numeric(15),
tipo_operacion char(1)
) ;
-- dmap_object_gen_tag : type : alter table name : fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
alter table fe_extrae_folios alter column folio set not null;
-- dmap_object_gen_tag : type : alter table name : fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
alter table fe_extrae_folios alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
alter table fe_extrae_folios alter column id_banco set not null;
-- dmap_object_gen_tag : type : alter table name : fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
alter table fe_extrae_folios alter column id_chequera set not null;
-- dmap_object_gen_tag : type : alter table name : fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
alter table fe_extrae_folios alter column id_divisa set not null;
