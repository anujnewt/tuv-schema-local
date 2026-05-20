-- dmap_object_gen_tag : type : table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_parrilla_det_tab"  (
id_parrilla_det numeric not null,
id_parrilla numeric not null,
id_genero numeric,
des_ciclo varchar(500),
des_hora_inicio varchar(10),
des_hora_fin varchar(10),
des_hora_inicio_real varchar(10),
des_hora_fin_real varchar(10),
id_tipo numeric,
des_programa varchar(500),
des_programa_original varchar(500),
id_clasificacion numeric,
id_formato numeric,
id_restriccion numeric,
des_notas varchar(2000),
num_transmisiones numeric,
fec_ultima_trasmision timestamp(0),
num_created_by numeric(15) not null,
fec_creation_date timestamp(0) not null,
num_last_update numeric(15) not null,
fec_last_update timestamp(0) not null,
num_last_update_login numeric(15),
atributo1 varchar(150),
atributo2 varchar(150),
atributo3 varchar(150),
atributo4 varchar(150),
atributo5 varchar(150),
atributo6 varchar(150),
atributo7 varchar(150),
atributo8 varchar(150),
atributo9 varchar(150),
atributo10 varchar(150),
atributo11 varchar(150),
atributo12 varchar(150),
atributo13 varchar(150),
atributo14 varchar(150),
atributo15 varchar(150),
attribute_category varchar(150),
num_color numeric(1) default 0,
num_sap numeric(1) default 0,
num_temporada numeric(3),
num_repeticion_temp numeric(1) default 0,
des_programa_ibope varchar(500),
id_fuente numeric,
id_evento numeric,
des_hora_fin_iso varchar(10),
des_hora_inicio_iso varchar(10),
fec_ultima_transmision timestamp(0),
des_ultima_transmision varchar(100),
des_descripcion varchar(250),
num_fuente_xls decimal(3, 1),
num_cambio_prog numeric(1) default 0,
fec_cambio_prog timestamp(0),
des_capitulo varchar(250),
cod_programa_ibope varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_pk primary key (id_parrilla_det);
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab alter column id_parrilla_det set not null;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab alter column id_parrilla set not null;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_01 foreign key (id_parrilla) references admp_parrilla_tab(id_parrilla) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_02 foreign key (id_genero) references admp_genero_tab(id_genero) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_03 foreign key (id_tipo) references admp_tipo_tab(id_tipo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_04 foreign key (id_clasificacion) references admp_clasificacion_tab(id_clasificacion) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_05 foreign key (id_formato) references admp_formato_tab(id_formato) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_06 foreign key (id_restriccion) references admp_restriccion_tab(id_restriccion) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_07 foreign key (id_fuente) references admp_fuente_tab(id_fuente) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_parrilla_det_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_parrilla_det_tab add constraint admp_parrilla_det_fk_08 foreign key (id_evento) references admp_evento_tab(id_evento) on delete no action not deferrable initially immediate;
