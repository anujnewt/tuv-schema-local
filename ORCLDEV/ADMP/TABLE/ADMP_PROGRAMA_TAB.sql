-- dmap_object_gen_tag : type : table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_programa_tab"  (
id_programa numeric not null,
des_programa varchar(500) not null,
des_link_web varchar(250),
des_link_icono varchar(250),
id_genero numeric,
id_cobertura numeric,
fec_fecha_inicio timestamp(0),
fec_fecha_fin timestamp(0),
cod_codigo varchar(100),
des_titulo_original varchar(500),
id_estado numeric not null,
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
attribute_category varchar(150)
) ;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab add constraint admp_programa_pk primary key (id_programa);
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column id_programa set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column des_programa set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column id_estado set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab add constraint admp_programa_fk_01 foreign key (id_genero) references admp_genero_tab(id_genero) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab add constraint admp_programa_fk_02 foreign key (id_cobertura) references admp_cobertura_tab(id_cobertura) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_programa_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_tab add constraint admp_programa_fk_03 foreign key (id_estado) references admp_estado_tab(id_estado) on delete no action not deferrable initially immediate;
