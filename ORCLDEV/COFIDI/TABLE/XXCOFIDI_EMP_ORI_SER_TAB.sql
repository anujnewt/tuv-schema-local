-- dmap_object_gen_tag : type : table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_emp_ori_ser_tab"  (
id_emp_ori_ser_pk numeric not null,
id_empresa_fk numeric not null,
id_origen_fk numeric not null,
id_serie_fk numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab add constraint xxcofidi_emp_ori_ser_pk_idx01 primary key (id_emp_ori_ser_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab alter column id_emp_ori_ser_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab alter column id_empresa_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab alter column id_origen_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab add constraint xxcofidi_emp_ori_ser_emp_idx foreign key (id_empresa_fk) references xxcofidi_empresa_ct_tab(id_empresa_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab add constraint xxcofidi_emp_ori_ser_ori_idx foreign key (id_origen_fk) references xxcofidi_origen_ct_tab(id_origen_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_emp_ori_ser_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_emp_ori_ser_tab add constraint xxcofidi_emp_ori_ser_ser_idx foreign key (id_serie_fk) references xxcofidi_serie_ct_tab(id_serie_pk) on delete no action not deferrable initially immediate;
