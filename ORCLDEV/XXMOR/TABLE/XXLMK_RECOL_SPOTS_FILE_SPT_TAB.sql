-- dmap_object_gen_tag : type : table name : xxlmk_recol_spots_file_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_recol_spots_file_spt_tab"  (
id_recol_spots numeric(38) not null,
num_spot_lmk numeric(38) not null,
ind_status varchar(1),
original_scheduled_date timestamp(0),
original_scheduled_time varchar(6),
scheduled_date timestamp(0),
scheduled_time varchar(6),
des_error varchar(500),
original_status varchar(1),
status varchar(1),
channel varchar(50),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizado_por timestamp(0),
cve_actualizado_por varchar(100),
fec_processed timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_file_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_file_spt_tab add constraint xxlmk_recol_spots_file_spt_tab_pk primary key (id_recol_spots,num_spot_lmk);
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_file_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_file_spt_tab alter column id_recol_spots set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_file_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_file_spt_tab alter column num_spot_lmk set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_file_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_file_spt_tab add constraint xxlmk_recol_spots_file_spt_tab_xxlmk_recol_spots_file_tab_fk foreign key (id_recol_spots) references xxlmk_recol_spots_file_tab(id_recol_spots) on delete no action not deferrable initially immediate;
