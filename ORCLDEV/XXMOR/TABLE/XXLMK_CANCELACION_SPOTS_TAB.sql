-- dmap_object_gen_tag : type : table name : xxlmk_cancelacion_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_cancelacion_spots_tab"  (
id_cancelacion numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
nom_archivo varchar(100),
des_archivo bytea,
ind_estatus numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_cancelacion_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_cancelacion_spots_tab add primary key (id_cancelacion);
-- dmap_object_gen_tag : type : alter table name : xxlmk_cancelacion_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_cancelacion_spots_tab alter column id_cancelacion set not null;
