-- dmap_object_gen_tag : type : table name : xxlmk_can_except_hora_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_can_except_hora_tab"  (
id_except numeric(38) not null,
des_hora_ini varchar(6) not null,
des_hora_fin varchar(6) not null,
num_duracion numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_hora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_hora_tab add primary key (id_except,des_hora_ini,des_hora_fin);
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_hora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_hora_tab alter column id_except set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_hora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_hora_tab alter column des_hora_ini set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_hora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_hora_tab alter column des_hora_fin set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_hora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_hora_tab add constraint xxlmkcanexcepthoratab_fk1 foreign key (id_except) references xxlmk_can_except_dur_tab(id_except) on delete no action not deferrable initially immediate;
