-- dmap_object_gen_tag : type : table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_origen_ct_tab"  (
id_origen_pk numeric(38) not null,
origen varchar(255) not null,
tipo numeric(1) default 0,
id_estado_fk numeric,
procesar_solo_xml numeric(1) not null,
folio_numerico numeric(1) not null,
descripcion varchar(150) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab add constraint xxcofidi_origen_pk_idx01 primary key (id_origen_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab alter column id_origen_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab alter column origen set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab alter column procesar_solo_xml set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab alter column folio_numerico set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_origen_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_origen_ct_tab add constraint xxcofidi_origen_estado_idx foreign key (id_estado_fk) references xxcofidi_estado_ct_tab(id_estado_pk) on delete no action not deferrable initially immediate;
