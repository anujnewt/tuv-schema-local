-- dmap_object_gen_tag : type : table name : xxcofidi_documento_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_documento_tab"  (
id_documento_pk numeric(38) not null,
tipo_archivo varchar(3) not null,
nom_archivo varchar(150),
archivo bytea not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_documento_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_documento_tab add constraint xxcofidi_documento_pk_idx01 primary key (id_documento_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_documento_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_documento_tab alter column id_documento_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_documento_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_documento_tab alter column tipo_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_documento_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_documento_tab alter column archivo set not null;
