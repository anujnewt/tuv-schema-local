-- dmap_object_gen_tag : type : table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_memo_detalle_tab"  (
id_memo_detalle numeric not null,
id_memo numeric not null,
id_cambio numeric not null,
des_ciclo varchar(800),
fec_inicio timestamp(0),
fec_fin timestamp(0),
num_lunes numeric(1),
num_martes numeric(1),
num_miercoles numeric(1),
num_jueves numeric(1),
num_viernes numeric(1),
num_sabado numeric(1),
num_domingo numeric(1),
des_cambio varchar(600),
des_hora_ini varchar(10),
des_hora_fin varchar(10),
num_duracion numeric,
des_reparto varchar(2000),
id_tipo numeric,
id_sub_genero numeric,
id_produccion numeric,
id_estatus numeric,
id_origen numeric,
des_responsabilidad varchar(400),
id_udn numeric,
id_clasificacion numeric,
id_clase numeric,
fec_ultima_trans timestamp(0),
des_observaciones varchar(800),
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
id_restriccion numeric,
id_genero numeric
) ;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_pk primary key (id_memo_detalle);
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column id_memo_detalle set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column id_memo set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column id_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_01 foreign key (id_memo) references admp_memo_tab(id_memo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_02 foreign key (id_cambio) references admp_cambio_tab(id_cambio) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_03 foreign key (id_tipo) references admp_tipo_tab(id_tipo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_04 foreign key (id_sub_genero) references admp_sub_genero_tab(id_sub_genero) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_05 foreign key (id_produccion) references admp_produccion_tab(id_produccion) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_06 foreign key (id_estatus) references admp_estatus_tab(id_estatus) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_07 foreign key (id_origen) references admp_origen_tab(id_origen) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_08 foreign key (id_udn) references admp_udn_tab(id_udn) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_09 foreign key (id_clasificacion) references admp_clasificacion_tab(id_clasificacion) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_10 foreign key (id_clase) references admp_clase_tab(id_clase) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_11 foreign key (id_restriccion) references admp_restriccion_tab(id_restriccion) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_detalle_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_detalle_tab add constraint admp_memo_detalle_fk_12 foreign key (id_genero) references admp_genero_tab(id_genero) on delete no action not deferrable initially immediate;
