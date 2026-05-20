-- dmap_object_gen_tag : type : table name : xxcofidi_cfdi_emisor_recep_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_cfdi_emisor_recep_tab"  (
id_cfdi_emisor_recep_pk numeric not null,
id_factura_fk numeric not null,
emisor numeric(1) not null,
rfc varchar(20),
nombre varchar(255),
regimen_fiscal varchar(20),
num_reg_id_trib varchar(20),
uso_cfdi varchar(20),
residencia_fiscal varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_emisor_recep_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_emisor_recep_tab add constraint xxcofidi_cfdi_emisor_recep_pk primary key (id_cfdi_emisor_recep_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_emisor_recep_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_emisor_recep_tab alter column id_cfdi_emisor_recep_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_emisor_recep_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_emisor_recep_tab alter column id_factura_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_emisor_recep_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_emisor_recep_tab alter column emisor set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_emisor_recep_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_emisor_recep_tab add constraint xxcofidi_cfdi_emi_re_fk_idx01 foreign key (id_factura_fk) references xxcofidi_factura_tab(id_factura_pk) on delete no action not deferrable initially immediate;
