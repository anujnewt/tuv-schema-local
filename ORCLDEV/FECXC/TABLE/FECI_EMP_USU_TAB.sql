-- dmap_object_gen_tag : type : table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_emp_usu_tab"  (
id_usuario numeric,
id_empresa numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab alter column ind_estado set not null;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab add constraint fk_feci_emp_feci_empu_feci_emp foreign key (id_empresa) references feci_empresa_cat(id_empresa) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : feci_emp_usu_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_emp_usu_tab add constraint fk_feci_emp_feci_empu_feci_usu foreign key (id_usuario) references feci_usuario_tab(id_usuario) on delete no action not deferrable initially immediate;
