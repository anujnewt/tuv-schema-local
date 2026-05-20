-- dmap_object_gen_tag : type : table name : xxlmk_can_except_dur_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_can_except_dur_tab"  (
id_except numeric(38) not null,
id_grupo numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_dur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_dur_tab add primary key (id_except);
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_dur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_dur_tab alter column id_except set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_dur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_dur_tab alter column id_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_dur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_dur_tab add constraint xxlmkcanexceptdurtab_fk1 foreign key (id_grupo) references xxlmk_grupos_canales_tab(id_grupo) on delete no action not deferrable initially immediate;
