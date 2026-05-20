-- dmap_object_gen_tag : type : table name : xxlmk_ordln_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ordln_tab"  (
id_linea numeric not null,
id_ordhdr numeric,
num_linea numeric,
cve_canal varchar(50),
des_fec_ini varchar(8),
des_fec_fin varchar(8),
num_duracion numeric,
id_buyunt varchar(50),
des_hora_ini varchar(4),
des_hora_fin varchar(4),
can_spots numeric,
can_lun numeric,
can_mar numeric,
can_mie numeric,
can_jue numeric,
can_vie numeric,
can_sab numeric,
can_dom numeric,
des_tipo_servicio varchar(200),
ind_bn varchar(10),
ind_p varchar(5),
des_marca varchar(200),
des_version varchar(50),
can_tar_sp_sin_desc numeric,
can_tar_sp_con_des numeric,
can_tot_lin_sin_desc numeric,
can_tot_lin_con_desc numeric,
des_sobrecargo varchar(50),
des_observaciones varchar(100),
des_plataforma varchar(20),
pos1 varchar(50),
pos2 varchar(50),
pos3 varchar(50),
pos_ant varchar(50),
pos_pen varchar(50),
pos_ult varchar(50),
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50),
des_campana varchar(200),
can_grps numeric,
des_sptchr numeric,
des_usrchr varchar(2),
can_spots_x_sem numeric,
ind_estatus numeric(38),
num_porc_line numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ordln_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ordln_tab add constraint xxlmk_ordln_tab_pk primary key (id_linea);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ordln_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ordln_tab alter column id_linea set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ordln_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ordln_tab add constraint xxlmk_ordln_tab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
