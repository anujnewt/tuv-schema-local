-- dmap_object_gen_tag : type : table name : xxlmk_can_except_date_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_can_except_date_tab"  (
id_except numeric(38) not null,
fec_except timestamp(0) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_date_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_date_tab add primary key (id_except,fec_except);
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_date_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_date_tab alter column id_except set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_date_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_date_tab alter column fec_except set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_can_except_date_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_can_except_date_tab add constraint xxlmkcanexceptdatetab_fk1 foreign key (id_except) references xxlmk_can_except_dur_tab(id_except) on delete no action not deferrable initially immediate;
