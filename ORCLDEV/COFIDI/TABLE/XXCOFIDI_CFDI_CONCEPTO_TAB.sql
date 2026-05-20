-- dmap_object_gen_tag : type : table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_cfdi_concepto_tab"  (
id_cfdi_concepto_pk numeric not null,
id_factura_fk numeric not null,
clave_prod_serv varchar(20) not null,
no_identificacion varchar(500),
cantidad varchar(20) not null,
clave_unidad varchar(20) not null,
unidad varchar(20),
descripcion varchar(1500) not null,
valor_unitario varchar(20) not null,
importe varchar(20) not null,
descuento varchar(20),
cod_objeto_imp varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab add constraint xxcofidi_cfdi_concepto_pk primary key (id_cfdi_concepto_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column id_cfdi_concepto_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column id_factura_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column clave_prod_serv set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column cantidad set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column clave_unidad set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column valor_unitario set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_concepto_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_concepto_tab add constraint xxcofidi_cfdi_co_fac_fk_idx01 foreign key (id_factura_fk) references xxcofidi_factura_tab(id_factura_pk) on delete no action not deferrable initially immediate;
