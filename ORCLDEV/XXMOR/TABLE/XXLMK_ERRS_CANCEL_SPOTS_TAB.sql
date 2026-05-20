-- dmap_object_gen_tag : type : table name : xxlmk_errs_cancel_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_cancel_spots_tab"  (
id_spot_cancelado numeric(38) not null,
num_msg numeric(38),
des_msg varchar(4000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_cancel_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_cancel_spots_tab alter column id_spot_cancelado set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_cancel_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_cancel_spots_tab add constraint xxlmkerrscancelspotstab_fk1 foreign key (id_spot_cancelado) references xxlmk_spots_cancelados_tab(id_spot_cancelado) on delete no action not deferrable initially immediate;
