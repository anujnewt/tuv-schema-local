-- dmap_object_gen_tag : type : table name : xxlmk_lineas_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_lineas_spots_tab"  (
id_spot numeric(38) not null,
id_linea numeric(38) not null,
des_fecha_break varchar(8),
des_hora_inicio varchar(6),
des_hora_fin varchar(6),
des_hora_break varchar(6),
num_duracion numeric(38),
des_tolerancia varchar(6),
ind_estatus numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_prog numeric(38),
num_spot numeric(38),
nom_prog varchar(200),
brek_nom_time numeric(38),
val_tarifa numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_lineas_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_lineas_spots_tab add primary key (id_spot);
-- dmap_object_gen_tag : type : alter table name : xxlmk_lineas_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_lineas_spots_tab alter column id_spot set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_lineas_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_lineas_spots_tab alter column id_linea set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_lineas_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_lineas_spots_tab add constraint xxlmklineasspotstab_fk_01 foreign key (id_linea) references xxlmk_ordln_tab(id_linea) on delete no action not deferrable initially immediate;
