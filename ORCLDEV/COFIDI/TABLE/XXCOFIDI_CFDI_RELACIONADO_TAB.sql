-- dmap_object_gen_tag : type : table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_cfdi_relacionado_tab"  (
id_cfdi_relacionado_pk numeric not null,
id_factura_fk numeric not null,
tipo_comprobante varchar(1) not null,
tipo_relacion varchar(2) not null,
uuid varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab add constraint xxcofidi_cfdi_relacionado_pk primary key (id_cfdi_relacionado_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab alter column id_cfdi_relacionado_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab alter column id_factura_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab alter column tipo_comprobante set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab alter column tipo_relacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab alter column uuid set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_relacionado_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_relacionado_tab add constraint xxcofidi_cfdi_rel_fa_fk_idx01 foreign key (id_factura_fk) references xxcofidi_factura_tab(id_factura_pk) on delete no action not deferrable initially immediate;
