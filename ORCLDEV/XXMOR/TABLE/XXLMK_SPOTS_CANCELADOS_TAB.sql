-- dmap_object_gen_tag : type : table name : xxlmk_spots_cancelados_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_spots_cancelados_tab"  (
id_spot_cancelado numeric(38) not null,
id_cancelacion numeric(38) not null,
id_spot numeric(38),
num_spot_lmk numeric(38),
ind_estatus numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_spots_cancelados_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_spots_cancelados_tab add primary key (id_spot_cancelado);
-- dmap_object_gen_tag : type : alter table name : xxlmk_spots_cancelados_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_spots_cancelados_tab alter column id_spot_cancelado set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_spots_cancelados_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_spots_cancelados_tab alter column id_cancelacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_spots_cancelados_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_spots_cancelados_tab add constraint xxlmkspotscanceladostab_fk1 foreign key (id_cancelacion) references xxlmk_cancelacion_spots_tab(id_cancelacion) on delete no action not deferrable initially immediate;
