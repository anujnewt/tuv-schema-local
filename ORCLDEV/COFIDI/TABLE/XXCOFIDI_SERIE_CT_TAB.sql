-- dmap_object_gen_tag : type : table name : xxcofidi_serie_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_serie_ct_tab"  (
id_serie_pk numeric(38) not null,
serie varchar(10) not null,
id_estado_fk numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_serie_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_serie_ct_tab add constraint xxcofidi_serie_pk_idx01 primary key (id_serie_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_serie_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_serie_ct_tab alter column id_serie_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_serie_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_serie_ct_tab alter column serie set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_serie_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_serie_ct_tab alter column id_estado_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_serie_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_serie_ct_tab add constraint xxcofidi_serie_estado_idx foreign key (id_estado_fk) references xxcofidi_estado_ct_tab(id_estado_pk) on delete no action not deferrable initially immediate;
