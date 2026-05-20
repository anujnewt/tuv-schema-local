-- dmap_object_gen_tag : type : table name : xxlmk_errs_create_camp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_create_camp_tab"  (
id_error numeric(38) not null,
id_ordhdr numeric(38) not null,
num_error numeric(38),
des_severity varchar(50),
des_error varchar(1000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_create_camp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_create_camp_tab add primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_create_camp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_create_camp_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_create_camp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_create_camp_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_create_camp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_create_camp_tab add constraint xxlmkerrscreatecamptab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
