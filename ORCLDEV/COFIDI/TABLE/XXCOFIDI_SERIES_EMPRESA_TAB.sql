-- dmap_object_gen_tag : type : table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_series_empresa_tab"  (
id_series_empresa_pk numeric not null,
id_serie_fk numeric not null,
id_empresa_fk numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_series_empresa_tab add constraint xxcofidi_series_emp_pk_idx01 primary key (id_series_empresa_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_series_empresa_tab alter column id_series_empresa_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_series_empresa_tab alter column id_serie_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_series_empresa_tab alter column id_empresa_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_series_empresa_tab add constraint xxcofidi_ser_emp1_emp2_tab_idx foreign key (id_empresa_fk) references xxcofidi_empresa_ct_tab(id_empresa_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_series_empresa_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_series_empresa_tab add constraint xxcofidi_ser_emp_serie_tab_idx foreign key (id_serie_fk) references xxcofidi_serie_ct_tab(id_serie_pk) on delete no action not deferrable initially immediate;
