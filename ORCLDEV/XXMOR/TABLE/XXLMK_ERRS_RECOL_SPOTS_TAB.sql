-- dmap_object_gen_tag : type : table name : xxlmk_errs_recol_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_recol_spots_tab"  (
id_spot numeric(38) not null,
num_spot numeric(38) not null,
des_error varchar(1000),
des_breaks varchar(1500),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_msg_err varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_recol_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_recol_spots_tab alter column id_spot set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_recol_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_recol_spots_tab alter column num_spot set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_recol_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_recol_spots_tab add constraint xxlmkerrsrecolspots_fk1 foreign key (id_spot) references xxlmk_lineas_spots_tab(id_spot) on delete no action not deferrable initially immediate;
