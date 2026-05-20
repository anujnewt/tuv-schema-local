-- dmap_object_gen_tag : type : table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_memo_tab"  (
id_memo numeric not null,
cod_memo varchar(50),
id_correo_remitente numeric,
des_remitente varchar(100),
des_remitente_puesto varchar(100),
id_correo_destinatario numeric,
des_destinatario varchar(100),
des_destinatario_puesto varchar(100),
fec_fecha_memo timestamp(0) not null,
id_usuario numeric not null,
des_asunto varchar(500),
id_estado numeric not null,
id_canal numeric not null,
num_agrupador numeric,
fec_envio timestamp(0),
num_enviado numeric(1),
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
bl_memo_detalle bytea,
des_archivo varchar(50),
des_cuerpo text default '',
des_referencia varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab add constraint admp_memo_pk primary key (id_memo);
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column id_memo set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column fec_fecha_memo set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column id_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column id_estado set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column id_canal set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab add constraint admp_memo_fk_01 foreign key (id_usuario) references admp_usuario_tab(id_usuario) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab add constraint admp_memo_fk_02 foreign key (id_estado) references admp_estado_tab(id_estado) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab add constraint admp_memo_fk_03 foreign key (id_canal) references admp_canal_tab(id_canal) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab add constraint admp_memo_fk_04 foreign key (id_correo_remitente) references admp_correo_tab(id_correo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_memo_tab add constraint admp_memo_fk_05 foreign key (id_correo_destinatario) references admp_correo_tab(id_correo) on delete no action not deferrable initially immediate;
