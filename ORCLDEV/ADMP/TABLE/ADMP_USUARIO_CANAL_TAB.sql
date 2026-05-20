-- dmap_object_gen_tag : type : table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_usuario_canal_tab"  (
id_usuario_canal numeric not null,
id_usuario numeric not null,
id_canal numeric not null,
id_modulo numeric not null,
id_permiso numeric not null,
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
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab add constraint admp_usuario_canal_pk primary key (id_usuario_canal);
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column id_usuario_canal set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column id_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column id_canal set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column id_modulo set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column id_permiso set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab add constraint admp_usuario_canal_fk_01 foreign key (id_usuario) references admp_usuario_tab(id_usuario) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab add constraint admp_usuario_canal_fk_02 foreign key (id_canal) references admp_canal_tab(id_canal) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab add constraint admp_usuario_canal_fk_03 foreign key (id_modulo) references admp_modulo_tab(id_modulo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_usuario_canal_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_usuario_canal_tab add constraint admp_usuario_canal_fk_04 foreign key (id_permiso) references admp_permiso_tab(id_permiso) on delete no action not deferrable initially immediate;
