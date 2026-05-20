-- dmap_object_gen_tag : type : table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_usu_ori_emp_tab"  (
id_usu_ori_emp_pk numeric not null,
id_usuario_fk numeric not null,
id_origen_fk numeric not null,
id_empresa_fk numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab add constraint xxcofidi_usu_ori_emp_pk_idx01 primary key (id_usu_ori_emp_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab alter column id_usu_ori_emp_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab alter column id_usuario_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab alter column id_origen_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab alter column id_empresa_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab add constraint xxcofidi_usu_ori_emp_emp_idx foreign key (id_empresa_fk) references xxcofidi_empresa_ct_tab(id_empresa_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab add constraint xxcofidi_usu_ori_emp_ori_idx foreign key (id_origen_fk) references xxcofidi_origen_ct_tab(id_origen_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usu_ori_emp_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usu_ori_emp_tab add constraint xxcofidi_usu_ori_emp_usu_idx foreign key (id_usuario_fk) references xxcofidi_usuario_tab(id_usuario_pk) on delete no action not deferrable initially immediate;
