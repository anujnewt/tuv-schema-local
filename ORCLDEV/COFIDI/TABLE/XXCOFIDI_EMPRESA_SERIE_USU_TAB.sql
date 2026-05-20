-- dmap_object_gen_tag : type : table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_empresa_serie_usu_tab"  (
id_empresa_serie_usu_pk numeric(38) not null,
id_usuario_fk numeric not null,
id_empresa_fk numeric not null,
id_serie_fk numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab add constraint xxcofidi_emp_ser_usu_pk_idx01 primary key (id_empresa_serie_usu_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab alter column id_empresa_serie_usu_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab alter column id_usuario_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab alter column id_empresa_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab alter column id_serie_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab add constraint xxcofidi_empserusu_emp2_idx01 foreign key (id_empresa_fk) references xxcofidi_empresa_ct_tab(id_empresa_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab add constraint xxcofidi_empserusu_ser2_idx01 foreign key (id_serie_fk) references xxcofidi_serie_ct_tab(id_serie_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_serie_usu_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_serie_usu_tab add constraint xxcofidi_empserusu_usu2_idx01 foreign key (id_usuario_fk) references xxcofidi_usuario_tab(id_usuario_pk) on delete no action not deferrable initially immediate;
