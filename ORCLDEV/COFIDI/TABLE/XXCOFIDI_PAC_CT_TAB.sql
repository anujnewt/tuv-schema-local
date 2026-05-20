-- dmap_object_gen_tag : type : table name : xxcofidi_pac_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_pac_ct_tab"  (
id_pac_pk numeric(38) not null,
pac varchar(255) not null,
id_estado_fk numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_pac_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_pac_ct_tab add constraint xxcofidi_pac_pk_idx01 primary key (id_pac_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_pac_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_pac_ct_tab alter column id_pac_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_pac_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_pac_ct_tab alter column pac set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_pac_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_pac_ct_tab add constraint xxcofidi_pac_estado_idx foreign key (id_estado_fk) references xxcofidi_estado_ct_tab(id_estado_pk) on delete no action not deferrable initially immediate;
