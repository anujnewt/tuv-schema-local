-- dmap_object_gen_tag : type : table name : xxlmk_recol_spots_file_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_recol_spots_file_tab"  (
id_recol_spots numeric(38) not null,
nom_file varchar(500),
type varchar(4),
ind_status varchar(1),
des_error varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_file_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_file_tab add constraint xxlmk_recol_spots_file_tab_pk primary key (id_recol_spots);
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_file_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_file_tab alter column id_recol_spots set not null;
