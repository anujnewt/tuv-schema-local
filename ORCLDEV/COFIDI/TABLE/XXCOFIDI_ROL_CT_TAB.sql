-- dmap_object_gen_tag : type : table name : xxcofidi_rol_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_rol_ct_tab"  (
id_rol_pk numeric(38) not null,
rol varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_rol_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_rol_ct_tab add constraint xxcofidi_rol_pk_idx01 primary key (id_rol_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_rol_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_rol_ct_tab alter column id_rol_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_rol_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_rol_ct_tab alter column rol set not null;
